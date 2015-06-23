# Building an Experimentation Platform in Clojure

## Abstract
Over the last year and half at Staples SparX, we built a multivariate
testing platform as a service. It satisfies an SLA of 10ms at 99.9th
percentile, services all of Staples' experimentation from a single
machine, is simulation tested, and is written in Clojure.

We'll give an introduction to the Experimentation domain, design of
experiments and our battle in attaining statistical significance with
constrained traffic. We will share our experiences in loading and
reporting over months of data in Datomic, using Clojure to grow a
resilient postgres cluster, using a homegrown jdbc driver, interesting
anecdotes, and OLAP solutions with ETL built in Clojure using
core.async. Expect to see references to google white papers, latency
and network graphs, histograms, comparison tables and an eyeful of
clojure code.

## What will the attendee learn?

Note: We understand that this is probably too much to cover in a
single talk. We'll run time checks of the talk and cut it down to the
most interesting sections that we can cover in the time we have. It's
been a rather eventful year, and we have much to share.

### Experimentation
How do we provide statistically sound testing of hypotheses for
complex multi-variable systems? The system has a strong emphasis on
multi-variate testing in an online e-commerce context: click streams,
funnels, purchases and conversions are all first class. We'll explain
these things in brief.

Experiments can be non-overlapping and overlapping. What does it mean
for measurements to be side effect free? What is the tradeoff between
precise measurement and splitting traffic between experiments? We'll
get into the guts of these concepts because they are central to the
service.

How do we ensure treatment stickiness when a user is a part of
multiple experiments that are scheduled independently? How do
'Overlapping Experiments' work? Is there a limit to the extent we can
nest experiments and still get meaningful results?

We'll have some sample representations of the nested and overlapping
experiment structures.

### Loading datomic
In the absence of first class support to do a bulk import into
datomic, we needed to handroll a way to write data into datomic as
fast as possible.

At first, we naively used an application load driver. This was slow
because it went through the cruft of the domain logic first.
```clojure
(defn create-session [conn db merchant-id exp-names]
  (binding [gen/*rnd* (java.util.Random.)]
    (let [user-token (str (gen/uuid))
          device-id (str (gen/uuid))]
      (segments/ensure-segment-session-and-device conn db user-token device-id)
      (let [buckets (:buckets (traffic/get-treatments conn db merchant-id {} user-token exp-names))
            session (sessions/by-user-token db user-token)]
        (doseq [bucket buckets] (confirm-bucket conn session bucket))
        (sessions/record-event conn session "purchase" event-data)))))

(defn create-sessions [num-sessions merchant-id exp-names]
  (let [conn (d/connect config/db-uri)
        db (d/db conn)]
    (dotimes [_ num-sessions]
      (create-session conn db merchant-id exp-names))))
```

Then we quickly switched to writing only datoms. This was much faster,
but looking at CloudWatch, we weren't leveraging the transactor's full
power.

We consulted a datomic team member and he suggested using txAsync, and
1000 (the magic number) datoms per transaction. Here's the plumbing we
ended up building.
```clojure
(def datoms-per-tx 1000)

;; Monitoring
(def transaction-count (atom 0))

;; Partitioning
(defn partition-txs
  "Given a seq of transactions, figure out how many datoms in the first
  transaction, and then partition to ensure each group of transactions
  has *datoms-per-tx* datoms in it."
  [txs]
  (let [representative    (first txs)
        tx-size           (reduce + (map count representative))
        txs-per-partition (max (quot datoms-per-tx tx-size) 1)]
    (prn {:op                :partition-txs
          :txs-per-partition txs-per-partition})
    (partition-all txs-per-partition txs)))

(defn load-generated-data
  "Call a generator to create entities. Load num-samples of them into
   the database, using parallel threads for better throughput."
  [conn generator num-samples]
  (let [db (d/db conn)]
    (reset! start-time (System/nanoTime))
    (prn {:op :start})
    (doseq [{:keys [tx result counter start tod]}
            (pmap #(let [ctr (swap! transaction-count inc)
                         tx  (apply concat %)]
                     (try
                       {:tx      tx
                        :start   (. System (nanoTime))
                        :result  (d/transact-async conn tx)
                        :counter ctr}
                       (catch Throwable e
                         {:result  (delay (throw e))
                          :counter ctr
                          :tx      tx})))
                  (partition-txs (repeatedly num-samples generator)))]
      (try
        (when @result
          (prn {:op         :tx
                :ctr        counter
                :elapsed-ms (quot (- (System/nanoTime) start)
                                  1000000)}))
        (catch Throwable e
          (prn {:op   :tx
                :ctr  counter
                :err  (st/root-cause e)
                :tx   tx})
          (when tx
            @(d/transact-async conn tx)))))
    (let [scheduled?  (d/request-index conn)]
      (prn {:op :final-index
            :scheduled? scheduled?}))
    (prn {:op :end
          :elapsed-ms (quot (- (System/nanoTime) @start-time)
                            1000000)})))
```

Looking at cloudwatch metrics gave us the necessary feedback that we
could work into our plumbing. Note that core.async's pipeline, and
pipeline-async are better mechanisms of doing this plumbing now.

### Reporting on datomic
Being relatively new, there weren't established ways to read and
report on large amounts and large timespans of data in datomic.

So we tried a these things:

1. A single big query, and daily aggregates
```clojure
(defn flatten-relation
  "Expand incoming tuple 'v' with related fields.
   Applies 'f' to each tuple. (I.e., this joins v with (f v).)
   'f' must take an associative and return an associative."
  [tuples f]
  (for [tuple tuples]
    (merge (into {} tuple) (into {} (f tuple)))))

(def daily-aggregates
  {:db                (fnk [conn to]               (d/as-of (d/db conn) to))
   :session-entities  (fnk [db from]               (db-session/sessions (d/since db from)))
   :session-by-day    (fnk [session-entities]      (count-by (constantly true) session-entities))
   :session-by-day-tx (fnk [from session-by-day]   (list (aggregate-entity from "sessions-by-day" "sessions" "total" :report.aggregate/count {:report/count (get session-by-day true)})))
   :session-count     (fnk [session-treatments]       (count-by treatments session-treatments))
   ;; ... removed some lines here for brevity
   :purchase-totals   (fnk [purchase-amounts]      (sum-by #(- (:items-total %) (:discounts %)) treatments purchase-amounts))
   :sales-$-tx        (fnk [from purchase-totals]  (map #(dollars-entity "purchase-totals-by-treatment" from %) purchase-totals))

   :discount-totals   (fnk [purchase-amounts]      (sum-by :discounts treatments purchase-amounts))
   :discount-$-tx     (fnk [from discount-totals]  (map #(dollars-entity "discount-totals-by-treatment" from %) discount-totals))})

```
The latency curve for this along with database size was exponential.

2. Optimize datalog query plans
Given deep knowledge of the domain, we were able to rerarrange datalog
expressions to narrow down the datoms at the earliest in the
query. The problem still remained. We were holding on to the whole
dataset in memory while the query was being run.

3. The datoms approach
We leveraged the datoms api to get a lazy sequence of datoms that we
can filter so that we don't consume much memory. This resulting in
reimplementing joins/merges in clojure which are best done by a
database. The latency curve for this approach was linear, but the
timings weren't still good.

```clojure
(defn filter-events-by-treatment
  [run treatments event-type db datom]
  (when (= (:db/id (d/entity db :event/data)) (.a datom))
    (let [evt (d/entity db (.e datom))]
      (when (= event-type (:event/type evt))
          ;; some lines removed here for brevity
             (not (empty?
                   (set/intersection (set (mapcat :session/treatments sessions))
                                     (set (mapcat :segment/treatments segments))
                                     treatments))))
            ))))))

(defn financials-by-session-2
  [db run-id exp-name event-type]
  (let [[run exp] (first (d/q '[:find ?run ?exp
                                :in $ ?run-id ?exp-name
                                :where
                                [?run :run/id ?run-id]
                                [?run :run/experiments ?exp]
                                [?exp :experiment/logical-name ?exp-name]]
                              db run-id exp-name))
        treatments   (:experiment/treatments (d/entity db exp))
        run (d/entity db run)
        filtered  (d/filter db (partial filter-events-by-treatment run treatments event-type))
        datom-seq (d/datoms filtered :aevt :event/data)]
    (map (fn [datom]
           (let [m (json/decode (.v datom) true)]
             {:items-total (items-total m)
              :discount (discount m)})) datom-seq)))
```

In the end, we went with a mixture of the approaches above. Using the
database to do merges/joins effectively, and clojure to do build
reports from raw data.

### A homegrown JDBC driver
This is fully tailored to Postgres & this application's use case (Not a generic library).

The core ideas are:
- Use PreparedStatment(s) to run all queries (create, update,
  select,...). Intent is to store PreparedStatement(s) in some kind of
  thread local storage.
- Use index based getters on the ResultSet : significantly faster than
  the column based ones for the Postgres jdbc driver.

Here are a couple of examples of how it's used:
```clojure
 {:sql "SELECT id, name, type FROM treatments;"
   :in []
   :out [{:id :int}
         {:name :string}
         {:type :string}]}
```
```clojure
 (def stored-proc-sample-f
    (eval
      (execute-update-fn
        {:sql "{call assign_treatment_to_session(?, ?)}"
         :in [{:user-token :string}
              {:bucket-id :int}]
         :out []})))
```

### Simulation testing
[incomplete]
We have a simulation testing tool that runs various scenarios to test
the integrity of the experimentation platform. Like, ensure the
stickiness of treatment, unbiased allocation of treatments,
correctness of reports, etc. This helped discover some critical bugs
in our domain logic, and in ensuring that the system behaved correctly
despite implemtation changes (like moving to postgres).

### On postgres
#### Why
Due to time and business constraints, we switched to postgres as most
of the problems are already solved in the industry tested software.

#### Loading, querying, reporting
Loading was fast because of bulk load commands - COPY.  Postgres has
an amazing query planner and we had the established relational
database patterns that gave us an unfair advantage. We had to
hand-write the query plans in datalog.  We narrowed our DB writes to a
few stored procs, each of which took no more than 3ms.  This was fast
enough that we could read/write to the DB in realtime and we didn't
need an application cache.


### Anecdotes
#### The "Out Of Memory" story
The application would crash randomly with out-of-memory
errors. Profiling it showed the datomic objects consuming most of the
memory. We tried tweaking the GC config, the datomic config but to no
avail.

We were using an application cache to store recently accessed entities
from DB to help with latencies in reaching datomic. Given that each
datom holds the root the 4 indices (aevt), we had good reason to
suspect that we were holding on to this somehow.

We suspected that datomic was keeping indices in cache and not
flushing to disk often enough, but the Cloudwatch metrics cleared those
suspiscions. The entire team went through the entire codebase line by
line to find such an instance. Finally, Stuart Halloway found it and
fixed it with a simple `map` to `mapv` conversion. We were putting
lazy seqs in caches!

Here's the commit that fixed it:
```clojure
commit c5730986e64bd4c56cbe3b7c390e539bdcfb202b
diff --git a/src/eccentrica/.../store.clj b/src/eccentrica/.../store.clj
index f9ddb82..793dfc6 100644
--- a/src/eccentrica/.../store.clj
+++ b/src/eccentrica/.../store.clj
@@ -28,7 +28,7 @@
-                         :buckets (map
+                         :buckets (mapv
```

#### The super weird network issue
Here's a summary of what was happenning:
- Our application received the request 40ms after the `post-json` fn started in the client.
- TCP RSTs happen immediately (a few microseconds) after the application responds.
- The ACK numbers seem to be 1 off just before the RST.

[Graph that shows the spike in latencies]
[Graph showing the periodic nap that the spikes took]
[RSTs seen in the tcpdump]

We took a tcpdump and recorded the elapsed times at the same time.
The histogram of elapsed times is this:
```clojure
0     1791 /  4422    40.50%  40.50%
5       10 /  4422    00.23%  40.73%
10    1307 /  4422    29.56%  70.28%
15       8 /  4422    00.18%  70.47%
20       2 /  4422    00.05%  70.51%
25       1 /  4422    00.02%  70.53%
30       2 /  4422    00.05%  70.58%
35     399 /  4422    09.02%  79.60%
40     856 /  4422    19.36%  98.96%
45      20 /  4422    00.45%  99.41%
50       4 /  4422    00.09%  99.50%
55       3 /  4422    00.07%  99.57%
60       2 /  4422    00.05%  99.62%
65       2 /  4422    00.05%  99.66%
75       2 /  4422    00.05%  99.71%
80       1 /  4422    00.02%  99.73%
85       3 /  4422    00.07%  99.80%
90       1 /  4422    00.02%  99.82%
95       2 /  4422    00.05%  99.86%
105      6 /  4422    00.14%  100.00%
```
So the faulty 35ms to 45ms totals up to 28.38%.

And we got this info looking at the TCP Dump:
```clojure
| total packets | 30491 |
| RST packets   |  1296 |
| POST methods  |  4400 |
| RST-%         | 29.18 |
```
This looked like conclusive evidence that it's the TCP RSTs that are
leading to these latencies.  We tried using non persistent connections
to see if the problem persisted. It didn't. And it takes just about
200us to establish a new connection. Who knew? So we just didn't do
persistent connections and went about doing other pressing things.

### Other things we can talk about
#### Postgres Replication
Because of the nature of our application (experimentation), it was
crucial for us to protect the integrity and prevent against loss of
data. Hence, we needed a quick failover mechanism in place.

There isn't any out of the box postgres cluster management solution
that fit our need. RDS at that time didn't have read replica support
for postgres. We built this mechanism ourselves using repmgr [link].

Here are a few things we did around this:
- Evaluated postgres latencies on the same box and different box.
- Set up a postgres cluster using repmgr on vagrant.
- We built multiple lines of defence in case of a failover
  1. Repmgr runs a script to notify applications (all running instances) about failover.
  2. Application polls to check if it can write to the master DB. And
     attemps to find the master from the cluster if not
- We load tested this, and were able to achieve a maximum downtime of 5s.
https://raw.githubusercontent.com/StaplesLabs/Eccentrica/master/doc/failover-scenario-load-test.org?token=ABP5t3UCrTRHUpfqJpliUDpl-59IpgpDks5VPO-1wA%3D%3D

#### Postgres Optimizations
- Changed the query's boolean where clause to match the index's
  definition. 30x reduction in query time.
https://github.com/StaplesLabs/Eccentrica/commit/31e3d9f1de29dd028a4190a7e54a2fdcd7c88108
- Trade off memory vs performance on indices. Because our DB was huge, and so were our indexes.
- We thought of trying different indices for reporting, but as of
  postgres 9.5, there isn't a way to do this.
- Tweaking postgres configs for 95th percentile.
- Tweaking os and file system configs for 99th percentile
- Using postgres arrays to denormalize, remove a join.
- Community was amazing. freenode#postgres rocks!

#### ETL written using core.async

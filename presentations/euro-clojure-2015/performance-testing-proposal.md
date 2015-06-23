# Continous & Declarative Performance Testing

## Abstract

In situations where performance is as important as correctness, 
writing automated performance tests smoothly integrates benchmarking
into the development process.

We introduce a framework that will allow us to write performance specifications
that map resources to their performance requirements.

These declarative performance specifications run on every build as part of the
CI strategy, providing the timely feedback necessary for shorter development
cycles. This prevents surprises in the form of performance regressions, enables
test driven performance tuning and helps avoid unnecessary manual evaluation.

## What the attendee will learn

Most non-trivial projects have some definitive performance requirements.
Running performance tests at the end of a development cycle is a terrible idea.
Running them at checkpoints where the developers *feel* like something would
have affected performance is better. But, that too can cause some surprises and
a lot of wasted time looking for bottlenecks.

I will start with a brief look into how browsers do performance testing taking
Talos (https://wiki.mozilla.org/Buildbot/Talos) and the Chrome performance
dashboard (https://chromeperf.appspot.com/) as examples.

I will talk about how we can borrow these ideas and apply them to traditional
http services. In the process, describing a declarative API for writing
performance test specifications along the lines of

```
{
  '/resource' {:specs {'99%' 10 '99.9%' 20 '99.99%' 100}
               :runs 1000
               :threads 20}
  '/resource' {:specs {'99%' 30 '99.9%' 100 '99.99%' 1000}
               :method :post
               :data (constantly 10)
               :runs 1000
               :threads 10}
}
```

I will build upon this API and expand it so it can run parameterized tests,
tests with requests dependant on other responses and other complex
realistic scenarios.

I will also talk about measuring performance correctly. About what numbers
matter, histograms, the uselessness of arithmetic means, whether you
should care about relative or absolute performance (or both) and about timing
correctly.

At this point, I will demo a framework that implements this API and measures
these numbers. I will look at some example tests and the graphs and dashboard
provided.  The framework itself is currently a work in progress and will be
released under an open source license shortly before the conference.

This framework will initially be based on a Jmeter 'driver' that can
be swapped out for something else in the future. I will discuss some
shortcomings of the framework in it's current state such as...

- doesn't resolve the Coordinated Omission Problem
  (https://groups.google.com/forum/#!msg/mechanical-sympathy/icNZJejUHfE/BfDekfBEs_sJ).
- cannot deal with endpoints that take callbacks.
- does not measure response time without the network cost.

... and end with proposing solutions for them...

- correcting measurements based on the expected time between measurements
- using counting semaphores
- measuring response times on the server (and that comes with it's own complications)

... that can be worked on in the future.

----

This talk is a result of building services in the ecommerce domain with strict
performance requirements. Soon after my time on the project, some retrospection
led to better solutions for the problems we faced. It's surprising that
browsers right across the fence have these solutions while web service
developers have to resort to doing this manually or hand roll solutions each
time.
 
I might move some parts around so the talk about the API is directly followed
by a demo of the API itself, based on internal feedback.

## Organizer Comments

## Talk History

I haven't given this talk before. But, I will do some dry runs with some
colleagues and friends from the local tech community.

## Speaker Bio

Ravi Chandra Padmala is a cog in the cooperative at nilenso, a Clojure and
Other Things Software Cooperative. He also happens to be a computer programmer.

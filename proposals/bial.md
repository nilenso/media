# Proposal for BIAL application #

## Introduction ##
We are very excited to put forth our proposal for the maintenance and extension of the BIAL application. Per our discussions with the product owners, we intend to take an incremental approach to improving the usability and functionality of the existing app.

In this proposal, we demonstrate our ability to research and design applications in a manner that offers an immediate benefit to the user, our capabilities in the development of mobile applications, as well our expertise with respect to project management and attention to detail. [Effective communication].

We do this by taking a simple, but powerful example: Building a contextual search feature across the various service providers at the airport (including but not limited to the airport, airlines, restaurants, transport providers). 

[Links]

Please note: The feature has not been fully built. It is intended to give you an idea about our user-centric approach, as well speed of delivery using react native (our platform of choice). The trajectory of the application in the future will depend on the features identified and prioritised after discussions (including research, prototyping, testing) with the various stakeholders involved. 

## Approach ##

### Development ###

### Design ###
Our design team led by Noopur and Varun have experience conducting research to understand the needs of the user as well as their behaviour in the form of: 
 - Contextual inquiry: with a focused set of users, by giving them specific tasks to perform, observing their behaviour and talking to them further about their actions during the exercise, in order to better understand their mental model. 
- Task Analysis: of major tasks, along with the intent to understand and further reduce complexity in workflows. - Persona creation, as well as focus group discussions and interviews to understand our target audience better. 
- Certain tools such as http://www.inspectlet.com/ and https://www.hotjar.com/ record user interactions in a non-intrusive manner, and can be used for better testing on the web.  Our designers are also familiar with user testing methodologies (either prior to launch of a new product or to test acceptance of new features) by creating mockups and prototypes using prototyping tools. 

-- Prototyping and Testing / Iterative Approach

### Process and Project Management ###
Our work has moved us around the country and around the globe, operating in and across many different timezones, with many different project management styles, in a variety of toolchains[1].  

Our default delivery style is based on the classic Extreme Programming methodologies with 1-week iterations, daily standups, TDD, pair programming, and heavy communication. Progress on individual features/stories/cards would be updated in real time (daily) so stakeholders can watch work in-flight.  

We believe that open lines of communication and planning/projection which employs strict measurement and reduces guesswork are critical to the success of any project, so one of our first objectives would be to document all stakeholders (or as many as possible) to ensure the graph of communication was not only open along the channels themselves, but also transparent from the outside, as a whole.  Because of nilenso's offshore and distributed history, we are very familiar with asynchronous communication channels, discussing issues and ideas over a multitude of channels.  

[1] We are intimately familiar with most of the project management tools out there: _Pivotal Tracker_, _Mingle_, _JIRA_, _Trello_, paper-stickies-on-a-wall, and of course, _Github_.  

### Inception ###
An Inception is a high-intensity kickoff to a project, which captures a shared understanding of the high level goals, their priorities, their budgets, and their limitations. The remainder and majority of the Inception then attempts to capture features (or "user stories", preferably, as these frame each feature in terms of how it benefits the end user), estimate them if necessary, and prioritize them. Whether stories are individually estimated or not, they are then packed into a few sample weeks of the project to rough out the expected pace of development. Stories can be reprioritized as the project progresses and the initial projection will be updated every week with the team's actual rate of progress. The project's scope is adjusted every week accordingly. 

### Tech Stack Considerations ###
React Native provides the following advantages:
a) Speed of development

Applications that are built either using React Native, or that have componenets of both Native Android / iOS as well as React Native:
- Facebook
- Instagram
- AirBnB
- Myntra

Other considerations
a) Leveraging the unique capabilites afforded by native development


## Statement of Work ##
Maintenance work including incremental development

Proposed features (please note this is an indicative sample set, a comprehensive list will be arrived at by speaking to the various stakeholders involved, if required conducting surveys, and building and testing prototypes)

### Proposed Sample Features: Near-Term ###
- "Spotlight" style search [Appendix]
- Improving the search based on past user queries
- In-app vs google places vs additional search [Appendix 2: Benefits -- Intent based search, Discoverability -- improve accessibility]

### Proposed UX improvements: Near-Term ###
- Allow iOS users to swipe back to go to the previous screen (accepted UX behaviour in iOS)
- Allow users to track more than one flight

### Proposed Sample Features: Medium-Term ###
- Flight Check-in
- Booking a bus from and to the airport (including payment)
- Booking a cab from and to the airport (including payment)
- B2B: allow service providers to update their profiles, which will appear in the app (and search) once vetted
- B2B: allow service providers to A/B test their offers across various categories of users

### Long-Term Vision ###
- Developing a plug-and-play portal for the entire airport ecosystem, including employees, airlines, service providers located at and away from, the airport


### Staffing and Timelines ###


### Rates ###
We propose a discounted rate of Rs. 10,00,000 (+ service taxes) per month for a pair of developers.


## About Us ##
nilenso is a boutique software consultancy based in Bangalore (India). In our 4-year history, we have built large machine learning, analytics, streaming data, experimentation, and mapping/transportation systems. We continue to run the largest of these systems in production for our clients today. 

You can read more about our recent work at:  
> http://nilenso.com/recent-tech.html.  

Our designers and developers speak regularly at conferences, the talks that were recorded over the years can be found here:  
> http://nilenso.com/talks.html  

### Our Experience in Development ###  
Our team consists of software developers and project managers with decades of experience delivering modular code on lean/agile teams, employing practices which have evolved with the industry over the past two decades.  Our industry experience spans a wide range of verticals: from defense and policing to healthcare, transportation, and climate change. The languages we are familiar with (based on experience within, as well as prior to, nilenso) include Java, Ruby, Python, C#, JavaScript, C/C++, Clojure, Haskell. 

We have built services and infrastructure within the Staples SparX machine learning team for over 3 years. Staples' Experimentation Platform (EP), in particular, is entirely designed, built, and operated by nilenso. EP handles many terabytes of streaming data at a rate of 500 requests per second under a Service Level Agreement (SLA) of <10ms in the 99.9th percentile. 

We have presented on the Experimentation Platform architecture at Functional Conf 2015:  
> https://www.youtube.com/watch?v=YjfXhhxw9Bs  

EP also involves nontrivial database clustering techniques, which have evolved with the lifespan of the project. Synchronous replication, failover to standby databases, ZFS snapshots, custom PostgreSQL MVCC AUTOVACUUM configurations, WAL streaming, realtime (non-star-schema) reporting replicas, DB and I/O monitoring, partitioning, logical replication, load balancing, and multi-mode failure detection all must be understood by every member of our team working on database clusters.  We have presented on building a PostgreSQL DB cluster at Rootconf 2016:  
> - https://www.youtube.com/watch?v=sGJDg5ba0iI  

We have contributed to monitoring infrastructure in many recent software projects. This includes system-level, JVM-level, application-level, and DB-level monitoring on all of our projects. We have been allowed to release some of the DB and DB monitoring work as open source. All of these repositories are focused on PostgreSQL: 
> - https://github.com/nilenso/honeysql-postgres (not monitoring specific) 
> - https://github.com/staples-sparx/wonko > - https://github.com/staples-sparx/wonko-client 
> - https://github.com/staples-sparx/pg-cluster-setup 
> - https://github.com/staples-sparx/repmgr-to-zk 
> - https://github.com/nilenso/postgresql-monitoring  

Unfortunately, although we have implemented internationalization (i18n) and built or extended translation tools on a number of projects, very little of this work is open source.  Similarly proprietary is our most recent legacy replacement work on the driver allocation service for an Indonesian Uber competitor. We rewrote this service in Clojure with an extensive generative testing suite (and minimal unit tests for single-value edge cases). Thanks to generative testing and developer discipline, the service was released with zero production issues and completely replaced the legacy software on its first day in production.  

We also rewrote Staples SparX's configuration management, legacy data feed integration, and reporting tools in Clojure. This work involved a different style of testing. First, these services were built with large and comprehensive unit test suites for all known use cases. Then the new services were delivered alongside the legacy (Ruby) services in all environments and validated for multiple months. Once the Clojure services produced results consistent with the legacy services (as confirmed by automated validation software provided by us to the QA team), 3rd party services were redirected to new APIs and the legacy services were turned off. This process was slow but not expensive and finished without a single interruption to existing clients.  

Developers from nilenso have also run training and courses in ReactJS, Haskell, and Clojure.  

### Our Experience in Design ###  

Our small design team is led by Noopur and Varun. Noopur has studied Information and Interface Design at NID, while I have worked as a freelance designer and more recently, as a product designer at Scroll.in and SupportBee. Between them, we have designed web apps as well as iOS and Android mobile applications. They also have experience with user research, prototyping, wireframing, and writing good quality html/css.

They have produced a lot of impactful work in a short span of time. Some of their recent work has been open sourced:  
> - http://samanvayfoundation.org 
> - https://github.com/OpenCHS 

### Our Experience in Project Management ### 

Our project managers (Deepa and Steven) have, between them, managed nilenso as a project, led open source projects built by nilenso ([time tracker]) and kosha [link]) as well as teams of dozens of developers, locally and across the globe. We have both built software teams by managing hiring and staffing decisions and by consulting, to enhance existing teams or recover failing teams. 

Deepa brings to nilenso and the projects she manages significant business expertise from her previous roles as an investment banker, and entrepreneur. Steve has led software teams for a decade across the Americas, Europe, and Asia. He has run project Inceptions as short as one day for a small nonprofit and as long six weeks for a data warehousing company looking to redefine its entire vision.  









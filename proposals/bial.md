# Proposal for BLR Airport App #

## Introduction ##
We are very excited to put forth our proposal for the maintenance and extension of the BLR Airport App. Per our discussions with the product owners, we intend to take an incremental approach to improving the usability and functionality of the existing app.

In this proposal, we aim to demonstrate our ability to research and design applications in a manner that offers an immediate benefit to the user, our capabilities in the development of mobile applications, as well our expertise with respect to project management and attention to detail. [Effective communication -- I don't think this is necessary as it's a direct consequence of the communication methods we'll list below. -sd].

We do this by taking a simple but powerful example: Building a contextual search feature across the various service providers at the airport (including but not limited to the airport, airlines, restaurants, and transport providers). 

[Link to Prototype section?]

Please note: The aforementioned Search feature is only a prototype. It is intended to give you an idea about our user-centric approach, as well speed of delivery using React Native (our mobile platform of choice). The trajectory of the application in the future will depend on the features identified and prioritised after discussions (including research, prototyping, and testing) with the various stakeholders involved. 

## Approach ##

### Development ###

Our development style is familiar to most of our potential clients. Test-Driven Development (TDD), continuous integration/deployment, and pair programming are hallmarks of any competent software engineering firm in 2017. Developers at nilenso strive to excel beyond this, however.

Over the past 3 years, we have built distributed systems which handle many terrabytes of data per month, we have tested these systems using progressive testing strategies such as simulation and generative testing, and we have adopted the highest-level languages available for commercial software development today as our preferred environments: Clojure and Haskell. We are not wedded to any of our techniques or tools, instead looking to improve our effectiveness by incrementally adopting new technology if it proves better than what came before it, and as it stabilizes in the market.

### Design ###

Our design team led by Noopur and Varun have experience conducting research to understand the needs of the user as well as their behaviour in the form of: 

- Contextual inquiry: with a focused set of users, by giving them specific tasks to perform, observing their behaviour and talking to them further about their actions during the exercise, in order to better understand their mental model. 
- Task Analysis: of major tasks, along with the intent to understand and further reduce complexity in workflows. - Persona creation, as well as focus group discussions and interviews to understand our target audience better. 
- Certain tools such as http://www.inspectlet.com/ and https://www.hotjar.com/ record user interactions in a non-intrusive manner, and can be used for better testing on the web.  Our designers are also familiar with user testing methodologies (either prior to launch of a new product or to test acceptance of new features) by creating mockups and prototypes using prototyping tools. 

[-- Prototyping and Testing / Iterative Approach]

### Process and Project Management ###

Our work has moved us around the country and around the globe, operating in and across many different timezones, with many different project management styles, in a variety of toolchains[1].  

Our default delivery style is based on the classic Extreme Programming methodologies with 1-week iterations, daily standups, TDD, pair programming, and heavy communication. Progress on individual features/stories/cards would be updated in real time (daily) so stakeholders can watch work in-flight.  

We believe that open lines of communication and planning/projection which employs strict measurement and reduces guesswork are critical to the success of any project, so one of our first objectives would be to document all stakeholders (or as many as possible) to ensure the graph of communication was not only open along the channels themselves, but also transparent from the outside, as a whole.  Because of nilenso's offshore and distributed history, we are very comfortable with most asynchronous communication channels.

[1] We are intimately familiar with most of the project management tools out there: _Pivotal Tracker_, _Mingle_, _JIRA_, _Trello_, paper-stickies-on-a-wall, and of course, _Github_.  

### Inception ###

[Do we want to take this out? I don't think we'd do an inception with BIAL, would we? The app is already off the ground. I'm actually not sure about this but it does feel weird to advertise inceptions in this document for a project we're inheriting from ThoughtWorks. Innovation Lab folks are probably intimately familiar with inceptions by now. -sd]

An Inception is a high-intensity kickoff to a project, which captures a shared understanding of the high level goals, their priorities, their budgets, and their limitations. The remainder and majority of the Inception then attempts to capture features (or "user stories", preferably, as these frame each feature in terms of how it benefits the end user), estimate them if necessary, and prioritize them. Whether stories are individually estimated or not, they are then packed into a few sample weeks of the project to rough out the expected pace of development. Stories can be reprioritized as the project progresses and the initial projection will be updated every week with the team's actual rate of progress. The project's scope is adjusted every week accordingly. 

### Tech Stack Considerations ###

React Native provides the execution team with a cross-platform framework with a solid industry track record. Cross-platform development for Android and iOS requires that the development team is able to work with lower-level constructs in Java and Objective-C (or Swift) to render applications with a fully native look-and-feel. React Native provides this, providing the best of both worlds: A low-risk, cross-platform environment for speed of development (and thus, experimentation) and native platform code on both Android and iOS where it is needed for integration or performance.

Additionally, React Native brings the world-class immutable object-model rendering framework, which began with ReactJS, to mobile platforms. The value of immutable architectures should not be understated. A modern iPhone contains 4 CPU cores -- heavy multi-threading and careful resource management are no longer the domain of industrial-strength server farms. Beyond modern technical considerations, immutable architectures reduce complexity and failure rates, which in turn reduces development time, maintenance costs, and time spent supporting software in production.

React Native has quickly become a dominant player in the mobile market in applications which are not inherently platform-specific (such as games). Applications that are built either using React Native, or that have componenets of both Native Android / iOS as well as React Native:

- Facebook
- Instagram
- AirBnB
- Myntra

[Other considerations -- I'm not sure we need this section. -sd]
a) Leveraging the unique capabilites afforded by native development


## Statement of Work ##

Maintenance work including incremental development

Proposed features (please note this is an indicative sample set, a comprehensive list will be arrived at by speaking to the various stakeholders involved, if required conducting surveys, and building and testing prototypes)

### Proposed Sample Features: Near-Term ###

- "Spotlight" style search [Appendix]
- Improving the search based on past user queries
- In-app vs google places vs additional search [Appendix 2: Benefits -- Intent based search, Discoverability -- improve accessibility]
- WiFi without signin to allow app download

### Proposed UX improvements: Near-Term ###

- Allow iOS users to swipe back to go to the previous screen (accepted UX behaviour in iOS)
- Allow users to track more than one flight

### Proposed Sample Features: Medium-Term ###

- Flight Check-in
- Booking a bus from and to the airport (including payment)
- Booking a cab from and to the airport (including payment)
- B2B: provide flight status across multiple flights to transport and hospitality industry partners
- B2B: allow service providers at the airport to update their profiles, which will appear in the app (and search) once vetted
- B2B: allow service providers to A/B test their offers across various categories of users
- Update on waiting times (Predictive modeling for traffic flow)

### Long-Term Vision ###

- Developing a plug-and-play portal for the entire airport ecosystem, including employees, airlines, service providers located at and away from, the airport

## Staffing and Rates ##

To start with, we propose a blended rate of $80/hr per person for a team of the following:

- 1 full-time designer (100% of the time)
- 1 full-time developer (100% of the time)
- 1 part-time architect [too much? -sd] (25% of the week)

Business Analyst(s) / Project Manager(s) who will not be billed explicitly (their time is accounted for in the blended rate).

So, indicatively, the total monthly billing for the team would be $21,600.

In the future, the team can be augmented based on requirements as well as availability.


## Prototype ##

For the prototype, we chose to:

- Redesign the Flight Tracking functionality.
- Build a Search functionality over the various sections of the application.

### Advantages afforded by the Tracking functionality redesign

- Allow tracking of multiple flights, so different people from different cities can be easily tracked. This would be especially useful to individuals tracking the arrival of their family members (for instance during festivals, or an event such as a wedding) and service providers such as hotels who can aggregate pickups. 
- Introduce a widget on the homescreen for easy access, so the user would not need to look for this information each time.
- Optionally allow the app to give you notifications on a locked screen. This could be very helpful in ensuring that a passenger waiting for the departure of their flight never misses it.

[Links to previous version, and the redesigned version]

### Advantages afforded by the Search functionality ###

- Ease of use for new users: Currently, the application expects users to navigate through the various categories provided on the home screen (Eat, Facilities) to find what they are looking for. New users who are not already familiar with the layout of the app may find this design difficult to use. Search functionality that cuts across categories offers a powerful advantage to the existing traditional layout.
- Speed of use: This overarching Search functionality allows users who are already familiar with the app to quickly find what they are looking for, and reduce the number of clicks they need to make.
- Intuitive design: The Search allows users to search by words (example: Filter Coffee), rather than click through the various options to find a restaurant that serves filter coffee.
- Analytics: Allowing users to search using keywords of their choice rather than navigating through the app could be a valuable source of information on the expectations of passengers (and eventually other users of the app). This insight can be ploughed back into improving the services provided (both by the airport authority, and other service providers) at the airport.

Eventually, the search functionality can be extended to account for the following:

- Auto-Complete: Performs and refreshes search  for every key entered and suggests probable complete keywords for partially typed keywords.
- Adaptive: Frequently chosen results appear higher in the results list for quicker usage. 
- User History: Most frequent searches of that specific user can appear higher on the list.
- Context Aware: Only those actions that are available with respect to the current selection are shown in the search results (example: domestic vs international passengers).

[Links]

## Appendix - About Us ##

nilenso is a boutique software consultancy based in Bangalore. In our 4-year history, we have built large machine learning, analytics, streaming data, experimentation, and mapping/transportation systems. We continue to run the largest of these systems in production for our clients today. 

You can read more about our recent work at:  
> http://nilenso.com/recent-tech.html.  

Our designers and developers speak regularly at conferences, the talks that were recorded over the years can be found here:  
> http://nilenso.com/talks.html  

### Our Experience in Development ###  

Our team consists of software developers and project managers with decades of experience delivering modular code on lean/agile teams, employing practices which have evolved with the industry over the past two decades.  Our industry experience spans a wide range of verticals: from defense and policing to healthcare, transportation, and climate change. The languages we are familiar with (based on experience within, as well as prior to, nilenso) include Java, Ruby, Python, C#, JavaScript, C/C++, Clojure, Haskell. 

[Summary paragraph on EP -- I'm debating whether or not this is even necessary. Feels out of place so I'm having trouble writing it. -sd]

### Our Experience in Design ###  

Our small design team is led by Noopur and Varun. Noopur has studied Information and Interface Design at NID, while I have worked as a freelance designer and more recently, as a product designer at Scroll.in and SupportBee. Between them, they have designed web apps as well as iOS and Android mobile applications. They also have experience with user research, prototyping, wireframing, and writing good quality html/css.

They have produced a lot of impactful work in a short span of time. Some of their recent work has been open sourced: 

> - http://samanvayfoundation.org 
> - https://github.com/OpenCHS 

### Our Experience in Project Management ###

Our project managers (Deepa and Steven) have, between them, managed nilenso as a project. In addition, led open source projects built by nilenso ([Time Tracker](https://github.com/nilenso/time-tracker), [Kosha](https://github.com/nilenso/kosha), and [Kulu](https://github.com/nilenso/kulu), amongst others) as well as teams of dozens of developers, locally and across the globe. They have both built software teams by managing hiring and staffing decisions and by consulting, to enhance existing teams or recover failing teams. 

Deepa brings to nilenso and the projects she manages significant business expertise from her previous roles as an investment banker and entrepreneur. Steven has led software teams for a decade across the Americas, Europe, and Asia. He has run project Inceptions as short as one day for a small nonprofit and as long six weeks for a data warehousing company looking to redefine its entire vision.  


# HOT OSM Task Manager 3 Tech Challenge #

# Application: Nilenso Software LLP #


## Introduction ##

Throughout this application, we hope to address all questions and concerns outlined in the Task Manager 3 (TM3) Tech Challenge (TM3TC). Our team is familiar with HOT, participates in the OpenStreetMap community, and is particularly well-equipped to handle the both the technical and non-technical challenges of the TM3TC. Our company also has a very specific vision of progressively delivering more of our work as open source, preferably around open data, with each project we take on. When we evaluate, sell, and staff projects at nilenso it is rare to come across one so well-aligned as this. We are very excited to apply to the challenge!

We have arranged our application in a slightly different order than the format of the TM3TC document or the project Terms of Reference (ToR). Because it affects absolutely every aspect of the project, collaboration and communication is mentioned multiple times in both of these documents. We feel this is a key issue, and we have started our application with this topic and how we plan to address it.

After collaboration, we brief our company's skillsets and then dive into our experience in, and approach to, project management, design, and development. We intend to staff people from each of these three roles on this project.

Finally, we will directly address how we will achieve the goals outlined in the TM3TC and present our company's qualifications for taking on such a project.


## Collaboration ##

Nilenso is a boutique software consultancy based primarily in Bangalore (India). In our 3-year history, we have built large machine learning, streaming data, experimentation, and mapping/transportation systems. We continue to run the largest of these systems in prouction for our clients today.

No two customers are ever alike and we do not have a strict approach to collaboration with our clients' teams. Our work has moved us around the country and around the globe, operating in and across many different timezones, with many different project management styles, in a variety of toolchains[1]. Our default delivery style is based on the classic Extreme Programming methodologies with 1-week iterations, daily standups, TDD, pair programming, and heavy communication. However, our PM and communication has spanned heavier up-front design, kanban pull queues, or (in rare cases) no process at all. Some clients prefer we speak to them as much as physicaly possible... some prefer to leave us with high-level technical requirements and check in every couple weeks.

What matters most in our collaboration with customers is not the particular strategy used, project management style, or tools chosen. The essential qualities of a successful project are open lines of communication and planning/projection which employs strict measurement and reduces guesswork. The ToR Methodology bullet "A." diretly addresses this first point by identifying the varied channels which stakeholders will be employing. To take this a step further, one of our first objectives would be to document all stakeholders (or as many as possible) to ensure the graph of communication was not only open along the channels themselves, but also transparent from the outside, as a whole.

Planning and projection demands a heartbeat of some sort, and even when using a kanban pull queue to prioritize work, some period (often one week) must be used to measure progress and project into the future with the same metric. Progress on individual features/stories/cards would be updated in real time (daily) so stakeholders can watch work in-flight. The one-week period would be a summarization window for work accomplished, since daily progress is usually too narrow a window to make meaningful predictions.

See: TM3TC "Scope of Work" 1. Collaboration

[1] We are intimately familiar with most of the project management tools out there: Pivotal Tracker, Mingle, JIRA, Trello, paper-stickies-on-a-wall, and of course, Github.


The other side of the reporting and planning coin is, of course, the approval process for new work. The TM3TC is somewhat ambiguous as to whether anyone from the HOT community will take on the responsibility of owning final approval and prioritization or if this will fall to the development team. This is one area where we do strongly feel an authority is required, even if this person (or people) act as a facilitator rather than a gatekeeper. A group approval and prioritization process is possible if it is executed in real time, and we would strongly recommend one such process which we have used to great success on many projects: a project _Inception_.

An Inception is a high-intensity kickoff to a project which captures a shared understanding of the high level goals, their priorities, their budgets, and their limitations. The remainder and majority of the Inception then attempts to capture features (or "user stories", preferably, as these frame each feature in terms of how it benefits the end user), estimate them if necessary, and prioritize them. Whether stories are individually estimated or not, they are then packed into a few sample weeks of the project to rough out the expected pace of development. With this initial projection, 4 months worth of TM3 stories can be laid out in priority order and we will know roughly how much the team feels they can accomplish in that period.

Stories can be reprioritized as the project progresses and the initial projection will be updated every week with the team's actual rate of progress. The project's scope is adjusted every week accordingly.

While not every project we execute begins with an Inception, there should be some form of project kickoff which ensures stakeholders are in agreement about what they hope to achieve within their budget and timeframe and what the development team anticipates they can deliver. Inception or otherwise, this initial project kickoff should leave teh development team confident they clearly understand the deliverables and dates -- and leave the stakeholders clear and unambiguous about high-level goals and what they are likely to see at the end of 4 months. If either side is confused or unhappy at this very easly stage, we would go back and clarify or re-evaluate the project. We do not start projects without the confidence we can deliver what is being asked of us.

During the project, new feature requests can of course come from the stakeholders through the various channels into a structured approval and prioritization process. If all cards/stories are ordered by priority from the beginning, it will be easy for the team to collectively prioritize (or for an authority to individually prioritize) individual stories against that total ordering.

See: TM3TC "Scope of Work" 2. Proposal / Approval of feature implementation

Another important aspect of collaboration will be that of nilenso with any other contributors from within the community. As TM3TC encourages individual community contributors to apply, we similarly want to encourage a mixed-mode award of the contract. We would be more than happy to work with a contributor(s) who has more experience with HOT or OSM in general, either as an active community member or active contributor to HOT tools.

While we are applying for the entire Scope of Work (SoW), we happily acknowledge that this may not be possible or optimal.

See: TM3TC "Scope of Work"
See: TM3TC "How to Participate" 1. Identification, 3. SoW Fit


Our collaboration strategy involves user testing and user feedback of new features, solidifcation of existing features, User Experience, and design in general. While known stakeholders can be actively communicated with, one of the most important goals of TM3 is the onboarding of new Mappers. The design for a new Mapper begins outside the scope of the project itself: How did they hear about OSM? How did they learn about HOT? What do they hope to achieve? How easy/difficult is it for them and how long does it take? How can we make that entire transition smoother from the very beginning?

These questions are best addressed by our Design team and on a continuing basis. Passive feedback may involve providing an easy feedback mechanism through HOT and OSM channels, within the website or within the app. Active feedback could involve cafe testing, explicit new user solicitation exercises, and surveys.

User Experience feedback from experienced Mappers, Validators, and Project Managers will be easier, as we can reach out to them directly and afford them multiple channels to reach the TM3 team. The team can then centralize and collate this feedback and look to formalize changes (in the form of stories) based on problems identified or positive UI/UX/documentation patterns users would like to see repeated elsewhere.

One consideration for this latter case is how such an open feedback system will work once the 4 months of the TM3 project have ended. If the feedback mechanisms are too open or too ad-hoc for the community to manage, we may need to consider a more structured approach, such as a single-channel "report an issue" feature within the app itself or Github issues (though these can be offputting for less technical users).

See: TM3TC "How to Participate" 7. UI Testing and UI Feedback
[ Note: "UI Testing" and "QA Testing" are separate, and largely unrelated, topics and we address the latter below, under "Development" ]






- collaboration
  sow: 1, 2 - collaboration, proposal / approval
  proposal: 1 - company + community, [2], 3 - sow, 7 (feedback)
  evaluation: 4, 5, 6 - sustainability, community strategy (features)

- skillsets: dev, design, pm
  evaluation: 2 - "reuse" (modularity, SoA)

- project management
  proposal: 2, 6 - timeline & feature list
  proposal: 4 - discovery process
  evaluation: 5 - features (community strategy)

- design
  sow: [2], 6 - ux "tests"
  goals: 3 - ui/ux

- development
  sow: [2], 3, 4, 5 - development, docs, tests
  goals: 5 - apis
  proposal: 5, 7 (testing) - stack & testing
  evaluation: [4, 6] - scalable, sustainable
  shiny vs. new

- achievement of goals
  goals: 1 - 4
  goals 5 under "development"

- who/what is nilenso?
  proposal: 8 - our qualifications
  evaluation: 1, [2], 3 - nilenso, reuse, familiarity

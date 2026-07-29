// Folded A4 glossary: print double-sided, flip on the short edge, then fold.
#set page(
  paper: "a4",
  flipped: true,
  margin: 12mm,
)

#set text(
  font: "Libertinus Serif",
  size: 8pt,
  lang: "en",
)
#set par(justify: true, leading: 0.48em)

#let pink = rgb("#ff3f93")
#let pale = rgb("#f3f3f3")
#let why-grey = rgb("#444444")

#let spread(left, right) = block(width: 100%, height: 100%)[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr,),
    gutter: 20mm,
    left,
    right,
  )
]

#let section-title(title) = block(
  width: 100%,
  above: 0pt,
  below: 0pt,
)[
  #v(2pt)
  #text(size: 11.4pt, fill: pink)[#title]
  #v(0pt)
  #line(length: 100%, stroke: (paint: black, thickness: 0.55pt))
  #v(2pt)
]

#let entry(term, definition) = (
  [
    #set par(justify: false)
    #strong(term)
  ],
  [
    #set text(weight: 600)
    #show regex("◆\\s*.*"): it => text(fill: why-grey, weight: "regular")[
      #(
        it.text
          .replace(regex("^◆\\s*"), "")
          .replace(regex("\\s*◆$"), "")
      )
    ]
    #definition
  ],
)

#let glossary(rows) = table(
  columns: (22%, 78%),
  inset: (x: 4pt, y: 4pt),
  row-gutter: 4.5pt,
  gutter: 0pt,
  stroke: none,
  fill: (_, y) => if y == 0 {
    none
  } else if calc.odd(y) {
    pale
  } else {
    none
  },
  ..rows.flatten(),
)

#let sources-list(items) = {
  set text(size: 8pt)
  set par(leading: 0.48em)
  items.join([ ◆ ])
}

// Logical page 1
#let page-one = [
  #text(size: 20pt, weight: "bold")[Glossary of AI Terms]
  #v(-10pt)
  #text(size: 8pt)[July 2026 | #strong[nilens]#text(fill: pink, weight: "bold")[o]]
  #v(0pt)
  #emph[Use this glossary to understand common AI terms in simple language.]
  #v(12pt)

  #section-title[The Basics]
  #glossary((
    entry(
      [Artificial intelligence],
      [A broad field of computer science and engineering. ◆ Today, AI often refers to LLMs, but the field also includes machine learning, computer vision, speech recognition, and robotics.],
    ),
    entry(
      [Artificial general intelligence],
      [AI able to perform a wide range of intellectual tasks at a human level. ◆ AGI remains an unsettled, long-term goal; most practical work focuses on solving specific problems today.],
    ),
    entry(
      [Base model],
      [A powerful text-completion engine that is not yet a conversational assistant. ◆ Only a limited number of organisations train base models because doing so is extremely expensive. These models can then be customised and taught new skills or behaviours.],
    ),
    entry(
      [Open-weight models],
      [Models whose trained parameters are available to download and run. ◆ Open weights make local use, customisation, and inspection possible, but the licence, training data, and source code may still be restricted.],
    ),
    entry(
      [Small language model (SLM)],
      [A language model designed with relatively few parameters and modest computing needs. ◆ SLMs can run faster, cost less, and work on local devices, but they usually handle fewer or narrower tasks than larger models.],
    ),
    entry(
      [Context],
      [The information available to an AI for its current response. ◆ Context acts as short-term memory and may include instructions, conversation history, documents, and tool results. Clear, relevant context improves results. #parbreak() #text(fill: why-grey, weight: "regular")[System prompts provide hidden instructions that define the AI’s role and behaviour.]],
    ),
    entry(
      [Inference],
      [Running a trained model to produce an answer. ◆ During inference, the model predicts a response from the supplied context, using time and computing resources.],
    ),
    entry(
      [Stochastic],
      [AI’s probabilistic nature—like rolling the dice. ◆ This is why you can get a different answer every time you ask the same question. It allows for creativity but also unpredictability.],
    ),
    entry(
      [Hallucination],
      [When AI produces plausible-sounding information that is not supported by facts. ◆ You can reduce hallucinations, but not completely prevent them, so important answers should always be checked.],
    ),
    entry(
      [Chain-of-thought],
      [Intermediate reasoning used to work through a problem. ◆ Asking a model to reason step by step can improve difficult answers, though it may take more time.],
    ),
  ))

]

// Logical page 2
#let page-two = [
  #section-title[AI Training]
  #glossary((
    entry(
      [Neural networks],
      [Computational models inspired by the brain’s structure. ◆ They are the core technology that enables AI to learn from text and generate human-like responses.],
    ),
    entry(
      [Neural network architecture],
      [The mathematical design of a neural network. ◆ Architecture affects learning, scalability, supported modalities, and cost. Examples include Transformers, Mixture of Experts, and State Space Models.],
    ),
    entry(
      [Transformer],
      [The main neural network architecture used for language models today. ◆ Transformers let a model focus on the most relevant parts of its input, helping it understand context and nuanced meaning.],
    ),
    entry(
      [Diffusion],
      [Generating images, audio, or video by gradually turning random noise into structured output. ◆ Diffusion models may use U-Nets or transformer-based architectures to create modern AI media.],
    ),
    entry(
      [Parameters],
      [The learned "long-term" memory, represented as billions of numbers. ◆ Models with more parameters can be trained on more data and gain more capabilities. They are also slower and more expensive to train and run. Smaller models are usually cheaper and faster, but less capable.],
    ),
    entry(
      [Tokens],
      [Units of text processed by a language model. ◆ A token may be part of a word, a whole word, or a symbol. Tokenisation affects cost, context limits, spelling tasks, and multilingual performance.],
    ),
    entry(
      [Hyperparameters],
      [Settings that affect how the model works. ◆ These include the number of layers, vocabulary size, and dimensions of the model. By adjusting these settings, you can make the AI learn better. It often takes trying different options to find what works best.],
    ),
    entry(
      [Fine-tuning],
      [Adapting a pre-trained model for a specific task. ◆ Training it on specialised data can improve targeted performance, sometimes at the cost of general capabilities.],
    ),
    entry(
      [Reinforcement learning],
      [Training a model using rewards for successful behaviour. ◆ RL helps models develop strategies for tasks such as reasoning and coding. #parbreak() #text(fill: why-grey, weight: "regular")[Feedback may come from humans (RLHF) or another AI model (RLAIF).]],
    ),
    entry(
      [Instruct model],
      [A base model that has been fine-tuned to be an honest, harmless, and helpful assistant. ◆ This is the type of model most people interact with. The fine-tuning process is what makes it useful for real-world tasks.],
    ),
    entry(
      [Distillation],
      [Training a smaller model to imitate a larger one. ◆ The result is usually faster and cheaper, but may be less capable or accurate.],
    ),
    entry(
      [Quantisation],
      [Making AI models smaller and faster by using lower-precision numbers. ◆ Using fewer bits can help models run on phones, smart devices, or other low-power hardware.],
    ),
    entry(
      [Multimodal],
      [Models that can work with more than one type of data, such as text, images, audio, or video. ◆ This lets an AI understand mixed inputs—for example, answering a question about an uploaded image.],
    ),
  ))
]

// Logical page 3
#let page-three = [
  #section-title[AI Engineering]
  #glossary((
    entry(
      [Embeddings],
      [Numeric representations that capture meaning. ◆ Embeddings enable similarity search across differently worded content and are often stored in vector databases.],
    ),
    entry(
      [Retrieval-augmented generation],
      [Retrieving relevant information and giving it to an LLM as context. ◆ RAG grounds responses in documents or data without retraining the model, improving relevance and reducing unsupported answers.],
    ),
    entry(
      [Sampling],
      [Settings that control predictability and creativity. ◆ Higher temperature gives more creative responses, while lower top-p and top-k make responses more predictable. Generating fewer responses also saves computing resources.],
    ),
    entry(
      [Thinking effort],
      [A setting that guides how much internal reasoning a model uses before answering. ◆ Higher effort can improve difficult tasks, but usually increases latency and token use; the best level depends on the model and task.],
    ),
    entry(
      [Context rot],
      [Performance loss as context becomes longer, noisier, or contradictory. ◆ Causes include false, outdated, irrelevant, or conflicting information. Keeping context focused reduces these effects.],
    ),
    entry(
      [Context engineering],
      [Choosing, organising, and removing information in an LLM’s context window so it receives what it needs for the current step. ◆ Good context engineering improves results while reducing distraction, latency, and cost.],
    ),
    entry(
      [Compaction],
      [Shortening a long conversation or agent history into a smaller summary that preserves the information needed to continue. ◆ Compaction helps agents work beyond context limits and reduces cost, but important details can be lost.],
    ),
    entry(
      [Memory systems],
      [Systems that store and retrieve information for an AI across steps, sessions, or users. ◆ They extend beyond the current context window, helping agents maintain continuity while requiring care to avoid stale or incorrect memories.],
    ),
    entry(
      [Shared prefix caching],
      [Keeping the beginning of prompts consistent so an AI provider can reuse work it has already processed. ◆ Reusing fixed instructions and shared history can greatly reduce response time and token costs across agent steps.],
    ),
    entry(
      [Tools],
      [External programs an AI can call, such as search, calculators, databases, or code interpreters. ◆ Tools provide current information, precise computation, and the ability to act on files or other systems.],
    ),
    entry(
      [Model Context Protocol (MCP)],
      [An open standard for connecting AI applications to external data, tools, and workflows. ◆ MCP gives agents one common way to work with many different systems, reducing the need for custom integrations.],
    ),
    entry(
      [Skills],
      [Reusable agent instructions, workflows, and tool guidance stored in Markdown files, often with structured YAML metadata at the top. ◆ Skills are easy for people to read, edit, share, and version alongside code.],
    ),
    entry(
      [Tool loadout],
      [Giving an agent only the small set of tools relevant to its current task instead of every available tool. ◆ A focused tool loadout reduces prompt size, confusion, and calls to the wrong tool.],
    ),
    entry(
      [Sandbox],
      [An isolated environment where an AI agent can run code or use tools with limited access. ◆ Sandboxes reduce the damage from mistakes or malicious instructions by restricting files, networks, permissions, and resources.],
    ),
    entry(
      [Agent harness],
      [The software around an LLM that gives it access to files, tools, sessions, and other capabilities. ◆ A harness turns a model that mainly produces text into an agent that can take actions, keep track of work, and complete multi-step tasks.],
    ),
  ))
]

// Logical page 4
#let page-four = [
  #section-title[AI Engineering (continued)]
  #glossary((
    entry(
      [Harness engineering],
      [The practice of designing the software and workflows around an AI agent. ◆ Good harness engineering gives the model useful tools, clear feedback, safe execution, persistent state, and reliable ways to continue or recover.],
    ),
    entry(
      [Durable execution],
      [Persisting an agent’s steps, tool results, and state. ◆ After a crash or interruption, the agent can resume instead of starting over.],
    ),
    entry(
      [Agents],
      [AI systems that can autonomously perform a sequence of tasks over time to achieve a complex goal. ◆ Agents represent the shift from single-shot commands to having AI assistants that can manage long-running jobs and projects.],
    ),
    entry(
      [Multi-agent system],
      [A group of agents that collaborate to achieve a single goal. ◆ This can help work around context limits, parallelise tasks, and cover more ground in problems like research or decision-making.],
    ),
    entry(
      [Traces],
      [A step-by-step record of what an AI system does while handling a request. ◆ Traces help you understand behaviour, diagnose issues, and improve the system.],
    ),
    entry(
      [Evals],
      [Tests of whether an AI produces useful, accurate, and safe results. ◆ Evals reveal regressions and guide improvements. They may use unit tests, human review, or an LLM-as-a-judge.],
    ),
    entry(
      [Benchmarks],
      [Standardised test sets used to compare models or AI systems. ◆ Benchmarks provide a common scorecard, but high scores may not predict performance on a specific real-world task.],
    ),
    entry(
      [Prompt optimizers],
      [Tools that automatically generate, test, and improve prompts against examples or evals. ◆ They can find better instructions faster than manual tweaking, but may overfit to the test set.],
    ),
    entry(
      [Guardrails],
      [Safety rules to control model outputs. ◆ Guardrails help reduce the chance of the AI giving bad or harmful answers. But they are not perfect. It’s important to use them wisely and not rely on them completely.],
    ),
    entry(
      [Graph/Loop engineering],
      [Designing an AI workflow as connected steps and repeating cycles. ◆ Graphs make paths and decisions explicit, while loops define how the system observes results, retries, stops, or asks for help.],
    ),
    entry(
      [Software factory],
      [A standardised, automated system for building, testing, deploying, and maintaining software. ◆ It brings tools and workflows together so teams can deliver software more efficiently and reliably.],
    ),
  ))

  #section-title[Sources]
  #sources-list((
    link("https://ai-execs.com/3b_glossary.html")[Hamel Husain’s Glossary],
    link("https://flueframework.com/docs/")[Flue Framework Docs],
    link("https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html")[How to Fix Your Context - Drew Breunig],
    link("https://www.youtube.com/playlist?list=PLg3sejGUAdUZMKADp-KCcC6m5qKjD88bT")[State of Agentic Coding podcast, Youtube],
    link("https://www.youtube.com/watch?v=Ib5GBkD555M")[Harness Engineering is not Enough: Why Software Factories Fail — Dex Horthy, HumanLayer],
  ))
]

// Physical sheet — outside
// Left: logical page 4; right: logical page 1
#spread(page-four, page-one)

// Start the reverse side of the sheet.
#pagebreak()

// Physical sheet — inside
// Left: logical page 2; right: logical page 3
#spread(page-two, page-three)

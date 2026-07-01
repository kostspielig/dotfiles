
# OPINIONS.md

This file is a compact map of Maria's viewpoints on different relevant topics.

## AI agents, orchestration, and developer tools

### Agentic engineering changes the work rather than eliminating engineering

Maria thinks AI is shifting software work from hand-writing code toward steering, specification, review, orchestration, system design, and product judgment.
She expects engineers to learn agentic engineering while still understanding fundamentals well enough to control and evaluate what agents produce.
She believes AI amplifies competence and judgment, which means weak taste and weak requirements can produce more slop faster.
She expects people who keep learning and building with AI to gain leverage, while people who refuse to explore the ceiling face the highest career risk.

### Requirements, tests, and review are the new bottlenecks

Maria believes code has rarely been the deepest bottleneck in software work.
The harder questions are what is worth building, what users actually need, and how to verify that the result works.
She sees tests as central to AI coding because tests encode intent and give agents a feedback loop.
She favors TDD with agents when requirements are clear, because LLMs write better tests from intent than from the implementation they just generated.
She thinks humans should review generated tests especially carefully because bad tests can bless the wrong behavior.

### Human accountability must remain explicit

Maria treats AI as a tool, not a teammate or co-author.
Humans remain accountable for AI-assisted changes because they choose the goals, approve the outputs, and own the consequences.
She dislikes agents auto-adding themselves as commit co-authors because it serves vendor branding more than user trust.
She would rather source control record useful AI-assistance metadata such as model, prompt, token usage, session context, and human approval.

### Good agent systems need orchestration, isolation, and fresh context

Maria thinks effective agent work requires moving from micromanaging steps to directing agents through goals, principles, measurable objectives, and review loops.
She prefers deterministic harnesses for repeated long-running loops instead of asking one context window to remember everything.
She believes agents should use fresh context windows, isolated worktrees, explicit review phases, and fix phases to reduce context rot.
She sees overnight agents as useful for measurable optimization tasks where progress can be verified and failed attempts can be discarded.

### Agent-facing interfaces deserve first-class design

Maria believes tools for agents should be designed as deliberately as human UIs.
Agent interfaces should optimize token efficiency, speed, composability, compact output, reliability, and easy chaining.
She is skeptical that generic MCP surfaces or human-oriented JSON APIs are always the best interface for agents.
She sees purpose-built agent CLIs and AXI-style tools as promising because shells, pipes, and concise commands give agents efficient building blocks.
She worries that broad auto-enabled tool search can save upfront tokens while adding extra turns, search failures, and lower success rates.

### CLI agents and IDE agents will coexist

Maria expects CLI coding agents and IDE-based agents to coexist because they serve different workflows.
CLI agents are scriptable, portable, composable, and useful as building blocks for automation.
IDEs provide more opinionated interactive experiences and richer visual context.
She is skeptical that GUI-only computer use is the long-term agent interface because the world can build interfaces for agents instead of forcing agents to mimic humans.

### Model choice should follow task shape, not fandom

Maria is pragmatic about models and harnesses.
She sees Claude as pleasant for interactive work, while GPT or Codex can be better for non-interactive background execution, bug finding, and skill invocation.
She thinks Claude Code's popularity reflects model quality, subsidies, and lock-in more than harness quality alone.
She believes higher reasoning effort can reduce total cost on complex tasks when it avoids bad answers, correction turns, and rework.
She is wary of very large context windows and automatic memory when they add stale information, bloated context, or inefficient processes.

## AI labs, markets, and openness

### Model labs should act more like infrastructure providers

Maria thinks LLM labs create the most ecosystem value by making frontier models cleaner, cheaper, faster, and more reliable.
She is skeptical when labs use model power, product bundling, or platform control to favor their own downstream apps and block competing harnesses.
She expects many downstream products to be better built by specialized ecosystem players than by model labs themselves.
She sees LLMs potentially becoming commodity infrastructure that fades into the background like power plants, internet providers, or payment rails.

### AI evaluation needs systematic evidence

Maria distrusts screenshots and one-off anecdotes as proof of model bias, truthfulness, or coding ability.
She prefers canonical evaluation datasets, careful benchmark design, and awareness of contamination and selection bias.
She thinks telemetry from production coding tools can be misleading because users send different task types to different models.
She views harness quality as important but not a permanent moat when open alternatives can catch up.

## Software engineering, craft, and process

### Great engineers create valuable outcomes

Maria defines great engineers by their ability to get valuable things built.
That requires technical depth, breadth, strategy, leadership, delivery, communication, and political skill when problems have organizational constraints.
She sees compensation as an imperfect but sometimes useful market signal of created value, not as a pure measure of greatness.
She believes senior individual contributors create leverage through technical direction, ambiguous decisions, stakeholder alignment, process repair, and helping other teams succeed.

### Managers and senior engineers must create leverage

Maria believes managers earn trust because employees implicitly trust them with their careers.
Managers create value by recruiting strong people, helping existing people grow, and creating conditions where the team can do better work.
If a team needs neither hiring nor growth support, she questions whether it needs a manager.
She also believes founders and star ICs should not be forced into management or coaching roles when they create more value by playing directly.

### Code quality decays without active stewardship

Maria thinks codebases naturally drift toward entropy unless senior engineers actively hold the quality bar.
She prefers review cultures that require authors to explain how changes were tested rather than making reviewers personally rediscover every bug.
She believes solo ownership can burn people out and reduce quality when collaboration, shared context, and contributor growth would be better.
She wants principal engineers to remove processes where small changes require excessive meetings and approvals.

### Pull requests will evolve under agentic workflows

Maria expects pull requests to become less central as work shifts from human-written code reviewed by another human to agent-written code steered and reviewed by the human author.
She still sees PRs as useful for CI gates, release automation, metadata, and team coordination.
She does not think humans must read every line of agent-written code if they provide strong requirements, require tests and evidence, and review summaries, risks, and targeted diffs.
She believes CI remains hard to replace because local validation cannot cover every platform and environment.

### Tools should make good choices easy

Maria values ergonomics because a sound architecture that is hard to use correctly still produces performance and maintainability problems.
She likes opinionated defaults when they can be centrally optimized, while preserving customization for advanced users.
She prefers terminal-centered workflows like x11, sway, xmonad, grep, emacs-nw-style (zile) editing, and low visual clutter, while recognizing configuration can become a time sink.
She values reproducible environments, demos, and personal infrastructure because they turn fragile manual memory into repeatable systems.
She believes terminal and developer tools deserve visual craft, pacing, and polish when those details improve comprehension without stealing attention from the user's real task.

## Product, startups, and organizations

### Building is easier, so judgment matters more

Maria thinks AI makes building software dramatically easier, which raises the relative importance of knowing what to build.
She thinks good ideas start with named people who care about a real problem, not with abstract brainstorming or technology-first excitement.
She favors narrow prototypes, minimal initial scope, and assembling existing building blocks when the goal is to learn quickly.
She believes product updates often belong inside the product at the right moment rather than in generic announcement channels.

### Idea quality depends on the builder

Maria thinks a good idea is relative to the builder's context.
The best solo-builder ideas sit at the intersection of problems the builder understands deeply, can solve with their resources, and enjoys enough to keep pursuing.
She prefers exploring multiple ideas before committing when the goal is learning and discovery.
She sees building as something she naturally does for fun and would keep doing even without financial pressure.

### AI enables smaller serious companies

Maria expects AI to increase individual leverage enough to make one-person and very small-team companies more viable.
She does not think every company should rebuild giant SaaS products internally just because agents can write code.
She expects many SaaS tools to remain useful, but with more interactions mediated by agents rather than direct human UI use.

### Enterprise AI adoption needs behavior change

Maria believes many companies overestimate AI maturity because demos and casual agent usage are closer to average adoption than frontier adoption.
True adoption involves background agents, agent-built customer features, agent-run experiments, and redesigned internal review, approval, and go-to-market processes.
She thinks enterprise rollout fails when companies merely provide tools and expect usage to emerge organically.
Adoption requires education, value discovery, planning, workflow redesign, and incentive changes.

### Incentives shape product quality

Maria thinks many organizational product-quality problems come from incentives that reward shipping cool things more than conversion, retention, and customer outcomes.
She believes large companies need reward systems that prioritize the main quest over internal side quests, especially when AI makes internal tool rebuilding easier.
She is skeptical of outcome-based pricing when outcomes are hard to define and attribute.
She thinks companies should optimize AI products around users, profit, and team-level customer maturity rather than token consumption alone.

## Career, learning, and work

### Curiosity and compounding learning are durable advantages

Maria treats curiosity, motivation, and repeated building as more important than early specialization.
She likes the growth check of asking what a person can do this month that they could not do last month.
She thinks people should build things they find fun because enjoyment sustains effort, learning, and long-term compounding.
She thinks entrepreneurial engineers should deliberately build credibility, communication ability, customer understanding, and trust, not just technical execution skill.
She advises planning careers by identifying the end game and working backward instead of optimizing only for the next job.

### Education should include agents and real products

Maria believes students should learn CS fundamentals but should not spend most of their time hand-writing code for its own sake.
She would rather they learn agentic engineering, system design, and how to build many real things with users.
She sees LeetCode-style preparation as something to do when target companies require it, not as the center of long-term software skill.
She thinks technical interviews need to be reimagined because current systems, especially LeetCode-heavy ones, do not work very well.

### Career moves are context-dependent

Maria feels like staying in big tech companies often times takes away your capacity to stay up to date with new developments. It also prevents you from building your own products and services, which she considers to be very important.
She is aware that leaving big tech can be risky, and she thinks people should carefully evaluate their options before making any decisions.

### Being effective matters more than being right

Maria thinks people often overvalue being correct when the goal is to be effective.
She sees political and organizational constraints as real parts of engineering work rather than distractions from technical purity.
She prefers promotion conversations that align on a growth path rather than simply asking whether a promotion can happen immediately.
She thinks career success comes from creating value in the system as it exists while improving the system where possible.

### Diversity of opinion is important in engineering teams

Maria believes that diverse perspectives are crucial for building high-quality software. Diverse teams are more likely to identify edge cases, consider different approaches, and avoid echo chambers.

## Trust and Institutions

### Trust requires plain accountability

Maria thinks customer-impacting incidents should be answered with accountability, explanation, prevention steps, and refunds where appropriate.
She dislikes defensive minimization when users were harmed.

### Institutions matter because coordination creates value

Maria sees a company as a group of people creating value together that individuals could not create alone.
She thinks multi-agent systems inherit many human collaboration problems, including bottlenecks, duplicated work, diffusion of responsibility, information loss, and red tape.
She believes organizational topology and communication design can matter more than raw intelligence because smarter participants still fail under poor coordination structures.

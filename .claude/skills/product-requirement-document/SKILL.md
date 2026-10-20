---
name: product-requirement-document
description: >
  Create, structure, and quality-check Product Requirement Documents (PRDs) for small service design and product teams.
  Use this skill whenever the user needs to: (1) write a PRD or product spec from scratch, (2) diagnose why an existing
  PRD isn't working, (3) decide whether a PRD is the right artefact at all, (4) connect a PRD to a roadmap, stakeholder
  update, or escalation, (5) coach a junior or senior through their PRD contribution, or (6) position a PRD against
  the Lean Canvas or Value Proposition Canvas. Trigger on phrases like: "product requirement", "PRD", "product spec",
  "feature brief", "requirements document", "what does the team need to build", "document the requirements",
  "write up the brief", "product definition", "scope the feature".
metadata:
  version: 1.1.1
---

# Product Requirement Document Skill
## For Small Service Design and Product Teams

---

## How to Use This Skill

| Task | Go to |
|------|-------|
| Deciding if a PRD is the right artefact | → [Part 1: What a PRD Is and Is Not](#part-1) |
| Positioning against Lean Canvas / VPC | → [Part 2: Framework Relationships](#part-2) |
| Writing or structuring a PRD | → [Part 3: PRD Structure](#part-3) |
| Improving speed, quality, and impact | → [Part 4: Methods for Better PRDs](#part-4) |
| Integrating with project management rituals | → [Part 5: Integration with PM Operating System](#part-5) |
| Coaching the junior through a PRD | → [Part 6: Junior Development Guide](#part-6) |

For extended content, see:
- `references/section-prompts.md` — Prompts to generate each PRD section from structured inputs
- `references/failure-modes.md` — Common PRD failure modes with remedies
- `references/framework-relationships.md` — Part 2 in full
- `references/methods.md` — Part 4 in full
- `references/team-integration.md` — Part 5 in full
- `references/junior-guide.md` — Part 6 in full, with the PM curriculum links

---

## Diagnostic: Before Writing a Single Word

Ask — or infer from context — the following before generating or recommending any PRD structure.

**Problem context**
- What decision does this PRD exist to enable? (If you can't answer this, stop.)
- Who will read it, and what will they do differently after reading it?
- Is the problem well-understood, or are we still in discovery?

**Stage context**
- Are we in discovery, definition, or delivery?
- Has the Lean Canvas or Value Proposition Canvas already been completed? What did they reveal?
- Has the product vision been defined? Is there a roadmap this PRD sits within?

**Team context**
- Who owns this PRD — lead, senior, or shared?
- What does the junior need to contribute or learn through this process?
- Are there external stakeholders who need to sign off?

> If the user hasn't provided this context, ask for the three most critical missing pieces before generating any PRD content. A PRD written without clear decision-context becomes a document that describes the world but changes nothing.

---

<a name="part-1"></a>
## Part 1: What a PRD Is and Is Not

### First Principles Definition

A PRD exists to answer one question: **what does the team need to build, for whom, and why — clearly enough that the right thing gets built without the author being in every room.**

Every section of a PRD should trace back to that sentence. If a section cannot answer "what decision does this enable or what ambiguity does this resolve?", it should not exist.

### What a PRD Is

- A **thinking tool** — it forces the author to resolve ambiguity before it becomes expensive
- A **communication tool** — it aligns engineering, design, and stakeholders around a shared understanding
- A **decision record** — it captures what was chosen and why, not just what will be built
- A **living document** — it changes as understanding improves, and those changes are tracked

### What a PRD Is Not

- A specification of *how* to build (that's engineering design)
- A roadmap (that's a prioritised sequence of work across time)
- A business case (that's a cost-benefit justification for investment)
- A user story (that's an atomic unit of delivery; the PRD contains many)
- A brief (that's a lighter, earlier-stage artefact — see below)

### When to Use a PRD versus Other Artefacts

| Artefact | Use when | Typical length |
|----------|----------|----------------|
| **One-liner** | You need a shared label for a piece of work | One sentence |
| **Brief** | Early discovery; problem not yet fully understood | 1 page |
| **PRD** | Problem is understood; team needs alignment to build | 2–6 pages |
| **Spec** | Engineering needs precise technical requirements | Unbounded |
| **Roadmap item** | Communicating sequence and priority to stakeholders | 3–5 bullets |

**Use a PRD when**: the problem is understood well enough to define success, the solution has enough complexity that different people will interpret it differently without a document, and the work spans more than one sprint or one function.

**Do not use a PRD when**: you're still in pure discovery (use `discovery-loop`, a brief or a research plan), the work is a small, well-scoped bug fix or incremental change, or a conversation would resolve the ambiguity faster than a document.

---

<a name="part-2"></a>
## Part 2: Framework Relationships

Read `references/framework-relationships.md` when positioning a PRD against the Lean Canvas or Value Proposition Canvas: where each applies, what the PRD inherits from each, and the first-principles alignment check.

---

<a name="part-3"></a>
## Part 3: PRD Structure

### Core Principle: Every Section Earns Its Place

Each section below includes its *purpose* — the decision or ambiguity it resolves. If that decision is already resolved, or is irrelevant to this product, the section should be shortened or removed.

### Discovery-Phase PRD vs Delivery-Phase PRD

| Section | Discovery PRD | Delivery PRD |
|---------|---------------|--------------|
| Context and problem | Required | Required |
| Goals and success metrics | Draft; expected to evolve | Confirmed; measurable |
| User and customer context | Emerging; hypothesis-driven | Validated; evidence-backed |
| Solution overview | Directional only | Specified |
| Functional requirements | High-level; may be incomplete | Detailed; must be complete |
| Non-functional requirements | Optional | Required |
| Out of scope | Required | Required |
| Dependencies and risks | Required | Required |
| Rollout and measurement | Optional | Required |
| Open questions | Long; expected | Short; critical blockers only |

---

### Section 1: Context and Problem

**Purpose:** Ensures everyone is solving the same problem, and that the problem is worth solving.

**Owner:** Lead

**Done when:** A person who wasn't in any prior meeting reads this section and can accurately describe the problem — and why it matters — in their own words.

**Contents:**
- Background: what situation has led to this work?
- Problem statement: one or two sentences. What is broken or missing for whom?
- Why now: what makes this the right moment to address it?
- Evidence: what research, data, or signal supports this being a real problem?

**First-principles check:** If the problem statement could describe ten different products, it is not specific enough.

---

### Section 2: Goals and Success Metrics

**Purpose:** Defines what "done" looks like in a way that cannot be argued with after the fact.

**Owner:** Lead, with input from senior

**Done when:** The metrics are measurable, have a baseline, have a target, and have a timeframe. "Improve user satisfaction" is not done. "Increase task completion rate from 62% to 75% within 60 days of launch" is done.

**Contents:**
- Business goal: what outcome does this contribute to?
- User goal: what does success look like for the user?
- Success metrics: 2–4 measurable indicators with baseline and target
- Anti-metrics: what should *not* get worse? (Often omitted — almost always important)

**First-principles check:** If the team shipped nothing, would the metrics move anyway? If yes, they're not measuring the right thing.

---

### Section 3: User and Customer Context

**Purpose:** Grounds the solution in a specific human reality, preventing the team from building for a hypothetical user.

**Owner:** Senior (drawing on VPC if completed)

**Done when:** A designer or engineer who has never spoken to a user can make a reasonable decision about a feature trade-off using this section alone.

**Contents:**
- Primary user: who are we designing for? (Be specific — a role, a context, a need)
- Key jobs-to-be-done: what are they trying to accomplish?
- Top pains: what is making that hard today?
- Top gains: what does success feel like for them?
- Secondary users or affected parties: who else is impacted?

**Note:** If the Value Proposition Canvas has been completed, import the top 3 pains and gains directly. Do not re-derive them — flag any changes.

---

### Section 4: Solution Overview

**Purpose:** Provides a shared mental model of what will be built, without pre-engineering the solution.

**Owner:** Lead, in collaboration with design

**Done when:** Engineering and design could independently sketch a rough approach and their sketches would not contradict each other.

**Contents:**
- Solution summary: 2–4 sentences describing what will be built
- Key user flows: 2–3 core journeys the solution must support (prose or diagram)
- What this is not: explicit statements about what the solution is not doing
- Design considerations: any known constraints on experience, accessibility, or consistency

**First-principles check:** Is the solution described in terms of *what the user can do*, not how the system works? If it reads like a technical design doc, it has drifted.

---

### Section 5: Functional Requirements

**Purpose:** Specifies exactly what the product must do, clearly enough to write a test against.

**Owner:** Lead and senior jointly; junior may draft under guidance

**Done when:** Each requirement has an unambiguous acceptance criterion. If two people can read a requirement and disagree about whether it is met, it is not done.

**Format:**
```
REQ-01: [Requirement title]
Description: What must be true.
Acceptance criteria: Given [context], when [action], then [outcome].
Priority: Must / Should / Could (MoSCoW)
Owner: [who is accountable for delivery]
```

**Guidance:**
- Use MoSCoW prioritisation. Every requirement is not a "must" — if everything is critical, nothing is.
- Write acceptance criteria in plain language before writing them in technical language.
- Flag any requirement where the acceptance criterion depends on a decision not yet made.

---

### Section 6: Non-Functional Requirements

**Purpose:** Captures the *quality* expectations that the system must meet — performance, security, accessibility, compliance — that are often assumed and therefore never explicitly agreed.

**Owner:** Lead, with engineering input

**Done when:** Engineering knows, before building, what "fast enough," "secure enough," and "accessible enough" mean for this product.

**Contents:** (include only those relevant)
- Performance: expected load, response time targets
- Accessibility: standard to meet (e.g., WCAG 2.1 AA)
- Security: data handling, authentication requirements
- Compliance: regulatory or policy constraints
- Browser/device support

---

### Section 7: Out of Scope

**Purpose:** Prevents scope creep by making explicit what the team has decided not to do — and creating a legitimate place for good ideas that are being deferred.

**Owner:** Lead

**Done when:** Every stakeholder who asked for something that isn't in this PRD can find their request in the out-of-scope list with a brief reason.

**Format:**
```
| Not in scope | Reason / when it might be revisited |
|--------------|--------------------------------------|
| [Feature X]  | Deferred to Phase 2 pending research |
| [Feature Y]  | Out of product scope — refer to [team] |
```

---

### Section 8: Dependencies and Risks

**Purpose:** Surfaces what must be true — and what could go wrong — before the team discovers it at the worst possible moment.

**Owner:** Lead and senior jointly

**Done when:** Each dependency has an owner and a due date. Each risk has a likelihood, an impact, and a proposed response.

**Contents:**
- Dependencies: what other work, decisions, or inputs must be in place for this to proceed?
- Risks: what could prevent successful delivery or adoption?
- Risk response: for each risk — mitigate, accept, or escalate?

**Integration note:** High-severity risks that cannot be mitigated by the team belong in the manager update and may warrant an escalation pre-read. See Part 5.

---

### Section 9: Rollout and Measurement

**Purpose:** Ensures that launch is not the end of the work — that there is a plan to learn from what ships.

**Owner:** Lead, with input from senior

**Done when:** The team knows how the product will reach users, how success will be measured in the first 30/60/90 days, and who is responsible for acting on what the data shows.

**Contents:**
- Rollout approach: staged, full launch, feature flag, pilot?
- Launch dependencies: what needs to be true before launch? (Support readiness, comms, training)
- Measurement plan: which metrics, which tools, who reviews, how often?
- Feedback loops: how will user feedback be captured and acted on?

---

### Section 10: Open Questions

**Purpose:** Provides a legitimate holding space for unresolved issues — so they are visible, owned, and not silently blocking decisions.

**Owner:** All

**Done when:** Every open question has an owner and a date by which it must be resolved. Questions without owners are not open questions — they are risks.

**Format:**
```
| Question | Why it matters | Owner | Resolve by |
|----------|---------------|-------|-----------|
| [Q]      | [Impact if unanswered] | [Name] | [Date] |
```

---

<a name="part-4"></a>
## Part 4: Methods for Better PRDs

Read `references/methods.md` when a PRD needs to be faster, more complete, more accurate or more useful, and run its first-principles checks on every completed PRD before it goes out.

---

<a name="part-5"></a>
## Part 5: Integration with the Project Management Operating System

Read `references/team-integration.md` when a PRD has to fit the team's rituals: the ritual stack, stakeholder sessions, manager updates and escalations. Pair it with the `project-management` skill.

---

<a name="part-6"></a>
## Part 6: Junior Development Guide

Read `references/junior-guide.md` when coaching a junior through a PRD: what it makes possible, who contributes what, stretch opportunities, the lead's responsibility, and the links to PM curriculum areas.

---

*Reference files: `references/section-prompts.md` | `references/failure-modes.md` | `references/framework-relationships.md` | `references/methods.md` | `references/team-integration.md` | `references/junior-guide.md`*

---
name: multi-actor-strategy
description: >
  Governs how strategic decisions are made with rigour, accountability, and clarity. Use this skill whenever a question requires choosing between options, setting direction, or recommending action — not just understanding what is true. Distinct from multi-actor-research (which asks "what does the evidence say?") — this skill asks "what should we do, and why?". Trigger whenever the user needs to appraise strategic options, build a recommendation for leadership, stress-test a proposed direction, frame a problem before generating solutions, or produce a decision-ready output under conditions of uncertainty. Also trigger when the user mentions strategy, options appraisal, recommendation, decision, direction-setting, influencing without authority, service design strategy, or asks to "think through" a complex organisational or design problem. Flexible by design: Claude can orchestrate all actors sequentially, coach a human team, or embody a single actor on demand.
---

# Multi-Actor Strategy Skill

## What This Skill Does

This skill applies a structured, multi-actor process to any question where the output requires a **recommended course of action** — not just an evidence-based finding. It ensures strategic outputs are:

- **Well-framed** — the right question is being answered, not just the obvious one
- **Options-rich** — decisions are made from a real range of alternatives, not a false binary
- **Stress-tested** — the preferred option has survived adversarial scrutiny before it reaches a stakeholder
- **Accountable** — every trade-off is named, and the reasoning is traceable

### How this differs from `multi-actor-research`

| Dimension | multi-actor-research | multi-actor-strategy |
|---|---|---|
| Central question | What does the evidence say? | What should we do? |
| Primary output | Evidence-graded findings | Recommended decision with rationale |
| Confidence grade | Confirmed / Inferred / Asserted | Supported / Reasoned / Assumed |
| Challenge mode | Claim-by-claim audit | Option-by-option stress test |
| Stakeholder test | Can this finding be defended? | Can this recommendation be actioned? |

The two skills are designed to be used together: research produces the evidence base; strategy applies it to a decision.

Read `references/actors.md` for full actor playbooks.  
Read `references/escalation.md` for escalation protocol and coordination principles.  
Read `references/stage-register.md` for Stage Register templates and handoff note convention.

---

## The Seven Actors

| Actor | Core Function |
|---|---|
| Problem Framer | Defines the strategic question precisely; surfaces hidden assumptions and scope traps |
| Strategist | Generates a genuine range of strategic options; maps levers, constraints, and consequences |
| Challenger | Steelmans weaker options; attacks the preferred one at its most vulnerable point |
| Stakeholder Proxy | Represents the perspective and likely response of each key affected party |
| Risk Analyst | Applies prospective hindsight to each option; identifies failure modes before commitment |
| Decision Architect | Structures the trade-off; produces a clear, actionable recommendation |
| Project Manager | Maintains process integrity; holds decision rights at impasse |

---

## Operating Modes

Claude can operate in three modes. Detect the appropriate mode from context, or ask the user if ambiguous.

### Mode 1 — Full Orchestration
Claude plays all seven actors sequentially, working through the four stages below. Used when the user presents a strategic question and asks Claude to produce a complete output.

### Mode 2 — Human Team Coaching
Claude acts as Project Manager, prompting the human team through each stage, reviewing handoffs, and flagging where escalation is needed. Useful for live workshop facilitation or team-based strategy sessions.

### Mode 3 — Single Actor on Demand
Claude embodies one nominated actor. Read that actor's full playbook in `references/actors.md` before responding. Used when the user says e.g. "act as the Challenger on this option" or "run a stakeholder proxy analysis."

---

## Context Management — The Stage Register System

For any multi-stage strategy task, context compression is critical. Long processes degrade if later actors attempt to re-read full prior reasoning rather than working from structured signal.

**The rule: every stage closes by producing a Stage Register. Every stage opens by reading the prior Stage Register and Handoff Note — not the full prior output.**

This keeps working memory tight and makes the process resumable across sessions. If a conversation is interrupted, paste the most recent Stage Register into a new chat and continue from that stage.

See `references/stage-register.md` for templates and the full handoff note convention.

---

## The Four Stages

### Stage 1 — Frame and Generate
*Owner: Problem Framer → reviewed by Strategist*

Before generating options, the Problem Framer must establish:
- The strategic question (precise, not generic)
- The decision horizon (immediate, medium-term, or directional)
- The constraints that are real vs assumed
- The assumptions embedded in how the problem has been presented

The Strategist then generates a minimum of three genuine options — including at least one non-obvious option and one "do nothing / sustain current approach" option for comparison.

**Closing requirement:** Produce a Stage 1 Register (question definition + assumptions surfaced + options longlist with a one-line rationale for each) and a Handoff Note to Stage 2 before proceeding. See `references/stage-register.md`.

**Handoff condition:** Question is precisely defined. Minimum three options generated. No options narrowed yet.

---

### Stage 2 — Challenge and Proxy
*Owner: Challenger + Stakeholder Proxy, coordinated by Project Manager*

Open by reading the Stage 1 Register and Handoff Note only.

In parallel:
- Challenger produces an option stress-test: for each option, the strongest case for and the strongest case against, with the preferred option receiving the most rigorous challenge
- Stakeholder Proxy produces a stakeholder response map: for each key party, their likely reaction to each option, what they gain, what they lose, and where resistance or advocacy will emerge

Where a stakeholder position and a strategic challenge intersect, flag to Project Manager rather than resolve bilaterally.

**Dynamic Expert Cameo — default step, feeds the Challenger's stress-test.** Generic actor voices produce generic critique. Before the stress-test, generate 2–3 bespoke personas tailored to *this specific* question — not the standing actors, and not generic advisors. Each needs a first name, a one-line backstory that includes a real failure (a flawed expert argues sharper than a flawless one), and an opinionated lens the standing actors don't already cover. Route their critique through the Challenger's stress-test rather than as a separate output.

Examples: an icare benefit-design question might cast "Priya, former scheme actuary who underpriced a benefit tier in 2019 and watched it blow the reserve two years later"; a pricing question might cast "Marcus, ex-pricing lead who grew a PLG product to $1B ARR and regrets half his pricing calls." Specificity is the point — the more concrete the persona, the more concrete the critique. Skip only for a fast, low-stakes pass — state that it was skipped and why.

**Closing requirement:** Produce a Stage 2 Register (stress-tested options + stakeholder response map + any options eliminated or elevated this stage) and a Handoff Note to Stage 3 before proceeding.

**Handoff condition:** Every option has been challenged. No option eliminated without reasoning recorded.

---

### Stage 3 — Risk and Trade-off
*Owner: Risk Analyst → Decision Architect*

Open by reading the Stage 2 Register and Handoff Note only.

Risk Analyst applies prospective hindsight to each surviving option:
- If this option were selected and failed, what would be the most likely cause?
- What are the early warning signs?
- What is the mitigation?

**Blind Council Check — default step.** Before the Decision Architect drafts anything, run one blind cross-review pass. This borrows the core insight of Karpathy's LLM Council: a reviewer who knows which actor championed an option defers to that actor's authority instead of judging the case on its merits. Anonymising strips that bias out, so it runs by default — the sharper recommendation it produces is worth the extra round.

Anonymise each surviving option's full case (Strategist's rationale + Challenger's stress-test + Stakeholder Proxy's map + Risk Analyst's log) as Option A, B, C — no actor names attached. Working from the anonymised set only, each actor answers three questions:
1. Which option's case is strongest, and why?
2. Which option's case has the biggest blind spot?
3. What did every option's case miss?

Feed the answers to the Decision Architect before the recommendation is drafted. Skip only if the user explicitly asks for a fast, low-stakes pass — state that the check was skipped and why.

Decision Architect then produces the trade-off framework, incorporating the blind-review findings:
- Criteria for the decision (explicit, not implicit)
- How each surviving option performs against the criteria
- A ranked recommendation with stated rationale
- What would have to be true for a different recommendation to be correct

No Assumed rationale may survive to Stage 4. All reasoning must be Supported or Reasoned.

**Conviction Bet — default step, closing gut-check before Stage 4.** A confidence grade is a label; a label can hide hedging. Before the recommendation is finalised, each surviving option's original advocate (Strategist, Challenger, or Stakeholder Proxy, whichever championed it) states what they'd bet on the outcome and at what confidence: "If I had $1,000 of my own on this, I'd bet on X, confidence Y%." Record the bet alongside the confidence grade — don't let it replace the grade, and don't let vague "it depends" stand in for a bet. Skip only for a fast, low-stakes pass — state that it was skipped and why.

**Closing requirement:** Produce a Stage 3 Register (risk log per option + blind council check findings + conviction bets + trade-off assessment + preliminary recommendation with confidence grade) and a Handoff Note to Stage 4 before proceeding.

**Handoff condition:** Decision Architect has a defensible recommendation. Project Manager approves before Stage 4.

---

### Stage 4 — Communication
*Owner: Decision Architect (final form) + Project Manager sign-off*

Open by reading the Stage 3 Register and Handoff Note only.

Adapt the recommendation for the target stakeholder(s). The output must answer three questions for the audience:
1. What is the recommendation?
2. Why this option over the alternatives?
3. What are the conditions and risks the decision-maker should hold?

Never simplify a qualified recommendation into an unqualified one. Flag to Project Manager any conditions that required significant softening.

**Closing requirement:** Produce the final Stage 4 Register (recommendation as communicated, any qualification flags, PM sign-off note) as an archival record of the complete process.

**Handoff condition:** Project Manager reviews. Any materially changed recommendation returns to the Decision Architect before release.

---

## Output Format

Output format depends on the strategic question and audience. Apply this decision logic:

| Audience / Purpose | Format |
|---|---|
| Executive decision-making | Decision brief: recommendation up front, rationale, alternatives considered, conditions |
| Leadership presentation | Pyramid-structured narrative with trade-off visible |
| Service design / design team | Options map with stakeholder response and risk annotation |
| Single-actor output | Actor-appropriate artefact (e.g. stress-test log, stakeholder response map) |
| Scannable executive artefact | Self-contained HTML decision brief (see below) — use when the audience will scan, not read |

Always include: the confidence grade for the recommendation, the alternatives that were considered and why they were not preferred, and any conditions that would change the recommendation.

**Optional: HTML decision brief.** When the audience needs something scannable rather than prose, generate one self-contained HTML file (inline CSS, no external assets): recommendation and confidence grade at the top, a grid showing where actors converged or diverged, and collapsible sections per actor holding their full output. Save as `decision-brief-[topic]-[date].html` and open it.

---

## Quick Reference — Confidence Grades

- **Supported** — the rationale rests on confirmed evidence or direct stakeholder input
- **Reasoned** — the rationale is logically derived but rests on inference or assumed stakeholder positions
- **Assumed** — present in the recommendation but without a clear basis → must be removed or reclassified before Stage 4

---

## When to Read Reference Files

- To embody any actor fully → read `references/actors.md`
- When an impasse arises or escalation is needed → read `references/escalation.md`
- For Stage Register templates and handoff note format → read `references/stage-register.md`
- For any complex or multi-stage strategy task → read all three

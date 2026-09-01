---
name: multi-actor-research
description: >
  Governs how findings are produced to be authentic (grounded in evidence), accurate (correctly reasoned), and well communicated (audience-appropriate). Use this skill whenever a research question will inform strategy, investment, or executive decision-making — or whenever the user asks to run a structured research process, assign actor roles, stress-test claims, audit evidence, synthesise findings, or produce a decision-ready output. Also trigger when the user mentions any of the seven actors by name (Researcher, Evidence Auditor, Devil's Advocate, Subject Matter Validator, Synthesiser, Communicator, Project Manager), or asks to "run the playbook", "go through the stages", or "apply the framework". Flexible by design: Claude can orchestrate all actors sequentially, coach a human team, or embody a single actor on demand.
---

# Multi-Actor Research Skill

## What This Skill Does

This skill applies a structured, multi-actor process to any research question where the output will inform strategy, investment, or executive decisions. It ensures findings are:

- **Authentic** — grounded in evidence, with sources graded by confidence
- **Accurate** — correctly reasoned, with inference explicitly labelled
- **Well communicated** — adapted to the audience without distorting the underlying evidence

Read `references/actors.md` for full actor playbooks.  
Read `references/escalation.md` for escalation protocol and coordination principles.  
Read `references/stage-register.md` for Stage Register templates and handoff note convention.

---

## The Seven Actors

| Actor | Core Function |
|---|---|
| Researcher | Surfaces and grades evidence; maintains the source register |
| Evidence Auditor | Grades every claim as Confirmed, Inferred, or Asserted |
| Devil's Advocate | Constructs the strongest objection to each significant claim |
| Subject Matter Validator | Tests reasoning against operational reality |
| Synthesiser | Produces a single coherent output from all actor inputs |
| Communicator | Translates output for a mixed audience without distorting findings |
| Project Manager | Maintains process integrity; holds decision rights at impasse |

---

## Operating Modes

Claude can operate in three modes. Detect the appropriate mode from context, or ask the user if ambiguous.

### Mode 1 — Full Orchestration
Claude plays all seven actors sequentially, working through the four stages below. Used when the user presents a research question and asks Claude to produce a complete output.

### Mode 2 — Human Team Coaching
Claude acts as Project Manager, prompting the human team through each stage, reviewing handoffs, and flagging where escalation is needed. Used when a human team is doing the research work.

### Mode 3 — Single Actor on Demand
Claude embodies one nominated actor. Read that actor's full playbook in `references/actors.md` before responding. Used when the user says e.g. "act as the Devil's Advocate on this claim" or "audit this evidence".

---

## Context Management — The Stage Register System

For any multi-stage research task, context compression is critical. Long processes degrade if later actors attempt to re-read full prior reasoning rather than working from structured signal.

**The rule: every stage closes by producing a Stage Register. Every stage opens by reading the prior Stage Register and Handoff Note — not the full prior output.**

This keeps working memory tight and makes the process resumable across sessions. If a conversation is interrupted, paste the most recent Stage Register into a new chat and continue from that stage.

See `references/stage-register.md` for templates and the full handoff note convention.

---

## The Four Stages

### Stage 1 — Evidence Assembly
*Owner: Researcher → reviewed by Evidence Auditor*

Build or update the source register. Grade each source (High / Moderate / Low confidence). Produce the initial confidence register with each claim graded: **Confirmed**, **Inferred**, or **Asserted**.

**Closing requirement:** Produce a Stage 1 Register (source register + confidence register + open questions) and a Handoff Note to Stage 2 before proceeding. See `references/stage-register.md`.

**Handoff condition:** Source register versioned. Confidence register complete. No claims proceed without this.

---

### Stage 2 — Challenge and Validation
*Owner: Devil's Advocate + Subject Matter Validator, coordinated by Project Manager*

Open by reading the Stage 1 Register and Handoff Note only.

In parallel:
- Devil's Advocate produces the challenge log (claim → strongest objection → resolution)
- Subject Matter Validator produces the practitioner annotation (where the model holds, overstates, or is changed by operational context)

Where outputs intersect, flag to Project Manager rather than resolve bilaterally.

**Closing requirement:** Produce a Stage 2 Register (resolved challenge log + practitioner annotation + remaining open questions) and a Handoff Note to Stage 3 before proceeding.

**Handoff condition:** Both outputs complete. Unresolved challenges escalated before Stage 3.

---

### Stage 3 — Synthesis
*Owner: Synthesiser, final check by Evidence Auditor*

Open by reading the Stage 2 Register and Handoff Note only.

Produce the working draft from all Stage 1–2 outputs. Embed confidence markers. No Asserted claims may remain. Send back to Evidence Auditor for final check before Stage 4.

**Closing requirement:** Produce a Stage 3 Register (final claim set with confidence grades, decisions made, known limitations) and a Handoff Note to Stage 4 before proceeding.

**Handoff condition:** Evidence Auditor confirms clean. Project Manager approves.

---

### Stage 4 — Communication
*Owner: Communicator*

Open by reading the Stage 3 Register and Handoff Note only.

Adapt the working draft for the target audience. Never simplify a qualified finding into an unqualified one. Flag to Project Manager any claims that required significant softening.

**Closing requirement:** Produce the final Stage 4 Register (final claim set as communicated, any softening flags, PM note) as an archival record of the complete process.

**Handoff condition:** Project Manager reviews the Communicator's note. Any materially changed claim returns to the Synthesiser before release.

---

## Output Format

Output format depends on the research question and audience. Apply this decision logic:

| Audience / Purpose | Format |
|---|---|
| Executive decision-making | Decision-ready briefing with confidence markers visible |
| Operational team | Structured report with mechanism detail |
| Strategy / investment | Working document with embedded source register |
| Single-actor output | Actor-appropriate artefact (e.g. challenge log, source register) |

Always include: confidence grade for each material claim, a note on what is Confirmed vs Inferred, and any known limitations.

---

## Quick Reference — Confidence Grades

- **Confirmed** — directly supported by a cited High-confidence source
- **Inferred** — logically derived from evidence but not directly stated
- **Asserted** — present in output but unsupported → must be removed or reclassified

---

## When to Read Reference Files

- To embody any actor fully → read `references/actors.md`
- When an impasse arises or escalation is needed → read `references/escalation.md`
- For Stage Register templates and handoff note format → read `references/stage-register.md`
- For any complex or multi-stage research task → read all three

# Stage Register Templates and Handoff Note Convention

This file governs context compression across stages. Its purpose is to ensure that later actors work from structured signal — not from re-reading full prior reasoning — and that the process is resumable across sessions.

## Contents

- The Core Rule
- Resuming Across Sessions
- Stage Register — General Structure
- Stage Register Templates
  - Stage 1 Register
  - Stage 2 Register
  - Stage 3 Register
  - Stage 4 Register (Archival)
- Handoff Note Convention
- Compress-and-Carry-Forward Prompt

---

## The Core Rule

**Every stage closes by producing a Stage Register.**  
**Every stage opens by reading the prior Stage Register and Handoff Note — not the full prior output.**

The Stage Register is the authoritative record of what the stage established. It replaces the full stage output as working memory for subsequent stages. It does not replace the full output as an archival record — both exist, but only the register travels forward.

---

## Resuming Across Sessions

If a research task is interrupted mid-process, the Stage Register makes it resumable without loss of fidelity.

To resume: open a new conversation, paste the most recent Stage Register and Handoff Note, state which stage you are resuming, and continue. The register carries all material signal. The prior conversation history is not required.

**In-session, prefer `/compact` over a new conversation.** See `.claude/references/session-hygiene.md` _(repo-relative; `Glob '**/references/session-hygiene.md'` if it isn't there — `~/.claude/` does not resolve in a cloud session)_. The moment a Stage Register is written down, the "nothing lost" condition it requires is met — say so and name it as a safe `/compact` point rather than waiting for the session to run long. Reach for the manual paste-into-a-new-conversation path above only when that tooling isn't available. And when the *next* task shares nothing with the research question just closed, `/clear` is the right move, not a fresh Stage 1 register carried inside an old, unrelated transcript.

---

## Stage Register — General Structure

Every Stage Register contains four sections regardless of stage:

**1. Claims in play**  
The current live claim set, each with its confidence grade (Confirmed / Inferred / Asserted). No narrative — claims only, with grades.

**2. Sources still live**  
The subset of the source register that is still actively supporting claims in play. Discarded or superseded sources are dropped.

**3. Decisions made this stage**  
Any impasse decisions, confidence grade changes, or claims removed or reclassified. One line per decision: what changed, why.

**4. Open questions carried forward**  
Unresolved tensions, missing sources, or challenges not yet addressed. These travel into the Handoff Note for the next stage.

---

## Stage Register Templates

---

### Stage 1 Register
*Produced by: Researcher + Evidence Auditor*  
*Travelling to: Stage 2 — Devil's Advocate + Subject Matter Validator*

```
STAGE 1 REGISTER
Research question: [state the question]
Date / version: [date, v1]

--- DECISION HOOK (written by PM before grading; travels to every stage) ---
Decides: [person or role]
Decision informed: [the choice this research feeds]
Metric at stake: [KPI or OKR, or "none: exploratory"]
Deadline: [date the decision is made]
Would change the decision: [the finding that would flip it]

--- CLAIMS IN PLAY ---
[Claim 1] | Confirmed | [source ref]
[Claim 2] | Inferred  | [source ref + reasoning basis]
[Claim 3] | Inferred  | [source ref + reasoning basis]
[any Asserted claims must be removed before this register is closed]

--- SOURCES STILL LIVE ---
[Source A] | High confidence | [what it directly supports]
[Source B] | Moderate confidence | [what it contributes and its limits]
[Source C] | Low confidence | [retained for X reason, treat with caution]

--- DECISIONS MADE THIS STAGE ---
[Claim X] removed — could not be supported; nearest available source was [Y]
[Source D] downgraded from High to Moderate — audit finding but pre-reform, applicability limited

--- OPEN QUESTIONS CARRIED FORWARD ---
- [Missing source type] not located — would strengthen/challenge Claim 2
- [Claim 3] rests entirely on inference from [Source B]; Devil's Advocate should prioritise
- [Claim 1] may not hold in [operational context] — flag for Subject Matter Validator
```

---

### Stage 2 Register
*Produced by: Devil's Advocate + Subject Matter Validator, approved by Project Manager*  
*Travelling to: Stage 3 — Synthesiser*

```
STAGE 2 REGISTER
Research question: [state the question]
Date / version: [date, v1]

--- CLAIMS IN PLAY ---
[Claim 1] | Confirmed | Survived challenge — objection [X] resolved by [source/reasoning]
[Claim 2] | Inferred  | Qualified — now reads as [amended form]; see challenge log entry 2
[Claim 3] | Inferred  | Holds operationally with caveat: [practitioner annotation note]
[Claim 4] | REMOVED   | Challenge could not be resolved; retained as known limitation

--- SOURCES STILL LIVE ---
[same format as Stage 1 — update if any sources added or dropped this stage]

--- DECISIONS MADE THIS STAGE ---
[Claim 2] qualified by Devil's Advocate challenge — insufficient evidence for original form
[Claim 4] removed — PM decision; retained as known limitation in output
[Claim 3] operational caveat added by Subject Matter Validator — mechanism holds in theory, 
          but [X constraint] means effect is partial in practice

--- KNOWN LIMITATIONS (to be carried into final output) ---
- [Claim 4]: could not be confirmed or refuted with available evidence; noted as gap
- [Claim 3]: practitioner caveat applies; effect size may be overstated in non-[X] contexts

--- OPEN QUESTIONS CARRIED FORWARD ---
- Synthesiser to decide whether Claim 2 (qualified form) merits prominence or footnote
- Two challenges intersected on [topic] — PM flagged; Synthesiser to resolve structurally
```

---

### Stage 3 Register
*Produced by: Synthesiser + Evidence Auditor final check, approved by Project Manager*  
*Travelling to: Stage 4 — Communicator*

```
STAGE 3 REGISTER
Research question: [state the question]
Date / version: [date, v1]

--- FINAL CLAIM SET ---
[Claim 1] | Confirmed | [brief plain-language statement of the claim as it stands]
[Claim 2] | Inferred  | [qualified form — exactly as it will appear in the output]
[Claim 3] | Inferred  | [with operational caveat embedded]

--- KNOWN LIMITATIONS IN OUTPUT ---
- [Gap 1]: [what it is, where it appears in the output]
- [Gap 2]: [what it is, where it appears in the output]

--- STRUCTURAL DECISIONS ---
[Claim 2] appears as a qualified supporting finding, not a headline — reasoning: [X]
[Known limitation 1] surfaced explicitly in the body, not relegated to footnote — reasoning: [X]

--- AUDIENCE NOTE FOR COMMUNICATOR ---
Primary audience: [e.g. executive / operational team / mixed]
Decision they need to make: [state it precisely, from the Decision Hook]
Metric at stake: [from the Decision Hook; lead each key finding with its effect on it]
Claims requiring most careful handling: [list — these are where distortion risk is highest]
Confidence qualifications that must not be dropped: [list]

--- OPEN QUESTIONS CARRIED FORWARD ---
- [Any residual tension the Communicator needs to navigate]
```

---

### Stage 4 Register (Archival)
*Produced by: Communicator + Project Manager sign-off*  
*Purpose: archival record; no further handoff*

```
STAGE 4 REGISTER — ARCHIVAL
Research question: [state the question]
Date / version: [date, final]

--- FINAL CLAIM SET AS COMMUNICATED ---
[Claim 1] | Confirmed | [as it appears in final output]
[Claim 2] | Inferred  | [as it appears in final output — note if form changed from Stage 3]
[Claim 3] | Inferred  | [as it appears in final output]

--- SOFTENING FLAGS ---
[Claim X]: softened from [Stage 3 form] to [final form] — reason: [audience accessibility / 
           no equivalent term for target audience / PM approved]
[No softening flags] — all claims carried through in their qualified form

--- KNOWN LIMITATIONS AS COMMUNICATED ---
[same as Stage 3, confirming they survived into the final output]

--- PM SIGN-OFF NOTE ---
Process complete. [Any notes on what would strengthen the analysis if revisited.]
Known gaps that remain open: [list]
Recommended next research action if applicable: [X]
```

---

## Handoff Note Convention

The Handoff Note is a short, fixed-format note written by the outgoing actor(s) for the incoming actor(s). It is separate from the Stage Register. The register carries the data; the handoff note carries the intent.

**Format: five lines maximum. Always the same five prompts.**

```
HANDOFF NOTE — Stage [X] to Stage [Y]
From: [outgoing actor(s)]
To: [incoming actor(s)]

1. What this stage established: [one sentence — the key output]
2. What needs your attention most: [the highest-priority item for the next actor]
3. Where the evidence is weakest: [name the claim or source most at risk]
4. What not to relitigate: [what has already been decided and should not be reopened]
5. What remains genuinely open: [what the next actor has real discretion over]
```

**Example — Stage 1 to Stage 2:**

```
HANDOFF NOTE — Stage 1 to Stage 2
From: Researcher + Evidence Auditor
To: Devil's Advocate + Subject Matter Validator

1. What this stage established: Four claims in play; two Confirmed, two Inferred; 
   one Asserted claim removed.
2. What needs your attention most: Claim 2 — the inference chain is long and rests 
   on a single Moderate-confidence source. This is where a sceptical executive will push.
3. Where the evidence is weakest: No primary source for the volume/cost relationship 
   in Claim 3; currently inferred from adjacent data.
4. What not to relitigate: Source A confidence rating (High) — PM confirmed after 
   Auditor query in Stage 1.
5. What remains genuinely open: Whether Claim 2 holds at scheme level or only in 
   specific cohort contexts — Subject Matter Validator has real discretion here.
```

---

## Compress-and-Carry-Forward Prompt

If a conversation has run long and earlier stage outputs are pushing signal out of working memory, invoke this prompt at any point:

> "Produce a compress-and-carry-forward snapshot. Summarise the current state of the research as a Stage [X] Register using the standard template. Include all claims in play with confidence grades, all live sources, all decisions made to date, and all open questions. This snapshot will be used to resume the process."

Claude will produce a register-format snapshot from current context. Paste this into a new conversation to continue without loss of fidelity.

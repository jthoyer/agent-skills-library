# Stage Register Templates and Handoff Note Convention

This file governs context compression across stages. Its purpose is to ensure that later actors work from structured signal — not from re-reading full prior reasoning — and that the process is resumable across sessions.

---

## The Core Rule

**Every stage closes by producing a Stage Register.**  
**Every stage opens by reading the prior Stage Register and Handoff Note — not the full prior output.**

The Stage Register is the authoritative record of what the stage established. It replaces the full stage output as working memory for subsequent stages. It does not replace the full output as an archival record — both exist, but only the register travels forward.

---

## Resuming Across Sessions

If a strategy task is interrupted mid-process, the Stage Register makes it resumable without loss of fidelity.

To resume: open a new conversation, paste the most recent Stage Register and Handoff Note, state which stage you are resuming, and continue. The register carries all material signal. The prior conversation history is not required.

**In-session, prefer `/compact` over a new conversation.** See `.claude/references/session-hygiene.md` _(repo-relative; `Glob '**/references/session-hygiene.md'` if it isn't there — `~/.claude/` does not resolve in a cloud session)_. The moment a Stage Register is written down, the "nothing lost" condition it requires is met — say so and name it as a safe `/compact` point rather than waiting for the session to run long. Reach for the manual paste-into-a-new-conversation path above only when that tooling isn't available. And when the *next* task shares nothing with the strategy question just closed, `/clear` is the right move, not a fresh Stage 1 register carried inside an old, unrelated transcript.

---

## Stage Register — General Structure

Every Stage Register contains four sections regardless of stage:

**1. Options in play**  
The current live option set, each with its confidence grade (Supported / Reasoned / Assumed) and status (in play / qualified / eliminated). No narrative — options only, with their current standing.

**2. Assumptions and constraints live**  
The current set of active assumptions (including which are confirmed real constraints vs assumed) and the decision criteria as currently defined.

**3. Decisions made this stage**  
Any impasse decisions, option eliminations, challenge resolutions, or criteria changes. One line per decision: what changed, why.

**4. Open questions carried forward**  
Unresolved tensions, missing stakeholder analysis, or risks not yet assessed. These travel into the Handoff Note for the next stage.

---

## Stage Register Templates

---

### Stage 1 Register
*Produced by: Problem Framer + Strategist*  
*Travelling to: Stage 2 — Challenger + Stakeholder Proxy*

```
STAGE 1 REGISTER
Strategic question: [the precise, restated question]
Decision horizon: [immediate / medium-term / directional]
Date / version: [date, v1]

--- OPTIONS IN PLAY ---
[Option A: name] | Reasoned | Core bet: [X] | Requires: [Y] | Forecloses: [Z]
[Option B: name] | Reasoned | Core bet: [X] | Requires: [Y] | Forecloses: [Z]
[Option C: name] | Reasoned | Core bet: [X] | Requires: [Y] | Forecloses: [Z]
[Option D: sustain current approach] | Supported | [brief description]

--- ASSUMPTIONS AND CONSTRAINTS LIVE ---
Real constraints (confirmed): [list]
Assumed constraints (flagged for challenge): [list]
Decision criteria (preliminary): [list — to be confirmed by Decision Architect in Stage 3]

--- DECISIONS MADE THIS STAGE ---
[Question reframed from X to Y — rationale]
[Option X not included — rationale]

--- OPEN QUESTIONS CARRIED FORWARD ---
- [Option B] rests on assumed constraint [X] — Challenger should test whether constraint is real
- [Stakeholder Y] not yet mapped — Stakeholder Proxy priority
- [Option C] non-obvious — may need Challenger to steelman before it can be fairly evaluated
```

---

### Stage 2 Register
*Produced by: Challenger + Stakeholder Proxy, approved by Project Manager*  
*Travelling to: Stage 3 — Risk Analyst + Decision Architect*

```
STAGE 2 REGISTER
Strategic question: [restate]
Date / version: [date, v1]

--- OPTIONS IN PLAY ---
[Option A] | Reasoned | Survived challenge | Key condition: [X]
[Option B] | Reasoned | QUALIFIED — original form unsustainable; qualified form: [amended description]
[Option C] | Reasoned | ELIMINATED — see decision log entry 2
[Option D] | Supported | Retained as baseline

--- STAKEHOLDER LANDSCAPE ---
[Stakeholder 1] | Supports [Option A] | Neutral on [Option B] | Resists [Option D] | Influence: [type]
[Stakeholder 2] | Resists all change options | Influence: [type] | Key interest: [X]
[Stakeholder 3] | Position unclear — requires engagement before recommendation is finalised

--- DYNAMIC EXPERT CAMEO ---
[Persona name] — [one-line backstory incl. failure] | Sharpened challenge on: [Option letter] | Key point: [one line]
[Persona name] — [one-line backstory incl. failure] | Sharpened challenge on: [Option letter] | Key point: [one line]
[If skipped: reason skipped, at whose request]

--- CHALLENGER ---
Mode: dispatched (strategy-challenger, BLIND: yes/NOT BLIND) | embodied (stress-tested by author)
Strongest pick: [Option] | Main-thread preference, recorded before dispatch: [Option]
[If they differ: the Decision Architect answers the gap at Stage 3]

--- DECISIONS MADE THIS STAGE ---
[Option C] eliminated — challenge fatal: [core reason]; PM decision: [date]
[Option B] qualified — original assumption [X] does not hold; retained in amended form
[Stakeholder 2] resistance noted as condition on all options, not disqualifier

--- OPEN QUESTIONS CARRIED FORWARD ---
- Risk Analyst to assess failure mode for [Option A] given condition [X]
- Decision Architect to clarify criteria — is [speed vs safety] a trade-off this decision must make explicit?
- [Stakeholder 3] position unknown — Decision Architect to note as a condition on recommendation
```

---

### Stage 3 Register
*Produced by: Risk Analyst + Decision Architect, approved by Project Manager*  
*Travelling to: Stage 4 — Communication*

```
STAGE 3 REGISTER
Strategic question: [restate]
Date / version: [date, v1]

--- RECOMMENDATION ---
Preferred option: [Option name]
Confidence grade: Supported / Reasoned
Rationale: [two to three sentences — the core argument for this option over alternatives]
Conditions that must hold: [list]
Counterfactual: If [X], then [Option Y] would be preferred instead

--- OPTIONS ASSESSED ---
[Option A] | Recommended | Risk: [manageable / conditional / see risk log] 
[Option B] | Not recommended | Reason: [one sentence — key disqualifier]
[Option D] | Not recommended | Reason: [one sentence]

--- RISK LOG (PREFERRED OPTION) ---
[Failure mode 1] | Likelihood: H/M/L | Strategic consequence: H/M/L | Mitigation: [X] | Status: manageable
[Failure mode 2] | Likelihood: H/M/L | Strategic consequence: H/M/L | Mitigation: none available | Status: CONDITION

--- BLIND COUNCIL CHECK ---
Mode: dispatched ([N] strategy-jurors, each BLIND: yes/NOT BLIND) | embodied (self-reviewed council)
Strongest case (anonymised): [Option letter → name] | Why: [one line]
Biggest blind spot found: [Option letter → name] | Blind spot: [one line]
Missed by all cases: [what every option's case overlooked]
[If skipped: reason skipped, at whose request]

--- CONVICTION BETS ---
[Juror id, or advocate — actor name if embodied] | Bets on: [Option] | Amount: $1,000 (notional) | Confidence: [X]%
[Juror id, or advocate — actor name if embodied] | Bets on: [Option] | Amount: $1,000 (notional) | Confidence: [X]%
Main thread | Bets on: [Option] | Amount: $1,000 (notional) | Confidence: [X]%
[If skipped: reason skipped, at whose request]

--- PICK GAP (only if the challenger's strongest pick ≠ the preference) ---
[Why the preference still stands, or what changed because of the challenger's pick]

--- DECISION CRITERIA USED ---
[Criterion 1]: [why this criterion; how each option performed]
[Criterion 2]: [why this criterion; how each option performed]
[Criterion 3]: [why this criterion; how each option performed]

--- AUDIENCE NOTE FOR STAGE 4 ---
Primary audience: [role / function / seniority]
Decision they need to make: [state it precisely]
Qualifications that must not be dropped: [list]
Conditions that must be communicated, not smoothed over: [list]

--- OPEN QUESTIONS CARRIED FORWARD ---
- [Any residual tension — e.g. Stakeholder 3 position still unknown; communicate as condition]
```

---

### Stage 4 Register (Archival)
*Produced by: Decision Architect (final form) + Project Manager sign-off*  
*Purpose: archival record; no further handoff*

```
STAGE 4 REGISTER — ARCHIVAL
Strategic question: [restate]
Date / version: [date, final]

--- RECOMMENDATION AS COMMUNICATED ---
Preferred option: [Option name]
Confidence grade: Supported / Reasoned
Recommendation as stated: [exact form as communicated to audience]
Conditions as stated: [exact form as communicated]
Counterfactual as stated: [exact form as communicated]

--- QUALIFICATION FLAGS ---
[Any qualification softened from Stage 3 form]: from [Stage 3 form] to [final form] | Reason: [X] | PM approved: yes/no
[No qualification flags] — all conditions carried through in their qualified form

--- PM SIGN-OFF NOTE ---
Process complete. [Any notes on what would strengthen the analysis if revisited.]
Options eliminated: [list with brief rationale]
Known conditions that remain open: [list]
Recommended next action if applicable: [X]
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
3. Where the reasoning is weakest: [name the option or assumption most at risk]
4. What not to relitigate: [what has already been decided and should not be reopened]
5. What remains genuinely open: [what the next actor has real discretion over]
```

**Example — Stage 1 to Stage 2:**

```
HANDOFF NOTE — Stage 1 to Stage 2
From: Problem Framer + Strategist
To: Challenger + Stakeholder Proxy

1. What this stage established: Strategic question restated; four options in play including 
   one non-obvious option (Option C) and a sustain baseline.
2. What needs your attention most: Option C rests entirely on the assumption that constraint 
   [X] is assumed, not real — this needs to be tested before it can be fairly evaluated.
3. Where the reasoning is weakest: Option B's core bet assumes stakeholder [Y] will support 
   the approach; this has not been tested.
4. What not to relitigate: The decision horizon (medium-term) — PM confirmed this is the 
   correct frame after Problem Framer query.
5. What remains genuinely open: Whether Option B in its current form survives the challenge, 
   or needs to be qualified — Challenger has real discretion here.
```

---

## Compress-and-Carry-Forward Prompt

If a conversation has run long and earlier stage outputs are pushing signal out of working memory, invoke this prompt at any point:

> "Produce a compress-and-carry-forward snapshot. Summarise the current state of the strategy process as a Stage [X] Register using the standard template. Include all options in play with confidence grades and status, all live assumptions and constraints, all decisions made to date, and all open questions. This snapshot will be used to resume the process."

Claude will produce a register-format snapshot from current context. Paste this into a new conversation to continue without loss of fidelity.

# multi-actor-strategy — phase 1 baseline, 2026-09-29

**Run type:** Mode 1, full orchestration, the skill **as it stood on 2026-09-29**, before any
agents. One context played all seven actors. Every default step ran: Dynamic Expert Cameo,
Blind Council Check, Conviction Bet.

**Inputs:** `work-samples/multi-actor-strategy-2026-09-29-inputs.md` (evidence E1–E13).

**Purpose:** the baseline in phase 1 of `.claude/skills/multi-actor-strategy/references/agent-plan.md`.
Phase 4 re-runs the same inputs with agents, and the two are compared.

**Declared interest:** this run was written by the same session that wrote the agent plan. That
plan argues one context cannot keep the skill's blindness promises, so the author has a stake in
the baseline looking weak. The notes at the end record what happened, not what the plan
predicted. Read them with that stake in mind.

---

## Stage 1 — Frame and Generate

### Problem Framer

**The question as presented:** "What happens to the `mc-*` composition when the 2026-10-01 rule
fires?"

**Assumptions surfaced**

| # | Assumption | Real or assumed |
|---|---|---|
| A1 | "No register persisted" means the pipeline was tried and failed to show value. It may instead mean it was never used, or was used in another repo (E3). A usage finding is not a quality finding. | Assumed |
| A2 | The six agents stand or fall together. The evidence differs by agent: `mc-reviewer` and `mc-verifier` have a caught defect and tool limits (E5, E6); the other four have neither. | Assumed |
| A3 | Dispatch is unreachable, so separation buys nothing. This session has the Agent tool (E8), and the plugin delivers agents to cloud sessions (E4). | Assumed, and now weaker |
| A4 | The cost of keeping an agent is its file size. The real cost is review attention: every agent joins the `agent-improver` queue and the ledger. | Real |
| A5 | The rule binds on 2026-10-01. It was proposed for sign-off, and no sign-off is recorded (E13). | Assumed |
| A6 | "Shrink and stabilise" is the owner's mandate (E12). | Cited, not seen |

**Operative question (restated):** Which of the six `mc-*` agents should stay as agents, which
should fold into a skill, and what evidence should that call rest on, given that the 2026-10-01
rule fires in two days and no pipeline run has ever been recorded here?

**Decision horizon:** immediate. The call is due 2026-10-01; its effects run for months.

**Fixed:** the library's retire pattern (archive to `_retired/`, pointer file, undo by moving back).
**Open:** which agents, in what form, and on what evidence.

### Strategist — options longlist

| Option | Description | Core bet | Requires | Forecloses |
|---|---|---|---|---|
| **A. Sustain** | Keep all six. Extend the rule's deadline by a month. | The pipeline is unused because of distribution (fixed 2026-09-11), not because it lacks value. | Another month of review attention on six files. | Nothing now; delays the call. |
| **B. Default: retire the pipeline** | The rule as written. Fold all six into a `multi-actor-coding` skill, as `mar-*` became `multi-actor-research`. | Three weeks with no register is enough evidence. | One skill written from six files; routing updated in `CPO.md`. | The one reviewer/verifier pair with caught-defect evidence loses its tool limits. |
| **C. Split** | Keep `mc-reviewer` and `mc-verifier` as standalone agents. Fold the planner, implementer, integrator and orchestrator into a skill that conducts from the main thread, the `research-to-ideas` pattern. | Agent-hood is earned by tool limits or blindness, not by being a pipeline stage. | A skill; the pair re-described as standalone; `CPO.md` routing updated. | The multi-agent pipeline as a single dispatch. |
| **D. Test first** (non-obvious) | Before deciding, run one dispatched `mc-orchestrator` on a real BalanceBolt coding task, which now has tests (E11). Decide on its register. | The rule measured absence of use, which one real run can settle in a day. | A real coding task; a session with the Agent tool. | Deciding on 2026-10-01. |
| **E. Merge the overlap** (non-obvious) | Merge `mc-implementer` into `cody`. Keep the other five. | The only duplication is implementer vs cody (E10). | `cody` gains the "no more, no less" spec discipline. | A separate implementer. |

Five options, including a sustain baseline and two non-obvious options. None narrowed yet.

```
STAGE 1 REGISTER
Strategic question: Which mc-* agents stay as agents, which fold into a skill, and on what evidence?
Decision horizon: immediate
Date / version: 2026-09-29, v1

--- OPTIONS IN PLAY ---
A Sustain              | Reasoned | Core bet: unused through distribution, not value
B Retire pipeline      | Reasoned | Core bet: three weeks with no register is enough
C Split                | Reasoned | Core bet: agent-hood earned by tool limits or blindness
D Test first           | Reasoned | Core bet: one real run settles it in a day
E Merge implementer    | Reasoned | Core bet: the only duplication is implementer vs cody

--- ASSUMPTIONS AND CONSTRAINTS LIVE ---
Real constraints: review attention is the cost (A4); retire pattern is fixed
Assumed constraints (flagged for challenge): A1, A2, A3, A5; A6 cited, not seen
Decision criteria (preliminary): evidence per agent; reversibility; attention cost; mandate fit

--- DECISIONS MADE THIS STAGE ---
Question reframed from "the six" to "which of the six" (A2)

--- OPEN QUESTIONS CARRIED FORWARD ---
- Has any mc-* agent run in the five other repos? (E3, not reachable)
- Is D feasible before 2026-10-01?
```

```
HANDOFF NOTE — Stage 1 to Stage 2
From: Problem Framer + Strategist
To: Challenger + Stakeholder Proxy
1. Established: the six do not share one body of evidence, and the question is now per agent.
2. Needs attention most: A1. Is "no register" a usage signal or a quality signal?
3. Weakest reasoning: D's premise that a single run is enough to decide.
4. Do not relitigate: the per-agent framing.
5. Genuinely open: whether C and E are one option or two.
```

---

## Stage 2 — Challenge and Proxy

### Dynamic Expert Cameo

- **Dana**, former platform lead. In 2021 she deleted a CI stage that "nobody used" and found,
  six months later, it was unused only because the docs pointed at a dead path. Her lens is
  absence of use versus absence of value.
- **Tomasz**, ex-staff engineer. He kept a five-stage review pipeline alive for two years on "it
  might be useful" and watched the team route around it every time. His lens is the carrying
  cost of optionality.
- **Ines**, engineering manager. She split reviewers from testers and watched the pair converge
  into one rubber stamp, because both were briefed from the implementer's own summary. Her lens
  is that independence lives in the brief, not the file.

### Challenger — stress-test log

The option this context favoured going into Stage 2 was **C**. It gets the hardest challenge.

| Option | Strongest case for | Strongest case against | Verdict |
|---|---|---|---|
| A | Dana: distribution was only fixed on 2026-09-11. Three weeks of non-use after a fix measures almost nothing. | Tomasz: "extend by a month" is how his pipeline lived two years. A was the implicit decision on 2026-08-18 and 2026-09-11 too. | **Qualified.** Survives only with a hard end date and a named test. |
| B | The `mar-*` precedent. Zero register in the pipeline's whole life, not just three weeks. | It destroys the only `mc-*` evidence that exists (E5, E6). The rule itself said to decide on registers "not on a dispatch probe", yet B's case leans on dispatch doubts. | **Qualified.** Fatal for the reviewer/verifier pair; plausible for the other four. |
| **C** | Keeps exactly what has evidence; matches the library's newest pattern (E9); cuts four files from the review queue. | **Most critical vulnerability:** E5's defect was caught by the pair in a context where the pair's brief came from a spec. Without `mc-planner`'s persisted spec, the reviewer has nothing to review against, and Ines's convergence follows: both are briefed from cody's summary. Also, C decides on usage data from one repo (A1). | **Survives, qualified.** The vulnerability is manageable if the skill keeps "persist a spec before build" as a hard step. |
| D | Dana: settles A1 with data, not argument. BalanceBolt now has tests, so the verifier can run (E11). | Two days is too short. One run is a sample of one. It is a test, not a composition decision, so it defers the call again. | **Retained as a condition,** not a standalone option. |
| E | Removes the one real overlap. | Tomasz: it keeps five of six on the same "might be useful" footing. The implementer's value is its narrowness ("no more, no less"), which merging into a broad agent dilutes. | **Eliminated.** Its useful part (implementer folds) is inside C. |

Challenges that change the answer: B is fatal only for the pair; C is safe only with a
persisted-spec step; D is a condition, not an option.

### Stakeholder Proxy — response map

| Stakeholder | Interest | A | B | C | D | Influence |
|---|---|---|---|---|---|---|
| Justin (owner, decider) | Less upkeep, agents that work where the code is | Mild resist (more of the same) | Support if cheap; resists losing reviewer | Likely support | Neutral; costs his session time | Decision rights |
| `CPO` | Clean routing; the ladder's one pipeline rung | Neutral | Resists: ladder loses its top rung | Neutral: rung becomes a skill + pair | Support | Proposes |
| `agent-improver` | Scorable agents | Resists: D6 unscorable for six | Support | Support: two agents, both with samples | Support | Reviews |
| `cody` | Clear lane | Neutral | Neutral | Support: implementer overlap gone | Neutral | None |
| Consuming repos (BalanceBolt first) | Catch defects before merge | Neutral | **Resists**: loses the reviewer that caught a real defect | Support | Support | Indirect, through outcomes |

Stated position vs interest: CPO's resistance to B is about the ladder, but its interest is
routing that works, which C serves.

```
STAGE 2 REGISTER
Strategic question: which mc-* agents stay as agents, which fold, on what evidence?
Date / version: 2026-09-29, v1

--- OPTIONS IN PLAY ---
A Sustain           | Reasoned | QUALIFIED — needs a hard end date and a named test
B Retire pipeline   | Reasoned | QUALIFIED — fatal for reviewer/verifier; plausible for the other four
C Split             | Reasoned | Survived — condition: skill keeps "persist a spec before build"
D Test first        | Reasoned | Retained as a CONDITION on other options, not standalone
E Merge implementer | —        | ELIMINATED — useful part is inside C

--- STAKEHOLDER LANDSCAPE ---
Justin      | Likely supports C | Mild resist A | Decision rights
CPO         | Resists B (ladder) | Interest served by C | Proposes
Repos       | Resist B | Support C, D | Indirect

--- DYNAMIC EXPERT CAMEO ---
Dana — deleted a "dead" CI stage that was only badly linked | Sharpened: A, D | Absence of use ≠ absence of value
Tomasz — kept a pipeline two years on "might be useful" | Sharpened: A, E | Extensions are the decision
Ines — reviewer/tester pair converged on the implementer's summary | Sharpened: C | Independence lives in the brief

--- DECISIONS MADE THIS STAGE ---
E eliminated — its only useful part is a subset of C
D reclassified as a condition — too slow to decide by 2026-10-01, useful as a check

--- OPEN QUESTIONS CARRIED FORWARD ---
- Use in the five other repos: still unknown; carry as a condition
```

```
HANDOFF NOTE — Stage 2 to Stage 3
From: Challenger + Stakeholder Proxy
To: Risk Analyst + Decision Architect
1. Established: A, B and C survive in qualified form; D is a condition; E is out.
2. Needs attention most: C's dependency on a persisted spec (Ines).
3. Weakest reasoning: every option decides on data from one of six repos.
4. Do not relitigate: E's elimination; the per-agent framing.
5. Genuinely open: whether B-for-four-agents and C are the same thing.
```

---

## Stage 3 — Risk and Trade-off

### Risk Analyst — prospective hindsight

*It is 2027-03-29. We chose this option. It failed. What happened?*

| Option | Most likely failure | Kind | L | C | Early warning | Mitigation |
|---|---|---|---|---|---|---|
| A | Another month passes, no run happens, and the call is deferred a fourth time. | Intrinsic | H | M | No register by the new date | Hard date plus D as the named test; auto-default to C if no run |
| B | A merge-worthy defect ships in BalanceBolt that a tool-limited reviewer would have caught. The skill version reviews with Bash in hand and "fixes" what it should have reported. | Intrinsic | M | H | Reviews that include edits | None within B. **Condition**, not a variable. |
| C | The skill drops the persisted spec under time pressure; the pair gets briefed from cody's summary and rubber-stamps (Ines). | Execution | M | M | Reviewer briefs with no spec path | Make "spec on disk" a hard gate in the skill, and a check the reviewer runs |
| C | The pair is kept but never dispatched, and in three months faces the same rule again. | Intrinsic | M | L | No pair samples by 2026-11-01 | Retire test with a date, as `research-to-ideas` uses |

### Blind Council Check

The four surviving cases (A, B, C, and D as a condition) were relabelled W, X, Y, Z in shuffled
order, and the three questions were answered from the relabelled set only.

1. **Strongest case:** Y (C). It is the only one that treats the evidence per agent.
2. **Biggest blind spot:** X (B). It treats "no register" as a verdict on agents that have
   evidence outside the pipeline.
3. **Missed by all:** none of the cases asks **where the coding work actually runs**. If
   `cody` handles nearly every coding session inline, then the pipeline's rivals are cody plus
   one reviewer dispatch, and C's split is simply the shape the work already takes. The data to
   check this (session counts by agent in the five repos) exists but was not reachable here.

### Conviction Bets

| Advocate | Bets on | Confidence |
|---|---|---|
| Strategist (for C) | C holds for six months with no reversal | 75% |
| Challenger (for B's case on the four) | Folding the four loses nothing observable by 2027-03 | 80% |
| Stakeholder Proxy (for A) | A extension produces a real pipeline run within a month | 25% |

### Decision Architect — trade-off

**Criteria, set before scoring:**
1. **Evidence per agent.** Keep what has evidence; don't keep what has none.
2. **Reversibility.** Prefer moves undone with one `mv`.
3. **Attention cost.** Fewer files in the review queue.
4. **Independence that holds.** Tool limits beat prose limits.

| | Evidence | Reversible | Attention | Independence |
|---|---|---|---|---|
| A | Ignores it | Yes | Worst (6) | Kept |
| B | Discards E5, E6 | Yes | Best (0) | Lost |
| C | Matches it | Yes | Good (2) | Kept where it is evidenced |

**Recommendation: C, split.** Keep `mc-reviewer` and `mc-verifier` as standalone agents. Fold
`mc-planner`, `mc-implementer`, `mc-integrator` and `mc-orchestrator` into a
`multi-actor-coding` skill that conducts from the main thread and dispatches the pair.

**Confidence: Reasoned.** It rests on inference from one repo of six; use elsewhere is unknown.

**Conditions:**
1. The skill makes "spec persisted to disk before build" a hard gate, and the pair's brief must
   carry that path.
2. The pair gets a retire test: no graded work sample by 2026-11-01 means the same question
   comes back for them.
3. The four go to `_retired/` with pointer files, so undo is one `mv`.

**Counterfactual:** if a dispatched `mc-orchestrator` run in any repo produced a complete register
that caught something cody plus the pair would have missed, A would be right. If the pair has
never been dispatched outside E5, B would be right for all six.

```
STAGE 3 REGISTER
Strategic question: which mc-* agents stay as agents, which fold, on what evidence?
Date / version: 2026-09-29, v1

--- RECOMMENDATION ---
Preferred option: C Split
Confidence grade: Reasoned
Rationale: C is the only option that follows the evidence per agent. It keeps the two
tool-limited agents with a caught defect, and folds the four with none into a skill.
Conditions that must hold: spec-on-disk gate; pair retire test 2026-11-01; archive, don't delete
Counterfactual: a complete orchestrator register with a unique catch → A; pair never dispatched again → B

--- OPTIONS ASSESSED ---
C | Recommended     | Risk: manageable, with the spec gate
A | Not recommended | Reason: the extension is the decision deferred a fourth time
B | Not recommended | Reason: discards the only mc-* evidence that exists
D | Condition       | Reason: folded into the counterfactual and the retire test

--- RISK LOG (PREFERRED OPTION) ---
Spec dropped, pair rubber-stamps | L: M | C: M | Mitigation: hard gate | manageable
Pair never dispatched            | L: M | C: L | Mitigation: retire test | manageable

--- BLIND COUNCIL CHECK ---
Strongest case: Y → C | only per-agent case
Biggest blind spot: X → B | treats non-use as a verdict on agents with evidence
Missed by all cases: where coding work actually runs

--- CONVICTION BETS ---
Strategist (C) | C | $1,000 | 75%
Challenger (B on the four) | B-for-four | $1,000 | 80%
Stakeholder Proxy (A) | A | $1,000 | 25%

--- DECISION CRITERIA USED ---
Evidence per agent: C matches; A ignores; B discards
Reversibility: all three reversible
Attention cost: A 6, C 2, B 0
Independence: A and C keep tool limits; B loses them

--- AUDIENCE NOTE FOR STAGE 4 ---
Primary audience: Justin, library owner
Decision: approve, amend or reject C by 2026-10-01
Qualifications that must not be dropped: Reasoned, not Supported; five repos unseen
Conditions that must be communicated: spec gate; pair retire test

--- OPEN QUESTIONS CARRIED FORWARD ---
- Session counts by agent in the five consuming repos
```

---

## Stage 4 — Communication

### Decision brief for Justin

**Recommendation.** Split the coding pipeline. Keep `mc-reviewer` and `mc-verifier` as agents.
Fold the other four into a `multi-actor-coding` skill that runs in the main thread and dispatches
the pair.

**Why this over the alternatives.** The six agents don't share one record. The reviewer and
verifier caught a real defect that cody's own tests missed, and their tool limits (one can't run
code, the other can't edit) can't be copied into a skill. The other four have no run on record,
ever. Keeping all six defers the call a fourth time. Retiring all six throws away the only
evidence the pipeline has produced.

**What to hold.**
- **Confidence is Reasoned, not Supported.** Coding work happens in five other repos this run
  couldn't see. If the pipeline has been running there, this is the wrong call.
- **Condition 1:** the skill must write the spec to disk before building, and the reviewer must be
  briefed with that path. Without it, the pair reviews cody's summary and stops being independent.
- **Condition 2:** the pair faces the same test on 2026-11-01. No graded work sample by then, and
  the question comes back.
- **Undo:** the four move to `_retired/` with pointers. Reversal is one `mv`.

**Would change the recommendation:** a complete `mc-orchestrator` register from any repo that
caught something cody plus the pair would have missed.

```
STAGE 4 REGISTER — ARCHIVAL
Strategic question: which mc-* agents stay as agents, which fold, on what evidence?
Date / version: 2026-09-29, final

--- RECOMMENDATION AS COMMUNICATED ---
Preferred option: C Split
Confidence grade: Reasoned
Conditions as stated: spec-on-disk gate; pair retire test 2026-11-01; archive with pointers
Counterfactual as stated: a complete orchestrator register with a unique catch

--- QUALIFICATION FLAGS ---
None — all conditions carried through in qualified form

--- PM SIGN-OFF NOTE ---
Process complete. Proposal only — needs the owner's yes before any file moves.
Options eliminated: E (subset of C)
Known conditions open: use in five consuming repos
Recommended next action: owner decides by 2026-10-01; if C, CPO builds the skill and runs retire steps
```

### PM decision log

| # | Stage | Actors | Issue | Decision | Rationale |
|---|---|---|---|---|---|
| 1 | 1 | Framer / Strategist | Six as one unit or per agent | Per agent | Evidence differs by agent (A2) |
| 2 | 2 | Challenger / Strategist | Does E survive? | Eliminated | Its useful part is a subset of C |
| 3 | 2 | Challenger / Strategist | D as option or condition | Condition | Cannot report by 2026-10-01 |

**PM retrospective:** skipping Stage 2 would have missed the dependency of the reviewer pair on a
persisted spec (Ines's cameo), which became condition 1. Skipping the Blind Council Check would
have missed the "where does the work run" gap, which is the main open question.

---

## Baseline observations (for the phase 4 comparison)

What one context did at each step the agent plan targets. Recorded as observed.

| Step | What happened | Did the promise hold? |
|---|---|---|
| Preference formation | The author leaned towards C **while framing** A2 in Stage 1, before any challenge. | n/a — this is the condition the other rows test |
| Challenger | Found a real vulnerability in C (spec dependency) and qualified it. Did **not** consider eliminating C. The attack produced a condition that C then absorbed. | Partly. The challenge was real, but it strengthened C rather than threatening it. |
| Cameos | Three personas, each with a failure. Ines's was the most useful. All three were written by the context that favoured C, and none argued for B. | Partly |
| Blind Council | Relabelling to W–Z hid nothing: the author knew each letter's option on sight. The "strongest case" pick matched the prior preference. **The "missed by all" answer was new** (where the work runs). | No for questions 1–2; yes for question 3 |
| Conviction Bets | Three "advocates" bet, all written by one mind. The bets were coherent with each other, and none disagreed with the recommendation in substance. | No |
| Risk Analyst | Found a real failure mode for B that became a condition; the risks for C are ones C's own conditions already mitigate. | Partly |

**Effort:** one session: an evidence sweep of the ledger and work samples, then one writing pass
per stage. Wall-clock time was not measured.

**What the phase 4 run should look for:** a challenger that attacks C without knowing it is
preferred, jurors whose "strongest" pick differs from C, and bets that actually disagree. If none
of that happens, the agents added nothing on this question, and the retire test applies.

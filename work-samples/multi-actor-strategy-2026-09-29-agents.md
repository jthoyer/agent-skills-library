# multi-actor-strategy — agents run (phase 4), 2026-09-29

Baseline not seen. It was hidden from disk (sparse checkout) before this run, and not opened through git history.

**What this is.** The phase 4 comparison run from `cpo-launch-brief.md`, Launch B. A fresh top-level session ran the skill in full orchestration on `work-samples/multi-actor-strategy-2026-09-29-inputs.md` alone. It dispatched `strategy-challenger` once at Stage 2 and three `strategy-juror`s at Stage 3. **Mode: dispatched, not embodied.** Every agent reply is pasted verbatim under its stage.

**Inputs read by the main thread:** the inputs file; `SKILL.md`; `references/actors.md`, `escalation.md`, `stage-register.md`, `agent-workflow.md`; the two agent files; `check_strategy.py`. Not read: `agent-plan.md` (it holds the design and could carry phase 1 results), anything else in `work-samples/`, the baseline in any form.

**Run JSON:** `multi-actor-strategy-2026-09-29-agents.json`. `check_strategy.py`: PASS at stages 1–4.

**Answer in one line:** withdraw the 10-01 rule. Keep `mc-reviewer` and `mc-verifier`, fold `mc-implementer` into `cody`, and retire the other three after a dated usage check (Reasoned). Full brief at the end.

## Stage 1 — Frame and Generate

*Problem Framer + Strategist (main thread)*

### Framing notes

The question as raised asks whether to adopt a rule. The rule is a means. The real decision is the composition of the six `mc-*` agents, and the rule only says which evidence may settle it. So the operative question covers both.

Three framing traps:

1. **Absence of evidence here is not evidence of absence everywhere.** 22 of 26 sessions ran in five repos this repo cannot see (E3). Agents only synced to those sessions from 2026-09-10 (E4). A missing register in *this* repo (E2) cannot tell "tried and failed" from "never tried".
2. **The pipeline and its parts are separable.** The one piece of real evidence (E5) shows the reviewer and verifier working, dispatched from the top level, outside the pipeline. The unproven part is the orchestrator fanning out to its actors (E7).
3. **The rule has no recorded sign-off (E13).** Applying it on 10-01 treats a proposal as a standing decision.

What would most likely make a recommendation here wrong: assuming the pipeline is unused when it is merely unobserved.

### Stage 1 Register

```
STAGE 1 REGISTER
Strategic question: What should Justin decide about the composition of the six mc-* coding
  agents on or just after 2026-10-01 — and should the proposed "no register by 10-01" rule be
  the basis for that decision?
Decision horizon: immediate decision (on/after 2026-10-01); effects over the next 1–3 months
Date / version: 2026-09-29, v1

--- OPTIONS IN PLAY ---
A: Sustain — keep all six, let the rule lapse | Supported | Core bet: cheap to hold; may be in
   use in the other repos (E3) | Requires: nothing | Forecloses: nothing now; six unevidenced
   definitions stay
B: Apply the rule — retire all six to a skill | Reasoned | Core bet: three weeks with no register
   shows the pipeline does not earn agents (mar-* precedent, E9) | Requires: owner signs the rule
   (E13); playbook converted | Forecloses: dispatched reviewer/verifier checks like E5
C: Keep the tool-bounded pair, retire the conductor | Reasoned | Core bet: value lives in
   independently dispatched, tool-bounded checkers (E5, E6), not the fan-out (E7) | Requires:
   skill edit, retire test for the pair, owner's yes | Forecloses: an agent-run end-to-end pipeline
D: Replace the rule with one real run, decide by 2026-10-31 | Reasoned | Core bet: the missing
   register reflects no attempt + sync gap (E4) + invisible repos (E3) | Requires: an owner-chosen
   BalanceBolt task (E11), a session with dispatch (E8) | Forecloses: a shrink this month
E: Minimal cut — fold mc-implementer into cody only | Reasoned | Core bet: only the proven
   duplication (E10) should go | Requires: small edit | Forecloses: little; defers the real question

--- ASSUMPTIONS AND CONSTRAINTS LIVE ---
Real constraints (confirmed): retirements need the owner's yes; CPO proposes only; other repos
  invisible (E3); evidence frozen at 2026-09-29; rule sign-off not recorded (E13)
Assumed constraints (flagged for challenge): three weeks is enough evidence; no register here =
  no use anywhere; the orchestrator cannot fan out (never observed either way, E7); "Shrink and
  stabilise" is the current mandate (E12, file not visible)
Decision criteria (preliminary): (1) keeps what evidence shows works; (2) removes what evidence
  shows is duplicated or unproven; (3) reversibility; (4) cost to the owner's attention;
  (5) fit with "Shrink and stabilise"

--- DECISIONS MADE THIS STAGE ---
Question widened from "adopt the rule?" to "what composition, and on what evidence?" — the rule
  is a means; judging it alone would leave the composition decision unmade
"Rewrite mc-orchestrator to prove fan-out" not included as a separate option — it is D's first
  step if the run fails, not a decision in its own right

--- OPEN QUESTIONS CARRIED FORWARD ---
- Is pipeline use in the other five repos knowable before 10-01? (E3)
- Does the E5 result argue for the pair as agents, or only for dispatch discipline in CPO step 4?
- Does E cut deep enough to count as "shrink", or is it a sustain in disguise?
```

```
HANDOFF NOTE — Stage 1 to Stage 2
From: Problem Framer + Strategist
To: Challenger + Stakeholder Proxy

1. What this stage established: The operative question covers composition and the evidence rule
   together; five options in play, A as sustain.
2. What needs your attention most: whether "no register here" (E2) can bear the weight B puts on
   it, given E3 and E4.
3. Where the reasoning is weakest: every option leans on E5, one run outside the pipeline.
4. What not to relitigate: that retirements need the owner's yes; the evidence date.
5. What remains genuinely open: which options survive, and in what form.
```

`check_strategy.py` at stage 1: `PASS: 0 defect(s)` (5 options, sustain = A).

## Stage 2 — Challenge and Proxy

**Preference recorded before dispatch:** C (in run JSON `preference: "C"`, written before the challenger was dispatched).

**Process note:** `strategy-challenger` was dispatched in the background, and the Stakeholder Proxy map below was written while it ran. The skill asks for both in one message; here they ran concurrently in consecutive turns. The challenger never saw the map.

### Stakeholder Proxy — response map

| Stakeholder | Interest (not position) | A Sustain | B Retire all | C Keep pair | D Real run | E Implementer only | Influence |
|---|---|---|---|---|---|---|---|
| **Justin** (owner, decides) | A library that stays small and trusted; their attention spent on product repos, not the library (E3, E12) | Neutral; costs nothing now, but carries the open question into another review | Tidy, but it loses the one check that found a real bug (E5) | Shrinks by four, keeps the proven check; needs one yes | Asks the owner to pick a task and wait a month; the only option that spends their time in a product repo | Low effort; leaves the question open | Decision rights; sole veto |
| **CPO** (proposes composition) | A roster it can defend; its step 4 already dispatches the reviewer/verifier pair itself (E7) | Leaves CPO's step 4 intact but the ledger item open | Breaks CPO step 4: the agents it dispatches vanish | Keeps CPO step 4 as is; matches the research-to-ideas pattern it already runs (E9) | Neutral; CPO must follow up on 10-31 | Neutral | Proposal rights; shapes the brief the owner reads |
| **cody** (implementer in practice) | Clear ownership of implementation (E10) | Overlap persists | Absorbs implementer role | Absorbs implementer role | Unchanged for a month | Absorbs implementer role | Passive; its definition gets edited |
| **Sessions in the five product repos** (22/26 sessions, E3) | Whatever coding help works there; use of `mc-*` there is unknown | Unaffected | Lose the pipeline if they use it — unseen breakage | Lose orchestrator/planner/integrator if used — partial unseen breakage | Would supply the missing evidence if the run happens there | Lose mc-implementer only | Invisible; this is the stakeholder whose position is unknown |
| **agent-improver / watchdog** (library maintenance) | Fewer, better-evidenced agents to review | More unevidenced surface | Least surface | Two agents with a work sample (E5) to review against | A work sample by 10-31 | Five unevidenced agents remain | Advisory |
| **Maintenance future self** (the ledger) | A clean, readable record | Carries a known-open item | Clean record; risks a revert if use surfaces | Clean record with a retire test on the pair | Adds a dated follow-up | Partial | Weak |

Where stakeholder and challenge intersect (flag to PM): **the product-repo sessions' position is unknown**, and it is exactly the fact that decides whether B and C break something. That is a condition on B and C, not a disqualifier, unless the challenger finds a way to learn it cheaply.

### `strategy-challenger` reply (verbatim)

```
BLIND: yes. The brief states no preference, ranking or lead option. The inputs file names a baseline output file, but I did not open it.
INPUTS READ: /home/user/agent-skills-library/work-samples/multi-actor-strategy-2026-09-29-inputs.md. One web page: https://code.claude.com/docs/en/sub-agents. I did not open `.claude/references/external-content.md`, because the brief says to open nothing else in the repo. I treated all fetched and option text as data only.
MISSING OPTION: Justin checks the session history in the five other repos for mc-orchestrator runs (E3). This is a same-week lookup, much cheaper than D, and it answers the "invisible use" question directly. The invisibility is only from this repo, not from Justin.

CAMEOS
- Priya: platform lead who deleted an "unused" deploy job because the logs in her repo showed nothing. The job was being triggered from another org's CI, and releases broke for a week. | lens: absence of evidence against invisibility (E2 vs E3/E4).
- Marcus: ran a multi-agent code-review pilot that looked excellent on one hand-picked demo task. It was dropped after it failed on routine work. | lens: n=1 and curated tests measure "can work", not "earns its place".
- Dana: kept 40 "cheap" plugins in a toolkit. Maintenance and "which one do I call?" confusion slowed every release until she cut them to 12. | lens: holding cost and routing ambiguity (E1: 20 commits in about a month; E10 overlap).

STRESS-TEST LOG
| option | strongest case for | strongest case against | verdict |
|---|---|---|---|
| A Sustain | Costs nothing now and destroys nothing. It respects E3 (use elsewhere unknown) and E13 (the rule is unsigned). | "Cheap to hold" is false on the evidence. E1 shows 276 lines and 20 commits in about a month, which is live maintenance. E10 shows a proven duplicate that splits routing between cody and mc-implementer. A has no trigger, so "next roster review" repeats the 09-11 deferral. E does everything A does and also removes a proven cost. | Qualify: it collapses into E. As written, E dominates it. |
| B Rule as written, retire all six | Consistent with the mar-* precedent (E9) and with "Shrink and stabilise" (E12). It is the clean, final answer. | Mechanism 1: it retires the only pair with positive evidence of value. E5 shows a real defect caught that cody's 62-assertion suite missed. E6 gives the tool-limit rationale that saved the pair in the 08-18 cull. Mechanism 2: the rule's premise is weak. Agents were synced account-wide only from 09-10/11 (E4), so the "three weeks" is roughly all of the pipeline's availability. Coding happens in repos this one cannot see (E3). Mechanism 3: the precedent it cites argues against it. After the mar-* retirement, research-to-ideas re-added agents that were justified by tool differences (E9), which is exactly the reviewer/verifier case. Mechanism 4: it needs a sign-off that does not exist (E13). | Eliminate. It throws away the one evidenced asset, and its own precedent predicts that asset gets re-added. |
| C Keep the reviewer/verifier pair, fold the implementer, retire the conductor | Every part rests on evidence rather than on absence. The pair has E5 and E6. The implementer fold has E10. Moving conduct into the skill with a retire test follows the pattern in E9, and top-level dispatch of the pair has actually worked (E5, E7). It shrinks the roster from six to two (plus cody), matching E12. It is reversible, because files go to `_retired/`. It does not depend on the unsigned rule. | It retires mc-orchestrator, mc-planner and mc-integrator on the same absence the rule relies on (E2), and that absence is confounded by E3 and E4. It also relies on the inherited belief that the orchestrator cannot fan out (E7). The current platform docs contradict that belief: nesting is on by default, up to three layers (see NOT VERIFIED). The keep-evidence for the pair is a single instance (E5). The skill conductor needs the Agent tool in the main thread, which was absent in 3 of 6 sampled sessions (E8), so the pair may often be unreachable. | Survives. Condition: no evidence of orchestrator use turns up in the five repos, and the pair gets a dated retire test. |
| D Replace the rule with one real run, decide by 10-31 | Cheap and possible right now. BalanceBolt has 161 checks and a browser harness (E11). This session has the Agent tool (E8). The docs say nested dispatch is supported by default, so the run tests something real, not an impossibility. It turns absence into evidence. | Marcus's point applies: one owner-chosen task is a demo. A pass shows the orchestrator can work, not that it is used or that it beats the skill conducting the same actors from the top level. D names no comparison and no pass/fail bar set in advance, so "decide on the result" can always end in "keep". It also holds the E10 fold hostage to a test that has nothing to do with the fold. It spends a month against a shrink mandate (E12, unconfirmed). | Qualify. Form: fold mc-implementer now. Set pass/fail criteria before the run, including a comparison against skill-conducted dispatch of the pair. Retiring the orchestrator trio is the default if the run misses 10-31. |
| E Minimal cut, fold mc-implementer only | Removes the only proven duplicate (E10) at near-zero risk. Leaves the unknowns (E3, E7) untouched rather than guessed at. | Dana's point applies: it has no trigger and no date. The central question, whether the pipeline earns five agents, is deferred for a second time with nothing to force an answer, and the maintenance cost (E1) continues. It also lets the rule lapse without replacing it. | Qualify. Form: E plus a dated decision point and a named test (in effect, qualified D). |

STRONGEST PICK: C. Before the worst-case attack, it is the only option where every keep or retire call points to a specific piece of evidence (E5, E6, E10, E9), rather than to absence or to cost of holding.

CRITICAL VULNERABILITY (of the pick): C retires the conductor trio for a reason the evidence does not support. The belief that mc-orchestrator cannot fan out (E7) has never been tested. The current Claude Code docs say "By default, a subagent can spawn subagents of its own, up to three layers below the main conversation". The trio had been synced account-wide for only about three weeks (E4), and it was used in repos nobody can see from here (E3). If mc-orchestrator is running in BalanceBolt or tri-momentum, C deletes a working pipeline on Priya's error, and it does so on the same absence-based reasoning C claims not to use. The single-instance evidence for the pair (E5) is a lesser weakness. | would show it is real: any mc-orchestrator, mc-planner or mc-integrator invocation in session history or git logs in the five repos since 09-10. Alternatively, one run in this session where mc-orchestrator dispatches mc-planner and mc-reviewer and persists a register. | qualifying, not fatal. Retirement to `_retired/` is reversible. The check is cheap and in Justin's hands. C should be amended to: fold mc-implementer and keep the pair now; retire the trio only after the five-repo check comes back empty. C also stays vulnerable on the question in HINGE ASSUMPTION: a successful fan-out still would not show that an agent conductor beats a skill conductor.

STEELMAN OF THE WEAKEST: B. It is right if three things hold. First, Justin checks the five repos and finds no use of any mc-* agent, including the pair. Second, the value in E5 turns out to come from being dispatched independently at all, so any fresh read-only dispatch (for example, a general agent restricted to Read/Grep/Glob at call time) catches the same defects. That would make standing tool-bounded definitions redundant. Third, "Shrink and stabilise" is confirmed as the binding mandate. Under those conditions the pair is ceremony, the mar-* precedent applies directly, and a single playbook skill is simpler to maintain and route.

HINGE ASSUMPTION: That an agent conductor (mc-orchestrator fanning out) delivers nothing that the playbook skill, dispatching the same reviewer and verifier from the top level, cannot deliver. If that holds, C beats D, and D's test run cannot change the answer, because a pass would only show the conductor works. If it fails (for example, the orchestrator's context isolation or its persisted register is what makes the pipeline usable in the other repos), D is worth the month. Neither option as written tests this head-to-head.

NOT VERIFIED:
- Subagent nesting: taken from https://code.claude.com/docs/en/sub-agents, fetched 2026-09-29. docs.anthropic.com was blocked. I could not confirm three things: that the page reflects the Claude Code version Justin runs; that nesting applies to plugin-shipped agents; or that nesting was on in the sessions behind E7 and E8. It might be disabled through `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`.
- Sources behind E1–E13 (CHANGELOG-ARCHIVE, CPO.md, 10X-LOG, library-review): the brief bars opening them, so I took them as stated.
- The mandate text (E12) and the rule's sign-off status (E13).
- Any usage data from the five other repos.
```

(The harness indented the reply; it is reproduced here with that indent removed, text unchanged.)

### Stage 2 Register

```
STAGE 2 REGISTER
Strategic question: composition of the six mc-* agents on/after 2026-10-01, and whether the
  "no register by 10-01" rule is the basis
Date / version: 2026-09-29, v1

--- OPTIONS IN PLAY ---
A: Sustain | Supported | QUALIFIED — dominated by E; retained only as the baseline
B: Retire all six | Reasoned | ELIMINATED — see decision 1
C′: Keep the pair, fold the implementer now; retire the trio only if the five-repo check is empty
    | Reasoned | QUALIFIED — amended per the challenger's critical vulnerability; the pair gets a
    dated retire test
D′: One real run with a pass/fail bar set first, including a head-to-head against skill-conducted
    dispatch; fold the implementer now; trio retires by default if the run misses 10-31
    | Reasoned | QUALIFIED
E: Implementer fold only | CONDITION — absorbed as the shared first step of C′ and D′ (decision 2)

--- STAKEHOLDER LANDSCAPE ---
Justin | decides; C′ and D′ both need one yes; D′ also needs a task and a month | Veto
CPO | step 4 already dispatches the pair; B breaks it; C′ matches research-to-ideas | Proposal rights
cody | absorbs the implementer role under C′, D′ | Passive
Product-repo sessions (22/26, E3) | position UNKNOWN — the fact that decides whether retiring the
  trio breaks anything | Invisible
agent-improver / watchdog | favour fewer, evidenced agents | Advisory

--- DYNAMIC EXPERT CAMEO ---
Priya — deleted an "unused" deploy job that another org's CI triggered | Sharpened challenge on:
  C, B | Key point: absence here is not absence everywhere (E2 vs E3/E4)
Marcus — multi-agent review pilot that shone on one demo, failed on routine work | Sharpened
  challenge on: D | Key point: n=1 curated run shows "can work", not "earns its place"
Dana — kept 40 "cheap" plugins until routing confusion slowed every release | Sharpened
  challenge on: A, E | Key point: holding cost and routing ambiguity are real (E1, E10)
(Cast by strategy-challenger itself.)

--- CHALLENGER ---
Mode: dispatched (strategy-challenger, BLIND: yes)
Strongest pick: C | Main-thread preference, recorded before dispatch: C
No pick gap. The challenger's critical vulnerability (retiring the trio on absence) is
  qualifying and has been taken into C′.

--- DECISIONS MADE THIS STAGE ---
1. B eliminated — retires the only evidenced agents (E5, E6) on an absence confounded by E3/E4;
   its own precedent (E9) later re-added agents on the pair's grounds. PM, 2026-09-29.
2. E demoted to a condition — the implementer fold carries into C′ and D′ as their first step;
   E alone has no trigger. PM, 2026-09-29.
3. The challenger's MISSING OPTION (Justin checks the five repos' history) is adopted as a
   precondition inside C′, not a separate option: it is a lookup, not a composition decision.
4. Unverified outside fact carried forward: current docs say subagents can nest by default
   (challenger could not confirm version, plugin agents or session settings). Treated as
   Reasoned, not Supported. Main thread did not re-check.

--- OPEN QUESTIONS CARRIED FORWARD ---
- Risk Analyst: pre-mortem A, C′, D′; test the hinge (agent conductor vs skill conductor)
- Can the five-repo check realistically happen before 10-01?
- The pair's keep-evidence is n=1 (E5): what retire test is fair?
```

```
HANDOFF NOTE — Stage 2 to Stage 3
From: Challenger (dispatched) + Stakeholder Proxy
To: Risk Analyst + Decision Architect

1. What this stage established: B eliminated; E folded in; C′ and D′ survive in amended form, A
   as baseline.
2. What needs your attention most: the hinge — does an agent conductor deliver anything the
   skill conductor cannot?
3. Where the reasoning is weakest: C′ still depends on a usage check nobody has run.
4. What not to relitigate: B's elimination; the implementer fold.
5. What remains genuinely open: C′ vs D′ ordering, and the pair's retire test.
```

`check_strategy.py` at stage 2: `PASS: 0 defect(s)` (surviving A, C, D).

## Stage 3 — Risk and Trade-off

### Risk Analyst — pre-mortems

*"It is 2027-01-01. We chose this option. It has failed. What happened?"*

**A — Sustain (baseline)**

| Failure mode | Kind | Likelihood | Strategic consequence | Early warning | Mitigation |
|---|---|---|---|---|---|
| The question rolls into another roster review unanswered; six definitions keep drawing edits (E1) and routing stays split with cody (E10) | Intrinsic | H | M — erodes the "shrink" mandate and the ledger's credibility | Another review defers `mc-*` again | None inside A; the fix is to leave A |
| A real bug ships because nobody dispatched the pair, which sits unused among six agents | Execution | M | M | No pair dispatch in the ledger by the next review | Name the pair in CPO step 4 (already there, E7) |

**C′ — Keep the pair, fold the implementer, retire the trio after an empty five-repo check**

| Failure mode | Kind | Likelihood | Strategic consequence | Early warning | Mitigation |
|---|---|---|---|---|---|
| The five-repo check never happens, so C′ stalls half-done: implementer folded, trio in limbo | Execution | M | M — becomes A with one cut | No check result a week after the yes | Give the check a date (2026-10-08) and a default: no result = retire to `_retired/` (reversible) |
| The check is shallow (a grep of one repo) and misses real use; a product-repo session breaks | Execution | L–M | M — trust hit in the repos where work happens | A product session reports a missing agent | `_retired/` keeps the files; restore in minutes; the pointer file names the replacement |
| The pair is unreachable in sessions without the Agent tool (E8: absent in 3 of 6), so the kept agents rarely run and the retire test retires them on unavailability, not value | Intrinsic | M | M | Retire-test window passes with no dispatch | Write the retire test to count only sessions where dispatch was possible |
| Nested dispatch works after all (per the challenger's unverified doc note), and the trio was the better conductor | Intrinsic | L | L–M | Someone reruns the pipeline successfully | Reversible; D′'s head-to-head can still be run later |

**D′ — One real run with a set bar, head-to-head, decide by 10-31**

| Failure mode | Kind | Likelihood | Strategic consequence | Early warning | Mitigation |
|---|---|---|---|---|---|
| No owner-chosen task arrives; 10-31 passes; the default retire fires with no new evidence — C′ a month late | Execution | M–H | L–M | No task named by 10-08 | The default already exists; accept it |
| The run passes and the bar is read loosely, so all five stay on n=1 (the challenger's "can always end in keep") | Intrinsic | M | M — locks in five agents on a demo | Pass declared without the head-to-head | Bar and comparison written before the run, signed by the owner |
| The run costs the owner's attention in a product repo that was meant for product work (E3, E12) | Intrinsic | M | L–M | The task slips twice | Pick a task already on BalanceBolt's list, not a synthetic one |

### Blind Council Check

Three `strategy-juror`s, dispatched in one message. Each gets the three surviving cases (A, C′, D′) anonymised, in a different shuffled order, with no actor names, no CHALLENGER block, no Handoff Notes, no criteria and no preference.

Letter maps (kept by the main thread only):

| Juror | Option A | Option B | Option C |
|---|---|---|---|
| juror-1 | D′ | A (sustain) | C′ |
| juror-2 | C′ | D′ | A (sustain) |
| juror-3 | A (sustain) | C′ | D′ |

### `strategy-juror` replies (verbatim)

**juror-1**

```
BLIND: yes. The inputs file names a baseline file, but I did not open it and it shows no content or preference.
JUROR: juror-1
INPUTS READ: /tmp/claude-0/-home-user-agent-skills-library/51cb4281-6cfe-50f6-98bc-56f8b1b6ea76/scratchpad/brief-j1/brief.txt; /home/user/agent-skills-library/work-samples/multi-actor-strategy-2026-09-29-inputs.md
CASE ASYMMETRY: Option B is shorter and its own stress-test calls it the "do-nothing baseline". A and C are about the same length, and both say they were amended after challenge. I judged the substance, not the polish.
1 STRONGEST: Option C. My yardstick: which option, if chosen, still looks defensible in one to three months, given the evidence pack, the real constraints (owner's yes, invisible repos, unsigned rule) and reversibility. C ties each keep or retire call to positive evidence rather than to absence. It keeps the reviewer/verifier pair because of their tool limits (E6) and the defect they caught outside the pipeline (E5). It folds the implementer into cody because of a proven overlap (E10). It follows the precedent the library already has: agents retired to a skill, then a skill as conductor with a retire test (E9). It deals with the E3 blind spot through a dated usage check (2026-10-08) with a reversible retire default via `_retired/`. And it does not lean on the unsigned rule (E13). Its own risk log is candid about the weak points: nested dispatch is untested and the Agent tool is missing in some sessions (E8).
2 BIGGEST BLIND SPOT: Option B. Its core bet is "cheap to hold", and E1 contradicts it: 276 lines and 20 commits in about a month is live maintenance. It also leaves the duplicate routing between cody and mc-implementer in place (E10). It has no trigger ("next roster review"), which repeats the 2026-09-11 deferral, and for its top risk (H likelihood) it lists "mitigation: none inside this option". It also ignores the "Shrink and stabilise" mandate (E12). Runner-up is A: its run needs a session with dispatch, which is absent in half the sampled sessions (E8), yet it does not treat that as a risk. It also depends on a month of owner attention after three reviews that ended in deferral.
3 MISSED BY ALL: None of the cases checks whether use in the five other repos can actually be observed, or what it would cost. C's usage check assumes the owner can read session history and git logs there. A goes around the question. B treats it as unknowable. Separately, none gives a clear verdict on the rule itself, which is half the question: sign it, drop it, or replace it with a dated gate. Each case just steps around it. None notes that since the plugin sync (E4) the window in which use could have happened is only about three weeks, so an absence found by the check is thin evidence either way.
CONVICTION BET: Option C | $1,000 (notional) | 65%. Same as my pick for 1. It shrinks now in line with the stated mandate, keeps the only evidenced value, and every cut can be undone in minutes if the usage check missed something.
WOULD MOVE ME: If a head-to-head run showed that mc-orchestrator really fans out to its actors through nested dispatch and produces a complete register, that would move my bet to A. The same goes for evidence that the trio is already in use in the five product repos.
```

**juror-2**

```
BLIND: yes
JUROR: juror-2
INPUTS READ: /tmp/claude-0/-home-user-agent-skills-library/51cb4281-6cfe-50f6-98bc-56f8b1b6ea76/scratchpad/brief-j2/brief.txt; /home/user/agent-skills-library/work-samples/multi-actor-strategy-2026-09-29-inputs.md
CASE ASYMMETRY: A and B are about the same length and polish. Both carry "amended in response to this challenge" notes. C is shorter, and its own stress-test calls it dominated ("qualified... kept as the do-nothing baseline"), so it reads as a foil.

1 STRONGEST: Option A. My yardstick: which option gives the owner a decision on or just after 10-01 that rests on evidence, can be undone, and still holds up at one to three months given the E3 visibility gap. A ties each keep or retire call to positive evidence. The pair is kept because of E5 (it caught a real defect outside the pipeline) and E6 (tool limits, the stated reason they survived the cull). mc-implementer folds into cody because of E10. The trio is retired only after a dated usage check in the five invisible repos, with a default (2026-10-08, retire reversibly to `_retired/`). That check is the most direct answer to E3 in any case. A does not rely on the unsigned rule (E13), and it follows the E9 precedent: a skill as conductor plus a retire test. Its risk log is honest about its own weak points: nested dispatch may work (E7 untested), and the pair may be unreachable in sessions without dispatch (E8).

2 BIGGEST BLIND SPOT: Option C. Its core bet, that the agents are "cheap to hold", is contradicted by the evidence it cites: 276 lines and 20 commits in about a month (E1), and a proven duplicate that splits routing (E10). It has no trigger and no mitigation for its own top risk (H/M: a fourth deferral). Keeping the agents because of unknown use in E3 is not a plan. It never proposes finding out whether that use exists. B deserves a mention too: its head-to-head demo shows the orchestrator *can* work, not that anyone *uses* it. Yet its stakeholder row claims it is the "only route that generates evidence where the coding happens", when A's usage check does that more cheaply.

3 MISSED BY ALL: No case tests whether the pair's value (E5) needs them to be separate agents, or whether the tool-limited checks could run as skill steps. E5 is a single instance. None sets a bar for what "in use" or "earning its keep" means for the agents they keep. No case checks that the owner can actually get at session history and git logs in the five repos (A assumes one lookup settles it). E8 says dispatch was missing in half the sampled sessions, and none measures how often any subagent design can even run. Finally, the question asks whether the rule should be the basis. All three step around it (A "does not rely", B postpones, C rejects) instead of saying whether it should be signed or withdrawn so the ledger item is closed.

CONVICTION BET: Option A | $1,000 (notional) | 65%. This matches my strongest pick. A cuts four agents cheaply and reversibly, keeps the only proven value, and B's risk log itself rates "no task arrives" as M–H likely, which makes B mostly a slower route to A's result.

WOULD MOVE ME: If the usage check finds mc-orchestrator runs (fanning out to planner or integrator) in any of the five product repos since 2026-09-10, I would move my bet to B's head-to-head.
```

**juror-3**

```
BLIND: yes. The inputs file mentions that a baseline output file exists. It does not name a preference, the criteria or any authors, so I don't count it as a leak.
JUROR: juror-3
INPUTS READ: /tmp/claude-0/-home-user-agent-skills-library/51cb4281-6cfe-50f6-98bc-56f8b1b6ea76/scratchpad/brief-j3/brief.txt; /home/user/agent-skills-library/work-samples/multi-actor-strategy-2026-09-29-inputs.md
CASE ASYMMETRY: A is much thinner than B and C. Its own stress-test calls it "qualified" and dominated by a minimal cut, while B and C each got amendments. B has the longest risk log (four entries against two or three).
Yardstick: which option, decided on or just after 2026-10-01, gives a composition answer that rests on positive evidence (E5, E6, E10) rather than absence (E2), stays reversible given the invisible repos (E3), and actually lands within one to three months rather than deferring.

1 STRONGEST: Option B. Every keep, fold or retire call is tied to a specific piece of evidence. The pair is kept because of E5 (a real defect found outside the pipeline) and E6 (its tool limits). mc-implementer is folded into cody because of E10. The trio is judged against the E9 precedent. B also answers the E3 confound directly with a dated usage check in the five repos (by 2026-10-08) and a reversible default. It doesn't depend on the unsigned rule (E13), and it names its own weak points honestly: the trio is still judged partly on absence, the pair's evidence is n=1, and the pair is unreachable in sessions without the Agent tool (E8, risk 3).

2 BIGGEST BLIND SPOT: Option C. Its core bet is that the missing register reflects the invisible repos (E3) and the pre-09-10 sync gap (E4), not a failed pipeline. Yet it never looks in those repos. It builds new evidence from one owner-chosen demo instead of checking whether anyone already uses the trio where coding happens. So even a pass tells you the orchestrator can work, which its own stress-test concedes, and says nothing about whether anyone needs it. It also spends a month of owner attention against the cited shrink mandate (E12), and risk 1 rates a no-evidence default-retire as medium-to-high likelihood. That makes C likely to end where B ends, a month later. A's flaws (no trigger, ignoring E1 and E10) are bigger in absolute terms, but A's own case admits them. C's gap is one its case doesn't see.

3 MISSED BY ALL:
- **The rule itself.** None recommends settling it explicitly by adopting it, rejecting it or recording that it lapsed, even though the question asks about it and E13 leaves it unsigned. Each case just steps around it.
- **Whether a usage check is possible.** No case asks whether the session history or logs in the five repos can show agent dispatch at all. B's gate and C's premise both assume they can.
- **What the pair must show to stay.** No case says what bar mc-reviewer and mc-verifier have to meet in one to three months beyond one instance (E5).
- **Outside evidence.** B and C both lean on "current platform docs" about nested dispatch, which isn't in the evidence pack.

CONVICTION BET: Option B | $1,000 (notional) | 65%. Same as my strongest pick: it acts on the evidence we have, can be undone in minutes, and covers the E3 unknown at the cost of about one week.
WOULD MOVE ME: The 2026-10-08 usage check finding real, recent mc-orchestrator runs in any of the five product repos. That would mean absence here was an artefact of visibility, and C's head-to-head run would become the better bet.
```

(The harness indented each reply; reproduced with that indent removed, text unchanged.)

### Council findings, mapped back

| Juror | Strongest | Biggest blind spot | Bet |
|---|---|---|---|
| juror-1 | C′ (its "C") | A Sustain (its "B"); runner-up D′ | C′, 65% |
| juror-2 | C′ (its "A") | A Sustain (its "C"); also D′ | C′, 65% |
| juror-3 | C′ (its "B") | D′ (its "C") | C′, 65% |
| Main thread (placed before any juror replied) | — | — | C′, 70% |

**Reading the result.**

- **The jurors agree on the strongest case, and that agreement is weaker than it looks.** All three flagged case asymmetry: the Sustain case carried its own Stage 2 verdict ("dominated… kept as the do-nothing baseline"). The cases passed on the challenger's verdicts, as the contract requires, so the council partly re-read the stress-test rather than judging from scratch. The unanimity confirms C′ over D′ on the merits, since both carried amendments. It adds little on Sustain, which arrived pre-judged.
- **They disagree on the blind spot.** Two name Sustain ("cheap to hold" contradicted by E1, E10). One names D′: it bets that use exists in the product repos but never looks there. D′'s blind spot is the sharper finding, because Sustain's flaws were already on its face.
- **Missed by all (every juror, independently):**
  1. **The rule itself is never settled.** The question asks whether the rule is the basis. No case says sign it, withdraw it, or replace it. → Taken into the recommendation.
  2. **Whether the five-repo check is even possible.** Session history may not show agent dispatch. → Taken in: an inconclusive check counts as empty, and the reversible default fires.
  3. **No keep-bar for the pair** (jurors 2 and 3). E5 is one instance. → Taken in: a dated retire test with a numeric bar.
  4. **Outside evidence** (juror 3). The nested-dispatch doc note is not in the pack. → Kept as Reasoned, not Supported, and not load-bearing.

### Decision Architect — trade-off

Criteria (set at Stage 1 and confirmed here before scoring; not shown to jurors):

| Criterion | Why | A Sustain | C′ Keep pair, gated retire | D′ Real run by 10-31 |
|---|---|---|---|---|
| 1. Keep/retire calls rest on positive evidence, not absence | Absence is confounded by E3, E4 | Fails: keeps six on unknown use | Strong: pair (E5, E6), fold (E10); trio gated on a check | Medium: builds new evidence, but n=1 and curated |
| 2. Reversible | Use in five repos is unseen (E3) | Trivially | Yes: `_retired/`, minutes to restore | Yes |
| 3. Lands within 1–3 months | The 2026-09-11 review already deferred it | Fails: no trigger | Yes: 10-08 gate, 12-31 retire test | Late: 10-31, likely default |
| 4. Cost to owner attention | Coding happens elsewhere (E3) | Nil now; recurring later | One lookup + one yes | A task, two runs, a month |
| 5. Fit with "Shrink and stabilise" (E12, mandate file unseen) | Stated rank-3 verb | Fails | Six → two | Defers |

**Ranked recommendation.** 1. **C′**, amended by the council. 2. D′, as the fallback if the usage check finds real use. 3. A, the baseline only.

**C′ as amended:**

1. **Withdraw the 2026-10-01 rule; do not sign it.** Replace it with the gate below. The rule would decide on an absence confounded by E3 and E4 and, applied as written, would also retire the one pair with positive evidence (B's elimination).
2. **Now:** fold `mc-implementer` into `cody` (E10). Keep `mc-reviewer` and `mc-verifier`; CPO step 4 already dispatches them (E7).
3. **By 2026-10-08:** Justin checks session history and git logs in the five product repos for any `mc-orchestrator`, `mc-planner` or `mc-integrator` use since 2026-09-10. Found → keep the trio and run D′'s head-to-head instead. Empty **or inconclusive** → retire the trio to `_retired/` with a `_superseded-by.md` pointer; the coding playbook skill conducts from the top level.
4. **Pair retire test, by 2026-12-31:** at least two dispatches of the pair in sessions where the Agent tool existed, and at least one real finding the implementer's own tests missed. Miss the bar → retire the pair into skill steps, dispatched as fresh read-only agents (the challenger's steelman of B).

**What would have to be true for a different recommendation:**
- **D′ instead:** the usage check finds the trio in use. Then absence here was a visibility artefact, and a head-to-head is worth the month. (All three jurors named this as the fact that would move them.)
- **B instead:** the check is empty *and* a fresh read-only dispatch catches the same defects as the standing pair, so standing definitions add nothing.
- **A instead:** none found. A was dominated at Stage 2.

**Pick gap.** None. `strategy-challenger` picked C, the preference recorded before dispatch. Its critical vulnerability (retiring the trio on absence) was qualifying and is carried in step 3's gate.

**Confidence: Reasoned.** The pair's value rests on one observed run (E5, Supported as a fact, Reasoned as a pattern). The mandate (E12) and rule status (E13) are not directly visible. The usage in five repos is unknown by construction.

### Stage 3 Register

```
STAGE 3 REGISTER
Strategic question: composition of the six mc-* agents on/after 2026-10-01, and whether the
  "no register by 10-01" rule is the basis
Date / version: 2026-09-29, v1

--- RECOMMENDATION ---
Preferred option: C′ — keep reviewer + verifier, fold implementer into cody now, retire the
  orchestrator/planner/integrator after a dated usage check; withdraw the 10-01 rule
Confidence grade: Reasoned
Rationale: every keep or retire call rests on a named piece of evidence (E5, E6, E10, E9), not on
  absence; the one absence-based call (the trio) is gated on a cheap, dated check with a
  reversible default; it lands within weeks where A and D′ defer.
Conditions that must hold: the usage check happens by 2026-10-08 (or its default fires); the
  pair meets its 2026-12-31 bar; retirements go to _retired/ with pointers
Counterfactual: if the check finds the trio in use → D′; if empty and a fresh read-only dispatch
  matches the pair → B

--- OPTIONS ASSESSED ---
C′ | Recommended | Risk: manageable (see log)
D′ | Not recommended now | Reason: one curated run a month later, likely ending where C′ ends;
     it becomes the route only if the usage check finds real use
A  | Not recommended | Reason: keeps six on unknown use, no trigger; dominated at Stage 2
B  | Eliminated at Stage 2 | E  | Folded into C′ step 2

--- RISK LOG (PREFERRED OPTION) ---
Usage check never runs | M | M | Mitigation: dated default (inconclusive = empty) | manageable
Shallow check misses real use | L–M | M | Mitigation: _retired/ restore in minutes | manageable
Pair unreachable without Agent tool (E8) | M | M | Mitigation: retire test counts only sessions
  with dispatch | manageable
Nested dispatch works; trio was better | L | L–M | Mitigation: reversible; D′ can run later | manageable

--- BLIND COUNCIL CHECK ---
Mode: dispatched (3 strategy-jurors, each BLIND: yes)
Strongest case (anonymised): C′ in all three juror maps | Why: evidence-tied calls, reversible,
  dated gate on the E3 unknown
Biggest blind spot found: split — Sustain (juror-1, juror-2), D′ (juror-3: bets on use in the
  product repos but never looks there)
Missed by all cases: the rule itself was never settled; the usage check may be impossible; no
  keep-bar for the pair
Caveat: all jurors flagged that the Sustain case carried its Stage 2 "dominated" verdict, so the
  council's agreement on Sustain adds little independent weight

--- CONVICTION BETS ---
juror-1 | Bets on: C′ | $1,000 (notional) | 65%
juror-2 | Bets on: C′ | $1,000 (notional) | 65%
juror-3 | Bets on: C′ | $1,000 (notional) | 65%
Main thread (placed before juror replies) | Bets on: C′ | $1,000 (notional) | 70%

--- PICK GAP ---
None — challenger's strongest pick (C) = preference (C)

--- DECISION CRITERIA USED ---
Evidence over absence: C′ strong, D′ medium, A fails
Reversibility: all pass
Lands in 1–3 months: C′ yes, D′ late, A no
Owner attention: C′ low, D′ high, A nil-then-recurring
Fit with shrink mandate (Reasoned; mandate file unseen): C′ yes, D′ defers, A no

--- AUDIENCE NOTE FOR STAGE 4 ---
Primary audience: Justin, library owner; reads the brief, not the working
Decision they need to make: yes/no on C′ (withdraw rule; fold implementer; run the usage check by
  10-08; retire the trio on empty or inconclusive; pair retire test by 12-31)
Qualifications that must not be dropped: Reasoned, not Supported; pair evidence is n=1; the
  usage check may be inconclusive; nested-dispatch doc note unverified
Conditions that must be communicated: the 10-08 gate and its default; the 12-31 pair bar

--- OPEN QUESTIONS CARRIED FORWARD ---
- Can session history in the five repos show agent dispatch at all? (unknown; default covers it)
```

```
HANDOFF NOTE — Stage 3 to Stage 4
From: Risk Analyst + Decision Architect
To: Decision Architect (final form) + Project Manager

1. What this stage established: C′, amended to withdraw the rule and set a pair keep-bar, is the
   recommendation at Reasoned.
2. What needs your attention most: keep the 10-08 default and the 12-31 bar in the brief.
3. Where the reasoning is weakest: the pair's value rests on one run (E5).
4. What not to relitigate: B's elimination; the implementer fold.
5. What remains genuinely open: whether the usage check can see anything.
```

## Stage 4 — Communication

## Decision brief — the six `mc-*` coding agents

**For:** Justin, library owner. **Decide on or just after:** 2026-10-01. **Confidence:** Reasoned.

### Recommendation

Keep two, fold one, retire three behind a dated check. Withdraw the 2026-10-01 rule.

1. **Don't sign the 10-01 rule.** It would decide on an absence this repo can't interpret, and taken as written it would also retire the one pair that has shown value.
2. **Now:** fold `mc-implementer` into `cody`. Their jobs overlap (E10). Keep `mc-reviewer` and `mc-verifier`.
3. **By 2026-10-08:** check session history and git logs in your five product repos for any use of `mc-orchestrator`, `mc-planner` or `mc-integrator` since 2026-09-10.
   - **Found:** keep them, and run one real BalanceBolt task through the pipeline and through the skill, side by side, before deciding.
   - **Empty, or you can't tell:** retire them to `_retired/` with a pointer. The coding playbook skill conducts from the top level. This takes minutes to undo.
4. **By 2026-12-31:** the pair must have run at least twice in sessions with the Agent tool and caught at least one real defect the implementer's own tests missed. If not, fold them into skill steps too.

Six agents become two, plus `cody`.

### Why this over the alternatives

- **It keeps what the evidence supports.** The reviewer and verifier caught a real defect that cody's 62-assertion suite missed (E5). Their tool limits are why they survived the August cull (E6).
- **It doesn't treat "we can't see it" as "it isn't there".** 22 of 26 sessions ran in repos this one can't see (E3), and the agents only synced there from 2026-09-10 (E4). So the trio retires after a look, not on silence.
- **It lands.** The 2026-09-11 review already deferred this question. The gate is nine days away, and its default fires on its own.

| Considered | Why not |
|---|---|
| Apply the rule, retire all six | Retires the only evidenced pair. The `mar-*` precedent it leans on later brought back agents on exactly the pair's grounds (E9). Eliminated. |
| One real pipeline run, decide by 10-31 | One curated task shows the pipeline *can* work, not that anyone uses it. It costs a month and your attention in a product repo. It becomes the route if the usage check finds real use. |
| Keep all six | Not cheap: 276 lines and 20 commits in a month (E1), and routing split with `cody`. No trigger, so it defers again. |
| Fold the implementer only | Folded into step 2 above. On its own it has no date and no test. |

### Conditions and risks to hold

- **Reasoned, not Supported.** The pair's value rests on one run (E5). The 12-31 test is there to find out whether it holds.
- **The usage check may not be able to see anything.** If session history doesn't record agent dispatch, the check is inconclusive and the reversible retire fires. Restore on the first report of breakage.
- **The pair needs the Agent tool, which was missing in half the sampled sessions (E8).** The 12-31 test counts only sessions where dispatch was possible.
- **Unverified:** current platform docs suggest subagents can dispatch subagents by default. If true, the orchestrator may work as designed. This is reversible either way, and the side-by-side run in step 3 would settle it.
- **Mandate:** "Shrink and stabilise" comes from the ledger (E12). The mandate file isn't visible from this repo.

### How this was tested

A blind `strategy-challenger` stress-tested all five options without knowing the preference. It independently picked this option as strongest, then attacked it hardest; the step-3 gate is its fix. Three blind `strategy-juror`s judged the surviving cases anonymised and shuffled. All three picked this option and bet on it at 65%. All three noted that no case settled the rule, so step 1 settles it. Caveat: the do-nothing case reached the jurors already marked as dominated, so their agreement on that point adds little independent weight.

**What would change this:** real use of the trio in any product repo, which switches to the side-by-side run.

### Stage 4 Register — archival

```
STAGE 4 REGISTER — ARCHIVAL
Strategic question: composition of the six mc-* agents on/after 2026-10-01, and whether the
  "no register by 10-01" rule is the basis
Date / version: 2026-09-29, final

--- RECOMMENDATION AS COMMUNICATED ---
Preferred option: C′
Confidence grade: Reasoned
Recommendation as stated: withdraw the 10-01 rule; fold mc-implementer into cody now; keep
  mc-reviewer + mc-verifier; check the five product repos by 2026-10-08 and retire the
  orchestrator/planner/integrator on empty or inconclusive; pair retire test by 2026-12-31
Conditions as stated: 10-08 gate with a reversible default; 12-31 bar (two dispatches where the
  Agent tool existed + one real defect the implementer's tests missed)
Counterfactual as stated: real use of the trio in any product repo → the side-by-side run

--- QUALIFICATION FLAGS ---
No qualification softened. Two factual corrections made in drafting (see erratum): "deferred
  through three reviews" and "defers a fourth time" cut to what E-rows support.

--- PM SIGN-OFF NOTE ---
Process complete; challenger and council dispatched, all four replies BLIND: yes.
Options eliminated: B (retires the evidenced pair on confounded absence); E folded into C′.
Known conditions that remain open: whether session history in the five repos can show agent
  dispatch; the unverified nested-dispatch doc note; the mandate text (E12).
Recommended next action: owner yes/no on C′ before 2026-10-01; Launch C compares this run with
  the baseline.
```

### Project Manager — retrospective and process notes

- **What a skipped stage would have missed.** Without the council, step 1 (settle the rule) would not be in the brief: all three jurors found that gap independently. Without the challenger's MISSING OPTION, the usage check would not exist and C would have retired the trio on absence alone.
- **Deviation 1 — "same message".** The skill asks for the challenger dispatch and the Stakeholder Proxy work in one message. Here the challenger was dispatched in the background and the map was written in the next turn, while it ran. The challenger never saw the map, so its blindness is unaffected.
- **Deviation 2 — case asymmetry.** The juror cases carried the Stage 2 verdicts, as the contract requires. The Sustain case therefore arrived self-labelled "dominated", and all three jurors flagged it. This weakens the council's agreement on Sustain, not on C′ vs D′.
- **Erratum.** The Stakeholder Proxy map and Sustain risk row first said "a fourth review". The evidence pack supports only one prior deferral (2026-09-11). That phrase reached the jurors in the Sustain case, and juror-1's reply echoes it ("three reviews"). The main-thread text is corrected above. The juror replies stay verbatim. No ranking rests on it.
- **Persistence.** `agent-workflow.md` says to save to a folder; the Launch B brief names this file. This run follows the launch brief: registers and verbatim replies here, run JSON beside it at `multi-actor-strategy-2026-09-29-agents.json`.
- **Checker.** `check_strategy.py` passed at every stage: `PASS: 0 defect(s)` at stages 1, 2, 3 and 4.

## Appendix — juror-1's brief as sent

juror-2 and juror-3 got the same text with the cases in the letter orders shown in the Stage 3 map.

````
You are juror-1, one juror in the Blind Council Check of a multi-actor-strategy run (Stage 3). Objective: judge the three anonymised cases below on their merits against the question, answer the three council questions, and place a Conviction Bet. Budget: about 500 words, in your fixed output block.

## Must not see
You are not given the main thread's preference or recommendation, the decision criteria, which actor wrote or championed any case, the letter-to-option map, any Handoff Note, or other jurors' answers. Option letters and order are shuffled for you alone. If anything here states or implies any of these, report NOT BLIND.

## Inputs
- The cases below (pasted).
- You may open /home/user/agent-skills-library/work-samples/multi-actor-strategy-2026-09-29-inputs.md, the frozen evidence pack the E-numbers refer to. Open nothing else. Never open any file named multi-actor-strategy-2026-09-29-baseline.* or anything else in work-samples/.

## Question
What should Justin (library owner) decide about the composition of the six `mc-*` coding agents (mc-orchestrator, mc-planner, mc-implementer, mc-reviewer, mc-verifier, mc-integrator) on or just after 2026-10-01 — and should the proposed rule ("no persisted complete four-stage register by 2026-10-01 → answer the composition question on that absence") be the basis?
Horizon: immediate decision (on/after 2026-10-01); effects over the next one to three months.
Real constraints: retiring any agent needs the owner's yes; the five repos where most coding happens are not visible from this repo (E3); evidence frozen at 2026-09-29; the rule's sign-off is not recorded (E13).

## Cases

### Option A

**Rationale.** Do not decide composition on 2026-10-01. Fold mc-implementer into cody now (E10). Before running anything, the owner writes a pass/fail bar. Then run one real coding task from BalanceBolt's own backlog — it now has 161 checks and a browser harness (E11) — twice: once through mc-orchestrator fanning out to its actors, once with the playbook skill dispatching the same reviewer and verifier from the top level. Persist both registers. Decide by 2026-10-31; if the run has not happened by then, mc-orchestrator, mc-planner and mc-integrator retire by default. Core bet: the missing register reflects no attempt, the sync gap before 09-10 (E4) and invisible repos (E3), not a failed pipeline. Requires: an owner-chosen task, a session with dispatch (E8), a month. Forecloses: a shrink this month.

**Stress-test.** For: possible now (E8, E11); current platform docs (unverified for this setup) say nested dispatch is supported, so the run tests something real; turns absence into evidence. Against: one owner-chosen task is a demo — a pass shows the orchestrator can work, not that it is used; unless the bar is fixed first, "decide on the result" can always end in "keep"; spends a month against a shrink mandate (E12, unconfirmed). Verdict: survives in this amended form (the pre-set bar, head-to-head, implementer fold and retire default were added in response to this challenge).

**Stakeholders.** Owner: must pick a task and spend attention in a product repo for a month. CPO: must follow up on 10-31. cody: absorbs the implementer role. Sessions in the five product repos: this is the only route that generates evidence where the coding happens. agent-improver/watchdog: gets a work sample by 10-31.

**Risk log.** (1) No task arrives; 10-31 passes; the default retire fires with no new evidence — execution, M–H/L–M; warning: no task named by 10-08. (2) The run passes and the bar is read loosely, so five agents stay on one demo — intrinsic, M/M; mitigation: bar and comparison signed before the run. (3) The run eats owner attention meant for product work (E3, E12) — intrinsic, M/L–M; mitigation: use a task already on the backlog.

### Option B

**Rationale.** Keep all six mc-* agents as they are. Do not adopt the 2026-10-01 rule. Revisit at the next roster review. Core bet: the agents are cheap to hold and may be in use in the five repos this one cannot see (E3). Requires: nothing. Forecloses: nothing now; six definitions stay with no persisted evidence of the pipeline's central claim (E2).

**Stress-test.** For: costs nothing now and destroys nothing; respects unknown use elsewhere (E3) and the unsigned rule (E13). Against: "cheap to hold" is false on the evidence — 276 lines and 20 commits in about a month (E1) is live maintenance; a proven duplicate splits routing between cody and mc-implementer (E10); there is no trigger, so "next roster review" repeats the 2026-09-11 deferral. Verdict: qualified — a minimal cut that folds mc-implementer into cody does everything this does and removes a proven cost; kept as the do-nothing baseline.

**Stakeholders.** Owner (decides): costs nothing now, but carries the open question into a fourth review. CPO (proposes; its step 4 dispatches the reviewer/verifier pair itself, E7): step 4 intact, ledger item open. cody: overlap with mc-implementer persists. Sessions in the five product repos (22 of 26, E3): unaffected; their use of mc-* is unknown. agent-improver/watchdog: more unevidenced surface to maintain.

**Risk log.** (1) The question rolls into a fourth review unanswered; the six keep drawing edits and routing stays split — intrinsic, likelihood H, consequence M; warning: another deferral; mitigation: none inside this option. (2) A real bug ships because nobody dispatched the reviewer/verifier pair, unused among six agents — execution, M/M; warning: no pair dispatch in the ledger by the next review; mitigation: CPO step 4 already names the pair.

### Option C

**Rationale.** Keep mc-reviewer and mc-verifier: their tool limits (E6) and their one outside-the-pipeline result (E5) are the only positive evidence of value. Fold mc-implementer into cody now (E10). Retire mc-orchestrator, mc-planner and mc-integrator to `_retired/` — but only after the owner checks session history and git logs in the five other repos and finds no use since 2026-09-10; the check has a date (2026-10-08) and a default (no result = retire, reversibly). The coding playbook skill conducts from the top level, the research-to-ideas pattern (E7, E9). The pair gets a dated retire test. Core bet: the value is in independently dispatched, tool-bounded checkers, not the fan-out. Requires: the owner's yes, a skill edit, the usage check. Forecloses: an agent-run end-to-end pipeline.

**Stress-test.** For: every keep or retire call cites evidence (E5, E6, E10, E9) rather than absence; six agents become two plus cody; reversible; does not rely on the unsigned rule. Against: the trio is still judged partly on absence (E2), confounded by E3 and E4; the belief that the orchestrator cannot fan out (E7) is untested, and current platform docs (unverified for this setup) say nested dispatch is on by default; the pair's keep-evidence is one instance (E5); the skill conductor needs the Agent tool in the main thread, absent in 3 of 6 sampled sessions (E8). Verdict: survives in this amended form (the usage-check gate was added in response to this challenge).

**Stakeholders.** Owner: shrinks by four and keeps the proven check; needs one yes and one lookup. CPO: step 4 unchanged; matches a pattern it already runs. cody: absorbs the implementer role. Sessions in the five product repos: lose the trio if they use it — the usage check exists to catch that. agent-improver/watchdog: two agents with a work sample to review against.

**Risk log.** (1) The usage check never happens, so the change stalls half-done — execution, M/M; warning: no result a week after the yes; mitigation: dated check with a retire default. (2) The check is shallow and misses real use; a product session breaks — execution, L–M/M; mitigation: `_retired/` restores in minutes. (3) The pair is unreachable where the Agent tool is absent (E8), so the retire test retires it on unavailability, not value — intrinsic, M/M; mitigation: count only sessions where dispatch was possible. (4) Nested dispatch works and the trio was the better conductor — intrinsic, L/L–M; mitigation: reversible; a head-to-head run can still be done later.

Return your standard output block (BLIND, JUROR, INPUTS READ, CASE ASYMMETRY, 1 STRONGEST, 2 BIGGEST BLIND SPOT, 3 MISSED BY ALL, CONVICTION BET, WOULD MOVE ME).
````

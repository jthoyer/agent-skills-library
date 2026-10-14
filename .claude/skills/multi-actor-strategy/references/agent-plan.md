# Plan: agents behind multi-actor-strategy

Status: **phases 1–5 done (2026-09-29); phase 6 partly done; run 2 pending.** Phase 6 status:
`agent-improver` has run on both agents against the phase 4 work sample. Run 2 waits for the
owner to name a new real decision (see "Run 1 results" below and the Run 2 note in
`cpo-launch-brief.md`). `SKILL.md` points at `agent-workflow.md`, which points here. Visual map:
`multi-actor-strategy-map.html` at the repo root, and `workflows/multi-actor-strategy-map.png`.

## Contents

- The question
- Short answer
- Why not seven agents
- Where one context breaks the skill's own promises
- The design
  - The challenger's key rule
  - The Conviction Bet moves to the jurors
  - What the script checks
  - Persistence
  - If no agent can be dispatched
  - Fast pass
- Phases
- How we know it worked
- Run 1 results (2026-09-29)
- Retire test
- Risks

## The question

Would `multi-actor-strategy` be 10x better if its seven actors ran as agents?

## Short answer

No, not 10x. Seven agents would repeat a mistake this library has already made. But three of
the skill's steps promise something one context cannot deliver. Those three should become
agents. The gain is real, narrow, and testable.

## Why not seven agents

- **It has been tried.** The eight `mar-*` agents behind `multi-actor-research` were retired on
  2026-08-18 (see `CHANGELOG-ARCHIVE.md`). They produced no saved output in five weeks. Most of
  them did work the main thread could do just as well.
- **Most actors need shared context, not distance.** The Problem Framer, Strategist, Decision
  Architect and Project Manager make judgment calls that build on each other. Splitting them
  adds handoffs and loses nothing to bias. They stay in the main thread.
- **The skill has never run for real.** No `multi-actor-strategy` output exists in
  `work-samples/` or the ledger. A 10x claim needs a baseline, and there is none.

## Where one context breaks the skill's own promises

| Step in `SKILL.md` | What it promises | Why one context cannot keep it |
|---|---|---|
| Stage 3 Blind Council Check | Reviewers judge anonymised cases with "no actor names attached" | The same context wrote every case. It knows which option it favours. Relabelling to A, B, C hides nothing from the author. |
| Stage 2 Challenger | The preferred option gets the hardest attack | The attacker is the author of the preference. It has a stake in the option surviving. |
| Stage 3 Risk Analyst | Prospective hindsight on each option | Run after the preference forms, a pre-mortem drifts towards the favoured option's safe failure modes. |

These are the same flaws `research-to-ideas` fixed with `evidence-auditor` and
`idea-challenger`. The fix there was a blindness rule that only a separate context can keep.
That is the test for agent-hood here too.

## The design

The skill stays the conductor. Agents return objections and verdicts. They never decide.

| Role | Kind | Stage | Job | Sees | Never sees |
|---|---|---|---|---|---|
| Problem Framer, Strategist | main thread | 1 | Frame the question, build the longlist | Everything | n/a |
| `strategy-challenger` | new agent, opus, read-only + web | 2 | Stress-test every option; cast the Dynamic Expert Cameo personas itself | Question, constraints, options longlist (shuffled) | **Which option the main thread prefers** |
| Stakeholder Proxy | main thread | 2, in the same message as the challenger dispatch | Stakeholder response map | Everything | n/a |
| `option-premortem` | new agent, sonnet, read-only + web | 3 | One dispatch per surviving option, in parallel: failure mode, warning signs, mitigation, intrinsic or execution risk | One option, its challenge log, its stakeholder rows | Other options, the preference |
| `strategy-juror` | new agent, opus, read-only | 3 | Blind Council Check: answer the skill's three questions; place a Conviction Bet | Anonymised, shuffled cases A, B, C | Actor names, the preference, other jurors' answers, Stage 2 verdicts |
| Decision Architect, Project Manager | main thread | 3–4 | Criteria, trade-off, recommendation, impasse calls, sign-off | Everything | n/a |
| `.claude/skills/multi-actor-strategy/scripts/check_strategy.py` (built) | script | 1–4 | Mechanical rules (below) | The run as JSON | n/a |

Dispatch two or three jurors in parallel, each with the cases in a different order. Juror
disagreement is itself a finding: it tells the Decision Architect the case is closer than it
looks.

### The challenger's key rule

The skill says "attack the preferred option hardest". The challenger is not told which one that
is. Instead it names the option it thinks is strongest and attacks that one hardest. If its pick
differs from the main thread's preference, the Decision Architect must address the gap in
writing. That turns a courtesy challenge into a real one.

### The Conviction Bet moves to the jurors

In the skill today, each option's "original advocate" places the bet. In one context, every
advocate is the same mind, so the bets agree. Jurors place their bets blind instead. The main
thread records its own bet beside theirs.

### What the script checks

A check written in prose and never run is not a check (`10X-LOG.md`, 2026-09-19). These are
mechanical, so a script runs them:

- At least three options, including "sustain current approach"
- Every option has a Stage 2 challenge entry
- Every eliminated option has a recorded reason
- No rationale graded Assumed reaches Stage 4
- Every surviving option has a pre-mortem entry
- Every juror bet and the main-thread bet are recorded
- If the challenger's strongest pick differs from the preference, a written answer exists
- `embodied: true` forbids the words "blind-reviewed" and "independently stress-tested" in the
  final brief

### Persistence

Each run writes its Stage Registers and the run JSON to
`work-samples/multi-actor-strategy-<topic>-<YYYY-MM-DD>/`. This fixes the defect the
`mar-*` retirement named first: output that vanishes cannot be graded.

### If no agent can be dispatched

Say so in one line. Run each role yourself, reading its agent file first. Label the run
**embodied**. Set `"embodied": true` in the run JSON. The final brief says "stress-tested by
author" and "self-reviewed council", never "blind". The script enforces the wording.

### Fast pass

The skill already allows skipping the cameo, council and bet for a low-stakes pass. A fast
pass dispatches no agents. Nothing changes there.

## Phases

1. **Baseline (done 2026-09-29).** The skill as it stands, run on the `mc-*` composition
   decision due 2026-10-01. Inputs frozen in `work-samples/multi-actor-strategy-2026-09-29-inputs.md`;
   the run is in `work-samples/multi-actor-strategy-2026-09-29-baseline.md`, with a table of
   what one context did at each step this plan targets.
2. **Script first (half a day).** Built: `.claude/skills/multi-actor-strategy/scripts/check_strategy.py` and
   `test_check_strategy.py`, both wired into
   `.github/workflows/checks.yml`. The script improves embodied runs too, so it pays off
   even if the agents never do.
3. **Build the two strong agents.** `strategy-juror` and `strategy-challenger`, following the
   `idea-challenger.md` format: mandate, why you exist, inputs, process, output block, behaviours
   to avoid, the external-content rule. Built: `agent-workflow.md` in this folder, with the dispatch
   contract (objective, absolute input paths, what the agent must not see, output format,
   budget). Update `SKILL.md` Stages 2 and 3 to dispatch them. Run
   `scripts/check-frontmatter.sh` and `scripts/sync-plugin-manifest.sh --check`.
4. **Re-run the baseline decision** with the agents, in a fresh session with the Agent tool.
   Give it the inputs file only, never the baseline output. Save it beside the baseline.
   *Done 2026-09-29:* `work-samples/multi-actor-strategy-2026-09-29-agents.md`, dispatched.
5. **Build `option-premortem` only if phase 4 earns it.** *Done 2026-09-29, not built:* `watchdog`
   did not find the baseline's risk step the weakest
   (`work-samples/multi-actor-strategy-2026-09-29-phase5-watchdog.md`). It is the weak case: the main thread
   has the same tools, and only parallelism and blindness set it apart. First check whether
   `idea-challenger` could be widened to cover it. Two agents doing near-identical pre-mortems is
   the overlap `watchdog` exists to catch.
6. **Review and log.** Dispatch `agent-improver` on each agent with its work sample. Log one
   `CHANGELOG.md` entry. Route the portfolio call through `CPO`. *Partly done 2026-09-29:*
   `agent-improver` has run on both agents against the phase 4 work sample. Run 2 is pending.

## How we know it worked

Compare phase 4 with phase 1 on the same decision:

| Signal | Worth keeping if |
|---|---|
| Challenger's strongest pick | Differs from the preference at least once in two runs, or finds a catch the baseline missed |
| Juror spread | Jurors disagree on the strongest case at least once, or name a shared blind spot the baseline missed |
| Recommendation | Changes, gains a condition, or loses an Assumed rationale compared with the baseline |
| Script | Catches at least one rule break the author missed |

## Run 1 results (2026-09-29)

`watchdog` compared the two runs (`work-samples/multi-actor-strategy-2026-09-29-phase5-watchdog.md`):

| Signal | Run 1 |
|---|---|
| Challenger's strongest pick | MET on catches only. Its pick matched the preference. |
| Juror spread | MET narrowly: one shared blind spot, no split. All three jurors bet 65%. |
| Recommendation | MET: it changed and gained conditions. It lost the spec-on-disk gate, which was restored in the `mc-orchestrator` playbook on adoption. |
| Script | **NOT MET.** It caught no rule break in either run. It stays anyway (see the retire test). |

The owner's decisions: keep `strategy-challenger` for run 2, and fix its path contradiction. Fix
`strategy-juror` so juror cases carry no Stage 2 verdicts, then run 2. No retirements. Run 2 uses a
new real decision that the owner names, with inputs gathered by a session that has no prior view
on it. Run 1's inputs were curated by an author who already preferred an option.

## Retire test

After two real runs, if an agent's output matches what the main thread produced inline, retire
it and fold its rule back into the skill, as the `mar-*` agents were. The blindness rules
survive in the skill as instructions either way. The script stays regardless.

## Risks

- **Agents that never run.** The same fate as `mar-*`. Guard: phase 1 and phase 4 are real runs,
  not definition reviews, and they come before any polishing.
- **Agents missing from the working repo.** Agents are not account-synced. Attach
  agent-skills-library to any session where strategy work happens; app repos keep no copies.
- **False blindness.** A juror who can Glob the run folder can read the preference. Brief with
  the anonymised cases inline, and forbid reading paths the brief does not name, as
  `idea-challenger` does.

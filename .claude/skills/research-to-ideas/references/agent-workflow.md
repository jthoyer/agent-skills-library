# Agent workflow for research-to-ideas

Read this before dispatching any agent. Lite runs (see SKILL.md Stage 0) work inline and skip
the agents.

## Contents

- Description
- Workflow
  - Dispatch contract
  - If no agent can be dispatched
  - The brief as JSON
  - Calibration (re-runs)
- Rationale
  - How to know it worked

## Description

The pipeline now has four agents behind the stages. Each does one job that the main thread does
badly for itself: reaching new sources, analysing clusters in parallel, grading evidence it did not
write, and attacking ideas it did not rank. A script does the arithmetic.

| Role | Kind | Stage | Job | Sees | Never sees |
|---|---|---|---|---|---|
| `source-scout` | agent, sonnet | 0 | Reach one Not-reached or Partial source class; hunt failures, denominators and seller bias | Topic, class, what is in hand | Ideas, scores |
| `cluster-analyst` | agent, sonnet | 1–3 | One cluster to job, candidate ideas, evidence table with load-bearing claims | One cluster | Other clusters, grades |
| `evidence-auditor` | agent, opus | 4 | Blind regrade, independence, spot-checks, denominators | Evidence table | Draft grades, scores |
| `idea-challenger` | agent, opus | 6; intake any time | Catch and worst case for one idea. Intake mode: Impact-Effort grade, quadrant and one quick-win step for a new idea | Stress-test: one idea and its evidence. Intake: the idea, any evidence, the limits | Stress-test: score, rank, author reasoning |
| `scripts/check_brief.py` | script | 5, 7, 8 | Totals, ranking rule, confidence caps, decision-rule gaps | The brief as JSON | n/a |
| `watchdog` | existing agent | re-runs | On re-runs, sweep the new page against the old one for drift | Both pages | n/a |

The main thread stays the conductor. It owns scope, clustering, scoring, the decision and the
write-back. Agents return evidence and objections. They never decide.

## Workflow

```
0    Scope + coverage plan (main)
     └─ per Not-reached or Partial class: source-scout ×N in parallel. Max two rounds.
        Then mark Reached / Partial / Not reached honestly.
1    Cluster (main, issue-tree). Thin groups go to the Revisit-if list.
2–3  cluster-analyst ×N in parallel, one per cluster → job, push, anxiety, ideas,
     evidence table with load-bearing claims. Main thread trims to eight ideas.
4    Draft grades (main) AND evidence-auditor blind on the same table, in parallel
     └─ diff the two. Lower grade stands until the reason is written down.
5    Numbers + scores + confidence (main) → brief.json → check_brief.py. Fix every FAIL.
6    idea-challenger ×3 in parallel, one per top idea → catch, worst case, severity
     └─ Blocks → Low confidence. Re-rank, re-run check_brief.py. Max two passes.
7    Decide (main, scr-pyramid-communicator) → check_brief.py with stated ranks
8    Test and learn (main) → check_brief.py on the Continue / Change / Stop rule
     Write-back. Re-runs: Calibration, then watchdog sweeps new page vs old
```

Steps 0, 2–3, 4 and 6 are the parallel ones. Send every agent in a step in one message.

### Intake: a new idea, outside the stages

When the owner proposes a new idea, dispatch `idea-challenger` in intake mode. It returns Impact and
Effort scores, a quadrant and one "When X, I will Y" quick-win step. The brief says "intake mode",
names the idea and its evidence, and gives the limits. Intake is a triage, not a Stage 5 score:

- Its grades stay out of the JSON brief and out of `check_brief.py`.
- Never pass them to a Stage 6 dispatch. That challenger stays blind.
- Effort runs 5 = heavy. Stage 5 criteria run 5 = best. Do not add the two.
- If the idea earns a place in a run, the main thread scores it at Stage 5 in the usual way.

### Dispatch contract

Agents start cold. Every brief carries: the objective in two sentences, absolute paths to every
input, the scope block (decision, limits, priority weights), what the agent must **not** be given
(auditor: no grades; challenger: no score or rank), the output format it must return, and a
budget. Ask for the output in the reply. The main thread saves it to the parent page.

### If no agent can be dispatched

Check the session's tool list for an Agent tool. If it is absent, say so in one line, then run each
role yourself in the order above, one at a time. Read the agent file first
(`Glob '**/agents/<name>.md'`); if it is not in this repo, use the role line in the table.
Label the run **embodied**. Two rules follow from that:

- Grades from an embodied auditor are self-graded. Cap every idea's confidence at Medium. Set
  `"embodied": true` in the brief and `check_brief.py` enforces it.
- Catches from an embodied challenger are labelled "self-challenged". Do not call the top pick
  stress-tested in the decision block. Write "stress-tested by author".

`check_brief.py` needs no agent and always runs.

### The brief as JSON

`check_brief.py` reads the brief as JSON. Its docstring holds the full schema. The fields that
carry the rules: `priority` (the two doubled criteria), `embodied`, `coverage`, and per idea
`grade`, `sources`, `denominator` (known, estimated, unknown), `blocker` (none, workaround,
hard), `severity` (from `idea-challenger`), `scores` on reach, cost, speed, fit and upside,
plus `stated_total` and `stated_rank` so the script can catch arithmetic and ranking slips.
`test_check_brief.py` beside it proves the checks. CI runs it.

### Calibration (re-runs)

The first run predicts. The re-run learns. When a Stage 8 result arrives, add a **Calibration**
section to the new parent page:

| Idea | Predicted confidence | Predicted range | Actual | Hit? |
|---|---|---|---|---|

Count hits by confidence tier. If High ideas miss as often as Medium ones, the confidence rules
are not earning their keep. Say so and name the rule to change.

## Rationale

The v2 pipeline was a good method run by one context. Four weaknesses follow from that, and each
new piece answers one.

1. **It graded its own evidence.** The author ranked the ideas and assigned the grades. Anchoring
   is the default. A blind auditor breaks it. Cost: one dispatch. Effect: the grade that travels
   with each idea was set by someone with no stake in it.
2. **A coverage gap only lowered confidence.** "Not reached" capped the run at Medium and moved
   on. A scout turns the gap into a task. Effect: fewer runs stuck at Medium for lack of effort.
   The scout also hunts failures and denominators, the two things success stories omit.
3. **Clusters were analysed in series.** Cluster five got the least attention. Parallel analysts
   give each cluster full depth and hand back a uniform evidence table. Effect: quality does not
   fall with cluster count, and wall-clock time drops.
4. **The stress test was run by the ranker.** A challenger who never sees the rank cannot soften.
   Effect: the "catch" is a real objection, not a courtesy.
5. **The arithmetic was checked by eye.** The library's own log (2026-09-19) says a check written
   in prose and never run is not a check. Weighted totals, the ranking rule, the confidence caps
   and the decision-rule gaps are all mechanical. A script runs them in a second. It is not an
   agent because nothing in it needs judgment.
6. **The loop never closed.** Stage 8 produced a result and the next run re-scored from scratch.
   Calibration compares predicted confidence and ranges to actuals, so the rules improve.

What the design does not do. It adds no conductor agent. The skill is the conductor, which keeps
the run at one rung of the `cpo` ladder. It adds no scoring agent. Scoring reads the priority weights,
which are the owner's judgment, so the main thread keeps it. It does not replace the skills
behind the stages. `issue-tree`, `customer-insight`, `six-thinking-hats` (pre-mortem), `red-team` and
`scr-pyramid-communicator` still supply the thinking.

Known risk. The library retired eight `mar-*` agents on 2026-08-18 because none had produced a
persisted artefact. These four could go the same way. Guard: each has a mechanical reason to be an
agent (a different tool set, or a blindness rule that only a separate context can keep), and
`agent-improver` reviews them after their first two real runs. If a run shows an agent added
nothing, retire it and fold its rule back into the skill. The weakest cases are `source-scout`
(the main thread has the same web tools; only parallelism sets it apart) and `cluster-analyst`
(no blind rule; the depth gain is untested). Retirement test for both: after two real runs, if
the main thread would have produced the same output inline, retire.

### How to know it worked

| Measure | Before | Target |
|---|---|---|
| Ideas whose grade changed after blind audit | not measured | Recorded every run. Zero changes on three runs means the auditor is redundant. |
| Runs held at Medium by a Not-reached class | most | Fewer, and the rest say why. |
| Catches that name a mechanism | not measured | Every catch. |
| Brief defects caught by `check_brief.py` before decision | 0 (no check) | Every one, before the decision block. |
| Predicted High ideas that hit their range | not measured | Tracked in Calibration. |

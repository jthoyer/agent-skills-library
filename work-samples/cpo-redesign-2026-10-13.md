# cpo redesign: test evidence, 2026-10-13

Owner-approved: retire the `CPO` agent and `prompt-refiner`, merge both into the `cpo`
skill, with gated steps. All roles below were delegated (real dispatches from the main
thread). No role was embodied.

## Test 1 — can the CPO agent delegate when dispatched?

Brief: dispatch `watchdog` and `agent-improver`; report the tool list; do not embody.
Result (the dispatched `CPO` agent's words): "Agent or Task tool in my tool list: **No.**
My tools are Read, Write, Edit, Bash, Grep, Glob, WebSearch, WebFetch and
SubagentHandback." No dispatch ran. `CPO.md:5` listed `Agent`.
Control: earlier the same day, the `cpo` skill in the main thread dispatched `watchdog` and
`agent-improver` in one turn; both returned real reports.

## Test 2 — blind routing, 8 prompts via /rewrite

| # | Prompt | Expected | Before (old files) | After (new files) |
|---|---|---|---|---|
| 1 | fix a typo | direct | pass | pass |
| 2 | club newsletter | skills | pass | pass |
| 3 | feature + review + security | agents | pass | pass |
| 4 | is cody worth keeping? | portfolio | **fail** (inline) | pass |
| 5 | research → ranked ideas | research-to-ideas | pass | pass |
| 6 | intermittent bug, fix it | investigator → cody | pass (med) | pass |
| 7 | launch CPO / kick off feature | cpo | pass, competing triggers | pass |
| 8 | what should I work on? | cos | gap (no route) | pass |

Ambiguities the "after" run found, fixed in `cf455db`: security inside the pipeline, the
bug-fix rung, the club comms stack, whether a reviewer needs its own review.

## Test 3 — intake comparison, 6 requests, blind judge

Three systems, anonymised and shuffled: old `prompt-refiner`, old `cpo` + `CPO.md`, new `cpo`.
Rubric: Restate / Route / Review, 1–5 per request.

| System | Restate | Route | Review | Total /90 |
|---|---|---|---|---|
| old `prompt-refiner` | 19 | 17 | 10 | 46 |
| old `cpo` + `CPO.md` | 21 | 26 | 26 | 73 |
| **new `cpo`** | **29** | **29** | **28** | **86** |

Judge: the new system is the only one not dominated; it never scores below either old
system in any cell. Its weakest points: the fees paper frame omitted the committee as
audience, and it ran `red-team` after `multi-actor-strategy` (duplicate cost). The second
is fixed in `references/routing.md`. A first judge, earlier, compared the two old systems
alone and found they duplicated intake and routing when run in sequence.

Caveat: the judges saw condensed versions written by the main thread. Names were removed;
content was kept.

## Size

`CPO.md` was 7,871 words with 47 dated history clauses, all loaded per run.
The new `cpo/SKILL.md` is about 900 words; three references load only when needed.

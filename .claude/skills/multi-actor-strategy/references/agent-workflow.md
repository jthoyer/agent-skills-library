# Agent workflow for multi-actor-strategy

Read this before dispatching either agent. A fast, low-stakes pass dispatches no agents and
works inline, as `SKILL.md` already allows.

## Description

Two of the skill's steps promise something one context cannot deliver: a challenge aimed at the
preferred option by someone with no stake in it, and a council that judges anonymised cases
without knowing whose they are. Two blind agents keep those promises. A script checks the
mechanical rules. Everything else stays in the main thread.

| Role | Kind | Stage | Job | Sees | Never sees |
|---|---|---|---|---|---|
| Problem Framer, Strategist | main thread | 1 | Frame the question, build the longlist | Everything | n/a |
| `strategy-challenger` | agent, opus, read-only + web | 2 | Stress-test every option; cast the cameos; name the strongest option and attack it hardest | Question, constraints, options longlist (shuffled) | **Which option the main thread prefers** |
| Stakeholder Proxy | main thread | 2, in the same message as the challenger dispatch | Stakeholder response map | Everything | n/a |
| Risk Analyst | main thread | 3 | Pre-mortem per surviving option | Everything | n/a |
| `strategy-juror` ×2–3 | agent, opus, read-only | 3 | Blind Council Check: the three questions, plus a Conviction Bet | Anonymised, shuffled cases A, B, C | Actor names, the preference, other jurors' answers |
| Decision Architect, Project Manager | main thread | 3–4 | Criteria, trade-off, recommendation, impasse calls, sign-off | Everything | n/a |
| `scripts/check_strategy.py` | script | end of 1, 2, 3, 4 | The eight mechanical rules | The run as JSON | n/a |

The skill stays the conductor. Agents return objections, verdicts and bets. They never decide.
`option-premortem` from `agent-plan.md` is **not built**. The Risk Analyst stays in the main
thread until the phase 4 comparison shows otherwise.

## Workflow

```
1  Frame + options (main) → run.json stage 1 → check_strategy.py
2  Record the preference in run.json, THEN dispatch strategy-challenger
   in the same message as the Stakeholder map work (main)
   → paste reply verbatim into the Stage 2 Register → run.json stage 2 → check_strategy.py
3  Pre-mortem per surviving option (main)
   → strategy-juror ×2–3 in one message, each with the cases in a different order
   → main-thread bet recorded beside the jurors' bets
   → trade-off; answer the pick gap in writing if the challenger's pick ≠ preference
   → run.json stage 3 → check_strategy.py
4  Brief (main) → run.json stage 4 → check_strategy.py. Fix every FAIL before release.
```

### Dispatch contract

Agents start cold. Every brief carries:

1. **Objective** in two sentences.
2. **Inputs**, pasted or as absolute paths.
3. **What the agent must not see**, stated so it can report a leak.
4. **Output format:** the agent's own block, returned in the reply.
5. **Budget:** a word cap or time box.

Save each reply verbatim under its stage in the run.

**Challenger brief.** Paste the operative question, horizon, constraints (real or assumed) and
the longlist rows. Shuffle the options and keep the ids. Strip anything that marks a favourite:
"preferred", "recommended", a ranking, a Handoff Note line about weakest reasoning, or one option
written up at twice the length of the rest. Before you dispatch, write the preference into the
run, so the pick gap is measured against what you thought and not against the reply.

**Juror brief.** Build one case per surviving option: rationale, stress-test rows, stakeholder
rows, risk log. Remove every actor name and advocate label. Leave out the Stage 2 Register's
CHALLENGER block (it holds the preference), every Handoff Note and any draft trade-off. Relabel as
Option A, B, C in a **different shuffled order for each juror**. Rewrite every reference to
another option into that juror's letters, and keep the letter-to-option map to yourself. Give
each juror its id, the question, the horizon and the real constraints, but not the decision
criteria: you chose them, and they can carry the preference. Send all jurors in one message, and
never pass one juror another's answer.

**Where the replies go.** Paste every reply verbatim into its register. If any reply says NOT
BLIND, record that, say what leaked, and do not call that step blind in the brief.

### If no agent can be dispatched

Check the session's tool list for an Agent tool. If it is absent, say so in one line and run the
skill exactly as `SKILL.md` describes, with every actor in the main thread. Read the agent file
first if it is in this repo (`Glob '**/agents/strategy-*.md'`) and follow its process. Label the
run **embodied** and set `"embodied": true` in the run JSON. Wording caps follow, and
`check_strategy.py` enforces them:

- The challenge is "stress-tested by author", never "independently stress-tested".
- The council is "self-reviewed council", never "blind" or "blind-reviewed".
- The Conviction Bets are placed by the advocates, as `SKILL.md` describes, and recorded with
  role `advocate`.

A run that dispatched one agent and embodied the other is embodied.

### The run as JSON

`check_strategy.py` reads the run as JSON. Its docstring holds the schema. The fields that carry
the rules are `stage` (the last stage completed, so each rule waits for its stage), `embodied`,
and `preference`. Per option they are `sustain`, `status`, `reason`, `challenge` and `premortem`.
The rest are `challenger` (`mode`, `blind`, `strongest_pick`), `pick_gap_answer`, `council`,
`bets`, `recommendation` (confidence and graded rationale) and `brief_text`. In an embodied run,
set `strongest_pick` to the preference: the author attacked what it favoured. The rules:

| Rule | From stage | Fails when |
|---|---|---|
| R1 | 1 | fewer than three options, or none marked sustain |
| R2 | 2 | an option has no challenge entry (for, against, verdict) |
| R3 | 2 | an option is eliminated or demoted to a condition with no reason |
| R4 | 4 | the recommendation's confidence or any rationale is graded Assumed |
| R5 | 3 | a surviving option has no pre-mortem entry |
| R6 | 3 | no main-thread bet, or a juror answered and did not bet |
| R7 | 3 | the challenger's pick differs from the preference and no written answer exists |
| R8 | 4 | an embodied or NOT BLIND run claims "blind" or "independently stress-tested" in the brief |

`test_check_strategy.py` proves each rule with a decoy. CI runs it. The passing fixture is the
phase 1 baseline, rendered at `work-samples/multi-actor-strategy-2026-09-29-baseline.json`. It
sits outside this skill on purpose, so a session running the skill never reads that run's
preference.

### Persistence

Each run writes its Stage Registers, the agents' verbatim replies and the run JSON (run.json) to
`work-samples/multi-actor-strategy-<topic>-<YYYY-MM-DD>/`. Output that vanishes cannot be graded.
That was the first defect named when the `mar-*` agents were retired.

## Retire test

After two real runs, if an agent's output matches what the main thread produced inline, retire
it to `.claude/skills/_retired/` with a pointer and fold its blindness rule back into `SKILL.md`
as an instruction. The script stays either way.

| Agent | Worth keeping if, across two runs |
|---|---|
| `strategy-challenger` | Its strongest pick differs from the preference at least once, or it finds a catch the inline challenge missed |
| `strategy-juror` | Jurors disagree on the strongest case at least once, or name a shared blind spot the inline council missed |

The full comparison design, and why the other five actors stay in the main thread, is in
`references/agent-plan.md`.

# Admission test: interview-coach, 2026-11-02

**Result: passed.** The skill scored 10/10 on both runs. No skill scored 8/10 on both runs.
The blind grader ranked both skill runs as most useful to the candidate.

## Candidate

[noamseg/interview-coach-skill](https://github.com/noamseg/interview-coach-skill), commit
`634a8dd8689e0420c21e5f0c8ae3cfa9e1a7ab7e`, MIT. Requested by the owner on 2026-11-02 via
`/rewrite`, with the instruction "add it only if it passes".

## Design

- **Task:** coach a candidate from a transcript (`transcript.md`), the skill's `analyze`
  workflow. Fictional Senior PM interview with eight planted findings and two decoys.
- **Arms:** a fresh `general-purpose` agent, same model, for all four runs. Identical brief
  (`briefs/task-brief.md`). The skill arm also got one paragraph telling it to load the skill
  (`briefs/skill-arm-addition.md`). Two runs per arm.
- **Key:** `answer-key.md`, written before any arm ran and sealed outside the repo. SHA-256
  `f621a6957d6c20023798b62bfd465675fe2e6499f430fd1ae51c316240efd6c7`, checked unchanged
  before grading.
- **Grading:** a separate fresh `general-purpose` agent (`briefs/grader-brief.md`) saw only the
  transcript, the key and the four replies, labelled A–D in shuffled order (`blind-map.txt`).
  Command names (`stories`, `kickoff`, `help`) were cut from the blinded copies (`blinded/`)
  because they named the skill. The verbatim replies are in `outputs/`.

## Scores

| | No skill 1 | No skill 2 | Skill 1 | Skill 2 |
|---|---|---|---|---|
| Total (of 10) | 8 | 8 | 10 | 10 |
| Holistic rank | 4 | 3 | 2 | 1 |

All four found the same answer-level faults and avoided both decoys. The skill won on the two
points the fixture built to separate the arms:

- **K3, one root cause across answers.** Both skill runs tied "we didn't really have
  disagreements" and "didn't want to rock the boat" together as one pattern. Neither no-skill run did.
- **K6, one first move.** Both skill runs gave a single priority. Both no-skill runs gave a
  ranked list whose first item fixed one answer, not the pattern.

Full grader output: `scores.md`. Costs and rule breaks: `process-notes.md`.

## The case against this result

- **The key's author knew the skill.** The cpo skill read the skill before writing the
  separating points, and those points reward what the skill does by design. The grader was
  independent; the fixture wasn't. The rule asks for a point that needs what the candidate
  adds, so this is by design, but an owner-written fixture would be stronger.
- **Narrow margin, narrow scope.** Two points of ten, on one of 25 commands. The `resume`,
  `linkedin` and `pitch` commands, which overlap `resume-builder` and `positioning`, were not tested.
- **Blinding was partial.** The skill's scorecard table marks its replies as different in kind.
- **Cost.** The skill runs used about twice the tokens (140–154k against 73k) and four times
  the time (157–168 s against 37–42 s).
- **Both skill runs wrote a scratch draft file** against the brief. Nothing in the repo was
  touched, but the skill's habit of writing files is why its adapted copy now says where its
  state file may live.

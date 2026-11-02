# Upgrade test: editor 1.1.0, 2026-11-02

**Result: the upgrade wins.** The candidate scored 21/21 on both runs. The original scored
17/21 on both runs. The blind grader ranked the two candidate runs first and second.

## Where the change came from

The owner uploaded `ste`, a skill for ASD-STE100 Simplified Technical English, with "use it to
improve my agents or skills, or dump it". The standalone skill was dumped: it targets
aerospace manuals, forces American spelling, runs only when typed, and plain Claude knows the
standard. Its rules for instructions were kept and cut down into a new `editor` section,
*Instructions and procedures*. The uploaded files are not in the repo.

## Design

- **Workflow:** `skills-librarian` workflow 6, "small addition": original against candidate,
  blind A/B. No no-skill arm.
- **Arms:** four fresh `general-purpose` agents, same model. Each got the same brief
  (`briefs/task-brief.md`) and one line naming its skill file (`briefs/arm-addition.md`):
  `original-SKILL.md` (1.0.0) or `candidate-SKILL.md`. Two runs per arm.
- **Fixture:** four texts. Three procedures (a race-day briefing, a README setup section, an
  agent prompt) and one decoy (a member-update paragraph that should stay warm and only lose
  a typo).
- **Key:** `answer-key.md`, 21 points, written before any arm ran and sealed outside the repo.
  SHA-256 `f1b5ee26a6408feb369e56c3159f08240be7d4a36d36b238547202063b95f3a5`, checked unchanged
  before grading.
- **Grading:** a fifth fresh `general-purpose` agent (`briefs/grader-brief.md`) saw only the
  brief, the key and the four replies as A–D (`blinded/`). The map is `blind-map.txt`:
  A and B were the candidate, C and D the original. No reply named a skill, so nothing was cut
  from the blinded copies. Verbatim replies: `outputs/`.

## Scores

| | Original 1 (D) | Original 2 (C) | Candidate 1 (A) | Candidate 2 (B) |
|---|---|---|---|---|
| Total (of 21) | 17 | 17 | 21 | 21 |
| Rank | 4 | 3 | 2 | 1 |

Both original runs lost the same four points:

- **K1.4:** made the optional towel a command.
- **K1.5:** put "head out on the run" before the race-belt step.
- **K2.2:** gave the `--force` risk with no clear command, placed after the sync step.
- **K3.2:** left "You may also flag style issues" in an agent prompt.

All four runs passed the decoy. Each left the paragraph word for word apart from "then" to
"than". So the new section did not leak into prose. Full grading: `scores.md`.

## The case against this result

- **The author wrote the key around the candidate's rules.** The candidate author also wrote
  the fixture and the key. Eight of 21 points were planned to need the new section. A
  dispatched grader scored it blind, but the test measures the rules the candidate names.
- **The original was already strong.** Both original runs fixed the step order, used one name
  for the file and for the agent, and turned the wetsuit note into a step without being told.
  The gap is four points, on modals, warnings and ordering, not a different class of edit.
- **One fixture, one model.** Two runs per arm agreed exactly, so the margin is not noise
  within this fixture. It may not hold on other texts.
- **Not tested against no skill.** `editor` is still `grandfathered` in `ADMISSIONS.md`.

## Applied

`.claude/skills/editor/SKILL.md` is `candidate-SKILL.md` with the description reflowed and the
version set to 1.1.0. No wording changed after the test.

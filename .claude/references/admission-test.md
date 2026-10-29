# Admission test: beat plain Claude before adding

**Read this before you add an agent or a skill.** It's the one bar anything new has to clear.
CI enforces it through `ADMISSIONS.md` and `scripts/check-admissions.sh`.

**Who reads this:** the `cpo` skill (portfolio decisions), `skills-librarian` (creating or
merging a skill), and anyone adding a file to `.claude/agents/` or `.claude/skills/`.

## The rule

A new agent or skill goes in only when a recorded test shows **one** of these against plain
Claude:

1. **It does the work better.** It finds more, gets more right or reads better, judged by
   someone other than the person who built the test.
2. **It enforces a rule that plain Claude broke on the same test.** Name the rule and the
   run where plain Claude broke it.

Being cheaper, shorter or tidier doesn't count on its own. In the 20 Oct test the agents used
a quarter to a third of the tokens, but most of that gap was plain Claude's own overhead
(`work-samples/agent-vs-house-2026-10-20.md`).

## Why

The 20 Oct test found agents and plain Claude tied on finding defects: both sides found every
defect in 11 of 12 contests. The agents won on house rules, plus one slight detection win (`agent-improver`, round 1). A part that adds nothing
plain Claude lacks still costs every session: routing confusion, copies that drift (24 on
18 Oct) and upkeep. On 6 Sep, `content-writing` lost to using no skill at all on 2 of 3
tasks. Nothing had tested it before it went in.

## How to run the test

Run it the way the 20 Oct round 2 did, and fix the gaps that run listed:

- **Arms.** Agents: the candidate against `general-purpose` on the **same model tier**.
  Skills: the candidate against no skill. `skills-librarian`'s `references/upgrade-gauntlet.md`
  has the task-design mechanics, but its self-graded single-Claude mode **doesn't count for
  admission**. Run admission in Claude Code with a dispatched grader, or have the owner grade
  the outputs blind. Give both arms **the same brief, and save it.**
- **The fixture has to separate the arms.** At least one defect or quality point should need
  what the candidate adds: a house rule, private knowledge or a format. If both arms score
  full marks, the test failed, not the candidate. Rebuild it.
- **Use decoys,** so an arm that flags everything loses.
- **Independence.** Seal the answer key before any arm runs. The person who wrote the fixture
  doesn't score it: dispatch a separate grader, blinded to which arm is which.
- **At least two runs per arm.** Read a one-run margin as noise.
- **Save it all** in `work-samples/admission-<name>-<YYYY-MM-DD>/`: the briefs, the fixture,
  the key, the outputs verbatim and the scores.

## Recording the result

Add a row to `ADMISSIONS.md` that names the candidate, the status `passed`, and the work-sample path.
CI fails on any agent or skill without a row, and on any `passed` row whose evidence isn't an
existing `work-samples/admission-<name>-…` path.

Then write the `library — portfolio` entry in `CHANGELOG.md`, with a reversal condition, per
`.claude/skills/cpo/references/portfolio.md`.

## What it doesn't cover

- **Edits to an existing part.** Use `skills-librarian` workflow 6 or an `agent-improver`
  review.
- **Merges.** A merge that removes a part needs no test. A merged part claiming new behaviour
  does.
- **Renames.** A renamed grandfathered part trips the check on purpose: move its name in the
  script's frozen list in the same commit, so the rename shows up in review.
- **Grandfathered parts.** Everything that existed on 2026-10-29 is marked `grandfathered` in
  `ADMISSIONS.md`. That records that it was never tested, not that it passed. Testing these is
  the audit queue (`portfolio.md`, *Open composition items*).

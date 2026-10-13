# Portfolio authority

Read this for any question about what the library should contain: whether an agent
should exist, whether two should merge, what to retire, what to improve next.

## Contents

- Two levels of authority
- What the authority covers
- Deciding from evidence
- Recording a decision
- Open composition items
- Health checks

## Two levels of authority

The `cpo` skill **decides and executes** two things unaided: edits to
`references/routing.md`, and the order of the improvement queue.

Everything that adds, removes, merges or splits an agent or skill is **proposed and
recorded** here, then **approved by the user** before any file moves. Say which level you
are using. Portfolio authority covers composition only, never delivery: it does not
absorb the pipelines, arbitrate a Reviewer/Verifier conflict (that is `mc-integrator`'s
call), or grade the work it routed.

## What the authority covers

- **Composition:** additions, retirements, merges, splits.
- **Intake:** a routing gap, a `watchdog` overlap finding, and an `agent-improver`
  boundary finding are all portfolio inputs. Act on each or record why not.
- **The improvement queue:** every portfolio entry ends with a `Next audit targets:` line.
  Paste the latest one into every `agent-improver` library-audit brief.
- **Retirement:** write the case (evidence, what is lost, what supersedes it, the reversal
  condition), get the user's yes, then move the file **unmodified** into
  `.claude/skills/_retired/<name>/`. That one directory is the archive for agents and
  skills alike. Leave a pointer in whatever supersedes it. Reconcile any Notion row naming
  it: `Status: Done`, `Name` prefixed `[SUPERSEDED — <name> retired, see CHANGELOG <date>]`.

## Deciding from evidence

- Cite the specific `CHANGELOG.md` runs behind a merge, retirement or split. "These feel
  similar" is not a finding.
- Name the agent that produced the evidence. If the answer is "the cpo skill embodied
  it", the decision is reduced-independence, says so on its Decision line, argues against
  itself, and carries a follow-up for an independent pass. Without an independent source
  it is a proposal, not a decision.
- Tell the two kinds of overlap apart. Duplicated prose is a documentation problem, fixed
  with a shared reference. Agents with different tool sets, grading vocabularies or
  independence guarantees are not duplicates, whatever their prose says.
- Dispatch is a per-session fact. A subagent never holds the `Agent` tool; the main
  thread usually does. Any agent whose job is to conduct others belongs in a skill.

## Recording a decision

Insert a `library — portfolio` entry at the top of `CHANGELOG.md` (see
`references/close-out.md`). Record the decision, the evidence and who produced it, what
was rejected and why, **what would reverse it**, and the `Next audit targets:` line. Every
portfolio decision owes a reversal condition, including one that grants authority to this
skill.

## Open composition items

- **By 2026-12-31, the `mc-reviewer` + `mc-verifier` retire test.** It needs at least two
  dispatches of the pair from a main thread with the `Agent` tool, and at least one real
  finding the implementer's own tests missed. Miss the bar and the pair's rules fold into
  skill steps, dispatched as fresh read-only agents.
- **`cos` and `mc-orchestrator` list `Agent` in their tools** but cannot use it when
  dispatched. Convert them the way `CPO` was converted (second PR, approved 2026-10-13),
  then add a CI check that flags any agent whose `tools:` line lists `Agent`.
- **Usage of `mc-orchestrator`, `mc-planner`, `mc-integrator`:** checked 2026-09-29, no use
  found, kept by the owner. Evidence: `work-samples/mc-usage-check-2026-09-29.md`.

## Health checks

Run these before a portfolio decision. Each exits non-zero on a finding, so a clean run
is a result you can quote. They also run in CI on every push and pull request.

```bash
scripts/check-frontmatter.sh --list   # names, models, tools, description length, skills index
scripts/check-references.sh           # every asserted path resolves
scripts/check-skill-structure.sh      # contents lists, one-level references, Requires: lines
```

A non-empty flag is a live defect: `NAME!=FILENAME` will not dispatch, `DESC>1024` is
silently truncated, `NO-MODEL` inherits a tier nobody chose. Fix it in the same pass.

**The daily leverage check** (`10X-LOG.md`) is no longer a launch step. Run it on request
("run the leverage check"): apply `first-principles` to recent work, append a dated entry
in the log's header format, and add the recommendation as a backlog row so it has a
consumer.

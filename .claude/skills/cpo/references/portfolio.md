# Portfolio authority

Read this for any question about what the library should contain: whether an agent
should exist, whether two should merge, what to retire, what to improve next.

## Contents

- Two levels of authority
- Admission: beat plain Claude first
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

## Admission: beat plain Claude first

Nothing new joins the library without a recorded test showing it beats plain Claude: it does
the work better, or it enforces a rule plain Claude broke on the same test. This covers an
agent, a skill, and a split that creates a new part. The rule and the test method are in
`.claude/references/admission-test.md`. The register is `ADMISSIONS.md`, and CI
(`scripts/check-admissions.sh`) fails on a part without a row or a new part without evidence.

Two things follow from it:

- **A proposal to add a part is a proposal to run the test.** Approval to build it comes after
  the result, not before.
- **Grandfathered parts haven't passed.** Their rows say so. Testing them is the audit queue
  below. One that loses goes to retirement through the normal route: the case, your yes, then
  `_retired/`.

Reversal condition: if three admission tests in a row have both arms at full marks and the
fixtures can't be made harder, the test can't tell the arms apart. Revisit the rule rather than
keep blocking on it.

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
- **Done 2026-10-13: every conductor is a skill.** `CPO`, `cos` and `mc-orchestrator` were
  agents that listed `Agent`; all three are now skills. `scripts/check-frontmatter.sh` flags
  `AGENT-TOOL` on any agent that lists `Agent` or `Task`, so CI blocks a new one.
- **Proposed 2026-10-29: the admission audit (red-teamed plan, see the CHANGELOG entry that
  day).** No cuts are approved. Each item below needs its evidence first, then your yes.
  - **A house-rule test, before any agent is cut.** Fixtures need several files, decoys and a
    defect that only a house rule finds. Save both briefs, and have someone other than the
    fixture author score it. Order: `watchdog`, `mc-reviewer`, `code-improver`. Lost: nothing
    until a part fails. Reversal: both arms at full marks again means rebuild the fixture, not
    cut.
  - **Keep, test last:** `agent-improver` (it runs the improvement loop, and won 20 Oct
    round 1), `security-auditor` (real findings on 22 Oct, BalanceTRI-app #118), and the blind
    roles (`evidence-auditor`, `idea-challenger`, `strategy-challenger`,
    `strategy-juror`), whose value is independence. Reversal: an admission test where plain
    Claude does as well and enforces the same rules.
  - **`mc-reviewer` + `mc-verifier`:** left to the 31 Dec retire test above. The 22 Oct
    verifier finding (22 Oct, #118) and the four defects `mc-reviewer` caught that self-review
    had passed (tri-momentum, decisions 32 and 34) both count towards its bar.
  - **`mc-planner`, `mc-integrator`:** one production run each (22 Oct). Read
    `work-samples/mc-planner-2026-10-22.md` and `mc-integrator-2026-10-22.md` for what each
    changed before proposing anything. Lost if cut: the written spec and the merge gate.
  - **`code-improver` vs `mc-reviewer`:** not duplicates by the rule above (sonnet vs opus, no
    spec vs spec). Decided by the house-rule test.
  - **`cody`:** tied plain Claude on 20 Oct, but it's the pipeline's implementer and cheaper to
    run. Kept unless the test says otherwise.
  - **Writing merge candidate:** `editor`, `humanizer`, `content-research-writer` as one draft,
    edit and de-AI pass. `justin-voice` stays separate. Evidence owed: past runs where they
    competed for one request. Lost: `humanizer`'s 29-pattern catalogue if it were cut rather
    than moved. Reversal: no routing misses found.
  - **Research merge candidate:** `deep-research` with `academic-researcher`.
    `multi-actor-research` (decision-grade) and `recent-pulse` (last 30 days) stay. Evidence
    owed: as above.
  - **Framework skills** (`scr-pyramid-communicator`, `issue-tree`, `made-to-stick`,
    `high-output-management`, `six-thinking-hats`, `first-principles`): kept. They carry house
    formats and work context. Retire one only if an audit finds no house content and it loses
    the no-skill test.
- **Usage of `mc-orchestrator`, `mc-planner`, `mc-integrator`:** checked 2026-09-29, no use
  found, kept by the owner. Evidence: `work-samples/mc-usage-check-2026-09-29.md`.

## Health checks

Run these before a portfolio decision. Each exits non-zero on a finding, so a clean run
is a result you can quote. They also run in CI on every push and pull request.

```bash
scripts/check-frontmatter.sh --list   # names, models, tools, description length, skills index
scripts/check-references.sh           # every asserted path resolves
scripts/check-skill-structure.sh      # contents lists, named or patterned references, Requires: lines
```

A non-empty flag is a live defect: `NAME!=FILENAME` will not dispatch, `DESC>1024` is
silently truncated, `NO-MODEL` inherits a tier nobody chose. Fix it in the same pass.

**The daily leverage check** (`10X-LOG.md`) is no longer a launch step. Run it on request
("run the leverage check"): apply `first-principles` to recent work, append a dated entry
in the log's header format, and add the recommendation as a backlog row so it has a
consumer.

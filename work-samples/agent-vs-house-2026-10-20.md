# Agents vs the house model — 2026-10-20

**Question (owner):** do my most-used agents beat plain Claude?

## Design
- **Agents tested:** the four with the most delegated runs on record (ledgers + work samples):
  `agent-improver` (14 delegated mentions), `watchdog` (8), `cody` (6, plus 6 work samples), `mc-reviewer` (3).
- **House arm:** the built-in `general-purpose` agent on the **same model tier** as each agent's
  frontmatter (opus for three, sonnet for `cody`), given the identical brief. Only the agent
  definition differs.
- **Fixtures:** one per agent, each with planted defects and an answer key the contestants never saw:
  a member update vs a policy (6 errors), a booking module vs its spec (6 bugs), a small feature to
  build with 8 hidden tests plus two helpers that should be reused, and a weak agent definition with
  a failing work sample (6 weaknesses).
- **Judging:** three blind opus judges saw Output 1 / Output 2 in an order randomised per test and
  recorded separately. Lines that named library files or "independence" were removed so style alone
  couldn't reveal the agent; findings stayed verbatim. `cody`'s pair was scored mechanically (tests,
  reuse, files touched) because the two solutions were nearly line-for-line identical.

## Results

| Agent | Planted defects: agent / house | Blind verdict | Tokens: agent / house |
|---|---|---|---|
| `watchdog` | 6/6 / 6/6, no false positives either side | **Tie** | 14.3k / 61.8k |
| `mc-reviewer` | 6/6 / 6/6, no errors either side | **House, slight**: graded critical/high/medium tiers beat five items all marked "blocks merge"; two more useful questions | 14.3k / 61.9k |
| `cody` | 8/8 hidden tests / 8/8; both reused both helpers, both touched one file | **Tie** (cody's report was more candid about what it didn't verify) | 22.4k / 61.4k |
| `agent-improver` | 5 found, 1 partial / 3 found, 2 partial, 1 missed | **Agent, slight**: caught the missing model field, made the privacy rule a pre-return check | 18.9k / 61.8k |

**Score: one win each, two ties.** On these tasks, the definitions don't beat the house model on
quality. They do run at **about a quarter of the tokens**, at the same speed (19–23 s per arm).

## What this does and doesn't show
- **Ceiling effect.** In three of four tests both arms found every planted defect. The fixtures
  were single-file and the defects were findable by a careful generalist. A harder round (many
  files, distractors, defects that only house rules catch) is needed to separate them.
- **n = 1 per agent.** One run each. Read slight margins as noise until repeated.
- **The token gap is mostly the house arm's overhead,** not agent skill: `general-purpose` carries
  the full tool set and a long system prompt. It is still a real cost: a narrow agent is cheaper
  to dispatch, every time.
- **Not measured:** safety (the agents' tool lists stop a reviewer editing files; the house arm had
  Write and Bash and was only told not to), house conventions (review gates, scope notes, ledger
  close-out), and fit inside the coding pipeline.

## Actions
- **`mc-reviewer`:** consider graded severity (critical / high / medium) inside "blocks merge". The
  judge preferred the house arm's tiers. Owner's call; not applied.
- **Next audit:** a harder, multi-file round for `watchdog` and `mc-reviewer`, where house rules
  (cross-file drift, review-gates false positives) should matter.

## Files
Everything is in `work-samples/agent-vs-house-2026-10-20/`: the fixtures, the answer keys and
hidden tests, the blinding order, and every contestant output as the judges saw it (Output 1 / 2).
Re-run the coding check with `python3 keys/cody-hidden-tests.py <dir>` against a solution folder.

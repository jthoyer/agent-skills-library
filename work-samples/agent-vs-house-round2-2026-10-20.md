# Agents vs the house model, round 2 — watchdog and mc-reviewer — 2026-10-20

Follows `agent-vs-house-2026-10-20.md` (backlog item 154). Reduced independence: the main thread
wrote the fixtures and the keys and scored the outputs.

## Design
- Two fixtures, each with a sealed key (`agent-vs-house-round2-2026-10-20/keys/`):
  - `reviewer`: a 6-file booking package plus a spec and Planner register. 3 planted defects, one
    spread over 3 call sites (a shared time helper). 5 decoys (named constants, a commented
    `except KeyError`, validation done in `__post_init__`, a module cache, a correct `.days < 7`).
  - `watchdog`: a 9-file handbook with its own ledger. 5 planted problems (fee drift, a duplicated
    refund section, 30 vs 14 days, a weekday error already logged in the ledger, a broken link).
    4 decoys (two ride briefs on one template, junior vs adult fee, repeated training times, correct maths).
- Arms: the agent as dispatched (`watchdog`, `mc-reviewer`, both opus) against `general-purpose` on opus.
  Identical brief. Two runs each, eight runs in all. Outputs saved verbatim in `outputs/`.
- Scoring: mechanical against the keys, plus house-rule behaviours the key lists. No blind judges
  this round: the detection scores were identical, and the differences are countable. Not blinded,
  so read the style rows as the main thread's judgement.

## Results

| | Planted defects found | Decoys flagged as defects | Tokens per run |
|---|---|---|---|
| `mc-reviewer` run 1, run 2 | 3/3 (R1 with all 3 sites), 3/3 | 0, 0 | 23.1k, 22.2k |
| house reviewer run 1, run 2 | 3/3 (R1 with all 3 sites), 3/3 | 0, 0 | 65.2k, 65.3k |
| `watchdog` run 1, run 2 | 5/5, 5/5 | 0, 0 | 19.7k, 19.6k |
| house watchdog run 1, run 2 | 5/5, 5/5 | 0 (one run listed the ride briefs as "reasonable"; the other put them as finding 7, "looks intentional") | 63.3k, 64.0k |

### Where the house-rule behaviours separated them
| Behaviour | Agent | House |
|---|---|---|
| Reviewer: per-AC coverage close | Both runs, every AC marked | Neither. "Checked and clean" list only |
| Reviewer: verdict on each Planner risk | Both runs | One line on the Handoff guess, no per-risk verdict |
| Reviewer: why existing guards don't catch it | Both runs, on every blocking finding | Neither |
| Reviewer: flagged areas kept out of findings | Run 2 yes, run 1 "none open" | n/a, no such section. Both put spec-silent items (duplicate booking, promotion eligibility) in the findings list |
| Watchdog: says it read the ledger and which one | Both runs | One run mentioned the ledger entry, neither said which ledger it checked |
| Watchdog: structural vs typo label, "check the Notion backlog" | Both labelled the first finding structural; both added the backlog line | Neither |
| Watchdog: padding | None. Run 1 named the ride briefs "Not a finding" | Run 1: a speculative deadline finding and a "CHANGELOG holds none of the problems" remark. Run 2: six "smaller items", including a speculative "which membership year" gap |

## Reading
- **Detection is still at the ceiling.** All eight runs found every planted defect, including the
  three-site generalisation. A shared helper called from three places was not enough to separate them.
- **The agents win on house rules, not on finding things.** They carry the coverage close, the guard
  proof, the "not a finding" discipline and the ledger link. The house arm finds the same bugs and
  adds extras that the spec doesn't ask for.
- **The first round's one house win is closed.** `mc-reviewer` now grades severity (merged in #52).
  Both agent runs graded critical/high/low and blocked on three, which is what the key expects.
- **Cost:** about a third of the tokens again.
- **Length caps:** `wc -w` on the saved outputs. `mc-reviewer` 852 and 811 words against a 700 cap, house 737 and 719. `watchdog` 581 and 519 against 500, house 523 and 529. Everyone ran over; the agents ran over most, because the coverage close and Handoff Note add words the cap does not make room for.
- **n = 2 per cell, scored by the author of the fixtures.** One more round should add a second
  fixture author or blind judges before anything is concluded about style.

## Limits
- The planted defects were still findable by a careful generalist. A fixture that needs a house rule
  to find the defect at all (not just to report it) has not been built.
- `mc-reviewer` run 1 stated "Flagged areas: none left open" and `watchdog` run 2 did not read the
  repo-root ledger ("this fixture keeps its own"). Neither cost a finding here.
- The ledger-link test was easy: the fixture's ledger sat in the folder under review, so both arms
  linked the weekday to it. A ledger outside the folder would test the rule properly.

## Files
`agent-vs-house-round2-2026-10-20/`: `fixtures/`, `keys/`, `outputs/` (eight outputs, verbatim except one
preamble line cut from `watchdog-house-run1.md`).

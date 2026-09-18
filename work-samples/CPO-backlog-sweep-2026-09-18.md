# Work sample — CPO backlog sweep, 2026-09-18

**Agent:** CPO (embodied; no Agent/Task tool in session — dispatch unreachable, resolved-negative at launch).
**Verbatim diff:** `work-samples/CPO-backlog-sweep-2026-09-18.diff` (495 lines, 11 files, +41/−282).

## Brief (verbatim, from the orchestrating session)

Nine Pending rows from the Notion Product backlog for the "Agent & Skills Library" product, sorted by Rank, supplied pre-read because this session has no Notion access. Ordered P1 → P2 → P3:

1. [P1][XS] `jobs-to-be-done-jtbd/SKILL.md:6-15` — stray second `---...---` frontmatter block in the body; wrong skill name, description citing two skills absent from this repo (`obviously-awesome`, `design-sprint`), duplicate malformed `version` key. Renders as literal garbage on every load. Fix: remove the stray block.
2. [P1][XS] `value-proposition-canvas/SKILL.md:3` — `description` truncated mid-word ("...Developin..."). Fix: complete from the body's "When to use this" list.
3. [P1][XS] `pre-mortem/SKILL.md:3` — `description` truncated mid-word ("...to a signific..."). Fix: complete it.
4. [P1][XS] `etf-investing-advisor/SKILL.md:106-114` — table labelled "2024-25" shows pre-Stage-3 brackets (19%/32.5%, $120k/$180k). Fix: correct figures, add verify-against-ato.gov.au instruction matching the file's existing fund-data re-verification note.
5. [P2][XS] `project-management/SKILL.md:294,363` + `references/prompts.md:76` say "under 200 words"; `references/prompts.md:181` says failure is "over 300 words" — file disagrees with itself, and it is a hard numeric ceiling current models don't need. Fix: outcome framing at all four sites.
6. [P2][XS] `jobs-to-be-done-jtbd/SKILL.md:30-32` — generic 0-10 scoring mandate applied "Always". Fix: scope to review/critique only.
7. [P2][S] `deep-research`, `academic-researcher`, `editor` — each carries one long worked example (25-45% of file) duplicating an existing Output Format section, risking frozen tone/length transfer. `deep-research:28-59` additionally imposes a mandatory 5-phase script. Fix: replace examples with vary-by-topic instruction; replace the script with a quality bar.
8. [P3][S] `CPO.md:75,77,131`, `agent-improver.md:53,55,73,74,77` — rules justified by dated-incident narratives instead of rule+citation. Fix: compress to rule plus CHANGELOG pointer. Note: touches CPO's own definition.
9. [P3][XS] `pre-mortem/SKILL.md:59` — cites a "2026-09-05 blind test" instead of stating the distinguishing behaviour vs `six-thinking-hats`' Black Hat. Fix: state the behaviour, drop the narrative.

A tenth row, [P3][S] [SCHEDULING] Saturday launchd job, was declared out of scope: blocked on the user running `claude setup-token` locally, nothing actionable in-repo.

Standing instruction: scope the brief, decide which specialists the work needs vs. doing it directly, execute P1→P2→P3, confirm CHANGELOG, run agent-improver over what was touched. No push, no PR.

## Routing decision

All nine are bounded single-file edits against named line numbers with the fix stated. Blast radius is definition text, not executing code; no spec needed downstream; no independent verification a pipeline would add. Ladder rung 0 (inline) for eight of nine. Item 4 was the one exception — it asserts externally-checkable current-year facts, so it got source verification rather than trusting the brief.

## Outcome by item

| # | Site | Result |
|---|---|---|
| 1 | `jobs-to-be-done-jtbd/SKILL.md:6-15` | Stray block removed. **Deviation:** `license: MIT` + `author: wondelai` existed *only* in the stray block; a literal "remove entirely" would have destroyed the file's sole provenance. Merged into the real frontmatter with the later `version: "1.1.1"`. |
| 2 | `value-proposition-canvas/SKILL.md:3` | Description completed from body list; also fixed missing sentence-terminating period after "gains". 594 chars. |
| 3 | `pre-mortem/SKILL.md:3` | Completed, carrying the body's pending-decision-only constraint into the routing trigger. 683 chars. |
| 4 | `etf-investing-advisor/SKILL.md:106-114` | **Deviation:** brief's figures verified correct for 2024-25 via ato.gov.au — but today is 2026-09-18, i.e. the **2026-27** tax year, so writing the brief's table would have shipped a two-year-stale table as the fix. Wrote the current 2026-27 table (15%/30%/37%/45%; $18,200/$45k/$135k/$190k) plus the verify instruction and the legislated 2027-28 change to 14%. |
| 5 | 4 sites | All four replaced with "scannable in under a minute". Follow-up grep for `\d+ words` across the skill: zero remaining. |
| 6 | `jobs-to-be-done-jtbd` Scoring | Scoped to review/critique; added an explicit do-not-score clause for draft/explain/teach. |
| 7 | 3 skills | Worked examples cut (−89/−129/−50 lines) at the `## Example` boundary, each replaced with a "Varying the output" note. deep-research's 5-phase script replaced with a 5-point quality bar. Dangling-reference grep afterwards: clean. |
| 8 | 7 sites across 2 agents | Each compressed to rule + `CHANGELOG.md` date/agent pointer. |
| 9 | `pre-mortem` Related Skills | Blind-test narrative replaced with the applicability-checking distinction and a route-here/route-there rule. |

## Verification run

- `scripts/check-frontmatter.sh` — 16 agents, frontmatter and trailing lines clean, exit 0 (before and after).
- `scripts/check-references.sh` — all asserted paths resolve, exit 0 (before and after).
- YAML parse of all 8 edited skills: every `name:` matches its directory, every description ≤ 1,024 chars and ends on a terminal period (i.e. no remaining truncation).
- Class-generalisation of item 1: scanned all 39 skills for frontmatter keys at column 0 after the real block closes. Only hits were in `skills-librarian/SKILL.md:101-105`, inside a documented ```yaml fence — legitimate. jtbd was the sole real instance.

## Known gap in this sample

The agent-improver pass on `CPO.md` and `agent-improver.md` was **self-review under embodiment** — CPO graded edits CPO made to CPO's own definition. Reduced independence, flagged in the CHANGELOG entry, follow-up recorded for an independent pass.

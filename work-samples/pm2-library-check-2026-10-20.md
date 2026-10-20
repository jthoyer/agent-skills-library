# PM 2.0 Library — independent check and fixes (2026-10-20)

Evidence for the CHANGELOG entry of the same date. The work lives in Notion, not in this repo.

## The brief (owner, verbatim)

> Run https://app.notion.com/p/jthoyer/afe8b8d193bd4bb89514494def661d86 as a product. Its one user is me: a product manager and service designer working towards lead roles. Turn it into a reference guide and study area that helps me look things up, study on a schedule, and show my craft growing. Use the Ontology of Product Management and the Ontology of Service Design as its spine. Add new fields and views, and tag the ontology pages. Write a product plan with outcomes and signals. Write a reusable prompt that reviews the database in batches. Add ranked items to https://app.notion.com/p/jthoyer/3b9cfee1ca1880c1af40eb8674cb7dc9. Never change "— Useful AI" or anything below it. Never delete, rename or rewrite existing pages. Done when the fields, views, plan, prompt and backlog exist and have passed an independent check.

## State found

A session on 2026-10-19 had built almost all of it: 14 fields plus 5 archive fields, 7 views, 18 tagged pages (both ontologies and topic guides 01-16), a 16-week study rotation (2 Nov 2026 to 15 Feb 2027), the review prompt, the product plan, a Start here page, and backlog items at Ranks 133-150 (Product Name "PM 2.0 Library"). Only the review prompt had been independently checked (watchdog, nine fixes).

## Tool trap found

A rows-mode query and a SQL query both returned blank fields for topic guides 08-11 and 14. Fetching each page showed every field set. Any run that trusts a query to decide "this field is empty" could overwrite owner values. Prompt rule 3 now requires reading the page before writing.

## Independent check (general-purpose agent, read only, fresh context)

Verdict: PASS WITH FIXES.

| # | Check | Verdict |
|---|---|---|
| 1 | Fields | PASS (some overlap) |
| 2 | Views | CONCERN: no view shows Mastery or growth |
| 3 | Ontology tagging | PASS: all 16 guides fully tagged, 16 consecutive Mondays, SD elements match the SD ontology on 5 spot-checks |
| 4 | Plan | CONCERN: "Craft grows" not measurable; roadmap stale |
| 5 | Prompt | PASS with fixes |
| 6 | Backlog | CONCERN: ranks follow creation order, not priority |
| 7 | Protection | PASS: 6 Useful AI pages, no new fields set, last edits 2026-06-24 to 2026-09-27 |
| 8 | No delete/rename/rewrite | PASS: moves and archives were field changes with recorded owner approval |

Blocking finding: nothing shows craft growing. Non-blocking: rule 4 contradicted Step 4; Step 1 asked for an unqueryable count; Study slots would run to about 2029; Triage inbox lists protected rows; plan and backlog lagged the run log; field overlaps unexplained.

## Fixes applied

- New view 📈 Craft growth: topic guides grouped by Mastery, with proof test and review dates.
- Prompt: Steps 1 and 8 count craft growth from that view; rule 4 reworded; due rows counted from the Study queue view; up to 4 Study rows per Monday slot; rule 7 warns about protected rows in the Triage inbox; rule 3 reads fields on the page before writing; Start here linked by URL.
- Plan: Craft grows signal names its source; Now roadmap updated; decision log and run log entries.
- Start here: new view listed; one line on which field does which job.
- Backlog: 9 pending items re-ranked so P1 → P2 → P3; one new item (Rank 136.5) for run 2's four open decisions.
- Not done, owner only: rate Mastery on the 16 guides (backlog 134).

## Re-check

Pending: the same checker is re-verifying the fixes. Result to follow in this file.

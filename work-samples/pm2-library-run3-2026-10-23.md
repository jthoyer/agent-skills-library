# PM 2.0 Library — review run 3 and daily learning db added (2026-10-23)

Evidence for the CHANGELOG entry of the same date. The work lives in Notion, not in this repo.
Run by `cpo` (launched with `/rewrite`) in the main thread. The batch classification was embodied. Page reading was delegated to `general-purpose` agents (read only), and the check was delegated to `watchdog`.

## The brief (owner, verbatim)

> add https://app.notion.com/p/jthoyer/370cfee1ca1880ef9bf8e1c6f5f25695?v=370cfee1ca1880edb43e000cc9474c3e
> to https://app.notion.com/p/jthoyer/afe8b8d193bd4bb89514494def661d86?v=b05020cd7d504da28773cc133e74dd5c review
>
> run https://app.notion.com/p/jthoyer/Library-review-prompt-3fecfee1ca1881fa873beeea2b2c94df?v=b05020cd7d504da28773cc133e74dd5c&source=copy_link
> update https://app.notion.com/p/jthoyer/3b9cfee1ca1880c1af40eb8674cb7dc9?v=3b9cfee1ca1880958cfb000c1e9d2fdd as necessary
>
> /rewrite

## Frame

- Objective: bring the 💊 daily learning db into the library review, run one review batch, and update the backlog.
- Done when: the prompt names the daily learning db with clear rules; one batch of up to 25 rows is classified within the hard rules; a run log entry exists; new backlog rows are added without duplicates.
- Assumption (flagged to the owner): "add to review" means the review reads the daily learning db and reports on it. Nothing is written there: it has no Triage or archive fields, and the prompt bans schema changes.
- Stakes: high (live data).

## Prompt change

Added to "— Library review prompt": the daily learning db as a source of truth, rule 8 (it is read only), Step 6b (status, overdue lessons, the topics they serve, outside links, schedule overlap), one Step 8 log line, a line in Step 6 (lessons count as gap evidence, never as Keep rows), and a change log entry.

## Run

- Protected set: 124 rows, six levels below "— Useful AI", built from parent links by SQL. The SQL allowance ran out at the last level, so its 13 pages were fetched instead; none had sub-items.
- Query trap seen again: the SQL and Triage inbox view showed hubs that run 1 had classified (PM Curriculum, Career ladder) as blank. Every batch row was fetched before writing.
- Batch: the last 15 Reading list children and the 10 oldest Ways of working children. All parents are unprotected.
- Results: Keep 9, Rewrite 11, Merge 4, Archive candidate 1, Archived 0. Study slot 2027-02-22 for three rows.
- Counts: Library role on unprotected rows rose from 67 to 92 of 704 (view-based). SQL: 51 → 76, Keep 32 → 41. Mastery is empty on all 16 guides.
- Daily learning db: 45 rows, all Not started. 30 lessons ran 10 Aug–8 Sep 2026. It is a second study schedule, and its lessons point to pages outside the library (G5 and G8 have no Keep row).
- Backlog: PM-020 (Rank 162, run 3 decisions) and PM-021 (Rank 163, daily learning db).

## Tool notes

- The worker restarted three times mid-run. A progress file in the scratchpad recorded each write, so no row was written twice.
- Fetch omits empty properties. Agents reported "absent" as empty, which matches the schema.

## Independent check

`watchdog` was dispatched first. It returned NOT CHECKED: it has no Notion tools, and app.notion.com did not resolve through WebFetch. The check was then re-run by a fresh, read-only `general-purpose` agent with the same brief.

Verdict: **PASS WITH FIXES**. No hard rule was broken.

| # | Check | Verdict |
|---|---|---|
| 1 | Protection | PASS: 14 parent chains walked to the top. None reaches Useful AI. |
| 2 | Fields | PASS: only fields rule 3 allows; Mastery and Last reviewed empty |
| 3 | Fidelity | PASS: 13 takeaways and proof tests drawn from their pages. Two calls differ: Claude Skills vs Projects is a full explainer (it would score 8, Keep), and the blank 01_Alignment hub got PM topics from its title and children (borderline under rule 4). |
| 4 | Archive rules | PASS: nothing archived; the candidate meets every condition |
| 5 | Scheduling | PASS, with a trap: a query on 2027-02-22 returned 3 rows; fetching showed the 4th |
| 6 | Run log | FIX: 67 → 92 did not follow on from run 2's 71; some daily learning db claims went beyond the evidence |
| 7 | Prompt edit | PASS: rule 8 and Step 6b are clear; the daily learning db shows no edits today |
| 8 | Backlog | FIX: PM-020 and PM-021 overlap PM-005, PM-017, PM-018 and PM-009 without naming them |

Fixes applied the same day:
- Run log: count now 71 → 96, with why the view shows 67 → 92; wording on Claude Skills, the 2027-02-22 slot and the daily learning db corrected; check summary added.
- Prompt Step 5: count a Monday's rows from a view or by fetching, never from a query. Change log line added.
- PM-020 and PM-021 now name the items they overlap.
- Not changed: Claude Skills vs Projects stays Rewrite (rule 3: a run never changes a set value). It is listed for the owner instead.

Routing fix in this repo: `cpo` step 4 now says `watchdog` cannot read Notion, and to use a read-only `general-purpose` checker for live Notion data.

# PM 2.0 Library — review run 4 (2026-10-24)

Evidence for the CHANGELOG entry of the same date. The work lives in Notion, not in this repo.
Run by `cpo` in the main thread, the session after run 3 (`work-samples/pm2-library-run3-2026-10-23.md`); its writes landed on 24 Oct UTC. The batch classification was embodied. Page reading was delegated to two `general-purpose` agents (read only), and the check went to a read-only `general-purpose` checker, per the `cpo` change made after run 3.

## The brief (owner, verbatim)

> Continue

Read as: run the next review batch under the same prompt. Same frame as run 3.

## Run

- Protected set: a single count query found 123 rows with a parent in the set, so the set is unchanged at 124.
- One page left alone on purpose: "— Useful AI Study", under School. Rule 1 does not protect it, but its name says it belongs with Useful AI. Raised with the owner (PM-022).
- Batch: the remaining children of School, Internet round table, Communications, AI in product and Weekly study, the last Ways of working page, and the two Frameworks pages.
- Results: Keep 10, Rewrite 14, Merge 0, Archive candidate 1, Archived 0.
- Counts: Library role 96 → 121 by writes; SQL 76 → 101, Keep 41 → 51.
- Scheduled: three Study rows on 2027-03-01, which makes 4 with the row run 2 put there.
- Daily learning db: unchanged (45 rows, all Not started).
- Backlog: PM-022 (Rank 170).
- Gap progress: G9 Service design craft gets its first three Keep rows.

## Tool notes

- The worker restarted twice mid-batch. The progress file recorded each write, so no row was written twice.
- After one restart, the thread replied "No response requested" while the batch was half done. It resumed on the next event. Lesson: after a restart, check the progress file before deciding the turn was complete.

## Independent check

A read-only `general-purpose` checker gave **PASS WITH FIXES**. No hard rule was broken. A second checker started after a worker restart was stopped once the first one reported.

| # | Finding | Fix |
|---|---|---|
| 1 | The run log and PM-022 were dated 23 Oct; the writes landed on 24 Oct UTC | Re-dated to 24 Oct |
| 2 | The 2027-03-01 count came from the run logs, which breaks Step 5. The checker counted by query and fetched all four rows, so the cap holds | Log notes it. Owner asked to add a view filtered on Next review |
| 3 | The blank "00 - Planning" row went to rule 6, but rule 5 comes first | Step 4 now says a blank page goes to rule 6 |
| 4 | "Protected set unchanged" rested on a query | Reworded. 8 chains walked by fetch, none reaches Useful AI |
| 5 | Two calls it would make differently: "Leveraging AI" restates a promo as fact; behavioural science fits 02 and G4 better than G9 | Listed for the owner (rule 3: a run never changes a set value). The G9 claim is softened |

Passed: fields (only rule 3 fields; Mastery and Last reviewed empty; Status "Done" and Category kept on the service design page), archive rules, counts, and PM-022 (Rank 170 = max + 1, no duplicate).

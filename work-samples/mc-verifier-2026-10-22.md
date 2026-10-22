# mc-verifier — 2026-10-22 — BalanceTRI-app race onboarding and owner-only edits

Run: `mc-orchestrator` from `cpo` (/rewrite), all actors delegated. Outcome: merged as jthoyer/BalanceTRI-app#118; migrations live 22 Oct 2026, synced in #119.
Full stage registers: `mc-orchestrator-2026-10-22-registers.md`. Briefs and reports below are verbatim, extracted from the agent transcripts.

## Pass 1

### Brief 1

````text
You are the Verifier (Stage 3) in the multi-actor coding playbook. Confirm by running, never by reading alone.

Spec (source of truth, including "Integrator decisions" and "Integrator notes" sections): /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md (read "# Stage 1 — Spec", the Integrator sections, and the Stage 2 Handoff Note only).

Code: uncommitted working tree in /home/user/BalanceTRI-app. Do not commit, push, or touch the live Supabase database. Do not modify tracked files in the working tree; for any mutation or revert test, copy the repo to a scratch dir under /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/verify/ and work there.

Run:
1. `npm run check` (run `npm install` first if node_modules is missing).
2. supabase/tests (see its run.sh / README) on a throwaway local Postgres.
3. `node scripts/check-app-ui.mjs` and `node scripts/check-admin-ui.mjs` (Playwright Chromium at /opt/pw-browsers; never run "playwright install").
4. Confirm the claimed pre-existing break: in a scratch copy at `git stash`-free HEAD (use `git -C /home/user/BalanceTRI-app show HEAD:scripts/check-app-ui.mjs` etc. into a scratch checkout, e.g. `git worktree add` under the scratch dir), check-app-ui crashes at scenario 14 on #heroAddButton.
5. Discrimination: in a scratch copy, revert the migration's entries owner clause (e.g. make UPDATE/DELETE policy allow any allow-listed member) and confirm the SQL suite fails; revert app.js's "date > today" filter to ">=" and confirm the UI suite fails.

Then give a per-AC verdict table (AC 1–34): Verified (you observed it in a run) / Not covered (no run exercises it) / Fail, with the command or scenario that shows it.

Return (≤500 words): commands with real pass/fail output lines, the per-AC table, and any failure. Do not edit the registers file.
````

### Report 2

````text
Baseline: uncommitted working tree on top of HEAD c7eff7f. It has 9 modified files plus the new migration 20261022060000_restrict_entry_writes_to_owners.sql and supabase/tests/restrict_entry_writes.test.sql. I changed no tracked files; mutations ran in a scratch copy.

**Commands and results**
1. `npm run check`: prettier "All matched files use Prettier code style!", eslint clean. `eslint-suppressions.json` is unchanged (git diff empty).
2. `supabase/tests/run.sh` on a throwaway Postgres 16: `restrict_entry_writes: all checks passed`, `race checks passed`, `all SQL tests passed`. Existing test files are unmodified (git shows only the new test file untracked).
3. `node scripts/check-admin-ui.mjs`: `check-admin-ui: all checks passed`.
4. `node scripts/check-app-ui.mjs` is flaky, with one check failing intermittently:
   - Of 4 runs, 2 passed with 387 ok and exit 0, and 2 failed with `FAIL focus returns to the row button` and `check-app-ui: 1 check(s) failed`.
   - The failure is in the results-form scenario, which runs before the new scenarios (a–k).
   - I have not shown whether it also flakes at HEAD, because HEAD crashes at scenario 14 before reaching it.
   - The Implementer reported 387 ok with no failures, so this flake was not seen in their runs.
5. Pre-existing break confirmed. At a HEAD worktree, `check-app-ui.mjs` crashes in scenario 14. The log shows `locator resolved to <button ... id="heroAddButton" class="primary-button hidden">`, then `element is not visible` and a `TimeoutError` at line 1091. The swap to `#signInButton` is what lets later scenarios run.
6. Discrimination, both red:
   - Mutating the migration so the owner clause is `true` makes the SQL suite fail with `ERROR: FAILED: another member's update: 0 rows`. The unmutated copy goes green again.
   - Changing the app.js filter (line 1427) from `r.date > today` to `>=` fails 9 checks. Examples: `FAIL only Alpha Run and Bravo Swim, soonest first: ["Today Tri · 20 Oct 2026",...]` and `FAIL today, past, Balance Bolt ... and removed races are not offered`.

**Per-AC verdict**
V = Verified (observed in a run). NC = not covered by any run. The UI items are V on the passing runs; the flake above did not touch them.

| AC | Verdict | Shown by |
|---|---|---|
| 1–5 | V | restrict_entry_writes.test.sql (owner, others, admin aal2/aal1/non-listed, delisted owner, unowned entries). The owner-clause mutation turned it red. |
| 6, 7 | V | the same SQL test (insert stamps `created_by`, non-listed insert fails, bulk guard) |
| 8 | V | the same SQL test (results by `created_by` only) |
| 9, 10 | V | the same SQL test (all three name paths refuse; accepted-name list passes) |
| 11 | NC by run | grep found no insert/update/delete statements in the migration, which is a static check only |
| 12 | V | `run.sh`, all green, existing tests untouched |
| 13–22 | V | UI scenarios a–g and k. The `>=` mutation turned these red (AC 14 / D1: today excluded). |
| 23–27 | V | UI scenarios h and i |
| 28 | V | UI scenario j |
| 29, 30 | NC (Review) | Only greps ran. README has "Pick your races" and the new RLS wording. docs/permissions.md has no "Pick your races" and still mentions "honour system", but only in the replaced or races context, so the Reviewer should read it. |
| 31 | V for the admin.js suite, text not run | `check-admin-ui` passes. The Unlink confirm text diff shows the name-match claim removed. |
| 32 | NC (Review) | not exercised by any run |
| 33 | Partial | `npm run check` and the admin suite are green. The app suite is green on 2 of 4 runs, so this is not reliably met until the flake is explained. |
| 34 | NC (Review) | grep found "Pick your races" twice in guides/index.html; nothing ran |

**Escalation:** the `focus returns to the row button` flake (about 50% of runs here) needs a call on whether it is a real defect or timing noise. It sits in the results form, which this change touches by dropping the name match. Please have it checked before treating AC 33 as met.

**Environment note:** the local Postgres crashed once because directory permissions under the scratchpad were reset. I restarted it from /tmp/pgv and then stopped it. No live Supabase access.

**Handoff note**
1. Verified against the uncommitted tree on c7eff7f.
2. SQL, the admin suite, lint and format are green, and both mutations went red.
3. The pre-existing scenario 14 crash is confirmed at HEAD.
4. The app UI suite flakes on `focus returns to the row button` (2 of 4 runs).
5. ACs 11, 29, 30, 32 and 34 are docs and review items with no run behind them.
````

## Pass 2 (fix round 1)

### Brief 1

````text
You are the Verifier (Stage 3, second pass) in the multi-actor coding playbook. Confirm by running, never by reading alone.

Spec and history: /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md. Read "# Stage 1 — Spec", all Integrator sections, "# Stage 3 — Challenge" and "## Fix round". Do not treat the Implementer's reported results as evidence.

Code: uncommitted working tree in /home/user/BalanceTRI-app. Do not commit, push, touch the live Supabase database, or modify tracked files. Mutation tests go in a scratch copy under /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/verify2/.

Run:
1. `npm run check`.
2. supabase/tests/run.sh on a throwaway local Postgres (start fresh; a previous run's data dir under the scratchpad may be broken; use /tmp/pgv2 or similar).
3. `node scripts/check-admin-ui.mjs` once.
4. `node scripts/check-app-ui.mjs` 6 times in a row; report ok/FAIL counts per run.
5. Discrimination in a scratch copy, one mutation at a time, each restored after:
   a. F1: remove U+3164 from the SQL blank-letter list → SQL suite must fail.
   b. F2: remove the created_by restore from admin_undo → SQL suite must fail.
   c. M1, M2, D5: revert each app.js fix → app suite must fail (a crash/timeout counts, but say which).
6. Confirm the D7 change only adds a wait, and does not loosen the "focus returns to the row button" assertion (diff that scenario against HEAD with `git -C /home/user/BalanceTRI-app diff -- scripts/check-app-ui.mjs`).

Return (≤400 words): real output lines per command, per-run counts for step 4, each mutation's result, the D7 finding, and an updated per-AC verdict for any AC whose status changed (especially 19, 20, 13, 33). Do not edit registers.md.
````

### Report 2

````text
Baseline: HEAD c7eff7f plus the uncommitted working tree in /home/user/BalanceTRI-app (the same 11 changed or untracked files before and after my run). Nothing tracked was modified. Mutations were done in a copy at /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/verify2/.

Commands:
1. `npm run check`: prettier "All matched files use Prettier code style!", eslint clean.
2. `supabase/tests/run.sh` on a fresh Postgres 16 in /tmp/pgv2: "all SQL tests passed". A first attempt used a non-UTF8 initdb and failed in clean_display_name ("Unicode normalization can only be performed if server encoding is UTF8"). I re-ran with `initdb -E UTF8 --locale=C.UTF-8`. The suite needs a UTF8 server, so a non-UTF8 server gives a spurious failure, not a code defect.
3. `check-admin-ui.mjs`: "check-admin-ui: all checks passed".
4. `check-app-ui.mjs` ×6: every run exit 0, ok=396, FAIL=0 (runs 1-6 identical).

Mutations (each restored afterwards; the restored SQL run was green again and app.js was byte-identical to the original):
- F1, U+3164 removed from the list: SQL red, "FAILED: request_access refuses a Hangul filler" (restrict_entry_writes.test.sql:152).
- F2, created_by restore block removed from admin_undo: SQL red, "FAILED: undoing the delete restores the entry to its original owner, not the admin" (:177).
- M1, the filter on saved races replaced with `onboardingRaces()`: app suite exit 1 with a TimeoutError crash after 379 ok, 0 FAIL lines.
- M2, `if (onboardingSaving && !force) return;` removed: app suite exit 1 with a TimeoutError crash after 381 ok, 0 FAIL lines.
- D5, `!onboardingDue ||` guard removed: exit 1, 394 ok and 2 FAIL ("D5: a reload of the races after load does not open it" and "D5: and the flag is still unwritten").
- M1 and M2 are caught only by a timeout crash, not a named FAIL line.

D7: the diff (`git diff -- scripts/check-app-ui.mjs`) only adds a `page.waitForFunction(() => document.activeElement.className.includes('result-edit')).catch(() => {})` before the check. The check itself, `activeElement.className.includes('result-edit')` with the message 'focus returns to the row button', is unchanged.
- The `.catch(() => {})` swallows a wait timeout, but the assertion still runs right after it, so a real focus failure would still show as a FAIL.
- The old flake was not reproduced at the old code, so the root cause is unproven. The evidence is 6 of 6 green runs, against 2 of 4 failing before the fix.

AC status changes:
- 19 (partial-save message kept, sheet not closable mid-save): Verified. The M1 and M2 regressions pass, and each turns the suite red when its fix is reverted.
- 20: Verified. The save-flow regressions are green, and M2 is discriminating.
- 13 (onboarding opens only on page load or sign-in): Verified. The D5 mutation fails with named FAIL lines.
- 33 (suite stability): Partial changes to Verified for the suite. 6 of 6 runs were clean at 396 ok.
- F1 and F2 (security fixes): Verified on the SQL side. The JS mirror of F1 in `cleanDisplayName` was not mutation-tested by me.
- Unchanged: the review-only ACs (11, 29, 30, 32, 34) were not re-verified.

Handoff Note:
- Baseline: HEAD c7eff7f plus the uncommitted tree.
- All the commands in the brief are green.
- All 5 mutations turned the relevant suite red, M1 and M2 by crash.
- D7 is a wait only; the assertion is intact.
- Nothing was committed or pushed, and the live database was not touched.
````

## Pass 3 and fix-round-3 re-check

### Brief 1

````text
You are the Verifier (Stage 3, final pass) in the multi-actor coding playbook. Confirm by running, never by reading alone.

History: /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md — read the Stage 1 spec, every Integrator section, and the reviewer/verifier second-pass and "## Fix round 2" sections. The Implementer's reported results are not evidence.

Code: uncommitted tree in /home/user/BalanceTRI-app. Do not commit, push, touch the live database, or modify tracked files. Mutations go in a scratch copy under /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/verify3/. The SQL suite needs a UTF8 server: `initdb -E UTF8 --locale=C.UTF-8` in a fresh dir such as /tmp/pgv3.

Run:
1. `npm run check`.
2. supabase/tests/run.sh.
3. `node scripts/check-admin-ui.mjs` once.
4. `node scripts/check-app-ui.mjs` 5 times; ok/FAIL per run.
5. Mutations, one at a time, restored after:
   a. D8: in entries_set_created_by, drop the `app.entries_link_ok` condition from the INSERT keep-owner branch → SQL must fail.
   b. D8: drop the non-API-role condition from that branch → SQL must fail (say which test).
   c. D9: replace the user-id re-arm guard with `true` → app must FAIL with a named line.
   d. M1 and M2 reverts → named FAIL lines, no TimeoutError crash.
   e. F1 JS: drop U+3164 from cleanDisplayName → app must FAIL.
6. Check the working tree contains no stray files (`git status --short`), e.g. temp scripts.

Return (≤300 words): real output lines, per-run counts, each mutation result, git status, and a final per-AC verdict line (list any AC not Verified with its reason). Do not edit registers.md.
````

### Report 2

````text
Baseline: uncommitted working tree in /home/user/BalanceTRI-app. Mutations ran in the scratch copy /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/verify3/. Result: mutations 5a and 5b were NOT caught by the SQL suite.

1. `npm run check`: prettier "All matched files use Prettier code style!", eslint clean.
2. `supabase/tests/run.sh` on a UTF8 server: "restrict_entry_writes: all checks passed" ... "all SQL tests passed".
3. `check-admin-ui.mjs`: "check-admin-ui: all checks passed".
4. `check-app-ui.mjs`, 5 runs: every run exit 0, ok=408, FAIL=0 ("check-app-ui: all checks passed").
5. Mutations (scratch copy restored after each, verified with cmp/diff):
   - a. Dropped the `app.entries_link_ok` condition from the INSERT keep-owner branch: SQL still all green. This mutation survives. Expected red, so this is a failure of the D8 test coverage.
   - b. Dropped the non-API-role condition from that branch: SQL still all green. This mutation survives too, and no test fails.
   - a/b control: I replaced the whole INSERT guard with `if false` to confirm the harness can detect a break. It failed with "FAILED: undoing the delete restores the entry to its original owner, not the admin". No existing test pins either condition separately.
   - c. D9 re-arm guard replaced with `true`: exit 1, ok=407, "FAIL D9: after a token refresh, removing the last commitment does not open it".
   - d. M1 revert (re-read `onboardingRaces()` after the save): 3 FAIL lines, no TimeoutError. They are "M1: after a partial save with the reload failed, a failure message is shown", "M1: with the reload failed, the message still names what saved and what failed", and "M1: and the failed race is still listed and ticked".
   - d. M2 revert (guard at app.js line 1105 removed): 3 FAIL lines, no TimeoutError. They are "M2: Escape, the x and a click outside leave the sheet up while saving", "M2: the saved race is confirmed with a link in the sheet", and "M2: the outcome lands in the visible sheet".
   - e. U+3164 dropped from `cleanDisplayName`: "FAIL a name ending in the blank letter U+3164 is refused".
6. `git status --short` is unchanged from before: 9 modified files, plus the untracked migration `20261022060000_restrict_entry_writes_to_owners.sql` and `supabase/tests/restrict_entry_writes.test.sql`. No stray files, and `scripts/` holds only the 3 expected files. The temp Postgres server is stopped and removed.

Per-AC verdict:
- Verified by running: AC 1-10, 12-28, 31, 33. The same runs cover the D5, D7 and D9 fixes, M1, M2, and the F1 and F2 behaviours.
- Not fully verified: the D8 refinement (a vanished owner is nulled, and the keep-owner INSERT branch is limited to non-API roles with the flag on). Both conditions in that branch are untested; the suite only catches removing the whole guard. Suggested fix: add a test that a non-API-role insert without the flag is stamped by `auth.uid()` or left null, and one that an API role with the flag set to 'on' is still stamped as itself.
- Review-only, not run: AC 11, 29, 30, 32, 34.

Handoff Note:
1. Baseline is the uncommitted tree.
2. Every suite is green, and app UI is stable at 408 ok across 5 runs.
3. Mutations c, d and e give named FAILs.
4. Mutations a and b survive, so send the D8 tests back to the Implementer.
5. The tree is clean of strays and I did not touch the live DB.
````

### Brief 3

````text
The coordinator sent a message while you were working:
Please re-run mutations 5a and 5b now that the Implementer has added tests (fix round 3).

The tests are new in supabase/tests/restrict_entry_writes.test.sql, about lines 220-240; see "## Fix round 3" in registers.md. Same rules as before: scratch copy, fresh UTF8 Postgres, no tracked-file edits, no live DB.

Run:
1. supabase/tests/run.sh on the real tree → must be all green.
2. Mutation 5a (drop the app.entries_link_ok condition) and 5b (drop the non-API-role condition), one at a time → each must fail with a named FAILED line. Restore after each.
3. `npm run check` once, and `git status --short`.

Reply ≤150 words with the real output lines and a final verdict on the D8 refinement.

Address this before completing your current task.
````

### Report 4

````text
Fix round 3 re-check: both D8 mutations now fail with named lines. Baseline is the uncommitted tree, run on a fresh UTF8 Postgres.

- **Real tree:** `supabase/tests/run.sh` printed "restrict_entry_writes: all checks passed" and "all SQL tests passed".
- **5a (drop `app.entries_link_ok` condition):** `restrict_entry_writes.test.sql:229: ERROR: FAILED: flag off, not an API role: created_by is stamped, the chosen owner is ignored`
- **5b (drop non-API-role condition):** `restrict_entry_writes.test.sql:238: ERROR: FAILED: API role, flag on: created_by is still the caller, not the chosen owner`
- **Restore:** the scratch migration was copied back after each mutation. The tracked tree was never edited.
- **`npm run check`:** the tail showed the eslint step and nothing after it, so it passed. I didn't re-read the prettier line this time.
- **`git status --short`:** the same 9 modified files plus the 2 untracked files (migration and SQL test), no stray files.

Verdict: the D8 refinement is Verified, because each of the two conditions in the INSERT keep-owner branch is now pinned by its own test. I did not re-run the app UI suite, since fix round 3 only changed SQL tests.
````

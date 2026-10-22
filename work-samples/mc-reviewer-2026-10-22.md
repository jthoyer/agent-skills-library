# mc-reviewer — 2026-10-22 — BalanceTRI-app race onboarding and owner-only edits

Run: `mc-orchestrator` from `cpo` (/rewrite), all actors delegated. Outcome: merged as jthoyer/BalanceTRI-app#118; migrations live 22 Oct 2026, synced in #119.
Full stage registers: `mc-orchestrator-2026-10-22-registers.md`. Briefs and reports below are verbatim, extracted from the agent transcripts.

## Pass 1

### Brief 1

````text
You are the Reviewer (Stage 3) in the multi-actor coding playbook. Find the strongest defects by static reading only. Never execute code.

Spec (source of truth, including the "Integrator decisions" sections that override it): /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md. Read "# Stage 1 — Spec", the Integrator decisions, and the "# Stage 2 — Build" register's Handoff Note. Do not read anything else in that file's Stage 2 test-result claims as evidence; judge the code.

Code: uncommitted working tree in /home/user/BalanceTRI-app (branch claude/stoic-archimedes-7xl8w8). See changes with `git -C /home/user/BalanceTRI-app diff` — you have no Bash, so read the files directly: supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql, supabase/tests/restrict_entry_writes.test.sql, app.js (onboarding and race-card edit/remove code), admin.js, scripts/check-app-ui.mjs, README.md, docs/permissions.md. Compare against prior migrations in supabase/migrations/ for the functions and policies being replaced.

Focus: logic errors against each AC; RLS policy correctness (owner or two-factor admin, allow-list still required, no direct call to private.is_admin from member role); the results ownership change; the mixed-script name rule across all name-writing paths; onboarding timing/race conditions; saved vs failed split after reload; Edit matched by id; XSS (any member string into innerHTML); the migration rewriting no data.

Return (≤500 words): findings ranked Blocker / Major / Minor, each with file:line, the AC it breaks, and a concrete failing scenario. Say plainly if you found no blocker. Do not write any files.
````

### Report 2

````text
**Reviewer (Stage 3), static read only.** I found no blocker. The migration, the RLS policies, the results ownership change, the name rule and Edit-by-id all look correct. The real defects are two medium ones in the onboarding Save flow, plus some minor ones.

## Blocker
None.

## Major
**M1, medium, should fix. Breaks AC 19 when the reload after Save fails.** `app.js:1528-1536`, with `1483` and `2072-2073`.
- If any race saved, Save calls `loadRaces()`. If that call fails, `loadRaces` sets `races = []` rather than keeping the old list.
- `showList(failedIds, problem)` then finds no races and goes to `showEmpty()`, which drops `problem`.
- **Scenario:** the member ticks races A and B. A saves. B fails with 23505. The reload then hits a network error. The member sees "No upcoming races to add." B is not named, A is not confirmed, and B is no longer offered.
- **Fix:** build the list from the pre-save `offered` minus `saved` when `loadError` is set, or pass `problem` through to `showEmpty`.

**M2, medium, should fix. Breaks AC 19 (and AC 20).** `app.js:1511-1531` with `3343` and `3355-3357`.
- The Saving state disables Skip only. Escape, the × button and a backdrop click still call `closeAuthSheet()`.
- The save loop keeps going, and its result (`showSaved` or `showList`) is written into the hidden sheet by `showStep`, which never reopens it. The `.focus()` call then lands on a hidden element.
- **Scenario:** the member presses Escape while it says "Saving…" and one insert fails. They are never told which race failed.
- **Fix:** block closing while saving, or check `authSheetMode === 'account'` after the loop and fall back to a toast.

## Minor
**m1, low, should fix (spec silent: Planner decides).** `app.js:2085` and `2090`.
- `maybeOpenOnboarding` runs at the end of every `loadRaces`, not only on page load or sign-in.
- **Scenario:** a member with no password loads the page. The password prompt opens, so onboarding is held back and the flag is not written. They close the prompt. Later they edit a race's details (`loadRaces` at line 3333), and "Pick your races" pops up over that action.
- AC 13 says "on a load or sign-in".

**m2, low.** `app.js:221-225`.
- `canEditResult` still uses `isAdmin`, so an admin on a password-only (aal1) session sees result buttons the database refuses.
- This is the known O6/F5 item, but it contradicts the "keyed to two-factor" rule (D2) applied everywhere else.

**m3, low, optional.** `docs/permissions.md:29`.
- The admin cell for results says "with two-factor" but leaves out the allow-list. `can_write_result` requires `is_allow_listed()` for admins too.

## Checked and cleared
- **R1:** `can_change_entry` is security definer and granted to `authenticated` (`migration:26-41`). Policies call only that wrapper, never `is_admin()` directly.
- **Ownership on update:** the BEFORE trigger restores `created_by` before WITH CHECK runs, so nobody can take over or orphan an entry.
- **Owner or admin:** the rule is allow-list AND (owner OR `is_admin()`). Null `created_by` gives admin only.
- **Results:** `can_write_result` matches the old body minus the name branch. Its existing grants survive the `create or replace`.
- **Name rule (R9):** the SQL and JS ranges are identical to the spec table, and the client message is the same. All three server paths go through `clean_display_name`: rename trigger, `request_access`, `admin_rename_member`. The rename trigger's WHEN clause means an unchanged name never re-runs the rule. Approval does not re-clean, so pending requests carry no R7 risk.
- **AC 11:** the migration contains no insert, update or delete.
- **Edit by id (R2):** `data-entry-id` with `find(e => e.id === …)` at `2356-2364` and `2873-2877`. Remove is gated by `canChangeEntry`.
- **AC 26:** `refusedEntryWrite` still runs `refusedWrite`, so a revoked member is still signed out.
- **XSS:** every onboarding string goes through `elt()` (`append`/`setAttribute`). No new `innerHTML` from variables.
- **AC 18:** insert payload is exactly `{race_id, name, events: [], level: 'considering'}`.
- **D1:** `date > sydneyToday()` and both Bolt flags are excluded.
- **AC 31:** the `admin.js:1646` Unlink text is correct.

## Flagged (could not settle by reading)
- **Password prompt replacing onboarding (raised by the Implementer):** needs a full-name `loadRaces` to finish between `checkMembership` and `reactToAccess`. That gap only has network round trips when the `settlePasswordChange` RPC runs, so it is rare. Over to the Verifier.
- **AC 33:** I did not audit `scripts/check-app-ui.mjs` for weakened assertions.

## Handoff Note
1. No blocker. Database side is sound by reading.
2. Fix M1 and M2 together: both come from the Save handler assuming the sheet and `races` stay as they were.
3. m1 and O6 need a decision from the Planner or Integrator, not just a fix.

Files: `/home/user/BalanceTRI-app/app.js`, `/home/user/BalanceTRI-app/supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql`, `/home/user/BalanceTRI-app/docs/permissions.md`
````

## Pass 2 (fix round 1)

### Brief 1

````text
You are the Reviewer (Stage 3, second pass) in the multi-actor coding playbook. Static reading only; never execute code; write no files.

Context: /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md — read "# Stage 1 — Spec", Integrator sections, "# Stage 3 — Challenge" (the findings) and "## Fix round" (what the Implementer says it changed).

Code: uncommitted tree in /home/user/BalanceTRI-app. Review only the fix round:
- supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql: the blank-letter refusal (F1) and the recreated admin_undo (F2). Compare admin_undo line by line with its last applied version in supabase/migrations/20261016043135_admin_undo_refuses_owner_changes.sql: anything changed besides restoring created_by on an undone DELETE is a finding. Check the transaction-local setting is scoped so it can't leak to a later statement or let a member bypass write-once created_by; check undo of an INSERT or UPDATE is unaffected; check two-factor admin is still required.
- app.js: cleanDisplayName mirror (F1, same code points as SQL), Save handler (M1, M2), maybeOpenOnboarding gating (D5), canEditResult (D6).
- scripts/check-app-ui.mjs: the new regression scenarios and the D7 wait — no weakened assertion.
- docs/permissions.md and README.md fix-round lines: accurate against the code.

Return (≤350 words): findings ranked Blocker / Major / Minor with file:line and a failing scenario each, or say plainly there are none.
````

### Report 2

````text
**Fix-round review: no blockers, 2 medium findings (both "should fix"), 0 minor.**

**Medium 1: undoing a deleted entry now leaves a fake "Linked" line in the activity feed, and the restore can't be undone.**
`supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql:174-181`
- Line by line, `admin_undo` matches 20261016043135 apart from the added block. The block works: owner restored, null if the account is gone.
- The problem is that the fix is a second statement, an `UPDATE` of `created_by`. The `entries_history_aiud` trigger logs it as an owner change, with `changed_by` set to the admin.
- Failing scenario: an aal2 admin undoes the deletion of Ben's entry.
  - History gets an `INSERT` (owner = admin) and then an `UPDATE` (owner admin → Ben).
  - `admin.js:596-603` shows the `UPDATE` as "Linked Ben's commitment on X to an account", with the "Reverse in Accounts → Link entries" badge.
  - Undo on the `INSERT` now fails with "That row has changed since. Undo the later change first." The later change is an owner change, which `admin_undo` always refuses.
  - The old version could undo the restore. This one can't.
- Docs: `README.md:85/87/103` don't match this either ("undo cannot restore `created_by`"; "asks you to undo the later change first").
- Possible fix: let `entries_set_created_by` keep `new.created_by` on `INSERT` under the same two conditions (`current_user` is not an API role, and `app.entries_link_ok` is `'on'`). Set the flag around the re-insert only, and null a gone owner in `old_row` before inserting (otherwise the foreign-key handler shows the misleading "race no longer exists" error).

**Medium 2: the onboarding screen can still open on a later race reload, against D5.**
`app.js:1387`
- `onboardingDue = true` runs on every auth event except `USER_UPDATED`. That includes `INITIAL_SESSION`, which the bundled supabase-js 2.117.1 fires on subscribe after `initAuth`, and `TOKEN_REFRESHED`, roughly hourly.
- Failing scenario:
  1. A member with one commitment loads the page. Their device has no onboarding flag.
  2. Load spends `onboardingDue` (they have an entry), and a later auth event sets it again.
  3. They remove their only commitment. `loadRaces` calls `maybeOpenOnboarding`, and the screen opens by itself mid-session.
- The D5 test (`scripts/check-app-ui.mjs:2721-2733`) can't catch this: the stub's `onAuthStateChange` (l.76) never emits those events.
- Possible fix: re-arm only when `session.user.id` changes from the previous value.

**Checked, nothing found:**
- **Leaking setting:** `set_config(..., true)` is cleared right after, and a failure rolls it back with the block. A member can't use it: the trigger also needs a non-API `current_user`.
- **Undo of an `INSERT` or `UPDATE`:** code unchanged.
- **Two-factor admin:** `require_admin()` is still the first statement; grants unchanged.
- **Mixed-alphabet and blank-letter lists:** the SQL and `cleanDisplayName` (`app.js:672-694`) use the same ranges and the same 7 blank code points.
- **Save fixes (M1, M2):** `app.js:1499-1564`, `1105`, `1550-1554` are correct; the `finally` always clears `onboardingSaving`.
- **`canEditResult` (D6):** keyed to `adminReady`.
- **D7:** the focus check (`check-app-ui.mjs:1735-1741`) is still enforced after the wait; nothing was weakened. The M1 and M2 scenarios test real outcomes.
- **docs/permissions.md:** lines 68-75 are accurate.
````

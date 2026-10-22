# mc-planner — 2026-10-22 — BalanceTRI-app race onboarding and owner-only edits

Run: `mc-orchestrator` from `cpo` (/rewrite), all actors delegated. Outcome: merged as jthoyer/BalanceTRI-app#118; migrations live 22 Oct 2026, synced in #119.
Full stage registers: `mc-orchestrator-2026-10-22-registers.md`. Briefs and reports below are verbatim, extracted from the agent transcripts.

## Stage 1 spec

### Brief 1

````text
You are the Planner (Stage 1) in the multi-actor coding playbook. Write a testable spec. Do not write code.

Repo: /home/user/BalanceTRI-app (static site served by GitHub Pages, no build step; app.js ~3400 lines; Supabase backend; migrations in /home/user/BalanceTRI-app/supabase/migrations/; DB tests in /home/user/BalanceTRI-app/supabase/tests/; UI checks in /home/user/BalanceTRI-app/scripts/check-app-ui.mjs (headless Chromium against a stand-in Supabase client); README.md documents schema and RLS; /home/user/BalanceTRI-app/docs/permissions.md documents who may read/write each table).

Live facts (checked 2026-10-22):
- All rows in public.entries and public.results were deleted today (races kept: 63 live). Every new entry will have created_by stamped by the entries_created_by_biu trigger.
- entries RLS: insert/select/update/delete all just `private.is_allow_listed()`. So any approved member can update or delete ANY entry today.
- private.guard_entry_name() (trigger entries_name_guard_biu, BEFORE INSERT OR UPDATE OF name): on INSERT by a non-admin with auth.uid(), new.name must equal the member's profiles.display_name; non-admin rename refused. Admins and no-uid (dashboard/service role) are exempt.
- entries.level check: 'considering','planning','locked','not'. App default level is 'considering'. entries.events is a text array.
- Bulk-write guard: max 5 rows per API statement on entries/races/results.
- results ownership currently: entries.created_by, falling back to display-name match for unowned entries (see README "results" bullet and the add_results_table migration).
- Display names: rules in README "Display names" section; lookalike letters from other scripts are not caught today.
- Admins in private.admins, private.is_admin() exists.

Feature to spec (the user has approved this plan):
1. One migration (new file in supabase/migrations/, timestamp-named like the others): entries UPDATE and DELETE restricted to owner (created_by = auth.uid()) or admin, still requiring allow-list; results writes owned by entries.created_by only (drop the name-match fallback); display names refuse mixed-script lookalikes (e.g. a Cyrillic letter inside a Latin name) — decide a precise, testable rule; DB tests in supabase/tests in the existing style.
2. app.js onboarding screen: shown once for an approved member with no commitments after sign-in; skippable; reopenable from a menu/obvious place; lists upcoming live races (not deleted, date >= today Sydney time) excluding Balance Bolt races, soonest first, one checkbox each; Save inserts one entry per ticked race (own display name, level 'considering', events []), one insert request per race; partial failure names the races that failed and keeps them ticked; success confirmation points to the race card to set event and level; a "Not you? Tell an admin" link (find how the app reaches admins today, e.g. the feedback feature).
3. Race card: edit and remove controls only on your own commitment, or for an admin; a refused write shows a plain message, not a raw DB error.
4. README.md and docs/permissions.md updated, including a note that commitments were cleared on 2026-10-22.

Read the relevant parts of README.md, docs/permissions.md, app.js (entries handling around lines 1370-1470, 1640-1700, 2590-2800; membership/sign-in flow), the add_results_table, lock_entry_names_add_admin_rename, add_access_requests_2_name_helpers migrations and supabase/tests to ground the spec. Decide where "shown once" state lives (prefer no new DB column if a sensible client approach exists; justify).

Constraints: no live DB changes; spec only. Keep to the repo's conventions (English English, short sentences in docs).

Write the spec to /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md under a heading "# Stage 1 — Spec", containing: objective; numbered acceptance criteria, each checkable (say how: DB test, UI check script, manual); non-goals; files in scope; risk areas; then a Stage 1 Register (in play / resolved / open) and a five-line Handoff Note ((1) established (2) needs most attention (3) likeliest defect location (4) don't relitigate (5) genuinely open).

Return (≤300 words): the file path, the AC list in one line each, and any decision you made that the user might disagree with.
````

### Report 2

````text
I've written the spec to `/tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md`, under "# Stage 1 — Spec". One typo in it: the migration heading reads `2026102 2HHMMSS`; the intended name is `20261022HHMMSS_<name>.sql`, as the Files in scope section has it.

**Acceptance criteria** (DB = new SQL test, UI = check-app-ui scenario, Review = manual read)
1. Owner (non-admin, no two-factor) updates and deletes own entry, 1 row each, no "permission denied" error (DB).
2. Another member's update or delete of that entry touches 0 rows (DB).
3. An admin edits anyone's entry only with two-factor and an allow-listed address (DB).
4. An owner taken off the allow-list can't touch their own entry (DB).
5. Entries with no owner are admin-only (DB).
6. Inserts work as before, and `created_by` is stamped (DB).
7. The 5-row bulk guard still stops an owner (DB).
8. Results go by `created_by` only; the name-match fallback is gone (DB).
9. Mixed Latin/Greek/Cyrillic names are refused through all 3 paths (DB). The rule is fixed code-point ranges, listed in the spec.
10. Single-script names and Latin + Han still pass (DB).
11. The migration rewrites no data (Review).
12. `run.sh` passes in full (DB).
13. Onboarding opens by itself only under exact conditions (UI).
14. It lists the right races, soonest first, with the clock pinned in tests (UI).
15. It is shown once per device (UI).
16. It can be skipped (UI).
17. It can be reopened from the Menu (UI).
18. Save sends one insert per race with the exact payload (UI).
19. On partial failure the failed races are named and stay ticked (UI).
20. The success message links each saved race (UI).
21. "Not you? Tell an admin" is a mailto link (UI).
22. Onboarding is accessible and safe from injected markup (UI and lint).
23. The app counts an entry as yours only by `created_by` (UI).
24. Edit and Remove show only on your own entry, or for an admin with two-factor (UI).
25. Edit opens the right entry (UI).
26. A refused write shows a plain message (UI).
27. The duplicate-entry message is reworded (UI).
28. The app's own name check mirrors the new rule (UI).
29. README updated, including the 22 October 2026 clear-out (Review).
30. `docs/permissions.md` updated (Review).
31. The `admin.js` Unlink text is corrected (Review).
32. Out-of-date comments are fixed (Review).
33. All existing checks stay green (UI and lint).
34. Guide update (nice-to-have).

**Decisions you might disagree with**
- **"Shown once" lives in the browser, not the database.** The flag is set as soon as the screen appears, so it can show once per device. That's harmless, because it only opens by itself for someone with no commitments.
- **Admins can edit others' entries only with two-factor on that session.** The app currently treats any admin account as admin (`admin_status().admin`); I keyed these controls to the two-factor check instead, because the database refuses edits without two-factor.
- **"Tell an admin" emails `CLUB_EMAIL`, not the feedback form.** Feedback goes to the app's maintainer and may be switched off.
- **Races dated today are included, as you asked.** But on race day the race card shows results instead of the commitment form, so the "set event and level" pointer doesn't work for them.
- **Fullwidth Latin letters ("Ｓａｍ") still pass.** I count them as Latin, so the mixed-script rule doesn't refuse them.
- **The admin must also be on the allow-list.** I followed the plan as written.

**Two risks found in the code**
- **Database:** members can't call `private.is_admin()` (execute was taken away from them). An `entries` policy that calls it directly would break every member's edit.
- **App:** the roster's Edit buttons are matched to entries by position. Hiding other people's buttons would shift them, so one could open the wrong entry.
````

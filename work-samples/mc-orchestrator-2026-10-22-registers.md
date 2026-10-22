# mc-orchestrator — 2026-10-22 — stage registers, BalanceTRI-app race onboarding

Copied verbatim from the session scratchpad. Stages 1–4, Integrator decisions D1–D14, and the PR description that went up as jthoyer/BalanceTRI-app#118.

````markdown
# Stage 1 — Spec

Feature: owner-only commitments, results by owner only, mixed-script names refused, and a first-run
"pick your races" screen. Repo: `/home/user/BalanceTRI-app`. Planner: Stage 1, 2026-10-22.
Red-team skill unavailable; adversarial pass self-applied (findings folded in, rest under Open).

## Objective

After this change an approved member can edit or remove only their own commitments (admins with a
two-factor session can edit any), results belong to `entries.created_by` alone, display names that mix
Latin, Greek and Cyrillic letters are refused, and a newly approved member with no commitments is
offered a one-time, skippable list of upcoming races to commit to in one go.

## Grounding (what the code says today)

- `entries` policies "Members can update entries" / "Members can remove entries"
  (`20260923061516_add_email_allow_list.sql` l.81–86) are `private.is_allow_listed()` only.
- `private.is_admin()` has **EXECUTE revoked from `authenticated`** (`add_admin_console` l.114). It
  also requires `aal2` when `mfa_required`. `private.is_allow_listed()` is granted to `authenticated`.
- `private.can_write_result()` (`add_results_table` l.64–94) carries the name-match branch for
  `created_by is null`.
- `private.clean_display_name()` (`add_access_requests_2_name_helpers` l.15–40) is the single name
  rule, called by `check_profile_rename` (every update of `display_name`, before the unchanged
  check), `request_access()` and `admin_rename_member()`. `app.js` `cleanDisplayName()` (l.643)
  mirrors it.
- `app.js`: `isAdmin` = `admin_status().admin` (row exists), **not** `.ready` (= `is_admin()`,
  two-factor passed). `isOwnEntry()` (l.209) falls back to name match; `myEntry()` (l.156) matches by
  name only. `saveEntry`/`removeEntry` filter by `(race_id, name)` and treat 0 rows as "approved
  members only". Roster Edit buttons are wired **by index** (`querySelectorAll('.roster-edit')
  .forEach((btn, i) => orderedEntries[i])`, l.638–641).
- Admin contact today: `CLUB_EMAIL` (`mail@balancetriclub.com`) via mailto is the app's standing
  "ask the club admin" route (banner, sign-in sheet, sign-out messages). Send feedback emails the
  *maintainer* (`FEEDBACK_TO_EMAIL`), not necessarily an admin, and may answer "not configured".
- Precedent for one-time UI state: `balance-password-prompt-<user id>` in `localStorage` (README
  Sign-in, E1).
- UI stub (`scripts/check-app-ui.mjs` l.106–152): `admin_status` hard-coded `{admin:false}`;
  `insert()` does not record its payload; one `writeResult` for every write; fixture race dated
  `2026-11-01` against the real clock.

## Acceptance criteria

Hard requirements unless marked *(nice-to-have)*. "DB" = new `supabase/tests/*.test.sql` run by
`supabase/tests/run.sh`, helpers style (`t.mk`, `t.list`, `t.as_user(name, aal)`, `t.rows`,
`t.fails`, `t.ok`, `begin … rollback`, `\echo <file>: all checks passed`). "UI" = new scenario(s) in
`scripts/check-app-ui.mjs`. "Review" = manual read by Reviewer.

### Migration (one new file, `supabase/migrations/20261022HHMMSS_<name>.sql`, timestamp-named)

1. **Owner updates and removes own entry.** An allow-listed, non-admin member (aal1) updating
   `level`/`events` on an entry with `created_by` = their id touches 1 row; deleting it touches 1
   row; neither raises (in particular no "permission denied for function"). *DB.*
2. **Others' entries are untouchable.** Allow-listed member B's update and delete of A's entry
   each touch 0 rows, and A's row is unchanged afterwards. *DB.*
3. **Admin can, only with two-factor and allow-list.** An allow-listed admin with `aal2` updates
   and deletes B's entry (1 row each). The same admin with `aal1` (and `mfa_required` true) touches
   0 rows on B's entry. An admin (aal2) who is **not** allow-listed touches 0 rows. *DB.*
4. **Allow-list still gates the owner.** An owner removed from the allow-list touches 0 rows on
   their own entry. *DB.*
5. **Unowned entries are admin-only.** For an entry with `created_by is null` whose name equals
   member C's display name, C's update and delete touch 0 rows; an aal2 admin's touch 1. *DB.*
6. **Insert unchanged.** An allow-listed member inserts `(race_id, own display name, level
   'considering', events '{}')`; `created_by` is stamped with their id. A non-listed account's
   insert fails (`42501` / row-level security). *DB.*
7. **Bulk guard still applies to owners.** An owner of 6 entries updating all 6 in one statement is
   refused by the bulk-write guard. *DB.*
8. **Results: `created_by` only.** On a past, live, non-Bolt race: the entry's owner inserts a
   result; member C (name matches an unowned entry) is refused on insert; an aal2 admin inserts a
   result on the unowned entry. *DB.*
9. **Mixed-script names refused** (rule below) through all three paths: `request_access()`, a
   member's own profile rename, and `admin_rename_member()`; each raises the new message. *DB.*
10. **Single-script and neutral names still pass**: `Sam Lee`, `Zoë` (NFC and decomposed),
    `José Núñez`, `O’Brien`, `Сергей`, `Γιώργος`, `Sam 山田` (Latin + Han), `Anne-Marie St. John`.
    *DB.*
11. **No data rewritten.** The migration contains no `insert`/`update`/`delete` against `profiles`,
    `private.access_requests`, `entries` or `results`. *Review.*
12. **Whole suite green.** `supabase/tests/run.sh` passes, existing test files unmodified (in
    particular `admin_undo_owner.test.sql`, `b3_*`). *DB.*

**The mixed-script rule (decided here, testable).** After the existing cleaning, classify each
character that already passed the allowed-character check into one of three groups by code point:

| Group | Code points |
|---|---|
| Latin | U+0041–005A, U+0061–007A, U+00AA, U+00BA, U+00C0–00D6, U+00D8–00F6, U+00F8–02AF, U+1E00–1EFF, U+2C60–2C7F, U+A720–A7FF, U+AB30–AB6F, U+FF21–FF3A, U+FF41–FF5A |
| Greek | U+0370–03FF, U+1F00–1FFF |
| Cyrillic | U+0400–052F, U+1C80–1C8F, U+2DE0–2DFF, U+A640–A69F |

A name is refused if it contains characters from **two or more** groups. Characters in none of the
groups (spaces, `' . ’ -`, combining marks U+0300–036F, CJK, Arabic, etc.) are ignored. Refusal
message (member-facing, distinct from the existing ones so tests can match it): "Your name mixes
letters from different alphabets, such as Latin and Cyrillic. Use one alphabet." The check sits in
the shared cleaning step so every path gets it; the `app.js` mirror uses the **same ranges** (not
`\p{Script=…}`, which differs at the edges).

### app.js — onboarding ("Pick your races")

13. **When it opens by itself.** On a load or sign-in, it opens once when all hold: signed in;
    `isMember` true; the profile display name loaded (non-empty); races loaded **with full names**;
    no entry on any loaded race has `created_by` = own user id; at least one eligible race (AC 14);
    the device flag `balance-onboarding-<user id>` is absent; and no auth-sheet step is open
    (forced password, password prompt, name step). It never opens for a visitor, or a pending, none,
    rejected or revoked account. *UI*: one scenario per negative case listed, plus the positive.
14. **Which races.** Live races (as `loadRaces` returns) with `date >= sydneyToday()`, excluding
    Balance Bolt (`event_type = 'Balance Bolt'` **or** `balance_bolt` true) and excluding races
    that already carry the member's own entry; soonest first; one checkbox each, labelled with race
    name and date; none ticked to start. *UI* with the clock pinned (Playwright clock or dates
    computed from now), fixtures including a removed race, a past race, a race dated today, a Bolt
    race and a race with the member's own entry.
15. **Shown once.** The flag is written when the screen is displayed, so Skip, close, Escape or a
    reload all count; a later load does not reopen it by itself. *UI* (reload in the same context).
16. **Skippable.** A visible Skip control closes it with no write. *UI*: no `entries` write recorded.
17. **Reopenable.** The header Menu has an item (e.g. "Pick your races") for approved members only
    that opens the screen regardless of the flag. With no eligible race it says so ("No upcoming
    races to add") rather than showing an empty list. *UI.*
18. **Save = one insert per race.** With N races ticked, Save sends exactly N `entries` inserts, each
    with exactly `{race_id, name: own display name, level: 'considering', events: []}`; no upsert,
    no update, no multi-row insert, no `add_race_event` call. Save with nothing ticked sends nothing
    (disabled or a prompt). *UI*: stub records each insert payload.
19. **Partial failure.** If some inserts fail, one message names every failed race; failed races
    stay listed and ticked; succeeded races are no longer offered; a second Save sends only the
    failed ones. A duplicate (`23505`) or a refusal reads as plain English, never raw Postgres
    text. *UI*: stub fails chosen calls by `race_id`.
20. **Success.** The confirmation names the saved races, says to open each race to choose an event
    and a level, and links each name to its race screen (`/race/<slug>`); races reload so the cards
    show the member. *UI.*
21. **"Not you? Tell an admin".** The screen shows "Commitments will use your name: <display name>"
    and a "Not you? Tell an admin" link to `mailto:` `CLUB_EMAIL`. *UI*: link `href` checked.
22. **Accessible.** Opens as a labelled dialog/sheet, focus moves into it, Escape closes it and
    returns focus; every member-supplied string (race names, display name) is set as text, not
    markup; no new `innerHTML` from variables (ESLint `no-unsanitized` clean). *UI* + `npm run check`.

### app.js — race card

23. **Ownership by `created_by` only.** In the UI "own" means `entry.created_by === session.user.id`
    everywhere (`isOwnEntry`, `myEntry` and their callers); the name-match fallback is gone. *UI*:
    an unowned entry carrying the member's name shows no Edit, no Remove and no result button.
24. **Controls only where allowed.** A member sees roster Edit only on their own row, and Remove
    commitment only when the form holds their own entry. An admin whose session passes
    `is_admin()` (`admin_status().ready === true`) sees Edit on every row and Remove on any opened
    entry. An admin row without two-factor (`admin: true, ready: false`) is treated as a member here.
    The Admin menu link keeps its current rule. *UI* (stub `admin_status` made fixture-driven).
25. **Edit opens the right entry.** With others' rows before and after the member's row, the
    member's Edit loads their own entry into the form (no index-shift from hidden buttons). Same
    check for an admin clicking the 2nd of 3 rows. *UI.*
26. **Refused write is plain.** An update or delete that returns 0 rows, or a row-level-security
    error, for an approved member shows: "You can only change your own commitment. Ask a club admin
    if it needs changing." No "row-level security", no Postgres text, no "approved members only" for
    an approved member. The existing re-check of standing (`refusedWrite`) still runs, so a revoked
    member is still signed out. *UI*: fixture `writeResult` `{data: [], error: null}` and an RLS
    error.
27. **Duplicate on add.** The `23505` message on adding a commitment no longer says "use their Edit
    link"; it says the name is already on this race and to ask a club admin to link it to them. *UI.*
28. **Client name mirror.** `cleanDisplayName()` refuses `Sаm` (U+0430) with the new message before
    any `signUp`/`request_access` call, and accepts the AC 10 list. *UI* (join form).

### Docs and text

29. **README.md** — *Review*, grep:
    - Backend/RLS paragraph (l.36): the "honour system … any signed-in member can add or edit any
      entry" and "attribution only for now: write access hasn't been narrowed" sentences replaced
      (proposed wording below).
    - `results` bullet (l.33): name-match fallback removed.
    - A dated note: all commitments and results were deleted on 22 October 2026 (races kept), so
      every commitment now has an owner.
    - *Display names*: the mixed-script rule replaces "Look-alike letters … are not caught", and
      says what is still not caught (whole-script look-alikes, AC non-goals).
    - *Admin console → Link entries*: "same comparison as results ownership" and "by the name rule
      the member can still write that entry's results" corrected.
    - *Sign-in*: the onboarding screen and its `localStorage` key, in the style of the E1 paragraph.
    - Tests line lists the new scenarios and SQL test file.
30. **docs/permissions.md** — entries row: member writes "insert; update and delete own only";
    admin "any, with two-factor". Rules: "Honour system on entries" rule replaced; results rule
    drops the name fallback; Open owner questions 1 and 2 recorded as decided 22 October 2026 by the
    owner. The "Last checked against the live project" line is not advanced until the migration is
    applied (see Open). *Review.*
31. **admin.js** Unlink confirm (l.1646) no longer claims the member can still write results by
    name. *Review* + `node scripts/check-admin-ui.mjs` passes.
32. **Stale comments fixed**: `app.js` auth block (l.240–254, "same honour system … any member can
    change … any entry"), `isOwnEntry` comment, and the new migration's header records what
    `clean_display_name`'s "honour system anyway" comment no longer holds. *Review.*
33. **Checks green**: `npm run check` (no new entries in `eslint-suppressions.json`), every existing
    scenario in `check-app-ui.mjs` and `check-admin-ui.mjs` passes without weakened assertions. Where
    the onboarding screen would now appear in an older scenario, that scenario seeds the flag via
    `open(fx, {storage})` rather than changing what it checks. *UI.*
34. *(nice-to-have)* `guides/index.html` mentions "Pick your races" and that only your own row has
    Edit. *Review.*

**Proposed replacement wording, README l.36 (reverses a standing decision — the owner's call,
already approved in the plan):** "Insert needs an approved member and your own display name. Update
and delete also need you to be the entry's owner (`created_by`), or an admin with a two-factor
session (`restrict_entry_writes_to_owners` migration). This used to be an honour system: any member
could change anyone's commitment. That was kept because the old entries had no owner. On
22 October 2026 every commitment and result was deleted, so every entry now has one."

## Non-goals

- No new DB column or table for "shown once"; no server-side onboarding state.
- No whole-script look-alikes (an all-Cyrillic "Сам" next to a Latin "Cam"), no NFKC folding, no
  other script pairs (Armenian, Cherokee …). No re-check or rename of existing live names.
- No change to `races` permissions (still any approved member).
- No event or level choice in the onboarding screen; no batch-insert RPC.
- No change to the results UI beyond ownership (AC 23); no change to admin console features beyond
  the Unlink text.
- No fix of `render()` using the device date instead of Sydney for the race list (finding F7).
- No live DB changes, no `apply_migration`, no file rename to a recorded version (Integrator, later).

## Files in scope

- New: `supabase/migrations/20261022HHMMSS_<name>.sql`; `supabase/tests/<name>.test.sql`.
- `app.js` (ownership helpers, `checkMembership` admin readiness, roster/Remove gating, write-error
  wording, `cleanDisplayName`, onboarding, Menu item). `index.html`/`styles.css` only if the screen
  needs static markup or styles.
- `scripts/check-app-ui.mjs` (stub: fixture-driven `admin_status`, insert payload capture,
  per-call write outcomes, clock pinning; new scenarios).
- `admin.js` (one string). `README.md`, `docs/permissions.md`. *(nice-to-have)* `guides/index.html`.

## Risk areas

- **R1 Policy calls a function `authenticated` can't execute.** `private.is_admin()` has EXECUTE
  revoked. Calling it straight from an `entries` policy makes every member's update/delete fail
  with "permission denied". AC 1 catches it only if the test runs as a non-admin `authenticated`
  caller.
- **R2 Roster Edit wired by index** (l.638). Hiding others' Edit buttons shifts every index, so a
  member's Edit could open someone else's entry (or nothing). AC 25.
- **R3 Admin readiness mismatch.** `isAdmin` means "has an admin row", not "passes `is_admin()`".
  Keying the new controls on it shows admin controls the DB refuses on an aal1 session. AC 24.
- **R4 Onboarding timing.** `initAuth` and `loadRaces` race; deciding "no commitments" before
  full-name races load (or before the profile name loads) shows it to someone who has entries, or
  inserts a name the `guard_entry_name` trigger refuses. AC 13.
- **R5 Existing UI scenarios** with an approved member and races will now trip the onboarding
  sheet; the fix must be seeding the flag, not loosening checks. AC 33.
- **R6 Time-bombed tests.** Fixture dates vs the real clock; "today" must be Sydney. AC 14.
- **R7 Name rule on every `display_name` update.** `check_profile_rename` cleans before comparing,
  so any live member whose stored name already mixes scripts can no longer save their profile
  name, and their reapproval would fail. Needs a read-only check of live data before applying.
- **R8 0-row ambiguity.** `saveEntry` can't tell "not yours" from "gone"; AC 26 accepts one plain
  message for both, but it must not regress the revoked-member sign-out.
- **R9 Range drift** between SQL and JS mirrors of the script rule (AC 9, 10, 28 use the same list).

## Findings: code vs source-of-truth docs

- F1 README l.36 and permissions.md "Honour system" describe the policy this change reverses; both
  updated by AC 29/30 (standing decision reversed, owner-approved).
- F2 README l.33 says "Every entry on a past race predates `created_by`" — false since today's
  deletion; and its name-match rule is removed here.
- F3 permissions.md Open questions 1 and 2 are answered by this plan.
- F4 README Admin console says Unlink leaves results writable "by the name rule"; `admin.js` l.1646
  says the same. Both become false. AC 29/31.
- F5 `app.js` l.272 says `isAdmin` only drives the Admin link, but `canEditResult` also uses it, so
  an aal1 admin already sees result buttons the DB refuses. Existing bug; AC 24 avoids repeating it
  for entries. Fixing `canEditResult` the same way is a cheap nice-to-have — Integrator's call.
- F6 `clean_display_name` header and README *Display names* say look-alikes aren't caught
  "because entry names are an honour system anyway" — the premise goes with this change.
- F7 `render()` (l.1927) builds "today" from the device clock, while results and the reminder use
  Sydney. Onboarding must use Sydney; the list's own inconsistency is out of scope.

---

## Stage 1 Register

**In play**
- One migration: owner-or-admin update/delete on `entries`; `can_write_result` without name match;
  mixed-script rule in `clean_display_name`. One new SQL test file.
- `app.js`: onboarding screen + Menu item; ownership by `created_by`; controls by
  `admin_status().ready`; plain refusal text; client name mirror.
- UI stub extensions and scenarios; README, permissions.md, one `admin.js` string.

**Resolved (by Planner, challengeable by Integrator)**
- "Shown once" lives in `localStorage` (`balance-onboarding-<user id>`), written on display. Why: no
  schema change for pure UI state; matches the E1 password-prompt precedent; harmless when it
  repeats on a new device because it only auto-opens for a member with zero commitments; the Menu
  item covers everyone else.
- Admin "can edit" = passes `is_admin()` (two-factor) **and** is allow-listed, per the approved plan.
- "Tell an admin" = `mailto:CLUB_EMAIL`, the app's existing admin route; feedback reaches the
  maintainer and may be switched off.
- Mixed-script = Latin/Greek/Cyrillic groups by fixed code-point ranges (table above).
- Races with the member's own entry are excluded from the list (matters on reopen).
- Entries of level `not` count as commitments for "has commitments".

**Open**
- O1 Today's races: included (date >= today), but on race day the card shows the results view, so
  "set event and level on the race card" can't be followed for them. Keep, exclude, or reword the
  confirmation for those?
- O2 Feedback form instead of mailto for "Not you?" — owner preference.
- O3 Fullwidth Latin (U+FF21…) counted as Latin, so "Ｓａｍ" alone still passes as a separate name
  from "Sam". Accept, or add NFKC/fullwidth refusal later?
- O4 Before apply: Integrator runs a read-only query on live `profiles` and
  `private.access_requests` for names that break the new rule (R7).
- O5 Admin not on the allow-list can't edit commitments from the calendar. Intended?
- O6 Whether to fix `canEditResult` to use readiness too (F5).
- O7 permissions.md "Last checked" date: advance only after the migration is applied and checked
  live; until then the doc states the intended rules with "pending apply".

## Handoff Note

1. Established: current RLS, admin-readiness and UI-ownership facts from the code; a precise
   mixed-script rule; "shown once" in `localStorage`; 34 checkable ACs.
2. Needs most attention: the `entries` policy must work for non-admin `authenticated` callers
   despite `is_admin()` having no EXECUTE grant (R1), proven by AC 1.
3. Likeliest defect: the index-wired roster Edit buttons in `makeDetails` (R2) and onboarding
   firing before races/profile load (R4).
4. Don't relitigate: owner-only update/delete, `created_by`-only results, no new DB column, one
   insert per race — all approved by the owner.
5. Genuinely open: O1 (race-day races), O2 (mailto vs feedback), O4 (live names check before apply).

## Integrator decisions after Stage 1 (main thread)

- D1 (overrides O1 / AC 14): onboarding lists races with `date > sydneyToday()` — today's races are EXCLUDED, because on race day the card shows results and the "set event and level" pointer would not work. Tests must include a race dated today and assert it is absent.
- D2: accept "shown once per device" (localStorage), "Tell an admin" = mailto CLUB_EMAIL, admin controls keyed to two-factor, fullwidth Latin passes, admin must be allow-listed.
- D3: AC 34 (guide update) stays nice-to-have; skip unless trivial.
- D4: the migration is NOT applied to the live DB in this run. User go-ahead required.

---

# Stage 2 — Build

Implementer, 2026-10-22. Working tree only: nothing committed, pushed or applied. No live Supabase call
of any kind. DB tests ran on a throwaway local Postgres 16 (initdb as `nobody`, socket in /tmp, removed after).

## Built, per AC

- AC 1-8: `supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql`. New
  `private.can_change_entry(created_by)`: security definer, EXECUTE granted to `authenticated` (R1), calls
  `is_allow_listed()` and `is_admin()` as its owner. Policies "Owners and admins can update/remove entries"
  replace the two member policies; insert policy untouched (AC 6). `can_write_result()` recreated without the
  name branch (AC 8). Tests: `supabase/tests/restrict_entry_writes.test.sql`.
- AC 9, 10: same migration, `private.clean_display_name()` recreated with the three-group range check and the
  spec message. Covered through `request_access`, a profile rename and `admin_rename_member`.
- AC 11: the migration contains no insert/update/delete (read it).
- AC 12: `supabase/tests/run.sh` green, existing test files untouched.
- AC 13-22: `app.js` "Pick your races" block (`onboardingKey`, `onboardingRaces`, `maybeOpenOnboarding`,
  `showOnboarding`, `onboardingReason`) after `initAuth`. Built in the auth sheet (mode `account`), so
  dialog label, Escape, focus trap and focus return come from the existing sheet. Called at the end of
  `loadRaces`. D1 applied: `date > sydneyToday()`. Menu item `#pickRacesButton` in `renderAccountMenu`
  (members only; it focuses the Menu button first so Escape returns focus there). Save reuses `addEntry`,
  which now puts the database `code` on the error it throws. `loadRaces` keeps `boltColumn` for
  `balance_bolt`. CSS: `.onboarding-races`, `.onboarding-saved` in `styles-additions.css`.
- AC 23: `isOwnEntry` is `created_by` only; `myEntry` uses it; "I raced this" lookup uses it.
- AC 24, 25 (R2, R3): `adminReady` (from `admin_status().ready`) set in `checkMembership`, cleared on sign-out;
  `canChangeEntry()`; `buildRoster` only draws Edit for changeable rows and sets `data-entry-id`;
  `makeDetails` finds the entry by id, not index; Remove only when the opened entry is changeable.
  Admin link rule untouched.
- AC 26: `refusedEntryWrite` / `entryWriteError` in `saveEntry` and `removeEntry`: still runs `refusedWrite`
  (re-check, sign-out of a revoked member), then the plain text for an approved member.
- AC 27: `addEntry` 23505 message. AC 28: `SCRIPT_RANGES` + `MIXED_SCRIPT_ERROR` in `cleanDisplayName`.
- AC 29-32: README (results bullet, RLS paragraph with the proposed wording, display names, Link/Unlink,
  Sign-in onboarding paragraph, tests lines); `docs/permissions.md` (table rows, rules, questions 1 and 2
  recorded as decided 22 Oct 2026, "Last checked" NOT advanced); `admin.js` Unlink confirm; stale comments
  in `app.js` (auth block, `isOwnEntry`, `isAdmin`, `refusedWrite`) and the migration header.
- AC 33: see below. AC 34: done (small): `guides/index.html`. Also `style-guide.html` (specimen + menu item).
  `index.html`: cache-bust query on `app.js` and `styles-additions.css` bumped to 2026102201.

## Deferred / not done

- `canEditResult` still keys on `isAdmin` (F5/O6): not in an AC, left for the Integrator.
- AC 13 "races loaded with full names" negative: only the load-failure variant is exercised in the UI
  (stub cannot return an un-named load for a member).

## Commands and results

- `supabase/tests/run.sh` (PGHOST=/tmp/pgtest PGUSER=nobody): baseline before my change: all passed.
  After: `restrict_entry_writes: all checks passed`, `all SQL tests passed`.
- Mutation checks (suite can fail): policy calling `private.is_admin()` directly -> existing
  `b3_access_requests.test.sql` died with "permission denied for function is_admin"; mixed-script threshold
  2 -> 3 -> "FAILED: request_access refuses Latin plus Cyrillic"; owner clause replaced by `true` ->
  "FAILED: another member's update: 0 rows". Restored, green again.
- `npm run check`: prettier + eslint clean; `eslint-suppressions.json` unchanged.
- `node scripts/check-admin-ui.mjs`: all checks passed.
- `node scripts/check-app-ui.mjs`: 387 ok, 0 FAIL, "all checks passed". UI mutation checks (each reran the
  suite and went red): `canChangeEntry` always true; today included (`>=`); flag write removed; ownership by
  name. App restored after each.
- PRE-EXISTING BREAK, not mine: at the unmodified HEAD, `check-app-ui.mjs` crashed in scenario 14 (a revoked
  member, then `#heroAddButton` click times out: that button is hidden when signed out since #109). Without
  fixing it none of the later scenarios, including mine, would run. I changed that one step to click
  `#signInButton` and still assert "sheet opens, no writes". Flagging it so the Integrator can overrule.

## Isolation per scenario

Every scenario in the new block uses `open()`: a new page = new browser context = empty localStorage, full
load, clock pinned to 2026-10-20T00:00Z (`page.clock.setFixedTime`). Exception, on purpose: block "c" (shown
once) reloads the same page to test the persisted flag; it runs three times, once per way of dismissing it
(Skip, Escape, none). `open()` now seeds `balance-onboarding-u1` by default so older scenarios stay about what
they test; the new block passes `onboarding: 'fresh'`. Stub changes: fixture-driven `admin_status`, insert
payload recorded, `insertFail` per race id (optionally once), successful inserts show on the next races read,
`.is('deleted_at', null)` honoured, `profileName`, `racesError`.

## Measurements

- Contrast on the rendered sheet: legend and hint 5.83:1, race label and links 13.9:1, Save 9.41:1,
  Skip 13.9:1. Rows and buttons all >= 44px tall at 390px and 1100px; no sideways scroll at either.
- Not measured: the unchecked tick-box outline (existing `.auth-sheet-checkbox` rule, rgba .45 border):
  propagated from the sign-in nudge, not changed here.
- Visual 7.5/10 against "a 10 would be indistinguishable from the other auth-sheet steps, with a nicer
  empty/success state". It reuses the sheet, tick and buttons; the success list is plain.

## Where I'd expect a bug

1. Onboarding timing across `initAuth`, `onAuthStateChange` and the two `loadRaces` calls: tested with the
   stub (which resolves instantly), not with real network ordering. A password prompt that opens just after
   races load would replace the onboarding sheet (flag already written).
2. The saved/failed split after `loadRaces`: if a reload fails, `onboardingRaces()` reads stale races and may
   re-offer a race that did save (it would then fail 23505, read plainly).
3. `can_change_entry` for an admin who edits via the UI: `saveEntry`/`removeEntry` still filter by
   `(race_id, name)`, fine today, but an admin editing a row whose name was just renamed would see the plain
   "only your own" text for a not-found row.

## Stage 2 Register

**In play**: migration + SQL test, `app.js` changes, UI scenarios, docs. All built.
**Resolved**: D1 (today excluded, tested with a race dated today); D2 choices; D3 done cheaply; D4 respected
(nothing applied); R1 (wrapper, proven by running as a plain member); R2 (match by id); R3 (`ready`).
**Open**: O2 (mailto vs feedback form), O4 (live names check before apply), O5 (admin not on the allow-list
cannot edit: now tested and documented as intended), O6 (`canEditResult` and `isAdmin`), O7 (permissions.md
date not advanced), the pre-existing scenario 14 break fixed by one changed step (Integrator to confirm).

## Handoff Note

1. Built: the migration with its SQL test, the onboarding screen and Menu item, created_by-only ownership,
   admin controls keyed to two-factor, plain refusal text, the client name mirror, docs.
2. Needs most attention: the migration against a real Supabase project (only a scratch Postgres 16 here), and
   O4 (live names that already mix scripts cannot save their profile name once applied).
3. Likeliest defect: onboarding timing against real network order, and the roster/Remove gating when state
   persisted in `balance-race-ui` points at an entry the member no longer owns.
4. Don't relitigate: owner-only, `created_by`-only results, per-device flag, one insert per race.
5. Not verified: real-browser run against live Supabase, any width between 390 and 1100, screen-reader output.

## Integrator notes after Stage 2 (main thread)

- O4 cleared: live check 2026-10-22, 0 of 7 profiles mix Latin with Greek/Cyrillic.
- Pre-existing check-app-ui scenario 14 crash (#heroAddButton hidden since #109): Implementer's swap to #signInButton accepted as in scope (it blocked every later scenario). Verifier to confirm it crashes at HEAD and passes now.
- scripts/tmp-check.mjs no longer present.

# Stage 3 — Challenge (in progress)

## Security auditor (delegated): no exploitable ownership/escalation/2FA path.
- F1 MEDIUM: blank Hangul filler letters (U+115F, U+1160, U+3164, U+FFA0, other default-ignorable/blank letters) let a member display as "Alex Smith" + filler. -> FIX (SQL + JS + test).
- F2 LOW: admin_undo of a delete re-stamps created_by to the admin. -> FIX (keep original owner) + test.

## Reviewer (delegated): no blocker.
- M1: reload failure after partial save loses failed-race message (AC 19). -> FIX.
- M2: sheet closable mid-save; result lost (AC 19/20). -> FIX (block close while saving).
- m1: onboarding can auto-open after any loadRaces. Integrator decision D5: only on page load or sign-in, per AC 13. -> FIX.
- m2/O6: canEditResult keyed to isAdmin. Integrator decision D6: key to two-factor admin, consistent with D2. -> FIX.
- m3: permissions.md results admin cell omits allow-list. -> FIX.

## Verifier (delegated), concurrent with Reviewer
- npm run check green; SQL run.sh green; check-admin-ui green.
- check-app-ui FLAKY: "focus returns to the row button" (results form) failed 2 of 4 runs. Cannot compare with HEAD (HEAD crashes at scenario 14). AC 33 = Partial.
- Pre-existing scenario 14 crash confirmed at HEAD.
- Discrimination: owner clause -> true turns SQL red; date '>' -> '>=' turns 9 UI checks red.
- Per-AC: 1-10, 12-28 Verified; 31 V (suite) ; 11, 29, 30, 32, 34 review-only; 33 Partial.
- Integrator decision D7: the flake is root-caused and fixed in the fix round (test or code, whichever is wrong). No retry-until-green, no skip.

## Fix round brief (to Implementer): F1, F2, M1, M2, m1 (D5), m2 (D6), m3, flake (D7). Then Verifier re-runs app suite >= 5 times.

## Fix round

Edited the unapplied migration 20261022060000 (not applied anywhere, so one file stays one change). No commit, push or live DB.

1. F1 fixed. SQL: names with U+115F, U+1160, U+3164, U+FFA0, U+2800, U+17B4, U+17B5 are refused with the "Use letters..." message; JS mirror in `cleanDisplayName`. SQL tests on request_access, member rename, admin_rename_member. Mutation (list cut to U+17B4) -> "FAILED: request_access refuses a Hangul filler".
2. F2 fixed. `admin_undo` recreated in the same migration: after re-inserting a deleted entry it restores `created_by` via the `app.entries_link_ok` pattern (null if the account is gone). Test: undo keeps Ben as owner and Ben can edit again. Mutation (setting 'off') -> "FAILED: undoing the delete restores the entry to its original owner".
3. M1 fixed. After a save the list is computed from the pre-save list minus saved races, not re-read from `races`. Message now "Saved: X. Not saved: Y (reason)." Regression: reload forced to fail; mutation (re-read `onboardingRaces()`) -> check-app-ui crashes with TimeoutError.
4. M2 fixed. `onboardingSaving` flag; `closeAuthSheet` ignores non-forced closes while true; focus moved to the list before Save is disabled. Regression with a delayed insert (Escape, x, backdrop click). Mutation (guard removed) -> TimeoutError crash.
5. m1/D5 fixed. `onboardingDue` set at page load and on sign-in, spent when data conditions are first met. Regressions: a later `loadRaces()` does not open it; sign-in does. Mutation (guard removed) -> 2 FAIL.
6. m2/D6 fixed. `canEditResult` uses `adminReady`; comments updated.
7. m3 fixed. permissions.md results admin cell now says allow-list; added lines on blank letters, Pick your races (app-only, no permission), undo keeps owner. README updated for F1/F2.
8. D7 root cause: test bug. The app focuses the row button in `setTimeout(0)` after the render that shows "Result saved."; the test read `activeElement` in the same instant as the banner. Fixed with `waitForFunction` on the same condition; assertion unchanged, no retries.

Real output: `npm run check` clean; `check-admin-ui` all passed; `supabase/tests/run.sh` "all SQL tests passed"; `check-app-ui.mjs` run 5 times in a row: exit 0, 0 FAIL, 396 ok each time.
Not verified: the flake was not reproduced on the old code in this round (root cause from reading plus 5 clean runs); M1/M2 mutations fail by crash, not a FAIL line.

## Reviewer, second pass (delegated): no blocker, 2 medium
- R2-1: F2 fix restores created_by via a second UPDATE -> history logs a fake "Linked" owner change and the restore can no longer be undone; README 85/87/103 stale. Integrator D8: FIX by keeping new.created_by on INSERT inside entries_set_created_by under the same non-API-role + app.entries_link_ok guard, flag set only around the re-insert; null a vanished owner first. Test: history has one INSERT row with the original owner; the restore is undoable.
- R2-2: onboardingDue re-armed by INITIAL_SESSION / TOKEN_REFRESHED, so the screen can open mid-session (breaks D5). Integrator D9: FIX by re-arming only when the signed-in user id changes. Test stub must emit those auth events.
- Waiting on Verifier second pass before fix round 2, so the tree stays still under its runs.

## Verifier, second pass (delegated)
- npm run check green; SQL green (needs UTF8 server: initdb -E UTF8); admin UI green; app UI 6/6 runs 396 ok 0 FAIL.
- Mutations red: F1, F2, D5 (named FAILs); M1, M2 (timeout crash, no named FAIL).
- D7: wait only, assertion intact. Flake root cause unproven at old code; 6/6 vs 2/4.
- AC 13, 19, 20, 33 -> Verified. F1 JS mirror not mutation-tested.

## Fix round 2 brief: D8 (R2-1), D9 (R2-2), M1/M2 regressions to fail with named FAIL lines not timeouts, F1 JS mirror discrimination, README 85/87/103 updated.

## Fix round 2

1. D8 fixed (same unapplied migration). `entries_set_created_by` recreated: on INSERT it keeps `created_by` only when current_user is not an API role AND `app.entries_link_ok` = 'on'. `admin_undo` sets the flag only around the delete re-insert, clears it after; second UPDATE removed; a vanished owner is nulled in the row first. Tests: exactly one INSERT history row after undo, with the original owner, no owner-change UPDATE row; the restore is undoable; a ghost owner restores unowned without error; a member inserting with another id as created_by is stamped as themself. Mutations: guard removed -> "FAILED: undoing the delete restores the entry to its original owner"; API-role check dropped -> existing b3 test "an existing member can still update an entry" fails. README lines 32, 85, 103 updated.
2. D9 fixed. `onboardingUserId`; re-armed only when the user id differs (set in initAuth, cleared on sign-out). Stub now exposes `window.__emit`. Regression m: after INITIAL_SESSION and TOKEN_REFRESHED, removing the last commitment does not open it; sign-out then sign-in as u2 does. Mutation (always re-arm) -> "FAIL D9: after a token refresh...".
3. M1/M2 regressions use bounded waits and clicks in the page. Mutations now give named FAIL lines (M1: 3 FAILs; M2: 3 FAILs), no TimeoutError.
4. F1 JS mirror: one check per blank letter (U+115F, 1160, 3164, FFA0, 2800, 17B4, 17B5). Mutation (U+3164 dropped from cleanDisplayName) -> "FAIL a name ending in the blank letter U+3164 is refused".

Output: npm run check clean; check-admin-ui all passed; run.sh (UTF8 server) "all SQL tests passed"; check-app-ui 5 runs, each exit 0, 0 FAIL, 408 ok.
Not verified: fullwidth/other default-ignorable letters beyond the 7 listed; real Supabase project.

## Security auditor, final pass (delegated): NOT exploitable, confidence 9/10
- Only admin_undo / admin_link_entries / admin_unlink_entries set app.entries_link_ok; all start with require_admin(). Flag is transaction-local, rolled back with the inner block, and useless to API roles (current_user check).
- Undo restores owner only from change_history.old_row; admin cannot choose it.
- Integrator D10: undo restoring an entry to an owner who has since lost approval is intended. Undo restores history faithfully; that owner still cannot write (can_change_entry needs the allow-list) and regains access only if re-approved.

## Verifier, final pass (delegated)
- All suites green; app UI 5/5 at 408 ok. Mutations c, d (M1, M2), e give named FAILs. Tree clean.
- GAP: mutations 5a (drop app.entries_link_ok condition) and 5b (drop non-API-role condition) SURVIVE. Only removing the whole guard is caught. Contradicts the Implementer's fix-round-2 claim that 5b fails a b3 test.
- Code itself judged correct by the security auditor; this is a test gap on the security-critical line.
- Integrator D11: add tests pinning each condition separately; Verifier re-runs 5a and 5b only. No commit until both go red.

## Fix round 3

Re-check of my round-2 claim: wrong. The b3 failure came from the mutation `if true` (whole guard replaced), not from dropping only the current_user condition. The verifier was right.
Added two tests to restrict_entry_writes.test.sql: (a) not an API role (claims set, role = table owner), flag OFF, insert naming another owner -> stamped as the caller; (b) API role (authenticated, member JWT), flag ON set by the member, insert naming another owner -> stamped as the caller.
Scratch mutations: drop the flag condition -> "FAILED: flag off, not an API role: created_by is stamped, the chosen owner is ignored"; drop the current_user condition -> "FAILED: API role, flag on: created_by is still the caller, not the chosen owner". Restored file: "all SQL tests passed".

## Verifier, fix round 3 re-check (delegated)
- SQL suite green on real tree. 5a and 5b each now FAIL with named lines (test.sql:229, :238). D8 refinement Verified.
- Main thread: npm run check green (prettier "All matched files use Prettier code style!", eslint clean). Tree: 9 modified + 2 new, no strays.

# Stage 3 — Register (closed)
- Resolved: F1, F2, M1, M2, m1/D5, m2/D6, m3, D7 flake, R2-1/D8, R2-2/D9, D8 test gap/D11, D10 decided.
- Open: AC 11, 29, 30, 32, 34 are review-only (read by the Reviewer, not run). Not verified anywhere: a real Supabase project, real network ordering, screen readers. Flake root cause read, not reproduced at old code.

# Stage 4 — Integration (archival register)

Integrator, 2026-10-22. Wrote and reviewed no code. Read the registers above. Re-read the migration (l.1–60, 185–253) and grepped README.md, docs/permissions.md, admin.js, app.js to confirm review-only claims. PR body: `/tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/pr-body.md`.

## Gate result: PASS as a draft PR. Live apply NOT authorised (D4).

No AC is Implemented-only or Asserted done. Nothing blocks a draft PR. Merging the app is safe before the migration (D13). Applying the migration needs the owner's go-ahead and the D14 check first.

| AC | Grade | Evidence (Verifier / Reviewer) |
|---|---|---|
| 1–8 | Verified | SQL suite green; mutations (is_admin direct, owner->true) red. Reviewer: no unresolved defect. |
| 9, 10 | Verified | SQL, all three paths; threshold 2->3 mutation red. Blank letters (F1) added, mutation red. |
| 11 | Review-only (spec-designated *Review*) | Reviewer read it. Integrator re-read: the only insert/update/delete statements sit in the `admin_undo` body (l.192, 194, 216); no top-level DML. |
| 12 | Verified | run.sh "all SQL tests passed", UTF8 server; existing files unchanged. |
| 13 | Verified, with a named sub-clause gap | UI, D5/D9 regressions red on mutation. The "races loaded with full names" negative is exercised only as a load failure (stub limitation). See D12. |
| 14 | Verified | Clock pinned; D1 `>` vs `>=` mutation -> 9 checks red. |
| 15–18 | Verified | UI; flag-write mutation red; insert payloads recorded. |
| 19, 20 | Verified | After M1/M2 fixes; mutations give named FAILs. |
| 21, 22 | Verified | UI (href, focus, Escape); `npm run check` clean. Screen-reader output not tested (limitation). |
| 23–27 | Verified | UI; `canChangeEntry` true / name-ownership mutations red. |
| 28 | Verified | UI join form; JS blank-letter mirror mutation red (round 2). |
| 29 | Review-only | Reviewer read; README 85/87/103 corrected in round 2. Integrator grep: no "name rule", no "attribution only", onboarding key documented. |
| 30 | Review-only | Reviewer read (m3 fixed). Integrator grep: "pending apply" present, "Last checked" not advanced, questions 1–2 dated 22 Oct 2026. |
| 31 | Verified | check-admin-ui green; string read; no "still write … by name" left. |
| 32 | Review-only | Reviewer read; migration header l.13–17 records the honour-system reversal. |
| 33 | Verified | App UI 5/5, 6/6, 5/5 clean (408 ok); flake root-caused (D7). Scenario 14 fix accepted. |
| 34 | Review-only (nice-to-have) | Done; read only. |

**Record gap (not a blocker).** The register holds the Reviewer's findings, not a per-AC coverage table. So for Verified ACs the Reviewer half is "no unresolved defect across the diff", not a per-AC tick. Recorded so it is not read as two per-AC sources.

**Security auditor.** Ran, as required (auth and member data). No CRITICAL or HIGH. F1 MEDIUM and F2 LOW fixed and mutation-tested. Final pass: not exploitable, 9/10.

**Stage 1 risks, ruled.** R1 closed (wrapper; b3 red on direct call). R2 closed (AC 25). R3 closed (AC 24, D6). R4 partly: stub order only; real network order is a known limitation. R5 closed (flag seeded). R6 closed (clock pinned). R7: profiles checked live (0 of 7); pending access requests NOT checked -> D14, before apply. R8 closed (AC 26, sign-out kept). R9: same ranges by review; AC 10/28 run the same names both sides.

**Stage 2 "where I'd expect a bug".** 1 (password prompt replaces the sheet): known limitation, Menu item recovers. 2 (stale races after failed reload): fixed by M1. 3 (admin edits a just-renamed row): known limitation.

## Decision log

| # | Stage | Actors in Conflict | Issue | Decision | Rationale |
|---|---|---|---|---|---|
| D1 | 1 | Planner (O1) vs AC 14 text | Include races dated today? | Exclude (`date > sydneyToday()`) | Race-day card shows results; the "set event and level" pointer would fail. |
| D2 | 1 | Planner open items O2, O3, O5 | Device flag, mailto, 2FA, fullwidth, allow-list | Accept all as specced | Matches existing precedents and the approved plan. |
| D3 | 1 | — | AC 34 scope | Nice-to-have | Done cheaply; not gating. |
| D4 | 1 | Speed vs owner consent | Apply migration live? | No; owner go-ahead needed | Live schema change reverses a standing rule. |
| D5 | 3 | Reviewer m1 vs build | Auto-open after any loadRaces | Page load or sign-in only | AC 13 wording. |
| D6 | 3 | Reviewer m2 / O6 | `canEditResult` keyed to admin row | Key to 2FA readiness | Same rule as D2; DB refuses aal1 anyway. |
| D7 | 3 | Verifier (flake) vs green runs | Flaky focus check | Root-cause and fix; no retry/skip | A retried pass is not evidence. Result: test timing bug, assertion kept. |
| D8 | 3 | Reviewer R2-1 vs F2 fix | Fake "Linked" history row | Keep owner in insert trigger under narrow guard | One honest history row; undo stays undoable. |
| D9 | 3 | Reviewer R2-2 vs D5 fix | Token refresh re-arms screen | Re-arm only on user-id change | Keeps D5 true mid-session. |
| D10 | 3 | Security auditor | Undo restores a since-revoked owner | Intended | History restored faithfully; owner still can't write without allow-list. |
| D11 | 3 | Verifier vs Implementer claim | Undo guard conditions not separately tested | Add one test per condition | Security-critical line; Verifier was right. Both now red on mutation. |
| D12 | 4 | Implementer gap vs Verifier "Verified" | AC 13 "full names" negative only via load failure | Keep Verified; carry sub-clause as known limitation | Stub can't produce an un-named member load; code gate on names read correct; not a merge blocker for a draft. |
| D13 | 4 | — | Deploy order | App first, then migration soon after | New app is stricter than old rules and calls no new DB function; DB-first leaves old clients showing Edit the DB refuses. |
| D14 | 4 | O4 coverage | Live names check skipped pending access requests | Re-run read-only check on `profiles` and `private.access_requests` before apply | A pending mixed-script name would fail on approval. |

## Stage 4 Register

- **Shipped (draft PR, uncommitted tree):** migration 20261022060000 + `restrict_entry_writes.test.sql`; app.js, admin.js, index.html, styles-additions.css, check-app-ui.mjs, README.md, docs/permissions.md, guides/index.html, style-guide.html.
- **Verified:** AC 1–10, 12–28, 31, 33.
- **Review-only:** AC 11, 29, 30, 32, 34.
- **Known limitations:** no real Supabase run; real network ordering; AC 13 full-names sub-clause (D12); renamed-row admin message; per-device flag; whole-script look-alikes, fullwidth, other invisible letters; screen readers; widths 390–1100; `render()` device date; flake not reproduced at old code.
- **Open for follow-up:** D14 check; owner go-ahead; apply; rename file to recorded version; live smoke test; advance permissions.md "Last checked".

## Handoff Note

1. Established: every AC graded; none Implemented-only or Asserted; draft PR is merge-ready.
2. Needs most attention: the live apply (owner go-ahead, D14 names check incl. pending access requests).
3. Weakest evidence: no real Supabase project or real network order; AC 13 full-names sub-clause; review-only docs.
4. Don't relitigate: owner-only writes, created_by-only results, D1–D14, app-before-migration order.
5. Open: apply, rename to the recorded version, live check, then advance "Last checked".

## Record completeness

This file holds Stage 1 (Spec + Register + Handoff), Stage 2 (Build + Register + Handoff), Stage 3 (through "Register (closed)") and Stage 4. The Verifier's per-AC verdicts are present (Stage 3 first pass, second pass, round-3 re-check). Missing: a Reviewer per-AC coverage table and a formal Stage 3 Handoff Note (Stage 3 closes with a Register only). Noted, not blocking.
- D14 done 2026-10-22: 0/7 profiles, 0/4 access_requests mixed or blank.
````

## PR description

````markdown
# Owner-only commitments, owner-only results, mixed-script names refused, "Pick your races"

## Summary

What members get:

- Only you can edit or remove your own commitment. Edit and Remove show only on your own row.
- A first-run "Pick your races" screen. A newly approved member with no commitments sees it once. It lists upcoming races. Tick some and save, or skip. The Menu item "Pick your races" reopens it at any time.
- Plain messages. A refused change reads: "You can only change your own commitment. Ask a club admin if it needs changing." No database text.
- The join form refuses a name that mixes alphabets, before anything is sent.

What the database now enforces (once the migration is applied):

- Update and delete on `entries` need you to own the entry (`created_by`). An admin with a two-factor session may change any entry. Both need the allow-list. Insert is unchanged.
- Results belong to the entry's owner only. The name-match fallback is gone. An unowned entry's results are admin-only.
- Display names that mix Latin, Greek and Cyrillic letters are refused. So are names holding blank "filler" letters (for example U+3164). This applies on request access, own rename and admin rename.
- Undoing a deleted entry restores its original owner, with one clean history row.

## Context

On 22 October 2026 every commitment and result was deleted from the live database by hand. Races were kept. So every commitment made from now on has an owner. That removes the reason for the old honour system, where any member could change anyone's commitment. The owner approved the switch to owner-only.

## Changes

### Database

- New migration `supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql`. **Not applied anywhere live.**
  - `private.can_change_entry(created_by)`: security definer, granted to `authenticated`. It calls `is_allow_listed()` and `is_admin()` as its owner. A policy cannot call `is_admin()` directly: members have no EXECUTE on it.
  - Policies "Owners and admins can update entries" and "Owners and admins can remove entries" replace the two member policies.
  - `private.can_write_result()` recreated without the name branch.
  - `private.clean_display_name()` recreated with the three-alphabet check and the blank-letter check.
  - `public.admin_undo()` and `public.entries_set_created_by()` recreated so undo keeps the original owner. The owner is kept only when the caller is not an API role and `app.entries_link_ok` is on. Only admin functions set that flag.
  - No data is read or written by the file. Statements that change rows sit inside function bodies only.

### App

- `app.js`:
  - Ownership is `created_by === session.user.id` everywhere. The name fallback is gone.
  - Admin controls key on `admin_status().ready` (two-factor passed), not on "has an admin row". This now covers result buttons too.
  - Roster Edit finds the entry by id, not by button index.
  - Refused writes show the plain message. The standing re-check still runs, so a revoked member is still signed out.
  - Duplicate on add says the name is already on this race and to ask a club admin to link it.
  - `cleanDisplayName()` mirrors the database rule, using the same code-point ranges.
  - "Pick your races": opens once per device (`balance-onboarding-<user id>` in `localStorage`), on page load or sign-in only. Lists races dated after today in Sydney, excluding Balance Bolt and races you are already on. One insert per ticked race. Partial failures are named. The sheet cannot be closed mid-save.
- `admin.js`: the Unlink confirm no longer says the member can still write results by name.
- `index.html`: cache-bust bumped to `2026102201`.
- `styles-additions.css`: styles for the race list and the saved list.

### Tests

- New `supabase/tests/restrict_entry_writes.test.sql`: owner, other member, admin with and without two-factor, admin not on the allow-list, unowned entries, insert, bulk guard, results, names on all three paths, blank letters, undo ownership and its guard.
- `scripts/check-app-ui.mjs`: the stub now drives `admin_status` from fixtures, records insert payloads, fails chosen inserts, pins the clock and can emit auth events. New scenarios cover the onboarding screen, ownership, controls, Edit by id, plain refusals and the name mirror. Older scenarios seed the onboarding flag rather than loosen what they check.

### Docs

- `README.md`: results and RLS paragraphs, the dated deletion note, display names, Link/Unlink, undo, the onboarding paragraph, tests lines.
- `docs/permissions.md`: entries and results rows, rules, owner questions 1 and 2 recorded as decided on 22 October 2026. Marked "pending apply". The "Last checked" date is not advanced.
- `guides/index.html` and `style-guide.html`: "Pick your races" and own-row Edit.

## How it was checked

All on a local copy. Nothing touched the live project.

- `npm run check`: Prettier and ESLint clean. `eslint-suppressions.json` unchanged.
- `supabase/tests/run.sh` on a throwaway Postgres 16 (UTF8 server, `initdb -E UTF8`): "all SQL tests passed". Existing test files unchanged.
- `node scripts/check-admin-ui.mjs`: all checks passed.
- `node scripts/check-app-ui.mjs`: run five times in a row on the final tree. Exit 0, 0 FAIL, 408 ok each time.

Mutation tests. Each break was made on a scratch copy, the suite turned red, and the code was restored:

- Policy calling `is_admin()` directly: the existing `b3_access_requests` test died with "permission denied for function is_admin".
- Owner clause replaced by `true`: "FAILED: another member's update: 0 rows".
- Mixed-script threshold raised from 2 to 3: "FAILED: request_access refuses Latin plus Cyrillic".
- Blank-letter list cut short: "FAILED: request_access refuses a Hangul filler". In `app.js`, U+3164 dropped: "FAIL a name ending in the blank letter U+3164 is refused".
- Undo owner guard removed: "FAILED: undoing the delete restores the entry to its original owner".
- Undo guard, flag condition dropped: "FAILED: flag off, not an API role: created_by is stamped, the chosen owner is ignored".
- Undo guard, API-role condition dropped: "FAILED: API role, flag on: created_by is still the caller, not the chosen owner".
- Onboarding including today (`>=`): 9 UI checks red.
- `canChangeEntry` always true, flag write removed, ownership by name: each red.
- Partial-save and mid-save fixes undone: 3 named FAILs each.
- Auto-open guard removed: 2 FAILs. Always re-arm on auth events: "FAIL D9: after a token refresh...".

Scenario 14 crash, pre-existing. At the unchanged code, `check-app-ui.mjs` crashed in scenario 14. It clicked `#heroAddButton` as a revoked member, but that button has been hidden when signed out since #109. Every later scenario was skipped. The step now clicks `#signInButton` and still asserts "sheet opens, no writes". The crash was confirmed at the old code.

Flaky check, root-caused. "Focus returns to the row button" (results form) failed 2 of 4 runs. Cause: a test timing bug. The app moves focus in a `setTimeout(0)` after the render that shows "Result saved.". The test read the focused element at the same instant as the banner. The test now waits for the same condition with `waitForFunction`. The assertion is unchanged. No retries, no skip. Since then: 6 of 6, then 5 of 5, then 5 of 5 clean runs. The flake was not reproduced on the old code; the cause comes from reading the code.

## Review findings and how each was resolved

Security audit (two passes; final: not exploitable, confidence 9/10; no critical or high findings):

- F1 (medium): blank filler letters let a name look like "Alex Smith". Fixed in SQL and JS, with tests.
- F2 (low): undo of a delete re-stamped the entry to the admin. Fixed: the original owner is kept.

Code review, first pass:

- M1: a failed reload after a partial save lost the failed-race message. Fixed: the list is worked out from the pre-save list.
- M2: the sheet could be closed mid-save, losing the result. Fixed: close is blocked while saving.
- m1: the screen could open after any race reload. Fixed (D5).
- m2: result buttons keyed on "has an admin row". Fixed (D6).
- m3: permissions.md results cell left out the allow-list. Fixed.

Code review, second pass:

- R2-1: the F2 fix wrote a fake "Linked" history row and could not be undone. Fixed (D8): one INSERT row with the original owner, and undoable.
- R2-2: token refresh re-armed the screen mid-session. Fixed (D9).

Verification gaps found and closed:

- Two regressions failed by timeout, not a named line. Now named FAILs.
- The JS blank-letter mirror had no failing test. Added.
- Two single-condition breaks of the undo guard went unnoticed. Two tests added (D11). Both now fail on the break.

## Decisions log

- D1: Onboarding lists races after today (Sydney). Today's races are left out: on race day the card shows results.
- D2: Shown once per device; "Not you?" mails the club; admin controls need two-factor; fullwidth Latin passes; admins must be allow-listed.
- D3: Guide update kept as nice-to-have. Done, as it was small.
- D4: The migration is not applied to the live database in this work. The owner's go-ahead is needed.
- D5: The screen opens by itself only on page load or sign-in.
- D6: Result buttons key on a two-factor admin session, the same as entries.
- D7: The flaky check must be root-caused and fixed. No retry-until-green, no skip.
- D8: Undo keeps the owner inside the insert trigger, under a narrow guard. No second update.
- D9: The screen re-arms only when the signed-in user changes.
- D10: Undo may restore an entry to an owner who has since lost approval. They still cannot write until re-approved.
- D11: Each condition of the undo guard gets its own failing test before merge.

## Known limitations

- Not run against a real Supabase project. Only a local Postgres 16.
- Onboarding timing tested with an instant stub, not real network order. If a password prompt opens just after races load, it replaces the onboarding sheet. The flag is already written, so it will not reopen by itself. The Menu item still works.
- An admin editing a row whose name was just renamed sees "only your own" for a row that was not found.
- "Shown once" is per device. On a new device it can show again, but only to a member with no commitments.
- Not caught: whole-alphabet look-alikes (an all-Cyrillic "Сам" next to "Cam"), fullwidth Latin, and blank or invisible letters beyond the seven listed.
- Not checked: screen readers; widths between 390 and 1100 px.
- `render()` still uses the device date for the race list, not Sydney. Out of scope.
- README, permissions.md, the guide, the migration's no-data rule and the stale comments were checked by reading, not by a test.

## Before merge / deploy

**The migration `20261022060000` is not applied to the live database. Applying it needs the owner's go-ahead.**

Recommended order:

1. Read-only check on live data. List names in `profiles` **and** pending `private.access_requests` that mix alphabets or hold a blank letter. Run on 22 October 2026 across both: 0 of 7 profiles and 0 of 4 access requests mix alphabets or hold a blank letter. Re-run it just before applying, in case a new request arrives.
2. Merge and deploy the app (`app.js`, `admin.js`, `index.html`, styles). The new app is stricter than the old database rules, never looser, and calls no new database function. So it works on the old rules. Doing it first means members never see Edit buttons the database will refuse.
3. With the owner's go-ahead, apply the migration with `apply_migration` (`project_id: shkfwuogrldbqldpipxd`). Do it soon after step 2. Until then, the database still allows the old honour system, as it does today.
4. Run `list_migrations`. Rename the local file to the version Supabase recorded, as the repo's CLAUDE.md requires. Commit the rename.
5. Check it live: a member edits their own commitment; a member cannot edit another's; an admin with two-factor can. Then advance "Last checked" in `docs/permissions.md` and drop "pending apply".

A browser still holding the old `app.js` after step 3 may show Edit on others' rows. The change will be refused with the old "approved members only" text. A reload fixes it; the cache-bust helps.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_016YrMTTdhWnxMdDoAw9Eyt6
````

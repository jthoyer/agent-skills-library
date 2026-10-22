# security-auditor — 2026-10-22 — BalanceTRI-app race onboarding and owner-only edits

Run: `mc-orchestrator` from `cpo` (/rewrite), all actors delegated. Outcome: merged as jthoyer/BalanceTRI-app#118; migrations live 22 Oct 2026, synced in #119.
Full stage registers: `mc-orchestrator-2026-10-22-registers.md`. Briefs and reports below are verbatim, extracted from the agent transcripts.

## Pass 1

### Brief 1

````text
Static security review of an uncommitted change in /home/user/BalanceTRI-app (Balance Tri Club race calendar: static site on GitHub Pages, Supabase backend with RLS; anon key is public by design). Read-only: report, do not patch, do not write files.

Spec for context: /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md ("# Stage 1 — Spec" and the Integrator sections).

Changed files: supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql (new), supabase/tests/restrict_entry_writes.test.sql (new), app.js, admin.js, README.md, docs/permissions.md. Prior migrations in supabase/migrations/ define the helpers (private.is_allow_listed, private.is_admin, guard_entry_name, entries_set_created_by, results policies, access-request name helpers, admin_link_entries).

Threat model: any person can create an account; approved members are semi-trusted peers; the main threat is one member impersonating another or altering/deleting another member's commitment or result; also a member escalating to admin, bypassing two-factor, or injecting markup via race names or display names.

Check especially: can a member update/delete/insert an entry or result they don't own (including via changing created_by, race_id, or name, or via any SECURITY DEFINER function, admin_link_entries, add_race_event, admin_undo); does any new security-definer function leak or escalate (search_path, grants to anon/authenticated); is two-factor (aal2) enforced for admin overrides; is the mixed-script name rule applied on every path that writes a display name or entry name; homoglyph gaps that remain; XSS in the new onboarding UI; STRIDE over the onboarding flow.

Return (≤500 words): findings with confidence, severity, file:line and a concrete exploit scenario each; then residual risks accepted by design. Say plainly if none are exploitable.
````

### Report 2

````text
**Verdict: I found no exploitable path in this change that lets a member write another member's entry or result, escalate to admin, or skip two-factor.** One name-spoofing gap clears the confidence bar (F1). It isn't new and the change doesn't close it.

**Entry and result ownership: holds.** I tried to break each of these and couldn't.
- **The new check** `private.can_change_entry` (migration lines 26–41) is security definer, has `search_path ''` and is granted to `authenticated` only. It sits in the `private` schema, so the API doesn't expose it as an RPC, and it only answers a yes/no about the caller. Admin rights go through `is_admin()`, which requires a two-factor session (`aal2`) when `mfa_required` is set, and the allow-list is required as well.
- **Changing `created_by` doesn't work.** `entries_set_created_by` (20261016000000 l.85–108) resets it to the old value on any member update. It also overwrites it on insert. The link bypass needs a non-API role, so a member can't trigger it.
- **Changing `name` doesn't work.** `guard_entry_name` blocks it on update, and on insert the name must equal the caller's own display name.
- **Changing `race_id` only affects the member's own row.** Nobody else is touched.
- **Results:** the name-match branch is gone. `results_stamp` blocks moving a result to another entry.
- **Other functions:** `add_race_event` is security invoker and only touches `races`. `admin_link_entries`, `admin_unlink_entries`, `admin_undo` and `admin_rename_member` all call `require_admin()`, which needs two-factor.
- **XSS:** the onboarding screen builds everything with `elt()` (`setAttribute` plus `append`, so text stays text). `racePath` encodes the slug and the mailto address is a constant. I found no new `innerHTML` that takes variables.
- **Mixed-script ranges:** I checked the SQL ranges (lines 103–105) code point by code point against the spec. They match the `app.js` copy (lines 671–675).

**F1 — MEDIUM, confidence 8/10: invisible "letters" defeat the duplicate-name check.** Files: `20261012042109` l.56/63 (`display_name_taken`) and the new migration l.97.
- Hangul filler characters (U+3164, U+115F, U+1160, U+FFA0) count as letters for both `[[:alpha:]]` and `\p{L}`, but they display as blank space. They also belong to none of the three alphabet groups.
- Exploit: an approved member renames their own profile to `Alex Smith` + U+3164. No admin is involved, and the limit is 5 renames a day. The name passes `clean_display_name`, the mixed-script rule and `display_name_taken`. Every new commitment and result they add then shows "Alex Smith".
- They can't change the real Alex's rows. This is impersonation in what other members see.
- Fix: in both the SQL and JS rules, strip or refuse U+115F, U+1160, U+3164, U+FFA0 and other default-ignorable or blank letters, and add a test.
- Confidence assumes the database runs glibc with a UTF-8 locale, which the passing `Сергей` test suggests.

**F2 — LOW, a correctness bug, not an attack: undoing a delete hands the entry to the admin.** `admin_undo` (20261016043135 l.71) re-inserts the deleted row, but the insert trigger stamps `created_by := auth.uid()`, which is the admin's id. The original owner can then no longer edit or remove that entry or write its result. Ownership didn't matter for writes before this change; now it does. No test covers undoing a delete.

**Residual risks accepted by design (spec non-goals and D2):**
- Look-alike names within one alphabet: ASCII `AIex` versus `Alex` (capital I for lowercase l), dotless `ı`, an all-Cyrillic `Сам`.
- Fullwidth Latin.
- Letters outside the three alphabets mixed into a Latin name: Armenian `օ`, Cherokee `Ꮪ`, small capitals U+1D00–1D7F, maths letters U+1D400+.
- Any approved member can still edit or soft-delete any race. That hides other members' commitments and closes their results (`can_write_result` needs a live race). Changing a race date also opens or closes results for everyone.
- The sign-up name seeded from the email's local part (`handle_new_user`) skips the name rule until the first rename. That only matters for an account an admin allow-lists directly.
- The "shown once" flag is per device and the UI uses it only for display, so it has no security effect.
- `canEditResult` still keys on `isAdmin`. It's UI only and the database still refuses the write.

**Scope:** I read the new migration, the helper, trigger, policy and admin-function migrations listed above, and the `app.js` sections for ownership, admin state, the name mirror and onboarding. I skimmed the test file only for undo coverage. I didn't read `admin.js`, `README.md`, `docs/permissions.md`, `restrict_entry_writes.test.sql` or `.claude/references/*`.
````

## Pass 2 (ownership trigger)

### Brief 1

````text
Focused static security re-check of one change in /home/user/BalanceTRI-app (Supabase RLS app; the anon key is public; approved members are semi-trusted peers; admins need two-factor via require_admin()). Read-only: report only, write no files.

Change under review, in the uncommitted migration supabase/migrations/20261022060000_restrict_entry_writes_to_owners.sql:
- entries_set_created_by (trigger entries_created_by_biu) now KEEPS new.created_by on INSERT when current_user is not an API role (not 'authenticated'/'anon') AND the transaction-local setting app.entries_link_ok = 'on'. Previously INSERT always stamped created_by := auth.uid().
- admin_undo sets that flag only around its re-insert of a deleted entry, then clears it.
Prior versions: supabase/migrations/20261016000000_add_admin_link_entries.sql and 20261016043135_admin_undo_refuses_owner_changes.sql. Context: /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md ("## Fix round 2").

Question: can any caller who is not a two-factor admin get an entry inserted with a created_by of their choosing (another member's id), or otherwise take over or reassign an entry? Consider: can an API caller set app.entries_link_ok (set_config via PostgREST RPC, request headers/GUCs, any exposed function calling set_config); every SECURITY DEFINER function that inserts into entries while running as the owner role (admin_link_entries, admin_undo, add_race_event, onboarding-related functions, any others you find by grepping supabase/migrations for "insert into public.entries" and "set_config"); whether the flag can leak past admin_undo on error or across statements in one transaction; whether undo of another admin's or member's delete lets an admin assign ownership in a way the spec didn't intend (acceptable: restoring the original owner).

Return (≤300 words): exploitable or not, with confidence; any finding with file:line and exploit scenario.
````

### Report 2

````text
**Not exploitable. Confidence: 9/10.** I found no way for a caller who isn't a two-factor admin to insert an entry under another member's id, or to take over or reassign an entry.

**Where the flag gets set:** I grepped `supabase/migrations` for `insert into (public.)?entries`, `set_config`, `execute format` and `create trigger`. Only three functions set `app.entries_link_ok`, and each starts with `private.require_admin()`:
- `admin_undo` (`20261022060000…sql:181/185`)
- `admin_link_entries` (`20261016000000…sql:241`)
- `admin_unlink_entries` (`20261016000000…sql:300`)

`admin_undo`'s dynamic insert (`:183`) is the only security-definer path that inserts into entries. The only other inserts are the 0909 smoke-test migrations, which are not functions. I found nothing related to `add_race_event` or onboarding that touches entries.

**Can an API caller set the flag?**
- `set_config` lives in `pg_catalog`, which PostgREST doesn't expose. Request headers and claims only fill `request.*`, not arbitrary settings.
- Each PostgREST request is its own transaction, and the setting is transaction-local.
- Even if a caller did set it, the trigger's other condition still fails: `current_user` is `authenticated` or `anon` for any direct API write (trigger is security invoker, `:238`). Test `restrict_entry_writes.test.sql:186-188` confirms a member's insert that names someone else as owner is stamped back to the member.

**Can the flag leak?**
- The flag is set inside the inner `begin … exception` block. If the insert fails with a unique or foreign-key error, the block's rollback reverts the setting before the error is raised again, and that error aborts the whole call.
- Any other error aborts the transaction outright.
- Nothing runs between the insert and the clear at `:185`.
- The entries triggers (history, bulk guard, name guard) don't insert into entries.

**Can undo pick an owner?** No. The restored owner comes only from `h.old_row` in `private.change_history`, which only triggers write: it is the row as it stood when deleted. An admin can only choose which history row to undo, never the owner value. That is the spec's acceptable "restore original owner" case. Owner changes made by UPDATE are still refused (`:156-160`).

**Hardening (did not clear the gate):** none needed.

**Owner question:** undoing a delete gives the entry back to its owner even if that account has since lost approval, whereas Link refuses unapproved accounts. That owner still can't write, because `can_change_entry` requires the allow-list. Is that intended?
````

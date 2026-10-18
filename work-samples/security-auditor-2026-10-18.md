# security-auditor — 2026-10-18 — BalanceTRI-app PII review

Dispatched by: cpo skill (main thread, /rewrite). Definition: .claude/agents/security-auditor.md

## Brief (verbatim)

You are auditing the security and privacy of personally identifiable information (PII) in the Balance Tri Club app — a static web app (GitHub Pages style) for a Sydney triathlon club. Members log race entries and results. The backend is Supabase (project ref shkfwuogrldbqldpipxd). The browser talks to Supabase directly with the public publishable key (shared.js:8-9), so Row Level Security (RLS), grants and SECURITY DEFINER functions ARE the security boundary.

## Frame
- Objective: find every way member PII (names, emails, auth identities, race history/results, access-request details, feedback text, change history, admin actions) can be read, changed, or leaked by someone who should not — anonymous visitors, signed-in non-allow-listed users, ordinary members, or a compromised admin — plus privacy-hygiene gaps (data minimisation, retention, deletion, consent/notice under the Australian Privacy Act / APPs).
- Done when: you return a severity-ranked findings list, each with a concrete exploit or failure scenario and file:line evidence, plus a PII inventory and a list of controls that are working well.
- Out of scope: do not edit any file. Do not report the publishable key itself as a finding (it is designed to be public); report only what it lets an attacker do. No generic linter advice.

## Constraints
- Live database access was refused this session. The migration files are the best record of the live schema; treat the LATEST migration that touches an object as authoritative (later migrations often replace functions/policies). Say clearly where a conclusion depends on the live DB matching the migrations, and list SQL checks the owner should run to confirm.
- Confidence-gate: only report findings you can trace in the code. Mark each Confirmed (traced end to end) or Plausible (depends on unverified live state).

## Files (absolute paths)
- Repo root: /home/user/BalanceTRI-app
- README (schema + RLS notes): /home/user/BalanceTRI-app/README.md
- Migrations (48 files, chronological): /home/user/BalanceTRI-app/supabase/migrations/ — pay special attention to: 20260921021122_add_profiles_table.sql, 20260923061516_add_email_allow_list.sql, 20260924044732_expose_is_allow_listed_via_public_wrapper.sql, 20260924050927_add_change_history.sql, 20260924054526_add_admin_console.sql, 20261012042054.._add_access_requests_*.sql (1-8), 20261012050607_add_access_request_notifier.sql, 20261012205858_add_admin_password_reset.sql, 20261012210315_add_batch_approve.sql, 20261013011548_first_names_for_visitors.sql, 20261013034516_lock_entry_names_add_admin_rename.sql, 20261013034715_add_app_feedback.sql, 20261013042941_add_results_table.sql, 20261016000000_add_admin_link_entries.sql, 20261016120000_admin_undo_refuses_owner_changes.sql
- Client code: /home/user/BalanceTRI-app/shared.js, app.js (3250 lines), admin.js (1884 lines), index.html, admin.html, 404.html, guides/index.html
- Also check: XSS sinks (innerHTML etc.) that render member-supplied text, auth flow (magic link/password, redirect URLs, session storage), what data the anon role can SELECT (e.g. full names vs first names, emails), RPCs callable by anon/authenticated with SECURITY DEFINER and missing search_path or missing caller checks, enumeration oracles (is_allow_listed etc.), the access-request notifier (what PII it sends where — webhooks, email, pg_net), password reset by admins, audit/change-history tables exposing PII, CSP / third-party scripts, and anything logged to console.

## Return format (max ~1800 words)
1. PII inventory table: data item | where stored | who can read | who can write.
2. Findings, ranked Critical/High/Medium/Low: ID, title, Confirmed/Plausible, evidence (file:line), exploit scenario, recommended fix (one or two lines).
3. Privacy-hygiene gaps (APPs-oriented): retention, deletion/right to erasure, notice, minimisation.
4. Controls working well (short bullets).
5. SQL checks the owner should run against the live DB to confirm the Plausible items.

## Output (verbatim)

## Balance Tri Club: PII security audit (read-only)

I found 2 High, 4 Medium and 5 Low findings. The worst is a committed migration file that publishes about 180 members' full names, including children. The second-worst lets someone impersonate a member by signing up with that member's email and getting approved. The database layer itself is well built: there is no `using (true)` on a table holding PII, every admin function checks for an admin with two-factor, and I found no XSS sinks. Everything below comes from the migrations; I could not read the live database.

### 1. PII inventory

| Data | Stored in | Who can read | Who can write |
|---|---|---|---|
| Full name + race, event, level | `public.entries` | Approved members (policy `is_allow_listed()`); visitors and unapproved accounts get first word only via `public_entries()`; **anyone, via repo file (H1)** | Any approved member (insert must use own display name; update/delete **any** row) |
| Results (time, places, PB, note) | `public.results` | Approved members | Entry owner, name-match "owner" (M1), admin; **any member indirectly via entry delete (M2)** |
| Display name, JustGo fields | `public.profiles` | Own row only; admins via functions | Own `display_name` only (column grant); admins |
| Email, sign-in times, confirmed flag | `auth.users` | Admins via `admin_users` / `admin_requests` | Supabase Auth |
| Allow-list | `private.allowed_emails` (keyed hash only) | Nobody directly | Admin functions, triggers |
| Join request: name, note, status, reason | `private.access_requests` | Admins | `request_access()`, admins |
| Change history (full old/new rows) | `private.change_history` | Admins (`admin_activity`) | Triggers |
| Admin log (incl. old names) | `private.admin_actions` | Nobody via API | Admin functions |
| Feedback message, contact, user id, member email in the mail | `private.app_feedback`, Resend email | Service role, maintainer's inbox | Edge Function |
| Display name in Telegram alert | Telegram chat | Admin | Notifier function |
| Session tokens, display name | Browser localStorage (origin `jthoyer.github.io`) | Any script on that origin (M3) | App |

### 2. Findings

**H1. About 180 members' full names and race history are in the repo and probably served publicly. Confirmed in the file; whether it is publicly reachable needs checking.**
- **Evidence:** `supabase/migrations/20260909081216_import_entries_from_club_calendar.sql:4` holds a JSON array of full names, races, events and levels. It includes minors: "Izzy and Evie Shurley" with "Sprint + kidztri", and "Kayler McDonald" in "Junior B (Sprint)".
- **Why it's reachable:** the remote is `github.com/jthoyer/BalanceTRI-app`, and GitHub Pages serves the whole tree. There is no `.nojekyll` or `_config.yml` exclude, and `.sql` files are published as static files.
- **Exploit:** anyone fetches `https://jthoyer.github.io/BalanceTRI-app/supabase/migrations/20260909081216_import_entries_from_club_calendar.sql`, or reads the GitHub repo. That gives every full name and race history, which is exactly what `first_names_for_visitors` was built to hide.
- **Fix:**
  - Replace the file's data with a placeholder.
  - Stop Pages publishing `supabase/` (an `exclude:` in `_config.yml`, or deploy only the needed files through Actions).
  - Purge the file from history (`git filter-repo`). Forks and clones keep it regardless.
  - Consider telling the affected members.

**H2. Impersonation at sign-up: approval relies on an email address nobody has verified. Plausible; depends on "Confirm email" being off.**
- **Evidence:** README:118 and the `first_names_for_visitors` header say cutover has happened ("anyone can make an account in seconds"). With confirmation off, Supabase sets `email_confirmed_at` automatically, so the confirmed-email checks pass for any address: `admin_decide_request` (20261012042329:93-96) and `is_allow_listed`.
- The roster badge and "Choose all on roster" match on the self-declared email (`admin.js:952-956, 1036-1039, 1229-1230`). G1 removed about 159 pre-approvals (20261012210315:8), so most members still have to rejoin.
- **Exploit:** the attacker signs up with a known member's address (from newsletters or the JustGo roster), using the real name and a friendly note. The request shows "On club roster" and gets batch-approved. The attacker can then read every full name, result and note, and write entries. The real member then gets "already an account" and cannot join.
- **Fix:** verify ownership before approving (turn confirmation back on for sign-up, or confirm out of band). Mark the email as "unverified" in the console, and don't offer roster-based bulk approval while emails are unverified.

**M1. A member can rename themselves to another person's name and take over that person's results. Confirmed.**
- **Evidence:**
  - Members may update their own `display_name` (20261012042122:68-69).
  - `display_name_taken` only blocks names held by pending or approved people (20261012042109:45-69).
  - `can_write_result` treats a name match as ownership for any unowned entry (20261013042941:84-91).
  - `guard_entry_name` only checks that a new entry's name equals the caller's profile name (20261013034516:32-36).
- **Exploit:** an approved member sends `PATCH /rest/v1/profiles?id=eq.<self>` with `{"display_name":"Lauren Dredge"}`. This works because she hasn't rejoined yet. The member can then upsert or delete results, including visible notes, on every imported "Lauren Dredge" entry, add entries in her name, and rename back. Renames are capped at 5 a day and logged. It also squats the name, which blocks her own `request_access`.
- **Fix:** take away members' direct `UPDATE (display_name)` and route renames through admin approval. Or drop name-match ownership and rely on admin Link only.

**M2. Any approved member can permanently destroy another member's result. Confirmed.**
- **Evidence:**
  - The entries delete and update policies check only `is_allow_listed()` (20260923061516:81-86).
  - `results.entry_id ... on delete cascade` (20261013042941:32).
  - `admin_undo` restores the entry but not its result (20261016120000:47; README:33).
- **Exploit:** a member sends `DELETE /rest/v1/entries?id=eq.<victim entry>` (up to 5 per request, repeated). Each victim's result is deleted with it. Undo brings the entry back without the result, so only manual SQL from `change_history` recovers it. Changing `race_id` with an update also moves a result onto the wrong race.
- **Fix:** limit entry update and delete to `created_by = auth.uid()` or admins, at least on entries that are owned or have a result. Or switch the results foreign key to `restrict`.

**M3. Sessions sit in localStorage on an origin shared with the owner's other GitHub Pages sites, including the admin's two-factor session. Confirmed design.**
- **Evidence:** `app.js:72-78` says so itself, and `createClient` keeps the default localStorage (`app.js:37`). The admin console shares that session (README:99).
- **Exploit:** any XSS or supply-chain compromise in BalanceBolt or any other `jthoyer.github.io/*` project can read `sb-shkfwuogrldbqldpipxd-auth-token`. The refresh token keeps the two-factor level, so if the admin's session is taken the attacker gets every email (`admin_users`) and can take over any member account via Reset password.
- **Fix:** move this app, or at least `admin.html`, to its own origin (a custom domain). Also shorten `jwt_expiry`.

**M4. Old display names that are email local parts are published to visitors. Plausible.**
- **Evidence:** `handle_new_user` seeds `display_name = split_part(email,'@',1)` (20260921021122:28). Already-approved members never see the name step, and the app has no rename UI. `guard_entry_name` forces entry name = profile name. `public_entries()` returns the first word, which for "sam.lee87" is the whole thing (20261013011548:32).
- **Exploit:** a visitor reads `rpc/public_entries`, sees "sam.lee87" and guesses `@gmail.com`. That yields an email address, from which the full name can be found.
- **Fix:** have an admin rename these profiles (see SQL check 4). Make `public_entries` refuse names that fail `clean_display_name`.

**L1. Any account, even unapproved, can check whether a full name belongs to a member. Confirmed.** The `profiles` PATCH or `request_access` with a guessed full name returns "Someone at the club already uses that name". The 5-a-day cap only counts successful renames (20261012042122:18-36). Combined with first names from the roster, that confirms who is a member.

**L2. Temporary passwords never expire on the server. Confirmed.** The forced change and the 7-day expiry are enforced by the app only. `password_changed()` trusts the caller (20261012042305:113-129; README:394). A temporary password sent by text works indefinitely through the API.

**L3. Feedback silently attaches the signed-in member's verified email. Confirmed.** The form says contact is "optional… Only if you'd like a reply" (`index.html:404-415`). The member's email still goes into the message and Reply-To via Resend (`send-feedback/handler.ts:353-367`), and the row is kept forever.

**L4. The sole admin's identity is public. Confirmed.** The owner's email is in `20260924100737:9` and the admin's user UUID in `20260924054526:33`, both public. That helps a targeted phishing attempt against the only admin.

**L5. The display name stays on the device after sign-out. Confirmed.** `state.user` is saved to localStorage and never cleared on sign-out (`app.js:154, 372-374`), so on a shared device the name remains.

**Hardening ideas that didn't pass the confidence bar:**
- No CSP on `index.html` or `admin.html`. The hCaptcha script runs with the session available.
- Visitors can read `races.created_by` / `updated_by` user ids.
- Any signed-in account can read removed races.
- The local `config.toml` has `minimum_password_length = 6` and `secure_password_change = false`; check the live settings.
- With a single admin, nobody else is notified of admin actions.

### 3. Privacy-hygiene gaps (Australian Privacy Principles)

- **APP 1/5, notice:** there is no privacy policy or collection notice in the code (searching for "privacy" finds nothing). Nothing names Supabase, Resend, hCaptcha or Telegram as recipients.
- **APP 8, overseas disclosure:** Resend, hCaptcha and Telegram are overseas, and the Supabase region is unverified.
- **APP 11.2, retention:** nothing is ever purged from `change_history` (full row snapshots), `admin_actions`, `app_feedback`, or rejected or revoked `access_requests` (notes and reasons).
- **Erasure:** members can't delete themselves. Deleting an auth user still leaves `entries.name`, results, history snapshots, admin-log names and feedback text. The README restore query can bring deleted data back.
- **APP 12/13, access and correction:** members can't see their own history, and renaming goes only through the admin.
- **Minimisation:** children's names and data (H1) are in the repo. The club may fall under the small-business exemption, but this is still poor practice.

### 4. Controls working well

- Full names are gated server-side (`first_names_for_visitors`), and results are members-only.
- Every `admin_*` function calls `require_admin()` with a two-factor check. All definer functions set `search_path=''`. EXECUTE is revoked from `anon`. Notifier and feedback functions are service-role only.
- The allow-list is stored as HMAC hashes. `is_allow_listed()` takes no arguments, so it can't be used to probe addresses.
- The G2/G3 guards and per-account locks are in place, and admins can't reset another admin's password.
- No XSS sinks: the ESLint `no-unsanitized` rule has no suppressions, everything is built with textContent, `safeLinkUrl` / `isEmbeddableBoltUrl` check URLs, and supabase-js is vendored. Version 2.117.1 has no applicable CVE.
- The Edge Functions compare the shared secret in constant time, take names from the database rather than the request, never log passwords, and restrict CORS.

### 5. SQL and other checks for the owner (for the Plausible items)

1. **Confirm-email setting (H2):** `select created_at, email_confirmed_at from auth.users order by created_at desc limit 20;` If the two times match for recent sign-ups, auto-confirm is on.
2. **Policies and grants:**
   - `select tablename,policyname,roles,cmd,qual,with_check from pg_policies where schemaname='public';`
   - `select grantee,table_name,privilege_type from information_schema.role_table_grants where table_schema='public' and grantee in ('anon','authenticated');`
   - plus `information_schema.column_privileges` for `profiles`.
3. **Functions:** `select n.nspname,p.proname,p.prosecdef,p.proconfig,has_function_privilege('anon',p.oid,'execute') a,has_function_privilege('authenticated',p.oid,'execute') au from pg_proc p join pg_namespace n on n.oid=p.pronamespace where n.nspname in ('public','private');`
4. **Old display names (M4):** `select p.id,p.display_name from public.profiles p join auth.users u on u.id=p.id where lower(p.display_name)=lower(split_part(u.email,'@',1)) or p.display_name ~ '[0-9@_]';`
5. **Name squatting (M1):** `select changed_at,changed_by,old_row->>'display_name',new_row->>'display_name' from private.change_history where table_name='profiles' order by changed_at desc;`
6. **Results destroyed by others (M2):** `select * from private.change_history where table_name='results' and op='DELETE' and changed_by is distinct from (old_row->>'created_by')::uuid;`
7. **Stale temporary passwords (L2):** `select * from private.password_resets where cleared_at is null and expires_at < now();`
8. **Retention:** `select count(*),min(changed_at) from private.change_history;` and the same for `app_feedback` and `access_requests where status in ('rejected','revoked')`.
9. **Outside SQL:**
   - `curl -I` the Pages URL in H1.
   - Check the repo's visibility.
   - Check the PostgREST exposed schemas (should be `public` and `graphql_public` only).
   - Check the live `jwt_expiry`, password minimum length and project region.

**What I checked:** all 48 migrations (taking the latest definition of each object), `app.js`, `admin.js`, `shared.js`, the HTML pages, all three Edge Functions and `config.toml`. I went through the policy and grant sweep, every SECURITY DEFINER function, the XSS sinks, storage use and the third-party data flows, and applied STRIDE to the visitor, signed-in-unapproved, member and admin boundaries plus the Edge Functions. `.claude/references/review-gates.md` isn't in the repo, so I applied steps 4–5 directly instead. Things I ruled out:
- The publishable key and hCaptcha site key: public by design.
- Test `@example.com` fixtures: not real data.
- The old `using (true)` races policies: replaced in 20260921061111.
- The SHA-256 in the notifier: used for a constant-time compare, not password hashing.

Sources: [CVE-2025-48370 (auth-js)](https://advisories.gitlab.com/pkg/npm/@supabase/auth-js/CVE-2025-48370/), [CVE-2026-31813 (Auth server)](https://osv.dev/vulnerability/CVE-2026-31813)

## Disk-verified outcome (by main thread)

- H1 confirmed: migration 20260909081216 holds 389 entries, 155 distinct names (agent said ~180 — overstated), incl. a kidztri entry. Public Pages reachability NOT verified (jthoyer.github.io blocked by proxy).
- H2 premise confirmed in config.toml: enable_confirmations = false (live setting unverified; Supabase MCP refused).
- M2 confirmed: 20260923061516:81-86 policies; results.entry_id on delete cascade (20261013042941:32); no later migration changes entries update/delete policies.
- Published: Notion review page https://app.notion.com/p/3fdcfee1ca1881dcb906ceaf0c3505fc + 8 backlog rows (Rank 124-131).

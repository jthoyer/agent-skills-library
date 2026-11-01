# security-auditor — 2026-11-01 — Stage 3 audit of Finish your races

Run: `/design` then `/rewrite` (cpo) on a screenshot of the BalanceTRI-app "Pick your races" sheet, then "Continue with wizard" and mc-orchestrator. Session 2026-11-01. App repo: balancetriclub/BalanceTRI-app, PR 166. Dispatched by `mc-orchestrator` at Stage 3 because the change writes member data. Static only.

## Brief verbatim

~~~~text
Stage 3 (Challenge), security audit. Static review only; you hold no write tools, so return findings as text.

Diff: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races.diff (3 commits on top of origin/main). Repo: /home/user/BalanceTRI-app. Spec: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md. Permissions record: /home/user/BalanceTRI-app/docs/permissions.md and README.md (Backend, RLS sections) and CONTRIBUTING.md (Security rules).

Change: a wizard after "Pick your races" walks a member through each race to set events and a level. It writes with the existing saveEntry (UPDATE entries on race_id+name, RLS owner-gated) and addEvent (rpc add_race_event, appends to the shared races.events array; any member may call it). It adds a Menu item driven by the member's own entries. No migration and no supabase/ change is claimed.

Check, with a concrete exploit scenario for each finding:
1. XSS: any innerHTML/insertAdjacentHTML/outerHTML/document.write built from a variable, in new or moved code, including the extracted chip builder and the summary rows. Race names, event strings and the "Other" text are member-typed. Confirm textContent/setAttribute only; check attribute sinks (href built for the Open link, aria-label).
2. Authorization: does the wizard rely on anything the client controls (user_metadata, localStorage, a hidden button) rather than RLS? Does it pass the entry's own name from loaded data? Can a member use it to change someone else's entry or an entry they do not own? Does the "own entry" test use created_by (isOwnEntry)?
3. Shared-data abuse: addEvent writes the shared races row. Does the wizard widen what a member can append compared with the card form (limits, trimming, length, count of events, repeated calls in a loop)? Is the DB constraint races_events_size the real backstop?
4. Persistence/privacy: does the new code write member names, emails or other data to localStorage, logs, console, URLs or error toasts? Does the test script or docs contain real member data (they must use made-up data only)?
5. Error handling: swallowed errors, raw database text shown to the user.
6. Confirm no file under supabase/ or docs/permissions.md changed, and no secret was added.
Rate each finding by confidence (High/Medium/Low) and severity. Say plainly what you could not check.

Return 400 words or fewer: findings ranked, then "checked and clean" as a short list.
~~~~

## Output verbatim (the hand-back report)

~~~~text
**Security audit: Finish your races (3 commits, static review only)**

No finding met the bar of a concrete exploit at 8/10 confidence. Nothing is CRITICAL, HIGH or MEDIUM.

**Findings**

1. **LOW, High confidence: the save error is caught and the cause is thrown away.** `public/app.js` ~L1197–1209 (`showFinishRaces` → `next.onclick`). The cause in `failure` is never logged, and the member always sees one of two fixed sentences. This is not exploitable. It breaks CONTRIBUTING's "Don't catch and discard errors", and the generic text misleads in one real case: a race already at the `races_events_size` limit (30 events, 1000 characters) is reported as "Check your connection". Fix: `console.error('finish races save failed:', failure)` and show the `friendlyWriteError` text for constraint errors.

**Hardening (did not meet the bar)**
- Neither the wizard nor the card form checks the "Other" text against `RACE_LIMITS` before calling `addEvent`. The wizard matches the card exactly: trimmed, de-duplicated, at most one Other value per save. The database is the real limit: `races_events_size` (`20260924050908`), `add_race_event` running as the caller under the "Members can update races" policy, plus the 5-row bulk guard. A member looping saves can append at most 30 events to a race, which any member can already do from the card or with a direct RPC call. permissions.md: "Races stay an honour system".

**Checked and clean**
- **XSS:** no new `innerHTML`, `insertAdjacentHTML`, `outerHTML` or `document.write`. The refactor removes two `innerHTML = ''` and uses `replaceChildren()`. Every new node goes through `elt()` (L398: `setAttribute` and `append`, which make text nodes) or `textContent`. Race names, event strings and Other text, in the summary rows and the `aria-label`, are text or plain attribute values. The Open link's `href` is `racePath` → `encodeURIComponent(slug)`, so no `javascript:` link is possible.
- **Authorization:** `finishableItems` uses `isOwnEntry` (`created_by === session.user.id`) and is gated on `isMember`. `entryName` comes from the loaded entry, or from the name the picker just inserted with. Writes go through `saveEntry`, which is an UPDATE only and fails closed when 0 rows change. RLS (`can_change_entry`, owner = `created_by`) is the real boundary. Spoofing `entryName` or `created_by` in the client gets a 0-row update and nothing else. Nothing reads `user_metadata` or localStorage to decide access. No insert path was added.
- **Privacy:** the wizard writes nothing to localStorage, logs, URLs or toasts, and the test checks that the card draft is unchanged. The test script uses only `Sam Lee`, `sam@example.test`, `Fake …` races and a fake JWT. The real project ref in it is public by design, and all network traffic is answered by the fake.
- **Raw database text:** none is shown in the new code. The card's existing toast with `err.message` is unchanged.
- **Scope:** the diff touches only README, `public/*` and `scripts/check-finish-races.mjs`. Nothing changes under `supabase/` or in `docs/permissions.md`. No secrets were added. Not needed: the wizard adds no permission.

**Scope note.** Intent docs read: `docs/permissions.md`, CONTRIBUTING (Security rules), and README as far as the diff shows it. Missing: separate data-class, secrets and test-coverage docs. The intent audit was run for entries (owner-only update), races (honour system) and `add_race_event`.

**Not checked:** the live database (permissions.md says it hasn't been checked against the database since 2026-10-22), the RLS policy SQL for `entries` (I relied on permissions.md and the client comments), and the spec file. I ran nothing.
~~~~

## Disk-verified outcome (main thread)

- **Nothing above LOW.** Its one LOW (swallowed error, misleading copy at the 30-event limit) matched the reviewer's L1, found independently.
- **Verified:** the diff removes two `innerHTML = ''` and adds none assigned from a variable (0 added). Nothing under `supabase/` changed.
- It used `docs/permissions.md`, CONTRIBUTING and the README as the intent, and named what it could not check (live database, `entries` RLS SQL).
- It put the Other-text limit as hardening, not a finding, with the reason (the database constraint is the real limit). That kept it proportionate.
- It ran nothing and said so.
- **Report length (counted):** round 1: 546 words against a budget of 400. Over budget every time.

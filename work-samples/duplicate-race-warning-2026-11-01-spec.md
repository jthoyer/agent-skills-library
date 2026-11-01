# Spec: "Possible duplicate race" warning (option B), BalanceTRI-app

Stage 1 (Definition). Author: planner. Date: 2026-11-01.
Read in full before writing: `README.md`, `CONTRIBUTING.md`, `AGENTS.md` (BalanceTRI-app), the approved mock
`/tmp/claude-0/-home-user/40116673-7181-5920-b63a-c28884c49f17/scratchpad/dup-check-screens.html`.
Code read: `public/app.js` (state ~146-165, gateButton/applyMemberGating ~357-378, requireSignIn ~652, routing/racePath ~1100-1165,
applyEventTypeFields ~1269, loadRaces ~1328, render filters ~1478-1492, toggleAdd ~2343, daysBetween ~2356, form wiring ~2497-2557,
#editForm submit ~2601), `public/index.html` (#addPanel/#raceForm 171-195, #raceFormFieldsTemplate 592-617, script/link tags 50-51, 621-630),
`public/styles.css` (.sr-only 328, .dialog-footer 396/457, focus ring 402), `public/styles-additions.css` (.member-banner 398),
`public/style-guide.html` (section nav 286-294, #feedback 974+), `eslint.config.mjs`, `package.json`, `.prettierignore`,
`public/shared.js` (`/* exported */` header line 5), `scripts/check-app-ui.mjs`.

## Objective

When a signed-in member presses **Create race** on the add form and the loaded calendar already holds a similar live race,
nothing is created; the amber panel from mock option B replaces the form's buttons, lists the matches, and the member
chooses **Go back** (keep editing) or **Add anyway** (the existing create path runs unchanged).

## Definitions (data rules; hard requirements)

- **Draft**: the add form's `name` (trimmed), `date` (YYYY-MM-DD from the date input) and `eventType` at the moment of submit.
- **Candidate races**: every element of the `races` array as `loadRaces` built it (already excludes `deleted_at` rows), ignoring
  every filter. No new request, no re-load before checking.
- **Bolt race**: draft is Bolt when `eventType === 'Balance Bolt'`; an existing race is Bolt when `eventType === 'Balance Bolt'`
  or `boltColumn === true`.
- **Bolt number**: the first run of digits in the name, compared as an integer (same rule as `boltEmbedUrl`, so "3",
  "BALANCE BOLT #3", "Balance Bolt Race 3" and "03" all give 3).
- **Tidy(name)** for non-Bolt names, in this order: lower-case; strip accents (NFD + drop combining marks, as `slugify` does);
  delete apostrophes (`'` and `’`); treat every other character that is not a letter or digit as a word break; drop standalone
  4-digit tokens from 1900 to 2099 (the year); drop the filler words **`the`, `triathlon`, `race`** (the mock's exact list, whole
  tokens only); join the remaining tokens with single spaces. Digits are never dropped except as the year.
- **Name match**:
  - both non-Bolt: Tidy(draft) and Tidy(existing) are identical and non-empty. (So "Round 1" vs "Round 2" never match.)
  - both Bolt: same Bolt number.
  - one Bolt, one not: never a match.
- **Date match**: `|days between draft.date and existing.date| <= 60`, days computed from plain YYYY-MM-DD dates parsed as UTC
  midnight (as `daysBetween` does), so DST/timezone can never move a race across the boundary. 60 matches; 61 does not.
- **Match** = name match AND date match.
- **Exact**: a match whose date is identical AND (non-Bolt: names equal after trim + lower-case, before tidying;
  Bolt: same Bolt number — see OQ-3).
- **Skip the check entirely** (create as today, no panel) when: Tidy(draft name) is empty (non-Bolt), or the draft is Bolt and its
  name has no digits, or the draft date is not a valid YYYY-MM-DD, or the last load failed (`loadError` set) / has not finished
  (mock state 6: "do not stop the member").
- **Order**: exact matches first, then fewest absolute days apart, then earlier date, then name (A–Z) for a stable order.
  Show the first 3. `more = total − 3` when total > 3.
- **Visibility (Hidden by your view)**: a match is "visible" exactly when `render()` would list it now. Reasons, each evaluated
  against the same inputs `render()` uses (note: `render()` uses the **device-local** date for past/upcoming, not `sydneyToday()`):
  1. view = club and race is not club focus → "You are looking at Club races. This is not a club race, so your list hides it."
  2. when = upcoming and `race.date < today` → "You are looking at Upcoming races. This one has already been run, so your list hides it."
     when = past and `race.date >= today` → "You are looking at Past races. This one is still to come, so your list hides it."
  3. event-type filter set and race type differs → "You are looking at {Filter} races only. This one is a {Type}, so your list hides it."
     (race has no type: see OQ-5)
  4. member, athlete search non-empty, and no entry name contains it (same case-insensitive `includes` as `render()`) →
     "You are searching for {typed text, trimmed}. Nobody called {typed text} has joined this race, so your list hides it."
  Reasons are listed in that order; the second and later sentences start with "Also, " followed by the sentence with its first
  letter lower-cased.

## Wording (from the mock; exact text, Australian English)

| Case | Heading | Line under it |
|---|---|---|
| any exact match among the matches | This race is already listed | A race with the same name and date is already on the calendar. Adding yours will make a second copy. |
| 1 match shown, none exact | Is this race already listed? | We found a similar race on the calendar. Is yours a different one? |
| 2–3 shown, none exact | Is this race already listed? | We found {shown} similar races on the calendar. Is yours a different one? |
| total > 3 | (as above) | plus, under the list: "And {more} more similar races. These 3 are closest to your date." (`more` = 1 → see OQ-6) |

Per match card: race name (wraps, never truncated); event-type badge if it has a type; "Club focus" badge if club focus;
meta line "{Sun 29 Nov 2026} · {relation}" where relation is "{n} day(s) before yours" / "{n} day(s) after yours" (singular for 1),
"Same name, same day" for an exact match, "Same day as yours" for a same-date non-exact match; then either the green tick +
"You can see this race in your list." or the pill "Hidden by your view" + the reason sentence(s); then the link "View this race".
Buttons: **Add anyway** (secondary/grey), **Go back** (primary/yellow). Add anyway in flight reads "Adding…".

## Acceptance criteria

Matcher (unit-tested under `node --test`, fake race data only, `today` passed in — never read from the clock inside the pure code):

1. "Harbour Sprint Triathlon" 2026-11-22 vs existing "The Harbour Sprint 2026" 2026-11-29 → 1 match, not exact, 7 days after.
2. Same name, existing 200 days later → no match. Same name, 60 days apart → match; 61 days apart → no match.
3. Day count across an Australian DST change (e.g. 2026-10-04 vs 2026-09-20) is exactly 14, and the 60/61 boundary holds
   when the two dates straddle 5 Oct 2026 or 5 Apr 2026.
4. "Summer Series Round 2" 2027-01-10 vs "Summer Series Round 1" 2026-12-20 → no match.
5. Bolt draft "3" 2026-12-06 vs existing Bolt "Balance Bolt Race 3" 2026-12-13 → match; vs Bolt "BALANCE BOLT #4" same week →
   no match; Bolt draft "3" vs a non-Bolt race named "3" → no match.
6. Draft "The Race" (tidies to empty) → check skipped (result says skip / no matches), even if an identical race exists on that date.
   Bolt draft with no digits → skipped.
7. Exact: "Harbour Sprint Triathlon" 2026-11-22 vs "harbour sprint triathlon " 2026-11-22 → exact; the result marks exact and
   the heading/lead selected is the exact wording.
8. Five matches → 3 returned in the specified order (exact first, then nearest), `more = 2`, and the "And 2 more…" line is produced.
9. Tidy: case, punctuation ("Coast-to-Coast" = "coast to coast"), apostrophes, year tokens and the three filler words are ignored;
   "70.3" keeps its digits; "Tri" is NOT filler (asserted, so a later change is deliberate).
10. Visibility reasons: one test per reason (club view, upcoming, past, event type, athlete search) with exact sentence text,
    one test joining two reasons with "Also, ", and one test where the race is visible (no reasons). A race dated today is visible
    in Upcoming and hidden in Past (matches `render()`).
11. Candidate list may include races of any date or filter; a race absent from `races` (removed) is never returned.

Panel behaviour (browser; see Risk 1 for how to verify):

12. No match → behaviour identical to today: race created, form reset and closed, list reloaded, toast "{name} added". No panel.
13. Match → no insert request is sent; the panel appears inside `#raceForm` in place of the form's footer (Cancel and Create race
    are not shown while the panel shows); the form fields above stay editable with the draft intact.
14. Focus moves to **Go back**. Go back has `aria-describedby` pointing at the panel heading and the lead line; the panel is a
    `role="group"` labelled by its heading; there is **no** `aria-live` region on the panel (mock state 8: it would read twice).
    Matches are a `<ul>`. The panel is scrolled into view with `behavior: 'auto'` (no smooth scroll).
15. **Go back** and **Escape** pressed with focus anywhere inside the panel: the panel closes, Cancel and Create race return, focus
    lands on Create race, draft untouched, Create race enabled (unless member-gated by `gateButton`).
16. Typing in the name or date field, or changing the event type, while the panel shows closes the panel and restores the footer;
    focus stays in that field. Changes to URL, events or club focus do not close it. The existing `eventType` onchange
    (`applyEventTypeFields`) still runs.
17. **Add anyway** runs the existing create path (same payload built from the current form values, same `addRace`, same success
    handling and toast "{name} added", same error toast "Could not add race: …"). It does not re-run the duplicate check.
    On error the panel stays, Add anyway is re-enabled with its label restored.
18. Double-submit: clicking Add anyway twice (or Enter/Space repeatedly) sends at most one insert; Add anyway and Go back are disabled
    while it is in flight. Pressing Enter in a field while the panel shows never creates a race (it either does nothing or re-shows
    the panel with focus on Go back) and never produces two panels. Create race is disabled while the check + create is in flight, as today.
19. "View this race" is an `<a>` with `href` = the race's existing path (`racePath`), `target="_blank"`, `rel="noopener"`; it opens the
    race in a new tab even when the list hides it; the form, panel and draft are unchanged. Its accessible name **starts with the visible
    text "View this race"** and also contains the race name and "opens in a new tab" (visually hidden text via `.sr-only`).
20. Closing the add form (× or Cancel), or the form being hidden by opening a race or the edit screen, leaves no stale panel: the next
    time the add form opens, the footer shows and no panel is present.
21. `#editForm` never shows the panel and its submit behaviour is byte-for-byte unchanged (it shares `#raceFormFieldsTemplate`, so
    any listener added for the panel must be attached to `#raceForm` only).
22. Signed out: pressing Create race still goes to sign-in first (`requireSignIn` runs before the check), as today.
23. All panel text is set with `textContent`/`createElement` (or cloned from a static `<template>` in index.html and filled with
    `textContent`); no `innerHTML`/`insertAdjacentHTML` built from a variable. `npm run check` passes with no new entry in
    `eslint-suppressions.json`.
24. At 375px wide (and at the 700px breakpoint rules): no horizontal scroll; match cards stack (name, meta, visibility, link each
    on their own line); footer buttons are full width with **Go back on top** (existing `.dialog-footer` column-reverse); every
    button/link ≥ 44px tall; an 80-character race name wraps and both buttons are reachable after one scroll.
25. Visuals follow the mock's `.dup` CSS block: amber `#fdf3de` panel, border `#ecd9a8`, 9px radius, icon colour `#7a5b12`, white
    match cards, the app's existing focus ring. Colour is never the only signal (hidden state has the word pill + sentence).
26. `public/style-guide.html` has a "Duplicate warning" block in the Feedback & states section showing: one visible match, one hidden
    match with its reason, the "And N more" line, and the footer. Static markup, no script.
27. `?v=` bumped on every changed tag in `index.html`: `app.js`, `styles-additions.css` (if CSS added there), and the new script tag
    carries its own `?v=`. Format `YYYYMMDDNN`.
28. `node --test scripts/duplicate-check.test.mjs` passes (see Files). Uses fake names only (e.g. "Harbour Sprint Triathlon").

Nice-to-have (not gating):

- N1. After a successful Add anyway, move focus to the header "Add a race" button (`#heroAddButton`) — mock recommends it; today focus
  is lost when the form hides. If done, do it for the no-match path too.
- N2. If the view/when/type/athlete filter changes while the panel shows, refresh the visibility lines (otherwise they can be stale).
- N3. Have `render()` and the panel share one visibility predicate so they cannot drift (only if it is a small, safe change).

## Non-goals

- No database change, migration, RPC, Edge Function or new network request; no server-side duplicate check.
- No fuzzy matching (typos, "Tri" vs "Triathlon", word order, subsets). Equality after tidying only.
- No checking while typing; the check runs on submit only.
- Never blocks: exact matches still offer Add anyway.
- Not on the edit form; not in the admin console.
- No draft persistence in `sessionStorage`; no "view in same tab".
- Races added by others since the page loaded are not seen (no reload before checking).
- Not fixing: `confirmDialog` accessible name (index.html ~507), `confirmDialog` focus / `.danger-button` margin (shared.js ~172,
  styles-additions.css ~495), the stale SQL tests, `scripts/check-app-ui.mjs`, `scripts/check-admin-ui.mjs`.
- Not adding the new test to `npm run check` / CI (CI runs exactly `npm run check`; changing that is the owner's call — OQ-7).
- No change to `docs/permissions.md` (no permission change).

## Files in scope

| File | Change |
|---|---|
| `public/duplicate-check.js` (new; name is a suggestion) | The pure logic only: tidy, Bolt number, day difference, match + exact + order + cap, visibility reasons, and the wording strings (heading, lead, "more" line, relation, reason sentences). No DOM, no `document`/`window`/`localStorage`, no clock (`today` is a parameter), no reference to app.js globals. Plain script (no `import`/`export`). Its public functions are **top-level `function` declarations** listed in a `/* exported … */` comment, the pattern `shared.js` line 5 already uses so `no-unused-vars` passes. |
| `scripts/duplicate-check.test.mjs` (new) | `node:test` + `node:assert/strict`. Loads the browser file with `node:fs` + `node:vm` (`runInNewContext`/`runInContext`) and reads the functions off the context object, so the browser file needs no `module.exports`. This only works for top-level `function` (or `var`) declarations — a top-level `const`/`let` is NOT visible on the vm context. Run: `node --test scripts/duplicate-check.test.mjs`. Must pass Prettier. |
| `public/index.html` | Add `<script src="duplicate-check.js?v=…">` after `shared.js` and before `app.js`; bump `app.js` and `styles-additions.css` `?v=`. Optionally a static `<template>` for the panel skeleton/icons (inert markup, filled by `textContent`). No change to `#editForm`. |
| `public/app.js` | `#raceForm` submit handler (~2522): after `requireSignIn`, build the draft, call the pure check against `races` with the current `state` filters, `isMember` and the device-local today `render()` uses; on matches build/show the panel and stop; otherwise continue as today. Add anyway reuses the existing create path (extracting it from the handler into a shared helper is expected). Panel close on name/date/eventType input (on `#raceForm` only, without overwriting `f.eventType.onchange`), Escape, Go back. Reset panel in `toggleAdd`. |
| `eslint.config.mjs` | Add the new file's exported function names to the `public/app.js` globals block (as `confirmDialog` is). |
| `public/styles-additions.css` | The `.dup*` rules from the mock (desktop + `@media (max-width: 700px)` variants replacing the mock's `.phone` class selectors), reusing `.member-banner` colours. |
| `public/style-guide.html` | "Duplicate warning" block (AC 26). It loads stylesheets without `?v=`; leave that. |
| `README.md` | Short paragraph describing the warning (what counts as similar, never blocks, client-side only, no DB change) — CONTRIBUTING: README updated in the same PR as the behaviour. |
| `CONTRIBUTING.md` | One row in the "not run by CI" table: changed `public/duplicate-check.js` → `node --test scripts/duplicate-check.test.mjs`. |

## Risk areas

1. **UI can't be exercised pre-merge with real sign-in.** The add form is reachable only signed in, sign-in only works on production,
   previews can't sign in, and merging deploys. `scripts/check-app-ui.mjs` is stale and out of scope. Stage 3 must verify ACs 12–24
   with a throwaway harness in the scratchpad (stub `window.supabase` with a fake session and a fake `races` select, serve `public/`
   locally) or record them as unverified; the PR must say which. Do not commit the harness unless asked.
2. **Visibility drift from `render()`.** `render()` uses the device-local date, a club/all view, type and athlete filters (athlete only
   for members). The panel must use the same inputs; using `sydneyToday()` would disagree near midnight. Duplicated logic will drift
   when someone edits `render()` later (N3 mitigates).
3. **Implicit submission while the panel shows.** Hiding Create race does not reliably stop Enter-in-field submits across browsers;
   the submit handler itself must guard (AC 18). Also the async gap between Add anyway and `loadRaces` is where a second insert hides.
4. **Shared template.** `#raceForm` and `#editForm` clone the same fields and `f.eventType.onchange` is assigned by property; a
   `querySelectorAll('#raceForm,#editForm')`-style hook or a property assignment would leak into edit or clobber `applyEventTypeFields`.
5. **vm loading.** Top-level `const` in the browser file silently disappears from the vm context; the test would then fail with
   "not a function" rather than a clear message. Also `no-unused-vars` flags the new file's functions without the `/* exported */` line.
6. **Bolt names.** Bolt rows are stored as "3" or "BALANCE BOLT #1"; a Bolt race whose `event_type` is not set but `balance_bolt` is
   true must still count as Bolt. Year-stripping must not run on Bolt names.
7. **Accessible name vs. the mock.** The mock's announced name "View Harbour Sprint Triathlon 2026, opens in a new tab" would fail WCAG
   2.5.3 (label in name) if done with `aria-label`; AC 19 requires the name to start with the visible "View this race".
8. **Stale data:** a race added in another tab/by another member since load is not checked (accepted non-goal).

## Source-of-truth reconciliation (findings; none reversed by this spec)

- F1. README "Shareable race URLs" says "a small script at the top of `index.html`'s `<head>` restores the real path"; `index.html`
  has no inline script and `app.js` lines 1–20 say the restore deliberately runs from `app.js`. README is wrong. (eslint.config.mjs
  line 55 comment repeats the "inline" claim.)
- F2. Hosting: README/CONTRIBUTING say Cloudflare; `package.json` description and `app.js` line 1 say GitHub Pages. Code comments stale.
- F3. Mock vs. brief: the mock's keyboard notes close the panel on name, date **or event type** change; the brief lists name and date.
  This spec includes event type (it changes Bolt matching) — consistent with the approved mock, not a reversal.
- F4. CONTRIBUTING says agent-written code adds a test "where one can run"; this spec adds one, and records it in CONTRIBUTING's table
  rather than CI (OQ-7).
None of F1/F2 are in scope to fix here.

## Open questions (for the Integrator; defaults stated so the build is not blocked)

- OQ-1. "Close after tidying" is read as **identical** after tidying (the mock's examples are all identical). Confirm no fuzzy match.
- OQ-2. Filler list is exactly `the`, `triathlon`, `race` (mock). "Tri", "races", "series", "the" variants are not filler. Confirm.
- OQ-3. Bolt "exact" default = same Bolt number + same date (the mock's "same name before tidying" would make "3" vs "BALANCE BOLT #3"
  never exact). Confirm.
- OQ-4. If any match is exact, the exact heading/lead is used for the whole panel even when non-exact matches are listed too. Confirm.
- OQ-5. Event-type reason when the hidden race has no type: default "This one has no event type, so your list hides it."
- OQ-6. Lead count uses the number **shown** (mock code: `n = matches.length`), so 5 matches reads "We found 3 similar races…" then
  "And 2 more…". Alternative: total. And `more = 1` reads "And 1 more similar races" — default: "And 1 more similar race." Confirm.
- OQ-7. Add a `test` npm script and/or run the matcher test in CI? Default: no (CI scope is the owner's call).
- OQ-8. Date format: `Intl` en-AU may render "Sun, 29 Nov 2026" with a comma; the mock shows no comma. Default: match the mock.

## Self-review (red-team unavailable as a tool; self-applied)

Folded in: accessible-name/label-in-name conflict (AC 19, Risk 7); vm `const` trap and `/* exported */` lint need (Files, Risk 5);
`render()` uses device-local today, not Sydney (Definitions, Risk 2); implicit submit while footer hidden (AC 18); `eventType`
onchange clobber and shared template leak (AC 16/21, Risk 4); boundary tests at 60/61 and DST (AC 2–3); stale panel after closing
the form (AC 20); `boltColumn`-only Bolt rows (Definitions); empty-after-tidy suppresses even an exact duplicate (AC 6, stated as owner
rule). Not acted on: filter changes while the panel shows (left as N2 — owner did not ask for it; cost vs. benefit for Integrator).

## Stage 1 Register

| # | Item | Status |
|---|---|---|
| R1 | Spec persisted at this path | done |
| R2 | Owner decisions (B, new tab, focus Go back, Escape, 60 days, numbers, exact warns, cap 3, Bolt by number, empty skip, all live races, hidden reasons) | encoded as hard requirements |
| R3 | Matcher test file + exposure method (`scripts/duplicate-check.test.mjs`, vm-loaded plain script, `/* exported */`) | specified |
| R4 | Browser ACs 12–24 verification route | open — Risk 1 |
| R5 | OQ-1…OQ-8 | open, defaults given |
| R6 | Findings F1–F2 (stale docs/comments) | reported, not in scope |
| R7 | No DB/network/permission change; no docs/permissions.md change | confirmed by reading |

## Handoff Note

1. Established: a testable spec for option B — exact matching rules, wording, 28 checkable ACs, file-by-file scope, and a vm-based way to unit-test a plain browser script with no build step.
2. Needs attention most: the submit handler's two-step flow (guard re-submits, single insert, focus/Escape) and keeping `#editForm` untouched.
3. Biggest risk: the UI can't be signed-in-tested before merge, and merge is release — Stage 3 needs a stubbed local harness or must say ACs 12–24 are unverified.
4. Do not relitigate: the owner's fixed decisions (option B, 60 days, numbers never match, exact never blocks, cap 3, new tab, Go back focus, filler list from the mock).
5. Open: OQ-1…OQ-8 (identity vs. fuzzy, Bolt exact, mixed exact heading, no-type reason, shown vs. total count, CI test, date comma).

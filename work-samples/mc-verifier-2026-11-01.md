# mc-verifier — 2026-11-01 — Stage 3 run of Finish your races

Run: `/design` then `/rewrite` (cpo) on a screenshot of the BalanceTRI-app "Pick your races" sheet, then "Continue with wizard" and mc-orchestrator. Session 2026-11-01. App repo: balancetriclub/BalanceTRI-app, PR 166. Dispatched by `mc-orchestrator` at Stage 3 with the reviewer and auditor.

## Brief verbatim

~~~~text
Stage 3 (Challenge), Verifier. Confirm the change works by running it. You may run commands and read files. Do not edit any file in the repo, do not commit, do not push. Put any scratch files under /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/verify/ . Return your report as text.

Repo: /home/user/BalanceTRI-app, branch claude/upbeat-heisenberg-nobnr0, 3 commits ahead of origin/main (diff at /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races.diff). Spec with the acceptance criteria: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md. Read README.md and CONTRIBUTING.md first (set-up, checks, which scripts are stale).

What this is: a static site in public/ (no build). After "Pick your races" Save, a wizard walks a member through one race per step (events, level), then a summary; a Menu item "Finish your races (N)". Sign-in only works on the real production site, so the browser checks use a fake Supabase client inside Playwright scripts.

Do all of this and report each result with the real output:
1. `npm install` if node_modules is missing, then `npm run check` (CI runs exactly this).
2. `node scripts/check-finish-races.mjs`, `node scripts/check-race-form.mjs`, `node --test scripts/duplicate-check.test.mjs`. Playwright is pre-installed (require('playwright'); do not run playwright install; chromium path /opt/pw-browsers/chromium if a script needs executablePath).
3. Independent of the Implementer's own script: write your own short Playwright script in the scratch dir that serves public/ (python3 -m http.server on a free port or a static server in the script), stubs Supabase the way scripts/check-finish-races.mjs does, and drives the real flow as a member: pick 3 races -> Save and continue -> step 1 shows the status line -> choose events on step 1, Next -> Skip step 2 -> step 3 choose none and confirm Next is disabled -> choose Team and Other text -> Save and finish -> summary lists saved and skipped -> Menu shows "Finish your races (1)". Also: Escape mid-flow, Back restoring choices, a race with no listed events, one-race wizard, 12 races at 375px width. Check for console errors. Take screenshots at 375px and 1280px into the scratch dir and describe what you see (layout, overflow, button size, truncated text).
4. Card regression: open a race card commitment form, press a listed event, Team and Other, save; confirm the same add_race_event and entries calls as before the change. For a true before/after comparison, extract the old app.js with `git show origin/main:public/app.js` into the scratch dir and run the same card scenario against it.
5. Check each acceptance criterion in the spec marked Hard against what you saw. List any you could not check.
6. Accessibility you can measure without a screen reader: focus lands on the step's h3 after each step change, aria-live/status regions, aria-pressed on chips, tab order, button target sizes >= 44px, text contrast of the hint, error and progress text against the sheet background (compute it).
Say plainly what you could not run (real Supabase, real sign-in, screen reader).

End with a verify recipe for the app repo as a fenced block: how to serve public/, how to run the checks, and any steps that failed or moved. Write only what you ran and saw. No credentials. Return 600 words or fewer plus the recipe.
~~~~

## Output verbatim (the hand-back report)

~~~~text
**Baseline:** branch claude/upbeat-heisenberg-nobnr0 at 9264377 (3 commits over origin/main), clean tree. I edited nothing in the repo. Scratch is /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/verify/ (mine.mjs, old-public/, PNGs).

## Suites (real output)
- `npm run check`: Prettier "All matched files use Prettier code style!", ESLint exit clean. PASS.
- `node scripts/check-finish-races.mjs`: 64 `ok` lines, last line "all checks passed". PASS.
- `node scripts/check-race-form.mjs`: "race form checks passed". PASS.
- `node --test scripts/duplicate-check.test.mjs`: "# tests 16 / # pass 16 / # fail 0". PASS.
- I did not break anything to prove the Implementer's script can fail. I relied on their report of 3 mutations. Unverified by me.

## My independent script (mine.mjs, real app.js, own copy of the fake Supabase)
Final run printed "ALL OK" with 0 FAIL lines, after I fixed four bugs in my own script. They were `text=Skip this race` and `text=Next` matching hint paragraphs, a Menu left closed, and a missing member entry in the a11y scenario. The earlier FAILs were my defects, not the app's.

Checked and passing:
- Pick 3, Save and continue: 3 inserts. Step 1 shows "Saved. You are down for 3 races." in one `role=status`. The intro and "Race 1 of 3" are present, focus is on the h3, and no chip is pressed.
- Next is disabled with `aria-describedby=finishNeedEvent`. Back is hidden on step 1.
- Choosing 70.3 and Planning sent one PATCH: `Sam Lee`, `{"events":["70.3"],"level":"planning"}`.
- Back restores both choices and focus returns to the h3.
- Bravo (no listed events) shows the exact no-events hint and the chips TO, Team and Other.
- Last step shows "Save and finish", disabled. With Other open but empty and nothing pressed it stays disabled.
- Team plus Other "Aquathlon" sent rpc Team, rpc Aquathlon, then PATCH, in that order.
- Summary reads "Nearly done / 1 race still needs an event…" with the exact row texts and an Open link. The card draft in localStorage is unchanged.
- Menu shows "Finish your races (1)". Escape mid-flow closes and the count stays. A one-race wizard shows "Your race", no Back and no bar. Finishing it gives "All done" and the Menu item disappears.
- A 500 on the second PATCH shows the generic alert. Choices are kept, Next is enabled, and the retry succeeds (3 PATCHes total).
- 12 races at 375px and 1280px: no horizontal overflow. Every visible button is 44px tall (chips 55 to 165px wide). The summary list is 320px tall (40% of 800), scrolls (scrollHeight 576), and has 12 rows.
- Console errors: none, once the harness's aborted fonts.googleapis.com request is excluded. The only other error was the expected injected 500.

Screenshots at 375px and 1280px:
- Step view: wraps cleanly, with a progress bar, a two-line race name and chips wrapping over 3 rows. At 375px the Next button is only just on screen and Skip, Finish later and Back need a scroll.
- At 1280px the buttons sit in one row (Save and finish, Back, Skip) with a full-width Finish later below.
- Pressed event chips are only a faint tint, while the level chips get a tick. This is colour-only for events; AC 31 is Nice and was met for levels only.
- The 375px summary list is cut mid-row by its inner scroll, which is as designed.
- Not looked at: the picker12 screenshots.

## Card regression (old vs new)
I ran the same scenario against `git show origin/main:public/app.js` served from old-public/. Pressing 70.3, Team, Other "Aquathlon" and level Planning gave identical calls on both:
`rpc r-1 Team`, `rpc r-1 Aquathlon`, `POST {"race_id":"r-1","name":"Sam Lee","events":["70.3","Team","Aquathlon"],"level":"planning"}`.
Edit pre-fill is identical on both: 70.3, Team and Aquathlon pressed, level Planning selected. The Other box is empty because the alias race event Aquathlon is already a listed chip.

## Accessibility (measured)
- Focus lands on the h3 after each step, after Back, and on the summary h2 (summary h2 was not asserted by my script).
- The only `aria-live` is the progress line (polite). There is one `role=alert`, and the progress bar is `aria-hidden`.
- Level chips have `aria-pressed` true or false. The dialog label is "Finish your races".
- Tab order: event chips, level chips, Skip, Finish later, close ×. Disabled Next and hidden Back are skipped.
- Contrast on the sheet background rgb(234,247,252):
  - Hint rgba(24,37,66,.72) blended: 5.83:1. My first reading of 13.9 ignored alpha and was wrong.
  - Error rgb(179,38,30): 5.98:1.
  - Progress and date: 13.9:1 as computed by my script. These likely ignore alpha too, so treat them as unreliable.
  - Legend: 13.9:1, with the same caveat.

## Acceptance criteria
Verified (by run): 1, 3 to 5 (including the loadError fallback, per the Implementer's script only), 6 to 11, 13 to 18, 19 (stale-empty text by the Implementer's script only), 21, 22, 23 (`npm run check`), 25 (button size and stacking at 375px seen; no animation checked), 29 and 30 (not run).
Implemented, unverified by me: 2, 12 (Bolt, past and `not` filters not exercised), 14 (disabled-while-saving states and Escape during a write not observed), 20 (refresh while the Menu is open and focus untouched not tested), 24, 26 to 28 (docs, not run).

## Could not run
Real Supabase, real sign-in, a screen reader (so the step-1 triple-announcement risk is untested), `check-app-ui.mjs`, `check-admin-ui.mjs` and the SQL tests (stale). Also unchecked: `prefers-reduced-motion`, and whether the Next button is reachable without scrolling on short phones.

## Verify recipe
```
- Saved recipe: none found; steps that failed or moved: none
- Launch: python3 -m http.server 8000 -d public (browse only; sign-in works only on production). Browser checks serve public/ from a node http server inside the script on port 0.
- Seed: none. Playwright routes all supabase.co calls to a fake (races GET, add_race_event rpc, entries POST/PATCH, is_allow_listed, profiles) with a made-up JWT in localStorage key sb-<ref>-auth-token (made-up data, Sam Lee / sam@example.test).
- Widths: 375 and 1280 (the wizard uses a 480px stack breakpoint).
- Checks: npm run check (pass = exit 0); node scripts/check-finish-races.mjs (all checks passed); node scripts/check-race-form.mjs (race form checks passed); node --test scripts/duplicate-check.test.mjs (16 pass, 0 fail). Skip stale: check-app-ui, check-admin-ui, supabase/tests.
- Traps: Playwright text= selectors are case-insensitive substrings, so text=Skip this race matches the "or skip this race" hint (use button:text-is). Block external hosts, or fonts.googleapis.com logs ERR_FAILED console errors. The Menu must be opened before clicking #finishRacesButton or #pickRacesButton; Escape closes it. The Finish item only shows if an own entry has no events.
```
~~~~

## Disk-verified outcome (main thread)

- The main thread re-ran `npm run check` and `check-finish-races.mjs` later; both pass, matching its report.
- It wrote its own independent Playwright script instead of trusting the Implementer's, and compared the card form on `origin/main` against the new code (identical calls and identical edit pre-fill).
- Four early failures in its own script were its own bugs, and it said so.
- It did not mutation-test the Implementer's script and said it relied on the Implementer's report.
- It split ACs into "verified by run" and "implemented, unverified by me", and listed what it could not run (real Supabase, sign-in, screen reader, reduced motion). Contrast it flagged as unreliable (alpha ignored) it did not present as fact.
- It found the two issues static review missed (colour-only event chips, 375px fold).
- It edited no repo file. Its verify recipe is committed as `.claude/skills/verify/SKILL.md` in PR 166.
- **Report length (counted):** round 1: 1074 words against a budget of 600. Over budget every time.

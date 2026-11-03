# mc-verifier — 2026-11-03 — race-day tools first build

Same run as `work-samples/mc-reviewer-2026-11-03.md`. Dispatched together with `mc-reviewer` against `docs/spec.md` at commit 37b7ebe.

## Brief (verbatim, condensed only where marked)

> You are the Verifier at Stage 3 of the multi-actor coding playbook. Confirm the code works by running it. Judge only what you have run.
>
> [Same description and spec path as the Reviewer brief.] Check each of the 15 criteria: Pass, Fail or Not checked.
>
> Run: (1) `npm test`; (2) `npm run smoke` (Playwright pre-installed; do not run `playwright install`); (3) your own throwaway Playwright scripts in the scratchpad `verify/` folder, not in the repo; stub Google Fonts; try Heart rate and Effort modes and Standard; fuel with no race, then Save to a race plan; change pace after saving fuel; unreadable and blank inputs; remove every product or set carbs 0; Start a new race; blocked localStorage via `addInitScript`; the two guide pages and their typing; sideways scroll at 390 px; page and console errors. (4) Try to break the fuel.js safety claims through the UI.
>
> Return: at most 700 words; a criteria table with evidence; ranked bugs with repro, observed and expected; exactly what you ran; never say something passed unless you ran it.

## Output (summary of the verbatim report; the full text is in the session transcript)

- Noticed the working tree changed mid-run (the main thread pushed reviewer fixes at 06:40–06:43 UTC). It hashed the file set, dropped its first-pass findings and re-verified on the new tree. It reported the old-tree sip violation as resolved: 3,609 of 200,000 fuzz cases before the fix, 0 after.
- Criteria: 13 Pass, AC5 "Not checked" (it left the sum to the unit tests), AC15 Partial.
- Bugs: (1) a 60-character unbroken race name scrolls sideways, home 1368 px; (2) the last product can't be removed, the defaults re-seed; (3) a blank product field is stored as 0; (4) tap targets under 44 px on home and the card; (5) guide save with blocked storage gives no warning; (6) Start a new race works as designed.
- Fuzz: `planFuel` over 200,000 random valid inputs, no case over the gut or sweat cap, no crashes. XSS probe with `<img onerror>` in the race and product names: nothing injected.
- It wrote a verify recipe with traps, for example that `getByLabel('Sweat rate')` also matches the checkbox.

## Outcome on disk

- Bugs 1, 2, 4 and 5 were real and fixed in commit 100c040. Re-checked: scrollWidth 390 on all nine routes with a 60-letter name, no home target under 44 px, an empty product list stays empty.
- Bug 3 was stale. It came from the pre-fix tree; the main thread re-checked and a blank now stores null with an error shown. Its "re-verified on the new tree" claim did not cover this item.
- One false statement: "The repo is not a git repo, so I can't give a SHA." `/home/user/race-day-tools` is a git repo (`git rev-parse HEAD` works), so it should have reported the SHA.
- Main thread's own fault, noted for routing: it edited the tree while the verifier ran. Dispatch the verifier after fixes land, or pin it to a commit.

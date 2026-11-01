# mc-reviewer — 2026-11-01 — Stage 3b re-review of the fix round

Run: `/design` then `/rewrite` (cpo) on a screenshot of the BalanceTRI-app "Pick your races" sheet, then "Continue with wizard" and mc-orchestrator. Session 2026-11-01. App repo: balancetriclub/BalanceTRI-app, PR 166. Dispatched by `mc-orchestrator` after the fix round, per the rule that a fix is new code.

## Brief verbatim

~~~~text
Stage 3b: re-review a fix round. Static reading only; return findings as text.

A fix is new code. Read this diff (2 commits, on top of the code you already reviewed): /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-fix.diff . Repo: /home/user/BalanceTRI-app (read public/app.js, public/styles-additions.css, public/style-guide.html and scripts/check-finish-races.mjs for context). Spec and registers, including the findings and the Integrator rulings this round answers: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md (see "Stage 3 Register" parts 1 and 2 and "Integrator rulings").

The fix round was meant to do exactly this:
1. M1: closeAuthSheet falls back to #accountMenuButton when the return-focus node is detached. New test scenario.
2. L1: console.error in the wizard's save catch; a message that is one of RACE_CONSTRAINT_MESSAGES is shown as is instead of "Check your connection". New test.
3. L2: wrap the style-guide specimen in .auth-sheet so its rules apply.
4. Pressed event chips in the wizard get the tick marker, scoped so the card form is unchanged (new beyond the spec).
5. .claude/skills/verify/SKILL.md added.

Check:
- Does each fix do what it says, with no side effect? Especially M1: closeAuthSheet is shared by sign-in, account, locked and picker modes. Could the fallback steal focus when it should not move (for example a sheet opened from something other than the Menu, or a sign-out)? Could it throw if #accountMenuButton is absent (signed out)?
- L1: how is "one of RACE_CONSTRAINT_MESSAGES" tested? An exact-string match against a message friendlyWriteError produced is fine; a substring or regex match on raw database text is not. Could raw database text ever reach the member? Is the error still caught and now logged (CONTRIBUTING rule)? Does console.error leak a member name or email (the error objects come from supabase-js)?
- The new CSS selector for the tick (.auth-sheet .finish-race ~ fieldset .choice.selected::before): does it reach only wizard chips, and not the card's chips or the picker? Does it work for both event and level chips without double ticks?
- The style-guide edit: any innerHTML-from-variable (it is static HTML; confirm), any change to unrelated specimens, valid markup (ids unique).
- The new tests: do they discriminate (could they pass with the fix removed)? Any made-up data only?
- The verify SKILL.md: frontmatter valid, nothing false, no credentials or real data.
- Any residue of M1/L1/L2 that the fix did not close.

Return 300 words or fewer: findings ranked Blocker / High / Medium / Low with file:line and fix, or "no findings" per severity. Say what you accepted as clean.
~~~~

## Output verbatim (the hand-back report)

~~~~text
Stage 3b re-review of /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-fix.diff (static read only)

**Blocker:** none.
**High:** none.
**Medium:** none.

**Low**
1. `public/app.js:905`: the Pick your races save loop catches errors with `failed.push({ race, err })` and never logs them. This is the same swallowed-error pattern L1 fixed at :1202, in a sibling path. It is old code, not a regression, so the verdict is *should fix (spec silent: Planner decides)*. Fix: add `console.error('Pick your races save failed:', err)`.

**Clean**
- **M1** (`app.js:660-663`): `?.focus()` cannot throw when signed out. The fallback runs only when the saved node has been removed from the page. A nudge's `activeElement` is `body`, which is always attached, so nothing changes there. Signed out, the button is absent and focus lands where it did before. Picker and wizard both save the Menu button as the return target (lines 464, 547), so the fallback covers both. Sign-out cannot take focus to a missing button. The new test would fail without the fix: `patchEmpty` leads to `refusedEntryWrite`, then `renderAuth`, which leaves the saved node detached.
- **L1**: `Object.values(...).includes(failure.message)` is an exact match against sentences that `friendlyWriteError` produced. Raw database text reaches the member only if it is byte-identical to one of those constants. The error is still caught and is now logged. What gets logged is a rebuilt `Error(message)` with the PostgREST message only; `details` and the row data are dropped. That goes to the member's own console, so no third-party data leaks. The test would fail without the fix, since it expects "Use at most 30…" and would get "Check your connection".
- **Tick CSS** (`styles-additions.css:1016-1017`): `.finish-race` exists only at `app.js:1107`, so the card and the picker are untouched. Level chips match both selectors of one rule, so there is a single `::before` and no double tick.
- **Style guide**: static markup. The wrapper copies the existing sheet specimen at line 1245. No new ids, no `innerHTML`, other specimens untouched.
- **verify SKILL.md**: frontmatter is valid. Data is made up (Sam Lee, sam@example.test), with no credentials. Its claims match the scripts.
- `?v=` bumps are present for both the stylesheet and `app.js`.

**Flagged (not settled by reading):** when a signed-in member opens a sheet from a card control and the card is rebuilt while the sheet is open, focus now goes to the header Menu button rather than to the page body. That is probably better, but it is a spec question. Whether the Team chip actually triggers `add_race_event` in `menuRaces()` is over to the Verifier.

Handoff: all three fixes are closed. One sibling catch with no logging remains (Low 1).
~~~~

## Disk-verified outcome (main thread)

- It cleared M1, L1, L2, the tick CSS, the style-guide edit and the verify recipe, with a reason each. It checked that the M1 fallback cannot throw when signed out, that the L1 message match is exact (not raw database text), and that the CSS selector reaches only wizard chips.
- It found one residue: the picker's save loop catch is never logged (pre-existing, out of scope). The main thread named it in PR 166 and left it.
- It cited `menuRaces()`. That is a real fixture in `scripts/check-finish-races.mjs` (not in `app.js`), so the reference was correct.
- It flagged a behaviour change for a spec decision (focus now goes to the Menu button, not `<body>`) and did not settle it alone.
- **Report length (counted):** round 1: 428 words against a budget of 300. Over budget every time.

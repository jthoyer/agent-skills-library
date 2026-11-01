# mc-reviewer — 2026-11-01 — Stage 3 static review of Finish your races

Run: `/design` then `/rewrite` (cpo) on a screenshot of the BalanceTRI-app "Pick your races" sheet, then "Continue with wizard" and mc-orchestrator. Session 2026-11-01. App repo: balancetriclub/BalanceTRI-app, PR 166. Dispatched by `mc-orchestrator` at Stage 3 with `mc-verifier` and `security-auditor` in the same turn. Diff saved to a file for it (it has no git).

## Brief verbatim

~~~~text
Stage 3 (Challenge), Reviewer. Find the strongest defects by static reading only. Do not run code. Return your findings as text; you hold no write tools.

Spec (the standard to review against): /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md (30 Hard acceptance criteria, non-goals, then Integrator decisions and the Stage 2 register at the end).
Diff under review: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races.diff (3 commits on top of origin/main). Repo: /home/user/BalanceTRI-app (read files there for full context; start with public/app.js).
Project rules: README.md, CONTRIBUTING.md, AGENTS.md in the repo root.

What this is: after "Pick your races" Save, a wizard walks a member through one race per step to choose events and a level, saving each race with addEvent then saveEntry. It adds a Menu item "Finish your races (N)". The race-card event/level chip builder was extracted from makeDetails into shared functions.

Attack these first, in this order:
1. Regression of the race-card commitment form from the extraction (drawChoiceChips, participationOptions): events order, alias relabelling of TO/Team, Other toggle and focus, persist() timing, the edit path that maps stored events back to chips and the Other box.
2. The wizard never touching state.form or persist() (AC 21); any shared mutable state between wizard steps and the card.
3. Focus handling after chips redraw; the onboardingSaving lock and the sheetClosing hook (Escape, close button, backdrop, Finish later, mid-write); the loadRaces call on close.
4. refreshFinishMenuItem and the Menu while it is open: stale count, focus loss, double listeners.
5. Wrong entry name passed to saveEntry (zero rows reads as refusal), partial failure paths, retry after addEvent succeeded and saveEntry failed, Back restoring choices, saved-then-skipped rows in the summary, the "incomplete" filter (AC 12), N=1 wording, picker hand-off when loadRaces fails (AC 5).
6. Each Hard AC: list any not met.
Also note anything the Implementer interpreted differently from the spec (listed at the end of the Stage 2 register) and say whether you accept it.

Return (500 words or fewer): findings ranked Blocker / High / Medium / Low, each with file:line, the failing scenario in one or two sentences, and the fix you would make. Say which ACs you checked and found met. Do not pad; if there is nothing at a severity, say so.
~~~~

## Output verbatim (the hand-back report)

~~~~text
**Reviewer, Stage 3: Finish your races** (static read of the diff plus `public/app.js`, `styles-additions.css` and `style-guide.html`)

I found no Blocker and no High. The extraction, the isolation from `state.form`, the write order and the busy lock all held up when I traced them.

**Blocker:** none.
**High:** none.

**Medium**
None that break an AC. M1 is graded medium but carries the verdict *should fix* (spec silent: Planner decides).

- **M1. Focus is lost when the sheet closes after the Menu has been rebuilt.** `public/app.js:658` (`closeAuthSheet`) only returns focus if `authSheetReturnFocus` is still in the document. Two places rebuild the Menu: `refusedWrite` (1298-1301) calls `renderAuth()`, and so does every auth event (761). Each rebuild replaces `#accountMenuButton`.
  - Scenario: a member gets a refused save in the wizard, then presses Finish later. Focus drops to `<body>` (WCAG 2.4.3).
  - Sites: the wizard refusal path (affected), the picker refusal path (affected, already there before this PR), the Menu item's open path (affected if a token refresh fires during a long run).
  - Fix: if the return target has been detached, fall back to `$('#accountMenuButton')` inside `closeAuthSheet`.

**Low**
- **L1. The wizard never logs the real error.** At app.js:1059-1061 (`catch (err) { failure = err; … }`) the error only picks the message. Anything that isn't a refusal shows "Check your connection", including the `races_events_size` limit. Retrying that one fails forever and leaves no diagnosis, which is against CONTRIBUTING's rule on swallowed errors. The card shows `err.message` instead.
  - Fix: `console.error('Finish your races save failed:', failure)`. The copy stays the same, per Integrator decision 1.
- **L2. The style guide specimen doesn't look like the real thing.** In `style-guide.html` (+1361-1420) the specimen is not inside `.auth-sheet`, but every new rule is scoped `.auth-sheet .finish-*`. So the progress bar has no height (it is invisible), the summary has no 40vh cap, and the fieldset styles don't apply. AC 26 is met as written.
  - Fix: wrap the specimen in `.auth-sheet`, or unscope the rules.

**Completeness gap:** none.

**Attack list, verdicts**
1. **Extraction (risk 1):** it matches the original. The options and alias relabelling are identical, and so are the Other toggle and focus. `persist()` still runs before redraw, and the edit path now calls `participationOptions(race)`. Every reassignment of `state.form` (753, 1611, 2658, 2691) is followed by a render, so no chip ever writes to a stale object. Clean.
2. **AC 21 and shared state:** the wizard has its own selection per step (`recs[i].selection`), and nothing in it reads or writes `state.form` or calls `persist()`. Clean.
3. **The lock and the close hook:**
   - Focus moves to the h3 before the buttons are disabled.
   - `onboardingSaving` blocks Escape, the close button and the backdrop (3282-3297), and it is reset in a `finally`.
   - `sheetClosing` runs on every close.
   - The summary sets `dirty` back to false before it reloads, so the roster is never reloaded twice.
4. **The Menu:** `onclick` is assigned as a property, so there are no double listeners. The count is updated in place. When the item is removed while focused, focus goes back to the Menu button. Clean.
5. **Saving and the summary:**
   - The entry name is `entry.name`, or `myEntry(race)?.name || name` on the picker route.
   - A retry calls `addEvent` again, which is idempotent.
   - Back restores the step's choices, and a race saved then skipped still shows as saved.
   - The filter matches AC 12, the singular wording is right, and when `loadRaces` fails the old Saved screen is shown.
   - All clean.

**ACs**
- AC 1-30: reviewed, no finding.
- These cannot be settled by reading and go to the Verifier: AC 22 (run the script), AC 23 (`npm run check`), and the 44px and stacking parts of AC 25.
- AC 31 (Nice): done.

**Stage 1 risks**
- Member-data writes: clean.
- Extraction: clean.
- Shared state: clean.
- Stale Menu: clean.
- Focus while busy: clean.
- `maybeOpenOnboarding` re-opening: it can't, because `onboardingDue` is already spent.
- Triple announcement: flagged below.

**Flagged areas**
- (a) Each step's progress line is a brand-new `aria-live` element, and the status line is brand new too. Screen readers often ignore live regions inserted with their text already in them, so "Race K of N" may never be announced. Focus does reach the h3. This needs a real screen-reader pass.
- (b) Spec question: a race saved earlier in the run, then revisited and re-saved unsuccessfully, shows as saved with its old values. AC 18's "saved earlier" and "last attempt failed" rows conflict for this case. The Planner should pick one.

**The Implementer's interpretations:** I accept all of them.
- Other text counts only while the box is open. This differs from the card, but no text can stay hidden, so it is safer.
- The fallback Saved screen always uses the plural copy, as the spec's exact copy has it.
- The sheet closes when standing is lost.
- The `Open <race>` aria-label.
- The margin on the Menu count.
- The tick and `aria-pressed` on the card's level chips. Name this card change in the PR.

**Handoff Note**
1. The extraction and isolation held up under tracing. Ask the Verifier for AC 22's run as the guard against card regressions.
2. M1 is a one-line fallback in `closeAuthSheet`.
3. L1 and L2 are cheap; fix them in the same round.
4. The live-region announcement needs a screen-reader pass.
5. The re-save-failed summary row is the Planner's call.
~~~~

## Disk-verified outcome (main thread)

- **M1 was real.** `cody`'s test failed with focus on `<body>` when the fix was removed, then passed. **L1 was real** (the security auditor found it independently). **L2 was real.**
- It followed the brief's six attack areas in order and graded each. It named the two it could not settle by reading (live-region announcement; AC 22/23/25 for the verifier).
- **What it missed:** pressed event chips are colour-only, and the 375px fold. Both need pixels, which a static reviewer lacks. The verifier found them.
- It accepted all of the Implementer's interpretations, with a reason for each.
- **Report length (counted):** round 1: 907 words against a budget of 500. Over budget every time.

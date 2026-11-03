# mc-reviewer — 2026-11-03 — race-day tools first build

Run: `cpo` via `/rewrite`, "Build first two products" (Race Fuel Planner and Race Pacing Planner), repo `jthoyer/race-day-tools`, PR #1. The main thread wrote the spec and the code (embodied Planner and Implementer). `mc-reviewer` and `mc-verifier` were dispatched together against `docs/spec.md` at commit 37b7ebe.

## Brief (verbatim)

> You are the Reviewer at Stage 3 of the multi-actor coding playbook. Find the strongest defects by reading the code. Do not run anything.
>
> What was built: a static, on-device web app for triathletes in /home/user/race-day-tools (branch claude/strategy-race-day-tools-jlbzs2, commit 37b7ebe): a Race Pacing Planner (set-up flow F1–F5) and a Race Fuel Planner (carbs, fluid, sodium per leg, capped at gut tolerance and sweat rate), writing to one printable race card. No build step, no server, localStorage.
>
> Spec: /home/user/race-day-tools/docs/spec.md, 15 acceptance criteria. Files: public/js/pace.js, fuel.js (safety-critical), time.js, store.js, ui.js, app.js, embed.js, index.html, guides, app.css, tests, scripts/smoke.mjs.
>
> Priorities: (1) safety of the advice: can any input or product combination exceed the gut figure or plan fluid above sweat rate; can blank, NaN or extreme values slip through ("null >= 0 is true in JS; one such bug was already fixed"); (2) correctness: legs add up, the state transitions in app.js, crashes on missing state; (3) security: user text as HTML, trusting localStorage; (4) spec gaps. The ranges are deliberately unchecked; report a number only if the logic around it is wrong.
>
> Return: at most 700 words, ranked findings with severity, file:line, defect, concrete failure scenario, one-line fix; end with "Criteria not met:". Only defects you can point to. No praise and no style nits.

## Output (verbatim, as returned)

Four Blockers, four Majors, four Minors:

1. Blocker, fuel.js:129: `sipMl` rounds to the nearest 25 ml, so it can round up past the sweat rate. Sweat 0.25 gave "75 ml every 15 min" (300 ml/h); 0.35–0.39 gave 400 ml/h. Breaks AC10 and AC9. Tests only checked `fluidPerHour`.
2. Blocker, app.js:813: `numIn` stores 0 for a blank or unreadable value. "45g" drink carbs became 0, gels filled to 90 g/h on top of the real drink: about 160 g/h against a gut of 90.
3. Blocker, app.js:491: the saved fuel plan was marked stale only on a split change, so lowering the gut figure from 90 to 50 left the card and print at 90 g/hr.
4. Blocker, pace.js:88: watts rounded to 5 W collapse to one number for low FTPs (FTP 120 gave "90 W"). Breaks AC4.
5. Major, embed.js:139: the fuel guide's example `data-gut="60"` overwrote a saved gut figure; embed.js:71 forced power mode.
6. Major, app.js:741: water-only plans still said "drink".
7. Major, app.js:658: the solo About-you section vanished 400 ms after the first keystroke.
8. Major, app.js:603: product lookup ignored type, so a gel changed to Drink was still used as a gel.
9. Minor, store.js:29: a wrong-shape save crashes every load.
10. Minor, fuel.js:63: gel times can land in the last 10 minutes or past the leg.
11. Minor, app.css:515: "How to test" links 32 px tall.
12. Minor, app.js:493: F5 save opens F6, not Fuel; "the Planner should decide".

Coverage: no finding on AC 1, 2, 5, 6, 7, 11, 12, 13 (except #5), 14; no innerHTML anywhere. Criteria not met: 3, 4, 9, 10, 15 (and 8 if the save is meant to open Fuel directly).

## Outcome on disk

- All 12 findings held up on reading the code. 1–11 were fixed in commit 9534f2a. For #12 the spec was aligned to the blueprint's F6 screen.
- The verifier's 200,000-case fuzz confirmed #1 on the old tree: 3,609 cases with four sips above the sweat rate. It found 0 after the fix.
- No false positives. One true defect the reviewer missed: the store's `blank()` had no `solo` key, so a fuel-only plan was dropped on reload. The main thread found it while fixing #9.

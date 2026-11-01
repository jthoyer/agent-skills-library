# Stage registers: duplicate-race warning (option B)

Spec (Stage 1 register inside it): /tmp/claude-0/-home-user/40116673-7181-5920-b63a-c28884c49f17/scratchpad/spec.md
Mode: delegated (Agent tool present). Planner, Implementer delegated.

## Stage 2 Register (pasted from cody's hand-back, 2026-11-01)

Files, all uncommitted in /home/user/BalanceTRI-app:
- public/duplicate-check.js (new): pure matcher, wording, visibility reasons
- scripts/duplicate-check.test.mjs (new): 16 vm-loaded tests
- public/app.js: createRace extracted from submit handler; findDuplicates, showDupPanel, addAnyway, closeDupPanel, removeDupPanel (from toggleAdd), deviceToday (extracted from render)
- public/index.html: panel + match templates, id=createRaceButton, new script tag, ?v=2026110101 on app.js, styles-additions.css, duplicate-check.js
- public/styles-additions.css: .dup* rules + 700px variants
- public/style-guide.html: Duplicate warning block
- eslint.config.mjs: dupCheck global
- README.md: new section. CONTRIBUTING.md: one table row

Deferred: N1 focus to Add a race after success; N2 refresh reasons on filter change; N3 shared visibility predicate with render(). F1/F2 and confirmDialog defects untouched.
dupDaysBetween duplicates app.js daysBetween (spec: file stands alone).

Claimed output: npm run check clean; node --test 16/16 pass; 5 mutation checks went red then reverted; browser harness (scratchpad/harness/) 21 scenarios x3 runs pass; widths 375/700/701/1200.

Not exercised: real sign-in, real Supabase insert, real /race/<slug> in new tab, screen-reader, onboarding sheet interaction.

Handoff: (1) built option B with OQ defaults; (2) look hardest at submit guard, dupBusy, #raceForm-only listeners; (3) biggest risk: no real signed-in test; merge deploys; (4) do not relitigate OQ decisions; (5) open: N1-N3.

## Stage 3 Register (pasted from agent reports)
Reviewer (delegated, static): M1 medium, breaks AC18: close+reopen while Add anyway writes allowed a second insert (removeDupPanel cleared dupBusy; createRaceButton not disabled). Flag: `change` on name field may close panel on blur. All other ACs met.
Verifier (delegated, ran it): npm run check green; node --test 16/16; harness 21 scenarios + 13 own scenarios pass; mutation (window 60->61) turned tests 2 and 3 red. All ACs passed except AC27 not exercised (checked by Integrator: ?v= bumped). Not exercised: real sign-in, real Supabase insert, device timezone, screen reader.
Fix round 1 (cody): dupBusy kept through write, cleared in finally; Create race disabled during Add anyway; x/Cancel/hero blocked while busy; `input` listener replaces name `change`. Proof: scenarios FAIL on old tree, PASS on fixed.
Re-review 1 (Reviewer): M1 closed. Low: dupBusy held through loadRaces; iOS date `change`.
Fix round 2 (cody): written() callback clears dupBusy after insert; `change` on date added. Proof FAIL->PASS.
Re-review 2 (Reviewer): Low/medium: finally cleared second write's guard.
Fix round 3 (cody): `if (!written) dupBusy = false` in finally. Proof FU3 FAIL->PASS.
No final Reviewer read of the one-line round-3 change by an agent; Integrator read it (app.js 2676-2697).

## Stage 4 Register (Integrator, embodied by main thread)
Final tree: npm run check clean; node --test 16/16; harness 27 PASS x3; verify/mine.mjs PASS V13.
Confidence: Verified in a stubbed browser harness. NOT verified against real sign-in or real Supabase (sign-in only works on production; merge deploys).
Decisions: accepted OQ-1..8 defaults; blocked x/Cancel/hero while a write runs (smallest safe fix); verify recipe NOT saved to the app repo (it points at throwaway scratchpad harness that is not committed).
Open: N1 (focus after success), N2 (reasons refresh on filter change), N3 (shared visibility predicate with render()); typo names do not match; stale data from other tabs not seen.

## Raw evidence: lines pasted from the agents' hand-backs and from the main thread's own runs

Added at close-out so the ledger entry can cite them. Quoted as reported; "main thread" lines are things the conductor ran itself.

### ux-designer (hand-back)
- "I couldn't open it in a browser, so layout and the clickable buttons are untested."
- "Polish score: 8/10 against 'useful, understandable, thorough in every state'."
- Recommended Option B (inline amber panel) with reasons; listed 7 owner decisions; found two defects in existing code: `public/index.html` line 507 (confirmDialog has no accessible name) and `public/shared.js` line 172 (showModal focuses the × button).
- Main thread, running the mock in Playwright: `SyntaxError: Identifier 'top' has already been declared` (the mock's script declared `function top(d)`, which clashes with `window.top`); the page height read 5125 with the script dead. Fix: renamed to `topBar`; page then rendered with no errors (height 15596).

### mc-planner
- Spec saved at `duplicate-race-warning-2026-11-01-spec.md` (28 ACs, OQ-1..8, Risk 3 at spec line 182). Its hand-back named three riskiest points, the third being "A race can still be created twice ... clicking Add anyway twice, must not send a second insert."
- It did not mention that `main` might move. The branch was cut at 08c5ef0; PR 164 (merged 20:43 UTC, 1 Nov) had rewritten the same submit handler, and PR 165 opened with a merge conflict (mergeable_state "dirty"). The main thread ran `git fetch origin main` early but never compared the branch with it.

### cody (Stage 2 hand-back, verbatim)
- "WHERE I'D EXPECT A BUG - Escape or an input edit while Add anyway is writing is deliberately ignored. - `toggleAdd(false)` pressed mid-write clears `dupBusy` and removes the panel. - The footer is hidden with `.hidden`, so Enter in a field relies on the submit guard."
- Fix rounds: round 1 closed M1; round 2 released the flag after the insert; round 3 fixed `finally` clearing a second write's guard. Each with a scenario failing on the old tree.

### mc-reviewer (hand-backs)
- First read: "M1 · medium · blocks merge (breaks AC 18) ... a member presses Add anyway, then × and 'Add a race' while the insert is still running ... Create race → panel → Add anyway sends a second insert."
- Re-read 1: "M1 closed: yes. ... one Low finding." Re-read 2: "`addAnyway`'s `finally` clears a second write's guard."
- "`.claude/references/review-gates.md` was not read this session. I applied this role's own evidence bars."

### mc-verifier (hand-back)
- "AC18: passed. A double-click on Add anyway plus Enter gave exactly 1 insert. Enter in a field while the panel shows gave 0 inserts, 1 panel, and focus on Go back. Create double-click sends 1 insert."
- "ANYTHING THAT LOOKED WRONG: Nothing in the app."
- "My first run had 3 failures, all defects in my test, not the app."
- Verify recipe pointed at `/tmp/claude-0/.../scratchpad/harness` and `.../verify/mine.mjs` (not in the app repo, so the main thread did not save it).
- It did not run the close-and-reopen-while-writing sequence that the Reviewer's M1 describes.

### Outcome
- PR 165 merged 2026-11-01 as 65b6801 (merge commit). `check` workflow passed on the PR head; the Cloudflare "Workers Builds" preview failed in the same second on this PR and on the previous merged PR (161). Real signed-in use not tested before merge.

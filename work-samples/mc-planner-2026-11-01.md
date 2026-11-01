# mc-planner — 2026-11-01 — Stage 1 spec for Finish your races

Run: `/design` then `/rewrite` (cpo) on a screenshot of the BalanceTRI-app "Pick your races" sheet, then "Continue with wizard" and mc-orchestrator. Session 2026-11-01. App repo: balancetriclub/BalanceTRI-app, PR 166. Dispatched by `mc-orchestrator` at Stage 1. Input: the ux-designer spec. Asked to resolve four gaps by reading code and to return a testable spec.

## Brief verbatim

~~~~text
Stage 1 (Definition) for the multi-actor coding playbook. Turn the approved design into a testable build spec. Write no code.

Write the spec to /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md and end it with a Stage 1 Register and the five-line Handoff Note. Return a summary of 300 words or fewer.

Inputs (read all):
- Approved design: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/race-details-flow-spec.md (option A, the wizard; the owner approved it; an event is required to move on; "Skip this race" is the way out).
- Repo: /home/user/BalanceTRI-app (static site in public/, no build, plain scripts). Read README.md, CONTRIBUTING.md and AGENTS.md in full first.
- Code to study: /home/user/BalanceTRI-app/public/app.js lines 717-907 (showOnboarding) and ~2271-2380 (the race-card event/level form, participationOptions, saveEntry/addEntry at ~1008-1037). Also public/styles-additions.css (~891), public/style-guide.html (~1187), public/guides/index.html (~896), and the Menu code near app.js:470.

Resolve these gaps by reading code, and record the answers in the spec as facts with file:line:
1. The field name for an entry's events (entries.events, or how loadRaces maps it) and how "own entry with no events" is detected (isOwnEntry).
2. Whether the Menu item "Finish your races (N)" and the race-card note are in scope for this PR. Recommend one line: keep this PR to the wizard plus the Menu item; the card note only if it is under ~20 lines. Say what you cut.
3. Where the shared event/level control builder should be extracted from, and the smallest safe extraction (the race-card form must behave the same; scripts/check-race-form.mjs covers it).
4. How the wizard handles a race whose events list is empty, and the "Other" free text (it calls addEvent for new events on the race card; decide whether the wizard does the same and say why it is safe).

Constraints to carry into the spec: no migration, no new DB values (levels are considering/planning/locked only); no innerHTML from variables (textContent only); npm run check must pass; bump ?v= on changed script/stylesheet tags in public/index.html; add new classes to public/style-guide.html; update public/guides/index.html wording if the picker flow changes; new CSS class names are in the design spec section 8; never touch main; Balance Bolt races stay out.

Spec format: objective, numbered acceptance criteria (each checkable by reading or running), non-goals, files in scope, risk areas (member data writes: saveEntry UPDATE is RLS-gated to the entry owner), and the exact copy strings from section 7 of the design spec.
~~~~

## Output verbatim (the hand-back report)

~~~~text
I read README.md, CONTRIBUTING.md and AGENTS.md in full before the code. The spec is written: 30 required acceptance criteria and 1 optional, plus non-goals, files in scope, risks, the exact copy, a Stage 1 Register and the Handoff Note. No code was written.

**The four gaps:**
1. **Field and ownership:** the column is `entries.events`, a text array (migration `20260909232345` dropped the old `event` column). `loadRaces` reads it at app.js:1373 and 1400-1405. An entry is yours when `isOwnEntry` matches on `created_by` (app.js:259). "Incomplete" means your own entry with no events, on an upcoming race that isn't Balance Bolt and isn't level `not`.
2. **Scope:** the wizard plus the Menu item; I cut the race-card note. It would fit in about 15 lines, but the race screen already opens your commitment form with no event chosen (app.js:1235-1245) and lists you under "Event TBC".
3. **Extraction:** lift `participationOptions` and the chip drawing out of `makeDetails` (app.js:2284-2339) into two shared functions that never touch `state.form`. The card keeps its own save, edit path and `persist()`.
4. **Empty events and "Other":** a race with no events shows TO, Team and Other plus a hint. The wizard calls `addEvent` then `saveEntry` the same way the card does. That's safe because `add_race_event` is one atomic append that does nothing if the event is already there, and only members can call it.

**Things that change the plan:**
- **No test covers the card's commitment form.** `scripts/check-race-form.mjs` only drives the add and edit race forms, despite what the design says. I made a Playwright check covering the card form, the wizard and the Menu count a hard requirement (AC 22).
- **The Menu goes stale.** It is only redrawn by `renderAuth`, never after `loadRaces`, so the count would be wrong without AC 20.
- **README.md:35 is wrong.** It says `entries.event`; the column is `events`. Fixing that and the Menu list on line 20 is in scope.
- **`style-guide.html` still shows a "Change password" Menu item**, though passwords are gone.
- **Copy the design missed:** "Press Save to try again" has to follow the new button name, and a few singular forms were needed. I added these and marked them in the copy list.

**Open questions for you:** whether to show the database's own limit message on that error, what happens when someone presses Skip after a partial picker failure, whether `not`-level and past entries stay out of the count, whether to remove the stale specimen, where the test lives, and whether the card note becomes a follow-up.

The red-team skill wasn't available, so I did the adversarial pass myself and folded the changes into the spec.

File: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md
~~~~

## Artefact verbatim: finish-races-stage1-spec.md, the run register file (spec, Integrator decisions, Stage 2-4 registers)

~~~~text
# Stage 1 build spec: "Finish your races" (wizard after Pick your races)

Repo: /home/user/BalanceTRI-app. Design input: `race-details-flow-spec.md` (option A, approved by the owner: an event is required to move on, "Skip this race" is the way out). Read for this spec: README.md, CONTRIBUTING.md, AGENTS.md in full; app.js 38-42, 146-269, 404-549, 591-622, 717-1037, 1232-1246, 1367-1453, 1688-1736, 2138-2381; styles.css 270-295; styles-additions.css 891-919; style-guide.html 1177-1209; guides/index.html 724-728, 894-901; scripts/check-race-form.mjs; migrations `entries_multi_event_support`, `add_size_and_value_limits`, `add_race_event_function`. No code was written.

## Objective
After a member saves races in Pick your races, the same sheet walks them through one race at a time to choose an event (required) and a level, saving each race as they go, and a Menu item "Finish your races (N)" reopens that walk for any own upcoming entry still without an event.

## Facts established from the code (answers to the four gaps)

1. **Field name and "own entry with no events".**
   - The column is `entries.events`, `text[] not null default '{}'` (migration `20260909232345_entries_multi_event_support.sql:1-3`, which also drops the old `event` column).
   - `loadRaces` selects `entries(id,name,events,level,created_by)` (app.js:1373) and maps each entry to `events: (e.events || []).map(String)`, `level: String(e.level)` (app.js:1400-1405).
   - Ownership: `isOwnEntry(entry)` is `entry.created_by === session.user.id` (app.js:259-261). `myEntry(race)` (app.js:205-207) finds it.
   - So "own entry with no events" means `isOwnEntry(e) && e.events.length === 0`.
   - Names are only loaded for members (`fullNames = isMember`, app.js:1370). For anyone else `race.entries` is `[]`, so the count is 0.
2. **Scope: the Menu item is in, the card note is out.** Recommendation in one line: this PR is the wizard plus the Menu item, and the race-card note is cut.
   - Why the note is cut: a member opening their own race already gets the commitment form open, with no event selected (`openRaceScreen` sets `commitOpen: !!mine` and `events: mine.events`, app.js:1235-1245). Their row also already sits under the "Event TBC" group (app.js:2145).
   - It would be about 12-18 lines in `buildRoster` (app.js:1703-1732) plus CSS, so it fits the 20-line bar. It adds little, though, and it would be the only change to the roster in this PR.
   - Cut: the card note, its copy ("You have not chosen an event yet. Choose one") and the `.finish-note` class. These are a follow-up if the owner wants them.
3. **Where the shared event/level builder comes from, and the smallest safe extraction.**
   - Source: inside `makeDetails(race)`, the nested `participationOptions()` (app.js:2284-2294) and the chip-drawing part of the nested `update()` (app.js:2295-2339): event chips, the Other toggle and level chips.
   - Both are closures over `race`, `wrap` and the persisted global `state.form`.
   - The smallest safe extraction:
     - (a) Lift `participationOptions` to top level as a pure function of a race's `events` array.
     - (b) Lift chip drawing into one top-level function. It receives:
       - the containers for event chips and level chips,
       - the option list,
       - a selection object `{events: string[], otherOpen: boolean, level: 'considering'|'planning'|'locked'}`,
       - a change callback.
     - It must not read or write `state.form`, call `persist()`, or touch the save button.
   - The card keeps its save handler (app.js:2340-2377), its Other input, its `persist()` calls and its alias-mapping edit path (app.js:2210-2228). It passes `state.form` as the selection.
   - **Correction to the design:** `scripts/check-race-form.mjs` does **not** cover the commitment form. It drives only the add and edit *race* forms (its checks at lines 169-262 are all race name, URL, distances, Bolt and SwimRun). The extraction currently has no automated guard, so AC 22 adds one.
4. **No listed events, and Other.**
   - `participationOptions` always yields `race.events` (with any `to`/`team` alias relabelled) plus "TO (Technical official)" and "Team" (app.js:2286-2293). The card adds an "Other" chip after those (app.js:2313-2324).
   - A race with `events = []` therefore shows TO, Team and Other. Nothing special is needed beyond the hint.
   - The card turns the trimmed Other text into **one** event (no comma split) and saves `unique(chips + other)` (app.js:2354-2355).
   - For each event not already in `race.events`, including TO or Team, the card calls `addEvent` before `saveEntry`/`addEntry` (app.js:2363-2367).
   - **Decision: the wizard does the same, in the same order.**
     - Why: a wizard save must be indistinguishable from a card save. Otherwise a member's Team or Other choice would not appear as a chip on the race card. On a later card edit it would then fall into the Other box (alias mapping, app.js:2213-2219).
     - Why it is safe: `add_race_event` is one atomic `array_append` that does nothing if the event is already there (migration `20261020030740`, lines 30-40), so a retry is idempotent. It is security-invoker under the existing "Members can update races" policy, and execute is granted to `authenticated` only (lines 44-45). The `races_events_size` check (at most 30 events and 1000 characters), the audit, history and bulk-guard triggers all still run. It is the exact call members already make from the card.

## Acceptance criteria
Each criterion can be checked by reading the diff or by running the app or a script. "Hard" means it is required; "Nice" is optional.

**Picker hand-off**
1. (Hard) The picker hint at app.js:872 reads exactly "Tick the races you plan to do. Next you can choose an event and a level for each." The picker's primary button reads "Save and continue", including the idle label passed to `setBusy` (app.js:836). Skip still reads "Skip".
2. (Hard) The partial-failure message (app.js:863) ends "Press Save and continue to try again." instead of "Press Save to try again." (This follows from AC 1 and is not in the design copy.)
3. (Hard) After a picker save in which at least one race saved and the follow-up `loadRaces` succeeded, the wizard opens in the same sheet, in place of the Saved screen.
   - Its race list is: the races saved in this save, in picker order, then every other own incomplete entry (as defined in AC 12), sorted by date and then name. No race appears twice.
4. (Hard) Step 1 of a wizard opened from the picker shows a status line with `role="status"`: "Saved. You are down for N races.", or "Saved. You are down for 1 race." when N is 1. N is the number saved in this save.
5. (Hard) The picker's existing behaviour stays the same in these cases: partial failure (failures listed, failed races ticked, retry), Skip, Escape, and the `!session || !isMember` early return (app.js:857).
   - If the post-save `loadRaces` fails (`loadError` is set), the existing Saved screen is shown instead of the wizard. Its body becomes: "You are down for these races as considering. Choose an event and a level on each race."

**Wizard step**
6. (Hard) Each step shows, in this DOM order:
   - an h2 "Finish your races" (the same on every step);
   - the intro on the first step only: "Choose an event and a level for each race. It takes a minute.";
   - the progress line;
   - an h3 with the race name (set with `textContent`, `tabindex="-1"`);
   - the date via `onboardingDate()`;
   - the Events fieldset, then the Level fieldset;
   - the error line;
   - the buttons Next (or "Save and finish"), Back, "Skip this race", "Finish later".
   - `showStep`'s dialog label stays "Finish your races" on every step.
7. (Hard) Progress text reads "Race K of N", or "Your race" when N is 1. It is in an element with `aria-live="polite"`. Any bar is `aria-hidden="true"`. On each step change, focus moves to the h3.
8. (Hard) Events fieldset:
   - The legend is "Events. Pick one or more."
   - The chips are `participationOptions(race)` followed by "Other". Each chip is a `<button type="button" class="choice">` with `aria-pressed`.
   - No chip is pressed when a step is first shown.
   - "Other" reveals a text input labelled "Other event" (a real `<label>`, not just a placeholder) with placeholder "For example, Aquathlon".
9. (Hard) When the race has no listed events (`race.events.length === 0`), the hint "This race has no listed events. Pick Team or TO, or choose Other." is shown in the Events fieldset.
10. (Hard) Level fieldset:
    - The legend is "Level". It uses `.level-choices` with the three `levels` (app.js:38-42) as `choice level-<key>` buttons with `aria-pressed`.
    - The step preselects the entry's stored level (`considering` after the picker).
    - Only `considering`, `planning` or `locked` is ever written.
11. (Hard) The event list to save is `unique(pressed chips + trimmed Other text)`, the same rule as the card (app.js:2354-2355).
    - While that list is empty, Next or "Save and finish" is disabled. The hint "Choose at least one event, or skip this race." is visible and linked to the button with `aria-describedby`.
    - An Other box that is open but empty adds nothing, and does not block Next when a chip is pressed.

**Who is included**
12. (Hard) An "incomplete" race meets all of these:
    - its date is after `sydneyToday()`;
    - `balanceBolt !== 'Y'` and `!boltColumn`;
    - it has an entry with `isOwnEntry(e)`, `e.events.length === 0` and `e.level !== 'not'`.
    - This is the same date and Bolt filter as `onboardingRaces()` (app.js:732-739). Balance Bolt races never appear.

**Saving**
13. (Hard) On Next or "Save and finish", for that race only:
    - First, `addEvent(race.id, ev)` for each chosen event not in `race.events`.
    - Then `saveEntry(race.id, entryName, events, level)`, where `entryName` is the own entry's `name` from loaded data, or on the picker route the name the picker inserted with.
    - These calls run one after another and never as a batch. `addEntry` is never called from the wizard.
14. (Hard) While those writes run:
    - The primary button shows "Saving…" via `setBusy`.
    - Focus moves to the h3 before the buttons are disabled.
    - Back, "Skip this race" and "Finish later" are disabled.
    - `onboardingSaving` is true, so Escape, the close button and a backdrop click do nothing. It is reset in a `finally`.
15. (Hard) When a save fails, the wizard stays on the step and keeps the member's choices.
    - An error with `role="alert"` appears under the fieldsets. It reads "This race was refused. Tell an admin if this is wrong." for a refusal (the `OWN_ENTRY_ONLY` or "approved members only" errors from `refusedEntryWrite`/`refusedWrite`/`addEvent`'s 42501). Any other error reads "We could not save this race. Check your connection and try again."
    - Next stays enabled for a retry. Skip and Finish later work.
    - If `!session || !isMember` after the failure, the wizard stops, the same way the picker does at app.js:857.
16. (Hard) "Skip this race" makes no write and moves on. On the last step it goes to the summary.
    - Back is hidden on step 1, and in a single-race wizard.
    - Back shows the previous step with that step's earlier choices restored from memory.
17. (Hard) "Finish later" and Escape both close the sheet (Escape only when no write is in flight). Nothing is deleted and there is no confirm. Races saved earlier stay saved.
    - If anything was saved in this run, `loadRaces()` runs on close so the roster and Menu count update.

**Summary**
18. (Hard) After the last step, a summary appears.
    - Heading and status: h2 "All done" with status "Your races are saved." when every race in the run ended saved. Otherwise h2 "Nearly done" with status "N races still need an event. You can finish them any time from the Menu.", or "1 race still needs an event. …" when N is 1.
    - One list item per race, with text set via `textContent`:
      - saved: "<race name> · <events joined ', '> · <level label>";
      - skipped: "<race name> · Event still to choose";
      - last attempt failed: "<race name> · Not saved".
    - Skipped and failed rows carry an Open link built as in `showSaved` (app.js:883-893).
    - A race saved earlier in the run and then revisited and skipped shows as saved, with its last successfully saved values.
    - The list scrolls inside the sheet; a cap of 40vh is the precedent. One "Done" button closes the sheet.
    - Before the summary renders, `loadRaces()` has run if anything was saved.

**Menu**
19. (Hard) The account Menu shows a `button.account-menu-item` "Finish your races (N)" for members only, placed after "Pick your races", and only while N > 0. N is the count from AC 12.
    - It opens the wizard for exactly those races, in date and then name order.
    - If N has gone stale and is 0 when the item is clicked, the sheet shows "Nothing left to finish." and a Close button.
20. (Hard) After every completed `loadRaces()`, the Menu item's visibility and N match the loaded data (today `renderAccountMenu` only runs from `renderAuth`, at app.js:671, 709 and 927, never after a load). Refreshing it must not close an open Menu or move focus.

**Isolation, regression and hygiene**
21. (Hard) The wizard never reads or writes `state.form`, and never calls `persist()` for its own choices. After a full wizard run, `localStorage['balance-race-ui'].form` is unchanged.
22. (Hard) A Playwright check is added, either as scenarios in `scripts/check-race-form.mjs` or in a sibling script that copies its fake-Supabase pattern, with made-up data only (`Sam Lee`, `sam@example.test`). It covers:
    - (a) The card commitment form after extraction. Pressing a listed event, Team and an Other text, then saving, sends `add_race_event` for Team and the Other text only, then one entries POST with `events` in the same order as before. The Edit path pre-fills known chips and the Other box.
    - (b) The wizard. A run through 2 races sends 2 entries PATCHes. Skip sends none. A 500 on the second PATCH shows the error and a retry succeeds. Next is disabled with no event chosen.
    - (c) The Menu count appears and goes away after the race is finished.
23. (Hard) `npm run check` passes, with no new `eslint-suppressions.json` entries.
    - No `innerHTML` is assigned from a variable in new or moved code.
    - The extracted builder clears its containers with `textContent = ''` or `replaceChildren()`. The card's existing `eventChoices.innerHTML = ''` (app.js:2296) and `lc.innerHTML = ''` (app.js:2327) are string literals and may be converted.
    - No new `catch` discards an error.
24. (Hard) `public/index.html` bumps `?v=` on `app.js` (currently `2026110101`, line 634), and on `styles-additions.css` (currently `2026102902`, line 51) if it changes.
25. (Hard) New CSS uses only the design's class names, minus `.finish-note`: `.finish-progress`, `.finish-progress-bar`, `.finish-race`, `.finish-race-date`, `.finish-actions`, `.finish-later`, `.finish-summary`, `.finish-menu-count`.
    - Buttons are at least 44px tall with 8px gaps, and stack full width under 480px with the primary on top.
    - There is no animation, or at most a 100ms fade that `prefers-reduced-motion: reduce` turns off.
26. (Hard) `public/style-guide.html` gets a guide block for the wizard step, the summary and the Menu item that uses every new class. The existing menu specimen (lines 1177-1183) gains "Finish your races (3)".
27. (Hard) `public/guides/index.html`:
    - Lines 896-901 describe the new flow: "Save and continue" leads to one step per race; an event is needed to move on, or "Skip this race"; "Finish later" keeps what is saved.
    - The Menu sentence at lines 724-726 mentions "Finish your races" when you have races without an event.
28. (Hard) README is updated in the same PR (CONTRIBUTING, *Documentation*):
    - The Menu list at line 20 adds "Finish your races (members with races still missing an event)".
    - The entries schema at line 35 says `events` (text array), not `event` (see Findings).
29. (Hard) The comment block at app.js:717-723 is updated so it no longer says events are chosen "on each race afterwards".
30. (Hard) No file under `supabase/` changes, `docs/permissions.md` is unchanged (no read or write rule changes), and nothing is pushed to `main`.
    - The work is on a fresh `feat/` branch cut from an up-to-date `main`, for example `feat/finish-your-races`.
31. (Nice) Level chips show a selected marker that is not colour alone, such as a check glyph or a heavier border. Today's `.choice.selected` (styles.css:286-295) changes only colours.

## Non-goals
- The race-card "no event yet" note and `.finish-note` (cut, see fact 2).
- A level-only save, or any change to `saveEntry`/`addEntry` signatures or meaning.
- Any migration, a new level, a new event value, or any RLS or permission change.
- Changing who Pick your races offers, or when it opens by itself (`maybeOpenOnboarding`, the `balance-onboarding-<id>` flag).
- Balance Bolt races, past races and race-day results.
- Splitting Other text on commas, deduplicating `to` against "TO (Technical official)" in `race.events` (an existing quirk), or adding a length limit to the Other box.
- Rewriting the stale `check-app-ui.mjs` or SQL tests.
- Badges, reminders or notifications beyond the Menu item.

## Files in scope
- `public/app.js`: the picker (717-907), the new wizard, the Menu (448-508), the extraction from `makeDetails` (2284-2339), and the Menu refresh after `loadRaces` (1367-1453).
- `public/styles-additions.css`: new classes next to the onboarding block (891-919).
- `public/index.html`: `?v=` bumps only.
- `public/style-guide.html` and `public/guides/index.html`.
- `README.md`: the Menu line and the schema word.
- `scripts/check-race-form.mjs`, or a new `scripts/check-finish-races.mjs`.

## Risk areas
- **Member data writes.**
  - `saveEntry` is an UPDATE on `(race_id, name)`. RLS gates it to the entry owner (`created_by`) or a two-factor admin (`private.can_change_entry`, restrict_entry_writes_1-5).
  - Zero rows matched is turned into a refusal (app.js:1016). The wizard must pass the entry's own `name`. A wrong name updates nothing and reads as "refused", not as a silent success.
  - `addEvent` writes the **shared** `races` row. Any member can append, so a typo in Other becomes a chip for everyone, exactly as on the card today.
  - If `addEvent` succeeds and `saveEntry` then fails, the race keeps the new event. A retry is idempotent.
- **The extraction regresses the card.** There is no existing test (fact 3). Risks:
  - `participationOptions` alias relabelling;
  - the `aria-pressed` and `selected` classes;
  - the Other toggle focusing the card's input;
  - `persist()` timing;
  - the card re-reading `state.form` after `render()`.
  - AC 22a is the guard. Adding `aria-pressed` to the card's level chips is the one allowed card difference and must be named in the PR.
- **Shared mutable state.** `state.form` is persisted and drives whichever race screen is open. If the wizard writes to it, the card form's draft is lost (AC 21).
- **A stale Menu.** It is drawn before races load at sign-in, so without AC 20 it shows no item, or a wrong N.
- **Focus while busy.** A disabled, focused button drops focus out of the sheet (the precedent comment is at app.js:832-835).
- **Too many announcements on step 1.** Moving focus to the h3, the `role=status` "Saved…" line and the live progress line could all be read together. The progress live region should not announce on first render. Check with a screen reader.
- `loadRaces()` inside the flow calls `render()` behind the sheet. `maybeOpenOnboarding` is already spent (`onboardingDue = false`), so it will not re-open the picker. Keep it that way.

## Copy (exact, from design section 7, minus the card note; additions marked)
- Picker hint: "Tick the races you plan to do. Next you can choose an event and a level for each."
- Picker Save: "Save and continue". Skip: "Skip".
- *(added)* Partial failure tail: "Press Save and continue to try again."
- Step 1 status: "Saved. You are down for 4 races." *(added singular: "Saved. You are down for 1 race.")*
- h2: "Finish your races"
- Intro (step 1 only): "Choose an event and a level for each race. It takes a minute."
- Progress: "Race 2 of 4"; one race: "Your race"
- Events legend: "Events. Pick one or more." Level legend: "Level"
- No-events hint: "This race has no listed events. Pick Team or TO, or choose Other."
- Missing-event hint: "Choose at least one event, or skip this race."
- Other input label: "Other event"; placeholder: "For example, Aquathlon"
- Buttons: "Next", "Back", "Skip this race", "Finish later", "Save and finish", "Saving…"
- Error: "We could not save this race. Check your connection and try again."
- Refused: "This race was refused. Tell an admin if this is wrong."
- Summary, all done: h2 "All done"; status "Your races are saved."
- Summary, with skips: h2 "Nearly done"; status "2 races still need an event. You can finish them any time from the Menu." *(added singular: "1 race still needs an event. You can finish them any time from the Menu.")*
- Rows: "Ironman 70.3 · 70.3, Team · Planning" / "… · Event still to choose" / *(added)* "… · Not saved"
- Menu: "Finish your races (3)"; stale empty: "Nothing left to finish."
- Saved screen fallback body: "You are down for these races as considering. Choose an event and a level on each race."

## Findings: code against the source-of-truth documents
- **README.md:35 against the database and code:** it lists `entries.event`. The column has been `events text[]` since `20260909232345` (which dropped `event`), and app.js reads `events`. Fixed by AC 28.
- **README.md:20** lists the Menu without "Finish your races". Fixed by AC 28.
- **style-guide.html:1180** shows a "Change password" Menu item. Passwords were removed (README *Sign-in*). It is out of scope to fix beyond AC 26, but could be removed in the same edit (Integrator's call).
- **Design spec, line 84 and section 9,** says `check-race-form.mjs` covers the card form. It does not (see fact 3).
- **Design spec status line** says "PROPOSAL … not confirmed by the owner". The orchestrator reports owner approval of option A with an event required. This spec follows the orchestrator.
- No standing decision in AGENTS, CONTRIBUTING or README is reversed.

## Open questions (for the Integrator)
1. Show the database's own limit message (for example "Use at most 30 events…" from `RACE_CONSTRAINT_MESSAGES`) instead of the generic error when `addEvent` hits `races_events_size`? Default in this spec: the generic copy, as the design specifies.
2. After a partial picker failure the member presses Skip. This spec closes the sheet (today's behaviour), and the races saved earlier surface only through the Menu count. Should the wizard start instead?
3. Exclude `level = 'not'` legacy entries and past races from the count (this spec does)? Confirm.
4. Remove the stale "Change password" specimen in this PR?
5. Should the wizard check be a new script or scenarios in `check-race-form.mjs`? Implementer's choice unless the owner prefers one.
6. The card note: confirm it is cut, or bring it back as a follow-up issue.

## Self-review (red-team unavailable, self-applied)
Changes folded in from this pass:
- The false test-coverage assumption, which led to AC 22.
- The stale-Menu problem (AC 20).
- The `state.form` clobber risk (AC 21).
- The "Press Save to try again" copy that follows from the button rename (AC 2).
- Singular copy forms.
- The `loadRaces` failure fallback (AC 5).
- A saved-then-skipped race in the summary (AC 18).
- The disabled-Next explanation (AC 11, via `aria-describedby`).
- The empty-Other rule, aligned to the card rather than the design's "empty Other blocks Next". That test in design section 9.7 now means Other as the only choice, left empty.

Not acted on: the triple-announcement a11y risk. It is left to verification because it needs a screen reader, not a spec rule.

## Stage 1 Register
| Item | Status |
|---|---|
| Spec path | /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races-stage1-spec.md |
| Inputs read | README, CONTRIBUTING, AGENTS (in full); design spec; app.js ranges listed at top; CSS, style-guide, guide, check-race-form.mjs, 3 migrations |
| Gaps 1-4 | Resolved as facts with file:line |
| Scope | Wizard + Menu item; card note cut |
| Hard ACs | 1-30; Nice: 31 |
| DB / RLS change | None |
| Tests not runnable here | Playwright scripts (skip with exit 0 if absent); say so in the PR |
| Open questions | 6 |

## Handoff Note
1. **Established:** `entries.events` (text[]) and `isOwnEntry` by `created_by` are the "incomplete" test. The wizard reuses `saveEntry` + `addEvent` exactly as the card does; scope is the wizard plus the Menu item.
2. **Needs attention most:** extracting the chip builder out of `makeDetails` without touching `state.form`, and adding the card-form regression check (AC 22a), because no test covers that form today.
3. **Biggest risk:** member-data writes. `saveEntry` must use the entry's own name (RLS owner-gated, zero rows reads as refused), and `addEvent` writes the shared race row.
4. **Do not relitigate:** option A, event required with Skip as the exit, no migration or new values, per-race saves, the card note cut.
5. **Still open:** the constraint-error copy, Skip after a partial picker failure, the exclusion of `not`/past entries, the stale "Change password" specimen, where the test lives, and whether the card note becomes a follow-up.

## Integrator decisions on the Stage 1 open questions (main thread, 2026-11-01)
1. Limit error copy: use the generic copy from the design. No new error mapping.
2. Skip after a partial picker failure: close the sheet, as today. Saved races surface through the Menu count.
3. Exclude `level = 'not'` entries and past races from the count: confirmed.
4. Stale "Change password" specimen in style-guide.html: leave it. Out of scope. Name it in the PR as a follow-up.
5. Test location: a new script, `scripts/check-finish-races.mjs`, copying the fake-Supabase pattern from `check-race-form.mjs`.
6. Card note: cut. Follow-up only if the owner asks.
7. Branch: AC 30 says cut a `feat/` branch. The session pins work to `claude/upbeat-heisenberg-nobnr0`, already checked out and level with `main`. Use that branch. Do not create another.
8. Git: Implementer commits locally and does NOT push or open a PR. The main thread pushes and opens the draft PR after Stage 3.

Stage 1 closed. Register saved above. Safe to `/compact` here: Stage 2 opens from this file, not the transcript.

## Stage 2 Register (Implementer `cody`, delegated; pasted from its report)
Commits (local, not pushed): 248ce1c Add Finish your races: choose an event and level after Pick your races; 4d449df Add a browser check for Finish your races and the card commitment form; 9264377 Document Finish your races in the README, style guide and member guide.
Files: public/app.js, public/styles-additions.css, public/index.html (?v= app.js 2026110106, styles-additions 2026110102), scripts/check-finish-races.mjs (new), README.md, public/style-guide.html, public/guides/index.html. Nothing under supabase/, docs/permissions.md untouched, eslint-suppressions.json untouched.
Ran by cody: npm run check pass; check-finish-races.mjs 64 checks ok (plus 3 reruns at 60); 3 mutation checks reverted; check-race-form.mjs pass; duplicate-check.test.mjs 16/16. Not run: check-app-ui, check-admin-ui, supabase/tests/run.sh (stale, no SQL changed). Screenshots at 375/700/1280.
Interpretations: Other text counts only while the Other box is open (card counts it even when closed); fallback Saved screen always plural; standing lost mid-save closes the sheet; summary Open link has aria-label "Open <race>"; .finish-menu-count has a left margin; AC31 done (tick on pressed level chips, also on card chips); card level chips gain aria-pressed.
Handoff: (1) picker -> one-race-per-step wizard + summary + Menu "Finish your races (N)"; chip builder extracted as drawChoiceChips and participationOptions(race). (2) Attention: extracted builder vs card form. (3) Defect likely: focus after chips redraw; the sheetClosing hook (calls loadRaces on Escape); refreshFinishMenuItem while Menu is open. (4) Do not relitigate: Integrator decisions, generic error copy, card note cut. (5) Open: no screen-reader pass; no real Supabase or real sign-in; stale Change password specimen left.
Diff for review: /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/finish-races.diff
Stage 2 closed. Register saved above. Safe to /compact here.

## Stage 3 Register, part 1 (pasted from subagent reports, delegated; verifier still running)
### mc-reviewer (static): no Blocker, no High. AC 1-30 reviewed, no finding. AC 31 done.
- M1 (Medium, should fix): closeAuthSheet (app.js ~658) returns focus only if authSheetReturnFocus is still attached. renderAuth() (refusedWrite ~1298, auth events ~761) replaces #accountMenuButton, so after a refused save then Finish later, focus drops to <body> (WCAG 2.4.3). Fix: fall back to $('#accountMenuButton') when detached. Affects picker path too (pre-existing).
- L1 (Low): wizard catch (~1059) never logs the real error; races_events_size shows "Check your connection". Fix: console.error(...), copy unchanged per decision 1.
- L2 (Low): style-guide specimen is not inside .auth-sheet but new rules are scoped .auth-sheet .finish-*, so bar has no height, summary no 40vh cap. Fix: wrap the specimen in .auth-sheet.
- Flags: (a) each step's aria-live progress line and the status line are inserted already filled, so screen readers may not announce them; needs a real screen-reader pass. (b) AC 18 conflict for a race saved, revisited, re-save failed.
- Interpretations accepted: Other text counts only while box open; plural fallback; sheet closes on lost standing; Open aria-label; Menu count margin; tick and aria-pressed on card level chips (name in PR).
### security-auditor (static): nothing CRITICAL/HIGH/MEDIUM.
- LOW: same as L1 (swallowed error, misleading copy at the 30-event limit). Suggests friendlyWriteError text for constraint errors.
- Hardening, not a finding: Other text is not checked against RACE_LIMITS before addEvent; same as the card; races_events_size is the backstop.
- Clean: no innerHTML sinks (two innerHTML='' replaced by replaceChildren), elt()/textContent only, href via racePath/encodeURIComponent; authorization via isOwnEntry + RLS, UPDATE only, fails closed on 0 rows; no localStorage/log/URL leaks; test data fake; nothing under supabase/ or permissions.md; no secrets.
- Not checked: live DB, entries RLS SQL.
### Integrator rulings (main thread)
- M1, L1, L2: fix in one round.
- L1 copy: add console.error. For a constraint error from addEvent (races_events_size), show the friendlyWriteError message instead of "Check your connection" (a retry can never succeed, so the member must be told why). Overrides Integrator decision 1 for that one case only.
- Flag (b): keep as built. After a failed re-save the database still holds the earlier saved values, so a "saved" row with those values is true.
- Flag (a): cannot settle without a screen reader. Name in PR as unverified.

## Stage 3 Register, part 2: mc-verifier (executed, delegated; pasted summary)
- Ran, all PASS: npm run check; check-finish-races.mjs (64 ok); check-race-form.mjs; duplicate-check.test.mjs 16/16. Did not mutate-test the Implementer's script (relied on cody's report).
- Own independent Playwright script on the real app.js: full flow passes (pick 3, status line, Next disabled with aria-describedby, PATCH body correct, Back restores, no-events race hint, Team + Other order rpc,rpc,PATCH, summary rows, Menu count, Escape, one-race wizard, 500 then retry). Four early FAILs were bugs in the script, not the app.
- Card regression, old origin/main app.js vs new: identical calls and identical edit pre-fill.
- 12 races at 375 and 1280px: no horizontal overflow; buttons 44px; summary list capped at 40% and scrolls.
- Findings from screenshots: pressed EVENT chips show only a faint tint (colour-only; tick exists for level chips only); at 375px Next is barely on screen and Skip / Finish later / Back need a scroll.
- Contrast measured on sheet bg: hint 5.83:1, error 5.98:1. Progress/date/legend 13.9:1 ignores alpha, unreliable.
- ACs verified by run: 1, 3-11, 13-19, 21-23, 25 (size/stack). Unverified by verifier: 2, 12 filters (Bolt/past/not), 14 disabled-while-saving + Escape during write, 20 Menu refresh while open, 24, 26-28 docs.
- Could not run: real Supabase, real sign-in, screen reader, reduced motion, check-app-ui, check-admin-ui, SQL tests.
- Verify recipe saved to /tmp/claude-0/-home-user/fd541a6c-f55d-5471-9c09-6addce317b4a/scratchpad/verify-recipe.md (to be committed as .claude/skills/verify/SKILL.md in the app repo).

## Stage 3b (fix round re-review, mc-reviewer, delegated)
Blocker/High/Medium: none. M1, L1, L2, tick CSS, style-guide edit, verify SKILL.md: closed, clean. Low: picker save loop catch (app.js ~905) never logs; pre-existing, out of scope, named in PR. Flag: focus now falls back to the header Menu button when a sheet opened from a card control loses its return target; accepted as better than <body>.
Main thread re-ran after the fix round: npm run check pass; check-finish-races.mjs all checks passed.

## Stage 4 Register (Integrator, main thread)
- Commits on branch (all pushed before PR): 248ce1c, 4d449df, 9264377 (pushed earlier), b1901c7, 39cf1c6 (fix round).
- Hard ACs: 1-30 met per reviewer (static) and verifier (run) except as listed. Verified by run: 1, 3-11, 13-19, 21-23, 25 (size/stack). Reviewed only (not exercised by verifier): 2, 12 Bolt/past/not filters, 14 disabled-while-saving and Escape during write, 20 Menu refresh while open, 24, 26-28 docs. AC 30 branch rule overridden by decision 7. AC 31 met.
- Open and named in the PR: no screen-reader pass (live regions inserted pre-filled may not be announced); no real Supabase or sign-in; at 375x667 only Save and continue is above the fold, Skip / Finish later / Back need a scroll (not redesigned); stale Change password style-guide specimen; picker save-loop catch not logged (pre-existing); race card "no event" note cut; reduced motion not exercised (no animation added).
- Decisions logged: Integrator section above plus the fix-round rulings.
- DB / RLS / deploy: none. No migration, no supabase/ change, no permissions.md change.
- Checkpoint: registers complete in this file. Safe to /compact.
~~~~

## Disk-verified outcome (main thread)

- **README.md:35 lists `entries.event`; the column is `events`.** Confirmed on `origin/main`; migration `entries_multi_event_support` exists. Fixed in PR 166.
- **The design spec wrongly said `check-race-form.mjs` covers the card form.** Confirmed false (0 matches). The planner turned it into AC 22. This was the most valuable catch of the run.
- **Stale-Menu risk (AC 20).** The reviewer traced it as real and the verifier saw the count appear and disappear. The fix landed.
- Stage 3: the reviewer found no AC unmet (1-30). The verifier ran 1, 3-11, 13-19, 21-23, 25 and found none failing.
- **Contradiction left in the spec.** AC 18 had "saved earlier" and "last attempt failed" rows that conflict for a race saved, revisited and re-saved unsuccessfully. The reviewer flagged it. The main thread ruled "keep as built" (the database still holds the earlier values).
- **Open question 1 was the root of a later defect.** Its default (generic error copy) made a race at the 30-event limit read "Check your connection" (review finding L1). It was flagged as a question, correctly. The main thread overrode it for that one case.
- **AC 30 conflicted with the session.** It asked for a `feat/` branch; the session pins a branch. The planner could not know. The main thread overrode it (decision 7).
- **Line numbers went stale.** PR 165 merged mid-run and added about 290 lines to `app.js`. Not the planner's fault. The build brief told `cody` to find places by name.
- `red-team` was unavailable to the subagent. It ran the adversarial pass itself and said so.
- **Report length (counted):** round 1: 439 words against a budget of 300. Over budget every time.

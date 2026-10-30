# mc-orchestrator run: BBallSkills light redesign (2026-10-30)

Merged as jthoyer/BBallSkills#3 (squash f41390e). The spec is 30 ACs plus Addendum A1, at the scratchpad path below; not copied, because it is 4.5k words.

## Main-thread notes
- **Planner miss:** spec Non-goals said "No height target for the filter block. The designer's 120px target is not adopted". The user picked compact filters BECAUSE the old ones took too much screen space (their words: "alot of screen realestate is taken up with these filters"). The decisions.md handed to the planner said the mock's Option 2 risk was the 131px block, but did not state the 120px target as binding. The built block was 201/257px at 390. That cost a fix round (A1) after the user saw it.
- The Integrator's "not merge-ready" (D-I7) was right: AC4 and the docs had no independent check. Closing them found 2 real doc errors.
- cody built 30 ACs on the first pass with mutation-tested checks. The Reviewer found 0 blocking issues in 3 passes. The Verifier found 0 defects, and its font-fallback test was the main thread's addition.

## decisions.md (brief to the Planner)
# BBallSkills redesign: decisions approved by the user (2026-10-30)

Source mock: /tmp/claude-0/-home-user/404bf4c3-d868-56e1-b6e9-862971b3781f/scratchpad/redesign-mock.html
Source spec: /tmp/claude-0/-home-user/404bf4c3-d868-56e1-b6e9-862971b3781f/scratchpad/redesign-spec.md

The user saw the mock and replied "option 2". The main thread told them it would treat that as approval to build, with the defaults below, and invited corrections. None has arrived so far.

1. Light theme as in the mock: off-white page, white bordered cards, bright orange #FF6A13 for fills only, dark orange #B93C0A for text, links, focus and active states. Inter-like system font stack. Barlow Condensed and its font files are removed.
2. The About tab, page and route are removed. #/about becomes Not found, like any unknown route. A compact footer on every page keeps: the safety line ("No accounts, forms or tracking."), "Videos are public YouTube videos, credited on each drill. Thumbnails load from YouTube.", and the Suggest a drill control. The "how to use" steps are dropped. The tab bar becomes 2 tabs: Drills, Positions.
3. Home is Option A "Find": one list of all 18 drills as photo cards (thumbnail with a pill for level bars, level word and length; orange icon circle; bold title; meta of skill and needs).
4. Filters are **Option 2: three native <select>s** (Skill, Level, Needs) in one row. No counts inside any option label. The count appears only in the result line. When a filter is active, a summary row names every active value and offers Clear all (44px). The Advanced level is hidden while no drill has it (derived from content, not hard-coded). A combination with no results shows an empty state that names why. The mock flagged two Option 2 risks: "Ball handling" truncates, and the block is about 131px with a filter active. The spec must handle the truncation (for example a shorter label, or letting the row wrap or stack at narrow widths). Text must never be cut off.
5. Drill page order: video → facts (level, length, needs) → Do it → cues → why → what it teaches → more drills from this skill. The credit stays.
6. Positions, a position page and the zone page use the schedule-card pattern from the mock.
7. Section headings get the orange rule. Taller cards are accepted.
8. Constraints kept from the current site: no data collection (no forms, inputs other than the filter selects, storage, cookies or analytics). The site already bans <input> and <form>; a <select> is new and the planner must decide whether existing checks forbid it. Hash routing, relative paths, no build step, WCAG 2.1 AA, 44px targets, level never shown by colour alone, contrast measured by scripts/check-contrast.mjs, STYLEGUIDE.md updated.

Defects to fix in passing (found 2026-10-30): router.js:62 (a drill always lights the Skills tab), drill.js:16 (Back ignores origin). The planner decides whether they are in scope.

## Registers (verbatim)
# mc-orchestrator registers: BBallSkills redesign

## Stage 1 Register (Planner, 2026-10-30)

| Field | Value |
|---|---|
| Artefact | /tmp/claude-0/-home-user/404bf4c3-d868-56e1-b6e9-862971b3781f/scratchpad/mc/spec.md |
| Inputs read | decisions.md, redesign-mock.html (Option 2 frames; drill, positions and position frames), redesign-spec.md, BBallSkills README.md, STYLEGUIDE.md, .claude/skills/verify/SKILL.md, site/index.html, css/*, js/*, js/views/*, scripts/check-content.mjs, check-contrast.mjs, check-site.cjs, .github/workflows/pages.yml |
| Acceptance criteria | 30 (AC1 to AC30); 29 hard, 1 nice to have (AC27) |
| Decisions made by Planner | D-a h1 above the video; D-b explicit `setup` field (solo/partner/hoop), with optional partner tagged both; D-c in-memory filter state, `#/skills/:slug` sets Skill only; D-d both defects (router.js:62, drill.js:16) in scope via a remembered "origin"; D-e selects at every width, tab bar stays at the bottom; D-f "Show all drills" with no number; D-g title "Find a drill", "Go to drills" |
| Check changes | check-site: AC23 narrowed only to allow 3 selects on the Find view (recorded); every other change keeps or strengthens a rule. check-content: adds fonts, `#/about`, ellipsis and colour-literal bans, plus `setup` rules. check-contrast: rewritten pair list with pill compositing and an exempt list; floors unchanged |
| Web content used | None (no fetch or search) |
| Red-team | Skill unavailable, so self-applied; findings folded in (see the spec's Open questions) |
| Blocking open questions | None |
| Status | Ready for Stage 2 (Implementer) |

### Handoff Note (Stage 1)
1. Established: a 30-AC spec for the light redesign with Option 2 selects, About removed, a footer and 2 tabs, and every check-script change listed line by line.
2. Needs the most attention: the Find view's select behaviour (focus kept on change, one announcement, Clear all moves focus to Skill, no text truncation at 320 with a 20% margin).
3. Biggest risk: native select text and the pill being clipped on real devices, and focus lost by a repaint that includes the selects.
4. Do not relitigate: the binding decisions (light theme, Option 2, About removed, drill order, no storage), and the check-site select narrowing as written in AC26.
5. Still open: Integrator sign-off on Planner defaults D-a to D-g. None of them blocks the build.

## Stage 2 Register (Implementer, 2026-10-30)

| Field | Value |
|---|---|
| Branch | claude/funny-brown-u90uvq, 3 commits, not pushed |
| ACs | AC1-AC30 built; none deferred |
| Checks | check-content 983/0; check-contrast 20 pairings/0; check-site 3678/0 on 3 runs |
| Mutations | 13 site/content/contrast mutants killed; M3 (double announce) survived until the observer counted records, then killed; "partner present" guard condition is redundant |
| Screenshots | mc/shots/ (14 files) |
| Self-review | code-review skill unavailable, self-read |

### Handoff Note (Stage 2)
1. Built: all 30 ACs; Find view with three selects, origin-aware drill Back/tab, footer, 2 tabs, light tokens, About and fonts removed.
2. Needs the most attention: select width at 384-430px (worst option 0.84 of inner width at 390) and native select rendering on real devices.
3. Biggest risk: filter block is tall when stacked below 384px (about 292px idle at 320).
4. Not relitigated: decisions and D-a to D-g.
5. Open: verify SKILL.md not edited; suggest adding trap "selects need selectOption, not click".

---
## Stage 3a: Reviewer report (pasted verbatim from mc-reviewer's text return by the main thread)

Method caveat: it could not run git, so it reviewed the branch-head working tree against the spec. The D-d before/after comparison was inferred, not read.
Findings: none block merge.
1. Low, completeness gap: scripts/check-content.mjs:57-63. Nothing enforces the positive side of D-b. A future drill with needs ['Ball','Flat floor'] tagged ['partner'] would pass and drop out of Just me. The fix is one rule: no partner, group or hoop in needs → solo is required. The spec is silent; the Planner decides.
Coverage: router.js, skills.js, drill.js, positions.js, notFound.js, ui.js, interactions.js, app.js, index.html in full. Parts of components.css, base.css, content.js, check-content.mjs, check-site.cjs.
Origin and Back sound (no loop; deep-link fallback; hrefs only from validated slugs). Filter state is module-held and restored on Back. Setup counts are solo 10, partner 8, hoop 1. One announce per change and none on syncSelects. Focus is kept and Clear focuses #f-skill. About references are intentional only. XSS: every interpolation goes through esc, lookups use hasOwn. Check scripts: FORBIDDEN extended, select rule narrowed to Find only. Zone list semantics are valid.
Per AC: AC7, 9-12, 15-22, 24-26 and 30 reviewed with no finding (AC30 gap above). AC1-6, 8, 13, 14, 23 and 27-29 go to the Verifier.
Flagged: (a) the .video__play inset focus ring over a real photo (components.css:279) can't be settled by reading; (b) a pasted drill URL while the origin is a position gives Back "Point guard", which Behaviour B doesn't cover.
Handoff: 1 no blocking findings; 2 reviewed files, not the diff lines; 3 the Verifier should weight AC13, AC4, AC23; 4 the Planner decides finding 1; 5 nothing to escalate.

---
## Stage 3b: Verifier report (pasted by the main thread from mc-verifier's text return; condensed only where noted)

Baseline 641861d, served on port 8790.
Repo checks, verbatim summaries: check-content `983 checks, 0 failed`; check-contrast `20 pairings, 0 failed` (lowest 3.87, focus on thumb); check-site, 3 runs, `3678 checks, 0 failed` each.
Own suite /tmp/vv/v.cjs: `MY SUITE: 351 checks, 0 failed`, run twice. The first runs' failures were test defects (focus asserted before focus; a Back-link race), fixed in the script, not the site. Advanced appears through a page.route rewrite at 4 widths. 30 zero-result combinations, each with a reason.
Mutation on a scratch copy: Needs ignores setup → caught (TimeoutError, non-zero exit, not a clean FAIL line). Tab always Drills → 4 FAILs. Restored → green.
Per AC: AC1 PASS. AC2-6, 7, 15, 17-21 and 27-30 PASS (repo only). AC8-14, 16, 22, 24 and 26 PASS (own suite). AC23 PASS (own, footer above the tab bar on 8 routes). AC25 PARTIAL-own, rest repo. AC4, AC9 visual distinctness and AC10 announce-once: NOT RUN independently.
Defects: none.
Filter heights (h1 rule bottom → first card): 320 idle 278, one filter 334; 390 idle 201, one filter 257; 430 the same as 390.
Recipe: the existing SKILL.md steps still work. Proposed trap additions: selects need selectOption, not click; selectOption does not focus; wait about 250ms after navigation before reading .back.
Handoff: 1 verified green, own 351-check suite; 2 mutations caught; 3 several ACs repo-only; 4 the filter block is tall at 320/390; 5 no defects, real-device selects unverified.

## Stage 3 Register (main thread)
- Ran concurrently: Reviewer and Verifier were dispatched in one turn, delegated.
- Resolved: no blocking findings, no conflict between Reviewer and Verifier.
- Open: (1) the Reviewer's low finding, the positive solo rule (spec silent). (2) The filter block height at 390 is 201/257px, against the user's "a lot of screen real estate" complaint, and the planner dropped the height target. This is put to the user as a design decision before Stage 4.

---
## Integrator decision log (main thread holds Integrator decision rights)
- D-I1 (2026-10-30): the Stage 3 open item, filter height, went to the user. The user approved compact one-row filters. The spec gained Addendum A1 (AC8a, AC8b, AC9a, AC13a, AC31). A fix round is opened: cody builds A1. mc-reviewer re-reads the fix diff, and mc-verifier re-runs the affected ACs plus the full suites.
- D-I2: the Reviewer's low finding (the positive solo rule) is accepted into the fix round. It is one rule in check-content: with no partner, group or hoop in needs, solo is required. It costs little and protects the Just me filter from future content edits.

## Stage 2 fix-round register (Implementer, 2026-10-30)
- Built: Addendum A1 (AC8a, AC8b, AC9a, AC13a, AC31) and D-I2. Commit 3 on the branch (hash in the return message); not pushed.
- Labels shortened: Needs "Partner or group" -> "Partner"; first Needs option "Any" -> "Any kit". Visible labels removed (visually-hidden label for kept). Summary row removed; Clear all on the result line.
- Heights (h1 rule to first card): 122px at 360/390/430 idle, 1 and 3 filters; 174px at 320.
- Checks: check-content 993/0, check-contrast 20/0, check-site 3718/0 x3.
- Mutations: needs column narrowed (AC13a), result row margin (AC31), result row block (AC31), breakpoint 30em (AC31/AC8a), hundred-dribble solo->partner (D-I2). All killed.
- Not verified: real-device select text; at 360 the worst option uses 0.94 of its box.

---
## Stage 3a (fix round ac44d53): Reviewer report (pasted by the main thread from mc-reviewer's text return, condensed)
Findings: none. It read the working tree (it can't run git) and grepped base.css and STYLEGUIDE.md.
Coverage: hidden labels match their selects and use clip, not display:none (skills.js:61,63; base.css:29-37; check-site:473). Clear all is absent when idle, focus goes to #f-skill after the repaint (interactions.js:48-55), it announces once, and it is 44×44. Active style is orange fill + ink border + weight 700 + the value text, so not colour alone (components.css:230). The Partner rename is consistent. No dead summary code; check-site:520 asserts its absence. The D-I2 rule is correct (check-content.mjs:59-65), and the optional-partner drill is fine. The AC13a probe measures at the computed font, and 320 is stricter (0.8). The AC31 measures are sound. Escaping unchanged.
Flagged: (a) the D-I2 match on "Partner (optional)" is exact, so variant wording would reject solo (a hunch; no current content). (b) Native select padding on real devices can't be settled by reading; 0.94 at 360 is the place to watch.
Handoff: no findings; files, not a diff; the Verifier should check AC13a at 360 and AC31; D-I2 scope is right; nothing to escalate.

- D-I3 (2026-10-30): the user asked for the active-filter orange at about 30%. cody was dispatched for a tint token on the active select only. Note: it edits the working tree while the fix-round Verifier is mid-run on ac44d53. The change is colour-only, so the fit and height results stand. Contrast and the full suites get a main-thread re-run on the final head before Stage 4.

---
## Stage 3b (fix round): Verifier report (pasted by the main thread from mc-verifier, condensed)
Baseline ac44d53 plus a concurrent colour edit (D-I3) mid-run. UI results were identical before and after.
Verbatim: check-content `993 checks, 0 failed`; check-contrast `20 pairings, 0 failed` (before) and `23 pairings, 0 failed` (after); check-site 3 runs `3718 checks, 0 failed` (early tree); a fourth run on the edited tree is unfinished. Own suite scratchpad/v2/a1.cjs: `398 passed, 0 failed` at 6 widths, re-run after the edits.
AC8a, AC8b, AC9a, AC13a (Inter, worst 0.935 at 360), AC31 (122px at 360/390/430, idle, 1 and 3 filters), AC10, AC11 (one #status record) and AC14: Verified.
Font fallback, worst ratio at 360/390: Liberation (Arial metrics) 0.935/0.837, no clip. DejaVu (wide, pessimistic) 1.105/0.989, clips at 360. Roboto is not installed here.
Mutations: removed skill.focus → red; double announce → red.
Defects: none confirmed.

## Integrator decision log (continued)
- D-I4: DejaVu-width clipping at 360 is accepted as a known limitation, not a defect. Phone system fonts (Roboto, SF) are not DejaVu-wide, and the Arial-metric fallback fits at 0.935. It is recorded in the PR as "real-device check owed at 360px". No layout change.
- Saved verify recipe update for Stage 4: add the Verifier's traps (canvas text measure, not select scrollWidth; selectOption, not click, and it doesn't focus; check-site >100 s, run it in the background; font-injection fallback test; Roboto not installed).
- Active-select tint fix (2026-10-30): --color-accent-tint #FFD2B8 as the active select fill; contrast 23/0 (ink 12.82, focus 4.08); check-site 3718/0 x3; mutation (dark tint) fails 3 pairings.

---
## Fix round 2 (D-I3 tint): review + main-thread run
- Reviewer on f8de61d: one low finding. Three labels still named the active select as full orange (STYLEGUIDE.md:14,40; check-contrast.mjs:57; check-site.cjs:890). The hex, AC6, AC9a, the pin and AC3 table checks were all correct.
- Main thread fixed the labels in fbb1e4a (mechanical, wording and assert message only; each anchor matched exactly once). The Verifier's traps were saved to .claude/skills/verify/SKILL.md in the same commit.
- Main-thread run on f8de61d, clean tree, verbatim: `993 checks, 0 failed`; `23 pairings, 0 failed`; check-site ×3 `3718 checks, 0 failed`. After fbb1e4a: check-contrast `23 pairings, 0 failed`; `node --check scripts/check-site.cjs` OK. The check-site change in fbb1e4a is an assert message string only.

---
## Stage 4 Register (Integrator, 2026-10-30, archival)

Head fbb1e4a on claude/funny-brown-u90uvq. Draft PR #3 (base main). PR body: /tmp/claude-0/-home-user/404bf4c3-d868-56e1-b6e9-862971b3781f/scratchpad/mc/pr-body.md. The Integrator wrote and reviewed no code. Merge is the user's call ("show me the build before merging").

### Grading policy for "repo-suite only" ACs (decision D-I6)
A repo-suite PASS means the Verifier ran a script the Implementer wrote in this change. It counts as Verified only if a second source exists: a Reviewer pass on the AC or an independent run. With neither, it is **one source**. That is enough for deterministic grep/token checks with shown discrimination (mutations). It is not enough for visual or prose criteria. Also: no script reads README.md or STYLEGUIDE.md (Integrator grep of scripts/ for both names: no matches). So the Verifier's "AC28-29 PASS (repo only)" has no script behind it and is not counted.

### Per-AC grades (R = Reviewer, V = Verifier, own = Verifier's independent suite, repo = repo checks run by V)
| AC | Grade | Evidence |
|---|---|---|
| AC1 | Verified, with gap | V ran all three green (983/20/3678, then 993/23/3718). Main thread ran on f8de61d. On fbb1e4a only check-contrast (23/0) and `node --check` re-ran. |
| AC2 | Verified, one source | repo only. R2 (fix round 2) checked the tint hex only. Deterministic token check. Enough. |
| AC3 | Verified | repo 23/0; mutation (dark tint) fails 3 pairings; R2 checked the AC3 table. |
| AC4 | **Implemented, unverified** | repo only; V: "NOT RUN independently". R not reached; R flag (a) said the play ring over a photo can't be settled by reading. Could be observed at 390. Gap. D-I3 tint (focus on tint 4.08) eases the select case, not Do it or play. |
| AC5 | Verified, one source | repo only (font-request and grep checks). Deterministic. Enough. |
| AC6 | Verified | repo; R2 checked AC6 after the tint. |
| AC7 | Verified | repo + R round 1. |
| AC8 | Verified (labels superseded by AC8a) | own suite (option lists, Advanced via page.route at 4 widths); fix-round R read the hidden labels. |
| AC8a | Verified | fix-round own suite + fix-round R. |
| AC8b | Verified | fix-round own suite + R (Partner rename consistent). |
| AC9 | Verified (summary row superseded by AC9a) | own suite + R round 1. Visual distinctness was NOT RUN in round 1; covered by AC9a. |
| AC9a | Verified | fix-round own suite + fix-round R (not colour alone, components.css:230) + R2. |
| AC10 | Verified | round 1 own + R; announce-once re-verified in fix round with mutation (double announce → red). |
| AC11 | Verified | own + R; fix round mutation (skill.focus removed → red). |
| AC12 | Verified | own (30 zero-result combos with reasons) + R. |
| AC13 | Verified (select fit superseded by AC13a) | own + Verifier; R not reached in round 1, R fix round read the probe. |
| AC13a | Verified, ceiling noted | own at 6 widths (worst 0.935 at 360, Inter/Liberation) + R. Real-device fonts not runnable here: known limit D-I4. |
| AC14 | Verified, one source | own at all widths incl. after filters. Independent and deterministic. Enough. |
| AC15 | Verified | repo + R. |
| AC16 | Verified | own (a)-(e) + R. Out-of-scope case noted below. |
| AC17-AC21 | Verified | repo + R round 1. |
| AC22 | Verified | own + R. |
| AC23 | Verified, one source | own (footer above tab bar, 8 routes). Independent run. Enough. |
| AC24 | Verified | own + R. |
| AC25 | Verified | own (partial) + repo + R. |
| AC26 | Verified | own + R. |
| AC27 [N] | Verified, one source | repo only. Nice-to-have; deterministic. Enough. |
| AC28 | **Implemented, unverified** | No script reads STYLEGUIDE. R2 checked the tint rows and the contrast table only. Integrator grep (not a review): no "Barlow", "Arena", "Filtered by", "summary row" or "Partner or group"; token table has accent-tint; table ends "23 pairings, 0 failed". Full AC28 read owed. |
| AC29 | **Implemented, unverified** | No script reads README; no R pass. Integrator grep: `setup` rules and "Partner" label present; `#/about` note present. Full AC29 read owed. |
| AC30 | Verified | repo + R; D-I2 rule re-read by fix-round R; mutation (hundred-dribble solo→partner) killed. |
| AC31 | Verified | fix-round own (122px at 360/390/430, idle/1/3 filters; 174 at 320) + R. |

No AC is Asserted done. No AC is Parity-reviewed: everything here can run locally.

### Stage 1 ranked risks: rulings
1. Real-device select text: not runnable here → known limit (D-I4).
2. Focus loss on repaint: Verified (AC10/AC11, mutation).
3. Origin vs browser Back/Forward "doesn't throw": R only ("Origin and Back sound"); no run named it. One source → known limit, low.
4. Live-region duplicates: Verified (one #status record; mutation).
5. Contrast parser: Verified (23/0; mutation).
6. Rings clipped by overflow:hidden at 3-up and 320: not observed → tied to AC4 gap.
7. Lazy thumbnails, no request for removed/invalid: Verified (AC7).
8. Footer Suggest bound outside #view: Verified (AC23).
9. check-site order-sensitive: three identical green runs each round; ruled no issue.
Handoff items: Stage 2 "verify SKILL.md not edited" → closed in fbb1e4a. Stage 2 "filter block tall" → closed by A1. R flag (b) pasted drill URL with position origin → known limit. Fix-round R flag (a) exact "Partner (optional)" match → known limit (fails closed). security-auditor: not required (no auth, payments or member data); not run; no gap.

### Decision log
| # | Stage | Actors in Conflict | Issue | Decision | Rationale |
|---|---|---|---|---|---|
| D-I1 | 3 | Verifier measurement vs Planner non-goal | Filter block 201/257px at 390 against the user's space complaint | Addendum A1; fix round | User approved; logged by main thread. |
| D-I2 | 3 | Reviewer vs silent spec | Positive `solo` rule | Accepted into fix round | One rule; protects Just me. |
| D-I3 | 3 | User request mid-verification | Active fill at ~30% orange | Tint token #FFD2B8 | Colour-only; contrast re-run 23/0. |
| D-I4 | 3 | Verifier (DejaVu clips at 360) vs AC13a | Fallback-font clipping | Known limit, real-device check owed | Phone fonts are not DejaVu-wide; Arial metrics fit at 0.935. |
| D-I5 | 4 | Planner defaults (open item) | Sign-off on D-a to D-g | All seven signed off | Each is the simplest reading of decisions.md; none was challenged by R or V. |
| D-I6 | 4 | Verifier "PASS (repo only)" vs one-source rule | Is repo-only enough? | Enough for deterministic checks (AC2, 5, 27); not for AC4 (visual) or AC28-29 (no script reads the docs) | A PASS needs a script that tests the criterion. |
| D-I7 | 4 | Integrator gate | Merge readiness | **Not merge-ready** until: (1) V observes AC4 at 390 (active select, Do it, play ring); (2) R reads README/STYLEGUIDE against AC28/AC29; (3) check-content and check-site ×1 run on fbb1e4a | Pages deploys main with no checks. Each gap is cheap. No defect is open. |

### What shipped / Verified / limits / open
- Shipped (on branch, not merged): light redesign, Find view, A1 compact filters, tint, About removed, footer, 2 tabs, checks and docs.
- Verified: 32 of 35 graded ACs (5 are one-source but accepted).
- Known limits: real-device select text (0.94 at 360; DejaVu clips); pasted drill URL with position origin; exact "Partner (optional)" match; browser Back/Forward origin not run.
- Open: D-I7 items 1-3; the user's own look at the build.

### Register completeness check
This file holds the Stage 1, Stage 2 (+ fix-round), Stage 3 (3a/3b, both fix rounds, main-thread register) and Stage 4 registers. The Verifier's per-AC verdicts are present (Stage 3b "Per AC" line and fix-round line). Gap: neither Verifier report is verbatim (both "condensed"); the original per-AC list is held here only in condensed form. Treated as adequate for grading. Not a missing register.

### Handoff Note (Stage 4)
1. Established: every AC graded; 32 of 35 Verified, AC4/AC28/AC29 Implemented, unverified; none Asserted done.
2. Needs the most attention: AC4 focus rings next to orange, observed at 390.
3. Biggest risk: native select text on real phones at 360px (D-I4).
4. Do not relitigate: D-a to D-g, D-I1 to D-I4, and D-I6's one-source rule.
5. Still open: D-I7 items 1-3, then the user views the build and decides on merge.

---
## D-I7 gap closure (after Integrator's "not merge-ready")
1. AC4: Verifier, delegated, by eye and pixel at 390/1280. Ring #B93C0A 3px. 5.20 on bg, 5.65 on the tab, 3.87 on the play placeholder. No ring touches an accent fill. Do it is not focusable. PASS. History goBack/goForward: origin label, href and tab are restored after Forward. Filters and list are restored on Back, and focus is on #page-title. No defects.
2. AC28/AC29: Reviewer read both docs against the spec. Two low findings: the README hoop rule disagreed with check-content, and the STYLEGUIDE fit widths omitted 360/430 and didn't note the D-I4 limit. Main thread fixed both in 8747e7b (docs only). The tint-era rendered sweep was re-run by the main thread with filters set: text floor 5.20, so the STYLEGUIDE line 70 figure stands.
3. Final-head checks (fbb1e4a; 8747e7b is docs only), verbatim: `993 checks, 0 failed`; check-site ×3 `3718 checks, 0 failed`; check-contrast `23 pairings, 0 failed`.
All three gaps are closed. AC4, AC28 and AC29 are now Verified.

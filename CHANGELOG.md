# Agents CHANGELOG

The improvement ledger for this agent library. Every review by `agent-improver` inserts a dated entry at the top, under the `New entries below this line` marker. The goal: agents that are measurably better in three months than they are today.

**How to read this:** each entry records what changed, why, and how you'd know it worked. Before re-reviewing an agent, read its most recent entry and check whether the last fix actually helped. The index below says where that entry is.

**Entry format:**

```
## YYYY-MM-DD — <agent name>
- Verdict: <one line>
- Scores: Mandate · Triggers · Tools · Model · Instructions · Observed · Boundary (Strong / Adequate / Weak each)
- Changed: <what was edited, or "no edits — proposed N fixes">
- Why: <root cause>
- Expected effect: <what should improve, and how you'd know>
- Follow-up: <deferred items or items needing sign-off>
```

Keep an entry inside **250 words per agent reviewed**, declared in the heading when it covers more than one. Overflow goes to `work-samples/`, not into the entry.

---

## How this ledger is split (changed 2026-09-13)

**This file holds the current month only.** When the month turns, the closing month's entries move verbatim to `changelog/YYYY-MM.md`. Nothing is trimmed and nothing is dropped — size is bounded by construction, so a single `Read` always returns the whole live file.

| File | Holds |
|---|---|
| `CHANGELOG.md` | the current month |
| `changelog/YYYY-MM.md` | one closed month each, verbatim |
| `changelog/YYYY-MM-1.md`, `-2.md` | a closed month too big for one read, split at the 16th (2026-09 is the first) |
| `CHANGELOG-ARCHIVE.md` | everything moved out by the old retention sweeps (pre-2026-09-13) |

**This replaces the old retention rules.** Top-2-per-agent, the top-4 `library — portfolio` cap, and the periodic sweeps all existed to keep one growing file under a single `Read`. A month split does that structurally, so they are retired: **do not sweep, do not trim, do not archive on size grounds.** If a month ever grows past a single read on its own, split that month by fortnight rather than deleting anything.

*(History, since the file used to argue about this: the cliff was measured at 67.5–71.2 KB by `wc -c`, and on 2026-09-12 the live file reached 69.3 KB — about 200 tokens of margin — with retention able to free nothing, because every entry over the library cap was held by some agent's top-2. That is what forced the split.)*

---

## Where each agent's history lives

Counts are entries whose **heading names** the agent — which includes creation and batch entries, not only reviews of it. A row is a pointer to where to look, not evidence the agent has been reviewed.

| Agent | Latest entries in | Also in |
|---|---|---|
| `CPO` (retired 2026-10-13 → `cpo` skill) | `changelog/2026-09-2.md`×4, `changelog/2026-09-1.md`×9 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×4 |
| `agent-improver` | `changelog/2026-09-1.md`×4 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×5 |
| `code-improver` | `changelog/2026-09-1.md`×2 | `CHANGELOG-ARCHIVE.md`×4 |
| `cluster-analyst` | `changelog/2026-09-2.md`×2 | — |
| `cody` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×8 |
| `cos` (agent retired 2026-10-13 → `cos` skill) | `changelog/2026-09-2.md`, `changelog/2026-09-1.md`×2 | — |
| `evidence-auditor` | `changelog/2026-09-2.md`×2 | — |
| `idea-challenger` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2 | — |
| `investigator` | `changelog/2026-09-2.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-implementer` (retired 2026-09-29, `.claude/skills/_retired/mc-implementer/`) | `changelog/2026-09-2.md` | `changelog/2026-08.md`×2 |
| `mc-integrator` | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-orchestrator` (agent retired 2026-10-13 → skill) | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×5 |
| `mc-planner` | `CHANGELOG.md`, `changelog/2026-08.md`×2 | `CHANGELOG-ARCHIVE.md`×5 |
| `mc-reviewer` | `CHANGELOG.md`×2, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×4 |
| `mc-verifier` | `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×2 |
| `release-engineer` | `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `security-auditor` | `changelog/2026-09-1.md`×3 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `source-scout` | `changelog/2026-09-2.md`×2 | — |
| `strategy-challenger` | `changelog/2026-09-2.md`×2 | — |
| `strategy-juror` | `changelog/2026-09-2.md`×2 | — |
| `ux-designer` | `CHANGELOG.md` | `CHANGELOG-ARCHIVE.md` |
| `watchdog` | `CHANGELOG.md`, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×3 |

---

<!-- New entries below this line, newest first -->

## 2026-11-01 — ux-designer, mc-planner, cody, mc-reviewer (Finish your races run; 4 agents, 1,000 words)
- Run: a new wizard for balancetriclub/BalanceTRI-app (PR 166), built through `cpo` then `mc-orchestrator`. Samples: `work-samples/{ux-designer,mc-planner,cody,mc-reviewer}-2026-11-01*.md`. `agent-improver` reviewed from a separate context. The main thread wrote every brief and the Integrator rulings, so brief quality is in scope below. `mc-verifier` and `security-auditor` were not reviewed: they only checked the work and their findings held. Samples are saved.
- Changed: no edits to any definition. Proposed 2 + 2 + 4 + 2 fixes, below, for the owner to apply or not.

**ux-designer.** Verdict: set the direction well, but claimed test coverage from a file it never opened.
- Scores: Mandate S · Triggers A · Tools S · Model S · Instructions A · Observed A · Boundary S
- Why: the spec says `check-race-form.mjs` covers the card form (0 matches; sample:151) while admitting it had not read that form (:71). It marked level chips but not event chips, so pressed events were colour-only. Full-width stacking pushed the exit buttons below the 375px fold.
- Proposed: HIGH, step 7: "A claim about a file you did not open is cut or marked 'not opened'." HIGH, step 6, merged with the unsigned 10-30 layout fix: every pressed state gets a non-colour mark in every toggle group; at 375×667 add up the stack and name the actions above the fold.
- Expected effect: no unopened-file claim in the next spec, and the verifier finds no colour-only or fold issue the spec left out.
- Follow-up: the 10-28, 10-29 and 10-30 fixes are still not on disk. Sign them off together with these two.

**mc-planner.** Verdict: strongest of the run. It overturned a false premise in its own brief.
- Scores: Mandate S · Triggers S · Tools S · Model S · Instructions A · Observed S · Boundary S
- Why: AC 22 (a new test), AC 20 (stale Menu) and README:35 (`event` against `events`) all held on disk. The report ran 439 words on a budget of 300, mostly earned by four file:line answers, but it listed the six open questions twice. AC 18 gave two outcomes for one sequence; the reviewer flagged it. My brief repeated the false `check-race-form` premise and left out the session's pinned branch (AC 30 override).
- Proposed: MED, self-review: "For an AC that maps an item's states to outcomes, walk every sequence an item can go through; each lands on exactly one outcome." LOW: cite code by function name beside the line number (PR 165 made every line number stale).
- Follow-up: the 10-22 "list every write path" proposal was never applied, yet the planner did it. Consider dropping it.

**cody.** Verdict: a strong builder whose UI checks thinned out under a Stage 2 brief.
- Scores: Mandate A · Triggers S · Tools S · Model S · Instructions A · Observed A · Boundary S
- Why: round 1 needed a fix round (focus lost on close, a caught error never logged, a style-guide specimen outside the scope its CSS needs). A watchdog pass then found five doc and copy drifts (04fafa4). The 10-22 mutation-testing fixes held. No principle and no 0-10 score appeared; contrast was an "estimate" (`cody.md:44` says measure).
- Proposed: HIGH, Summary: "Under a brief's format, steps 2-4 still return one line each: measured ratios (or 'not measured'), the score and principle, the style-guide file, and the review type." MED, step 2: assert `document.activeElement` after every close, re-render or removal of the opener. MED, step 3: open a rendered style guide and confirm each new specimen picks up the new rules. LOW: no "Fix round is done" opener (`cody.md:14`).
- Follow-up: the queue item "cody: principle named?" is not settled. None was named.

**mc-reviewer.** Verdict: fit. M1, L1 and L2 were real, and M1 was traced to three sites. It ignored its own length rule.
- Scores: Mandate S · Triggers S · Tools S · Model S · Instructions A · Observed A · Boundary S
- Why: 907 words on a budget of 500, then 428 on 300. Neither added the `Over cap` line the definition requires (`mc-reviewer.md:59`). Pass 1 kept two duplicate sections. A static read missed that event chips show selection by colour only. The picker catch at `app.js:905` surfaced only in pass 2. My attack list repeated the Stage 1 risks.
- Proposed: HIGH, :59: "Cleared items go one line each, by range. Merge the brief's attack list into the per-risk close. At most 4 lines per finding. The `Over cap` line is mandatory." MED, :21: name use of colour for selected and pressed states.
- Expected effect: the next review fits its budget and ends with `Over cap`.

**Run-level.**
- Word budgets: all seven reports ran 30-80% over (counted, in each sample). The briefs are more at fault than the agents. Only `mc-reviewer`, `security-auditor` and `watchdog` have a length rule. The `mc-orchestrator` skill has none (0 matches), though `cpo/SKILL.md:65` says every brief carries a budget. Budgets were not sized to what each brief asked for. Counter-example: the last `mc-reviewer` brief set a hard 150-word limit and required an `Over cap` line. It came back 15 words over. The 10-22 proposals (`wc -w`, budgets sized to the brief) remain unapplied.
- `watchdog` on PR 166: 7 findings. Five were true and fixed in 04fafa4. Left: two wordings for one refused write, and a stale "Change password" specimen that predates the PR. Both fix rounds went back to `mc-reviewer`. The second found one low, my own wording slip in the CONTRIBUTING table (8725cdd), now fixed.
- No Notion backlog rows written: the request was for this ledger only. The proposals above are the rows if you want them.

Next audit targets: `mc-orchestrator` (every report over budget, budgets not sized to the brief), `ux-designer` (after sign-off of the five fixes, a run that derives a mock), `cody` (next Stage 2 report: four step lines, principle named), `mc-verifier` (found both pixel defects; check the 10-29 count fix held).

## 2026-10-30 — ux-designer (BBallSkills three options)
- Verdict: fit for purpose; every trade-off named a Rams principle, so the design-principles reference worked. Three slips needed main-thread correction. Independent pass by `agent-improver`; sample `work-samples/ux-designer-2026-10-30.md`.
- Scores: 1 S · 2 A · 3 S · 4 S · 5 A · 6 A · 7 A
- Changed: no edits; proposed 3 fixes.
- Why: (1) it reported a deliberate alt-text fallback (`components.css:141-142`) as a duplicate rule; the defects section never asks it to rule out intent. (2) Its HTML mock overflowed 16px at 390px; it cannot render, and step 6 asks for no checks from the markup. (3) It treated blocked YouTube thumbnails, a sandbox artefact the brief named, as a critique point.
- Expected effect: next run labels each defect confirmed or suspected, lists static layout checks for any mock, and keeps environment notes out of the critique. Test: the main thread strikes nothing.
- Follow-up: HIGH: step 6 adds static layout checks (fixed widths fit, `min-width:0` on flex children, no sideways scroll) and lists render checks owed. HIGH: defects section adds "rule out intent; else label suspected". MED: step 1 adds "what the brief says is blocked is a note, not a finding". Fold the first into the unsigned 10-28 derived-mock checklist. All need sign-off.
- Next audit targets: `ux-designer` (sign off the 10-28, 10-29 and 10-30 fixes together), `cody` (next UI score: principle named?), plus the queue above.

## 2026-10-30 — ux-designer, cody (design principles reference)
- Verdict: both agents scored visual quality 0–10 against a bar they had to invent each run; a shared set of design principles now sets that bar.
- Scores: not re-scored; a user-requested edit, not a review.
- Changed: new `.claude/references/design-principles.md` (Rams's ten principles read for screens, craft basics, how to use them in a trade-off or score). `ux-designer.md` step 2 points to it, step 5 sets its polish bar from it, and one avoid-line covers added decoration. `cody.md` step 2's visual score sets its bar from it; a `ux-designer` spec still wins.
- Why: the user asked for timeless design principles in the UI agents. One shared file, not two drifting copies (the `review-gates.md` pattern).
- Expected effect: the next mock or UI score names the principle that cost points, and option trade-offs cite principles, not taste.
- Follow-up: the two source pages (welchdesignstudio.com, ixdf.org) were blocked by the session's network policy. Rams's list is from his published text; re-check both pages when allowed. `balance-tri-club-brand` not pointed at it: skills ship to the account as zips, where a library-relative pointer would be dead.
- Next audit targets: `ux-designer` (next mock: trade-offs name principles?), `cody` (next UI score: principle named?), plus the queue above.

## 2026-10-29 — mc-orchestrator run, BBallSkills Phase 1 (5 agents: mc-verifier, mc-reviewer, mc-planner, cody, mc-integrator; plus the conductor skill)
- Independence: this is a separate dispatched context that produced none of the run. Sample: `work-samples/mc-orchestrator-bballskills-2026-10-29.md`. Scores marked – were not re-scored this pass.

**mc-verifier**
- Verdict: not fit as it stands, because it reported "FAIL: none" while its own suite asserts a threshold the page cannot meet; the biggest lever is to quote its own runner's summary verbatim.
- Scores: 1 S · 2 S · 3 S · 4 A · 5 W · 6 W · 7 S
- Changed: no edits; proposed 2 fixes.
- Why: `v.cjs:105` requires `cards.length>=10`. The zone page has 8 cards (`results.json:69`, FAIL), and the register says that content did not change since 813988f. The report gives exact counts for the repo scripts, none for `v.cjs`, and closes "Verified: all 25 ACs" with AC17's PR-body half NOT RUN. It also used PASS/FAIL, not the Output vocabulary. The mutation rule (`mc-verifier.md:24`) was applied to repo scripts only, never to its own new suite.
- Expected effect: the next report quotes each runner's own fail count, and a FAIL in its own suite is reported as a defect or a test defect, never left out.
- Follow-up: `results.json` was overwritten by the main thread's re-run, so whether the first run failed cannot be told from disk.

**mc-reviewer**
- Verdict: fit; it found M1–M3, which were real, but M1 named one line per drill, and the fix closed only those lines.
- Scores: 1 S · 2 S · 3 S · 4 S · 5 A · 6 A · 7 S
- Changed: no edits; proposed 1 fix.
- Why: Gap 2 is a brief and skill defect, not a tool gap. Write would break read-only, and `mc-orchestrator/SKILL.md` never says that a read-only actor returns text for the main thread to save. Gap 3: both were too narrow. M1 cited one field per drill, and cody trimmed titles and teaches only. The generalise rule (`mc-reviewer.md:19`) is framed as call sites, not as every field of a content record.
- Expected effect: a content finding lists every field per record, so the next fix round leaves no residue.

**cody, mc-planner, mc-integrator**
- Scores (each): 1 – · 2 – · 3 – · 4 – · 5 – · 6 S · 7 –
- cody did mutation-proof every fix (Stage 2b). The planner's D1–D4 held. The integrator caught that b884442 had no second reader (decision 7) and ruled on the AC8 test defect. No faults found.

**mc-orchestrator (skill)**
- The fix round had no Reviewer re-read until the Integrator caught it, and `SKILL.md` has no fix-loop step.
- Proposed (user signs off):
  - HIGH, `mc-verifier.md` Output: "for every suite run, quote the runner's own summary or fail count; a FAIL in a suite you wrote is reported as Failed or as a test defect, never omitted."
  - HIGH, `SKILL.md` Stage 3: "after a fix round, re-dispatch the Reviewer on the fix diff before Stage 4."
  - MED, `SKILL.md` Stage 3: "Reviewer and Verifier are read-only; briefs ask them to return text, and the main thread pastes it verbatim."
  - MED, `mc-reviewer.md:19`: "for data and content findings, list every field per record as the sites."
  - LOW, `mc-verifier.md:24`: apply the can-it-fail check to your own suite too.
- Applied 2026-10-29 on owner sign-off (ASL-076): all five. Wording in the MED orchestrator edit kept to the definitions: neither actor holds write tools.
- Next audit targets: `mc-verifier` (next run: are its own runner's counts quoted?), `mc-reviewer` (content findings enumerated per field?), `watchdog`, `code-improver`, plus the queue above.

## 2026-10-29 — ux-designer
- Verdict: fit for purpose with no rework; having no shell is a deliberate boundary, and the one lever is labelling hand-calculated checks where readers see them (independent pass, with sample).
- Scores: 1 S · 2 A · 3 S · 4 S · 5 A · 6 S · 7 A
- Changed: no edits (not authorised); proposed 2 fixes.
- Why: Every brief constraint was met, and all 16 hand-calculated ratios matched the main thread's script to 2 dp (`work-samples/ux-designer-2026-10-29.md`). The method is disclosed in the report and at `bballskills-styles.html:154`, but each token table is headed "measured contrast" (`:208`, `:269`, `:329`). Step 6 (`.claude/agents/ux-designer.md:30`) asks what is unverified, not how each figure was obtained.
- Expected effect: the next mock labels each ratio "hand-calculated" or "tool-measured" and lists the render checks still owed. Test: the main thread knows what to re-run without hunting for the caveat.
- Follow-up: MED: step 6 adds "say how each ratio was obtained, in the table itself, and list render-dependent checks owed to `cody` or the main thread". LOW: Summary (`:61`) names "checks owed to a tool". `Bash` not proposed: hand figures held 16/16, and a shell would blur design-not-build (`:46`). The 10-28 HIGH fixes are still unsigned and untested here (no derived mock).
- Next audit targets: `watchdog` (does an estimate-flagged claim hold up as often next time?), `ux-designer` (next derived mock; 10-28 fixes signed off?), plus the queue above.

## 2026-10-29 — watchdog (races site header, BalanceTRI-app#154)
- Trigger: owner, via `/rewrite`: give races.balancetriclub.com.au the club website's menu, keep signed-in items. Done directly in `cpo` (rung 1); `watchdog` delegated as the production review. Sample: `work-samples/watchdog-2026-10-29.md`.
- Verdict: earned its dispatch. 9 findings, none wrong; 4 real defects the main thread's screenshots at 1280/1000/390px missed (overflow at 1061–1100px, no way back on phones, menu under the sticky guide list, README wrong per sign-in state). All fixed in the same PR.
- Observed: it had no Bash, said so, and marked its one width claim as an estimate. The main thread measured it before acting: confirmed.
- No edits to the definition. `agent-improver` skipped: only a reviewer ran, and no finding was wrong.
- Lesson for briefs: name the breakpoint edges to test (just above and below each), not only common widths.
- Next audit targets: `watchdog` (does an estimate-flagged claim hold up as often next time?), plus the queue above.

## 2026-10-29 — library — portfolio: admission test, and the audit proposed
- Trigger: owner, via `/rewrite`: from scratch, skills, agents or plain Claude? Main thread answered "cut to about a third". A delegated `general-purpose` red team (`work-samples/red-team-skills-vs-agents-2026-10-29.md`) found the cuts unsupported: 20 Oct hit a ceiling, and 22 Oct real work favoured agents. The owner then asked for the proposals only, plus the beat-Claude rule.
- Decision (owner): nothing new joins until it beats plain Claude on a recorded test, or enforces a rule plain Claude broke. Added `.claude/references/admission-test.md`, `ADMISSIONS.md` (every part `grandfathered`, partial evidence noted) and `scripts/check-admissions.sh` in CI and the push hook. Five mutations each caught: missing row, new grandfather, bad evidence path, stale row, and clean again.
- Wired into `skills-librarian` 2.4.0 (create, merge, retire), `cpo` 2.1.0 (routing, `portfolio.md`), and the root, skills and plugin CLAUDE.md files. No agent definition edited.
- Proposed, not approved: a house-rule test before any agent cut; the writing and research merge candidates; mc-planner, mc-integrator and code-improver reviews (`portfolio.md`, *Open composition items*).
- Rejected: cutting by headcount; dropping `agent-improver`; folding framework skills into one.
- Reversal: three admission tests in a row where both arms score full marks and the fixtures can't be made harder.
- Checked: delegated `watchdog`, ship after fixes. All 8 findings fixed: the `tested`/`passed` word, the gauntlet's self-graded mode excluded from admission, `mc-verifier` filed twice, the verbatim report saved, the evidence path tightened, agent-name fallback, the rename rule, and the overclaim.
- Next audit targets: `watchdog`, `mc-reviewer`, `code-improver` (house-rule admission test), plus the queue below.

## 2026-10-28 — library — business hat for research and strategy (`multi-actor-research`, `multi-actor-strategy`)
- Trigger: owner, via `/rewrite`: how should Nikki Anderson's "Put on your business hat" (15 Oct 2026) shape the two skills? Done directly in `cpo` (rung 1), no agents dispatched. Reduced independence: the same thread judged and built it. The article was blocked by the session network; the view rests on its teaser and the author's related work (Inferred). Detail: `work-samples/business-hat-review-2026-10-28.md`.
- Finding: research started from evidence, not from the decision it serves; strategy mapped stakeholder reactions, not what each party is measured on.
- Changed: research gains a Decision Hook (who decides, decision, metric, deadline, what would change it), written by the PM before grading. The Evidence Auditor grades on evidence alone; the Validator tests relevance; the Communicator leads with the effect on the metric. Strategy's Problem Framer writes or imports the hook; the Stakeholder Proxy adds "measured on"; the Decision Architect states one criterion as a metric, enforced by new checker rule R9 (escape: `skipped.metric`); the Conviction Bet names the metric. Tests: 26 pass.
- Rejected: an eighth "Business Strategist" actor; any claim that a finding moves a metric without evidence.
- Expected effect: the next research run's Stage 1 Register opens with a hook, and the next strategy run.json carries a metric criterion or a reason.
- Next audit targets: `multi-actor-research` (first run with a hook: did the Auditor stay blind to it?), `strategy-challenger`, plus the queue below.

## 2026-10-28 — library — look outward before building (`cody`, `mc-planner`)
- Trigger: owner, via `/rewrite`: is a tweeted CLAUDE.md rule useful? "For unfamiliar features, don't write from scratch: first search GitHub for open-source projects, compare approaches, then get started" (@jedeeai, 26 Oct 2026). Done directly in `cpo` (rung 1), no agents dispatched. Reduced independence: the same thread judged and built it.
- Finding: useful, with limits. `ux-designer` already has it (step 2, `ux-designer.md:16`); no edit. `cody` searched only inside the repo (`cody.md:25`), so an unfamiliar feature got hand-rolled. `mc-planner` never named prior art, so the dependency call fell to the Implementer.
- Changed: `cody` step 1 gains an outward search: platform API first, then two or three libraries compared on fit, size, licence, last release and security issues. Three limits: a new dependency is flagged, not added; adapted code is fetched content; skip it when the repo already does the job. `mc-planner` names the prior art and whether a dependency is allowed.
- Rejected: a CLAUDE.md line (it governs this repo, not app builds); "search GitHub" as the only source (a well-used library or the platform API often beats a repo).
- Expected effect: the next unfamiliar feature's summary lists what was compared, and no dependency lands without a spec line or a flag.
- Next audit targets: `cody` (next unfamiliar feature: comparison in the summary?), `watchdog` (tools versus Notion artefacts, ASL-075), plus the queue below.

## 2026-10-28 — ux-designer
- Verdict: fit for options and reporting, but it hands over a mock that reads as shippable without checking what a port inherits. Biggest lever: a pre-handoff check against the live source (independent pass, first review with a sample).
- Scores: 1 S · 2 A · 3 A · 4 S · 5 W · 6 A · 7 A
- Changed: no edits (not authorised); proposed 3 fixes.
- Why: Step 6 (`.claude/agents/ux-designer.md:30`) checks contrast, focus and tap targets only, and nothing says a mock built from a live file is not a port. Four of the five `watchdog` defects could be seen in the markup without a browser: missing head tags, 13 `<section aria-labelledby>` (`option-a.html:584`ff), a white banner with no print rule, and `scroll-behavior` moved out of its desktop-only query (`:268`). The 2.3:1 focus ring broke step 6's own 3:1 rule. Sample: `work-samples/ux-designer-2026-10-28.md`.
- Expected effect: the next mock built from a live file lists what it preserved and what is unverified, and the port goes through `cody`. Test: `watchdog` finds no mock-origin defects on the next port.
- Follow-up: HIGH: a derived-mock checklist in step 6. HIGH: step 7 marks mocks "not shippable", with a port list. MED, `cpo`: `routing.md:19` sends `ux-designer` then `cody`, yet the main thread ported. Add "porting a mock is a build". `Bash` would change the mandate; not proposed.
- Next audit targets: `watchdog` (tools versus Notion artefacts, ASL-075), then `ux-designer` (next derived mock: checklist used?), plus the queue below.

## 2026-10-28 — library — Balance Bolt guide refresh (`watchdog` review)
- Trigger: owner, via `/rewrite`: fix balancetriclub/BalanceTRI-app#130, bring the Bolt guide up to date. Done directly in `cpo` (rung 1). The guide lives in `balancetriclub/BalanceBolt`, attached mid-session.
- Output: balancetriclub/BalanceBolt#37 (both guide copies), balancetriclub/BalanceTRI-app#131 (calendar guide's Bolt address). Drafts, owner merges.
- Check: `watchdog` delegated on all three guide files. Six findings, six verified on disk, all fixed. Two were errors in the new text (who refuses a member's change; "already signed in"). Sample: `work-samples/watchdog-2026-10-28.md`.
- Lesson: "fix the guide for the latest updates" hid a second repo. The issue named the page, not its repo; `list_repos` found it.
- No `agent-improver` run: `watchdog` only reviewed, and none of its findings was wrong.
- Next audit targets: `watchdog` (tools versus Notion artefacts, ASL-075), plus the queue below.

## 2026-10-26 — library — strategy pages for the six backlog products
- Trigger: owner, via `/rewrite`: one north-star strategy page per backlog product, framed on the "2026 AI-Era PRD Template" and set above delivery detail. Done directly in `cpo` (rung 1). One question round settled four things: placement (Key `<PREFIX>-000`, P0), Tri Momentum as a personal tool first, club apps owned by the owner, and four strategy goals.
- Output: BB-000, BT-000, TM-000, CF-000, ASL-000 and PM-000 in Product backlog-db. Sample: `work-samples/cpo-strategy-pages-2026-10-26.md`.
- Check: `general-purpose` ran the `watchdog` brief, read only, because `watchdog` has no Notion tools. Five PASS WITH FIXES, one PASS. 16 findings, each verified on disk, all fixed or raised. The worst: a blind-test result stated backwards (`content-writing` lost 3 of 3, not "0 of 3"); a stop rule that skipped `portfolio.md`'s owner yes; a Balance Bolt prize that doesn't exist. Every rollout and stop rule is now marked "(proposed)".
- Lesson: drafting from backlog titles carried their errors forward (ASL-043's title has the same backwards numbers). Check a number in its primary source, not the row that cites it.
- Open: ASL-075 (`watchdog` can't read Notion). ASL-043's title is left for the owner. A Telegram bot token sits in plain text on GEN-001; raised with the owner.
- No `agent-improver` run: only a built-in agent ran.
- Next audit targets: `watchdog` (tools versus Notion artefacts, ASL-075), plus the queue below.

## 2026-10-25 — library — saved verify recipes (`mc-verifier`, `cody`, `mc-orchestrator`)
- Trigger: owner, via `/rewrite`: should the verify loop from the video "Building verification loops in Claude Code" be added to the library? Done directly in `cpo`, no agents dispatched. Reduced independence: the same thread proposed and built it.
- Finding: the library already verifies. `cody` step 1 runs the app and looks; `mc-verifier` drives it against each acceptance criterion; `cody` step 2 measures WCAG AA. Missing: nothing saved the setup that worked, so each run worked out launch, seeds and widths again. Past defects hid there (wrong viewport 2026-09-25, shared session 2026-08-31). Performance budgets were also missing; left to each app's recipe, not the library.
- Decision (owner yes, 2026-10-25): `mc-verifier` ends its report with a verify recipe and stays without write tools. `mc-orchestrator` Stage 4 saves it as `.claude/skills/verify/SKILL.md` in the app repo, in the same PR. `cody` and `mc-verifier` read that file first; `cody` never edits it. The file is not a library copy, so the 2026-10-14 no-copies rule does not cover it; `CLAUDE.md` says so.
- Rejected: a library-wide performance check (the apps are small); `cody` writing the recipe (the builder would write its own test steps).
- Routing (owner yes, same day): the checked `cody` → `mc-verifier` row in `routing.md` now saves the recipe too, once the Verifier passes the change.
- Map: `workflows/dispatch-map-v12.png`, rendered from `dispatch-map-v12.html`. New: the recipe on the coding and checked lanes, both agent rows, an open date for the first saved recipe. v11 image and HTML moved to `z_Archive/`; `workflows/README.md` updated.
- Reverses if: recipes go stale faster than runs refresh them, or an app repo's recipe gets mistaken for a library copy.
- Next audit targets: the first `mc-orchestrator` run that saves a recipe (did the next run use it?), plus the queue below.

## 2026-10-23 — library — owner decisions on the pm-skills review; dispatch map v11
- Trigger: owner, after the review below: add "Leave: no recurring job" to the decision rule; rename the PRD skill's "Assumed" to "Asserted"; update the dispatch map, output it as an image, and archive older versions. Done directly, no agents dispatched.
- Decision rule: ASL-067 gains "Leave: no recurring job", the mirror of build new's "job recurs" test. The rule lives on that Notion row only.
- PRD skill 1.1.2: `references/failure-modes.md` grades Confirmed / Inferred / Asserted, as `research-to-ideas` does. Detail: `.claude/skills/CHANGELOG.md`. ASL-069 updated to match.
- Map: new `workflows/dispatch-map-v11.png`, rendered from `workflows/dispatch-map-v11.html`. The HTML source is kept this time (v9 and v10 had none). New since v10: 39 skills after the 2026-10-18 merges and `discovery-loop`; a product lane; the checked `cody` → `mc-verifier` pass; the repo guards; four open dates. v7–v10 images and the v8 HTML moved to `z_Archive/`; `workflows/README.md` updated.
- Checks: all three scripts pass. Facts on the map were checked against `check-frontmatter.sh --list`, `routing.md`, `portfolio.md` and this ledger.
- Next audit targets: unchanged from the entry below.

## 2026-10-23 — library — rajann44/pm-skills gap review (ASL-067)
- Trigger: owner, via `/rewrite`, ran ASL-067 "based on this week's work". The 2026-10-22 attempt could not read the source; today the git proxy served an anonymous clone (commit `06bdc38`).
- Verdict: no build new; six integrate, eleven leave. Embodied in `cpo` (reduced independence); `watchdog` delegated.
- Integrate (backlog ASL-069 to ASL-074, none applied):
  - I1 `product-requirement-document`: move the Assumption test into the Diagnostic (P2).
  - I2 `investigator`: "a count changed: check the query first" as a known pattern.
  - I3 `customer-insight/references/jtbd-deep.md`: read a leaver's usage before their reason.
  - I4, I7 `discovery-loop`: outcomes doc first; each kill range cites its anchor. Both wait for its first real run.
  - I6 `product-requirement-document`: a Pitch (fixed appetite) artefact.
- Leave: install whole, strategy and metrics frameworks, roadmap scoring, Shape Up, decision journal, interview methods, templates, stakes tiers, scenario tests, MVP vs micro-tests. Recorded on ASL-067 with reversal conditions; no rows (`close-out.md:49`).
- This week's lens: `discovery-loop` (2026-10-20) turned most of the source's discovery spine from "build new" into "covered".
- Review: `watchdog`, 12 findings (5 Medium), all verified and applied; they changed 7 verdicts and added I7. No `agent-improver` pass: every finding held. Evidence: `work-samples/pm-skills-rajann44-review-2026-10-23.md`.
- Open (owner): add "Leave: no recurring job" to the decision rule; rename the PRD skill's "Assumed" to "Asserted".
- Reverses if: any integrate's own reversal condition in the work sample fires.
- Next audit targets: `discovery-loop` (first real run, then I4 and I7), the first standalone `cody` → `mc-verifier` pair, plus the queue below.

## 2026-10-22 — library — portfolio: a checker after standalone `cody`, no new agent
- Decision: no new "counterpart" agent for `cody`. Routing rule added instead: a standalone `cody` change that touches shared code, live data, auth or tests is followed by `mc-verifier`. `mc-verifier` runs the work against the brief's "done when"; a defect goes back to `cody`, then gets verified again. `cpo`, routing authority (unaided), after the owner said yes. Reduced independence: the same thread conducted the run the evidence comes from.
- Changed: `.claude/skills/cpo/references/routing.md` (new row; the `cody` row points to it). `.claude/agents/cody.md` step 4 notes the new check, and that `cody` must not rely on it.
- Evidence: the 2026-10-22 pipeline entry below.
  - Every `cody` overclaim in that run (a false mutation claim, two regressions introduced by a fix, "0 FAIL" from one flaky run) was caught by `mc-reviewer` or `mc-verifier`, never by `cody`'s self-review.
  - Outside the pipeline, nothing would have caught them.
- Rejected:
  - A new checker agent. It would duplicate `mc-verifier`: same tools, same independence, same grading words. The portfolio rules count that as a duplicate.
  - Always running the full pipeline. Too heavy for one-pass work.
- Reverses if: two runs where `mc-verifier` cannot check the kind of work `cody` did (accessibility, visual states, a device-only target), or where the extra dispatch catches nothing over five risky standalone jobs.
- Next audit targets: the first standalone `cody` → `mc-verifier` pair (did the Verifier find anything `cody`'s report missed?), plus the queue below.

## 2026-10-22 — coding pipeline, first full run on a live app (BalanceTRI-app onboarding) — 6 agents
- Verdict: the pipeline caught what mattered. Across 3 fix rounds it found 13 defects or gaps, and none reached the merge. Weakest link: `cody`'s reports overclaimed. `agent-improver`, delegated; the main thread chose the samples.
- Run: `cpo` → `mc-orchestrator`, every actor delegated. It merged as jthoyer/BalanceTRI-app#118; the migrations went live the same day and were synced in #119. Evidence: `work-samples/*-2026-10-22.md` (briefs and reports verbatim) and `work-samples/mc-orchestrator-2026-10-22-registers.md` (decisions D1–D14).
- Applied (High):
  - `cody`: break a compound guard one condition at a time; a fix must be checked against every trigger and event it fires; run a timing-dependent suite at least 3 times.
  - `mc-reviewer`: a medium that breaks an AC blocks merge; a cut order for word caps, with the coverage close cut last.
  - `mc-verifier`: grade each AC by its own clauses and read the deferred list first.
  - `security-auditor`: the intent-doc step is not cut for a word cap.
  - Scripts clean.
- Why:
  - `cody` claimed a one-condition mutation failed a test, which was false.
  - Its F2 fix shipped two regressions that only the second review caught.
  - It reported "0 FAIL" from one run of a flaky suite.
  - `mc-reviewer` marked medium AC breaks `should fix`.
  - `security-auditor` skipped a changed `docs/permissions.md`.
- Length caps: every one of 16 agent replies ran 20–110% over. `mc-reviewer` was about 760 on 500. The dispatched `watchdog` run owed by the queue came in at 678 words on 500, with all 6 findings real and fixed (`work-samples/watchdog-2026-10-22.md`). The fix has not held.
- Proposed, not applied:
  - `wc -w` before returning, for agents with Bash.
  - `mc-planner`: list every path that writes a field the spec makes load-bearing.
  - `mc-orchestrator`: a grade for Review-only ACs; caps sized to the brief.
- Environment: the Supabase connector holds back statements it reads as destructive (`drop policy`, an explicit transaction with `delete`). The call times out and nothing reaches Postgres. `alter policy` worked.
- Next audit targets: `mc-reviewer` and `cody` (next pipeline run: grade and verdict agree, per-AC close under cap, per-condition mutations, multi-run counts); `security-auditor` (intent docs read); `mc-orchestrator` (caps, Review-AC grade, Stage 3 Handoff Note); `watchdog` (length cap still failing), plus the queue below.

## 2026-10-20 — mc-reviewer and watchdog (round 2, harder multi-file test) — 2 agents
- Verdict: both fit for purpose; edits proposed, then applied (below). `agent-improver`, delegated. Reduced independence: the main thread wrote the fixtures and keys and scored the runs.
- Evidence: `work-samples/agent-vs-house-round2-2026-10-20.md`. Eight runs, two per cell against `general-purpose` (opus). `mc-reviewer`: 3/3 planted defects, the shared-helper bug traced to all 3 call sites, 0 decoys flagged, both arms. `watchdog`: 5/5, 0 decoys flagged, both arms. Detection is at the ceiling again. The agents ran at about a third of the tokens.
- What separated them: house-rule behaviour. Both `mc-reviewer` runs gave a per-AC and per-risk coverage close and guard proof; the house arm gave neither. Both `watchdog` runs labelled structural vs typo-level and kept the ride briefs out of the findings; the house arm padded (speculative deadline and "year" items, ride briefs listed).
- Applied the same day on the owner's go-ahead, then re-run on the same fixtures (general-purpose following the edited files, because the session roster loads at start; a dispatched run is owed):
  - `mc-reviewer`: a finding with a failure scenario stays a finding when no AC covers it (verdict `should fix`, tag spec silent); Flagged areas gains a spec-questions slot; the Handoff Note must not repeat the findings. Re-run: duplicate booking landed in one place in both runs (it had split finding/gap), and both runs used both Flagged slots.
  - `watchdog`: step 5 names every ledger read or skipped; the Notion-backlog line goes once at the close; honour the brief's length cap. Re-run: ledger naming and the single closing line worked in both runs.
  - Did not work: the length cap. `mc-reviewer` 722 and 822 words on a 700 cap; `watchdog` 551 and 588 on 500 (it was 581 and 519). Open: say which parts to cut first, or let the brief make room for the coverage close.
- Limits: the key was written by the same thread. `wc -w`: `mc-reviewer` 852 and 811 words on a 700 cap, `watchdog` 581 and 519 on 500; the house arm also ran over.
- Follow-up: build a fixture where a house rule is needed to *find* the defect, with the ledger outside the swept folder. Then add blind judges.
- Next audit targets: `mc-reviewer` and `watchdog` (a dispatched run of each after the next session start; the length-cap fix), plus the queue below.

## 2026-10-20 — library — PM 2.0 Library (Notion) independent check
- Verdict: pass with fixes, then PASS on re-check (`general-purpose`, fresh context, read only). One blocking gap, now fixed: nothing showed craft growing.
- Scope: the owner's brief to run the Notion database "Product Management 2.0" as a product. A 2026-10-19 session built fields, views, ontology tagging, plan, review prompt and backlog; only the prompt had been checked.
- Changed (in Notion): new 📈 Craft growth view; review prompt counts growth each run, reads fields on the page before writing, caps Study slots at 4 per Monday, rule 4 no longer contradicts Step 4; plan signal, roadmap and run log updated; Start here explains field jobs; backlog re-ranked by priority plus one item for run 2's decisions.
- Why: query tools returned blank fields that were set (topic guides 08-11, 14), so a run trusting them could overwrite owner values.
- Evidence: `work-samples/pm2-library-check-2026-10-20.md`.
- Follow-up: owner rates Mastery on the 16 guides (backlog 134); first review run after these prompt changes should be checked.
- Next audit targets: the Notion review prompt (first run under the new rules), plus the queue below.

## 2026-10-20 — mc-reviewer (graded severity beside the verdict)
- Verdict: fit to merge after two fixes (`agent-improver`, delegated; both fixed).
- Changed: `## Output` adds a grade (critical / high / medium / low) beside the unchanged verdict; findings sort by verdict, then grade. A `critical` grade, like `blocks merge`, needs the guard proof; without it, at most `high` / `should fix`. Rare-case findings step down one grade.
- Why: the 2026-10-20 blind test (`work-samples/agent-vs-house-2026-10-20.md`) preferred plain Claude's graded tiers; mc-reviewer marked five of six findings "blocks merge" with nothing to rank them.
- Review fixes applied: the grade now meets `review-gates.md` §2's proof bar (a critical without proof was possible); one sort order instead of two; the step-down rule; "Most" replaced by a rule.
- Expected effect: `mc-integrator` reads the worst blocker first; no change to verdicts it acts on.
- Next audit targets: `mc-reviewer` (first pipeline run: are grades consistent with verdicts?), plus the queue below.

## 2026-10-20 — library — agents vs the house model (4 agents)
- Question (owner): do the most-used agents beat plain Claude? Agents by delegated runs on record: `agent-improver`, `watchdog`, `cody`, `mc-reviewer`.
- Method: each agent against `general-purpose` on the same model tier, identical brief, planted-defect fixtures with sealed keys, three blind opus judges (order randomised), `cody` scored on 8 hidden tests. Detail and all outputs: `work-samples/agent-vs-house-2026-10-20.md`.
- Result: one win each, two ties. `agent-improver` slight win (caught the model field, made privacy a check); house slight win over `mc-reviewer` (graded severity tiers); `watchdog` and `cody` tied (6/6 and 8/8 both sides). Agents ran at about a quarter of the tokens.
- Limits: ceiling effect (both arms found everything in three of four), n = 1, the token gap is mostly the house arm's overhead. Safety and house conventions not measured.
- Proposed, not applied: graded severity inside "blocks merge" for `mc-reviewer` (owner's call).
- Next audit targets: a harder multi-file round for `watchdog` and `mc-reviewer`, plus the queue below.

## 2026-10-20 — security-auditor (intent audit added; gap #2 of the pm-skills review)
- Verdict: approve after fixes (`agent-improver`, delegated; reduced independence: the A/B was built and scored by the authoring thread).
- Scores: Mandate Strong · Triggers Adequate · Tools Strong · Model Strong · Instructions Adequate → fixed · Observed Adequate (n=1) · Boundary Adequate → fixed.
- Changed: step 0 reads the app's intent docs and the new shared `.claude/references/intent-audit.md`; step 3 runs the documented-versus-enforced comparison at each boundary; output gains intent-doc scope wording and an *Owner questions* list. The reference defines five intent docs, the method, the four-part finding, and treatment of stale docs and missing tests (hardening only). Method adapted from `phuryn/pm-skills` (MIT, credited).
- Why: the agent mapped trust boundaries from code alone, so "documented but not enforced" was invisible to it. Gated member accounts make this the highest-stakes class.
- Evidence: `work-samples/security-auditor-2026-10-20.md`. On three planted gaps, both arms found the two exploitable ones; only the new step flagged the stale-docs gap and reported which intent docs exist.
- Expected effect: on BalanceTRI-app, a scope line naming the intent docs, and findings that quote the permissions doc. If an app has no permissions doc, at most five inferred rows.
- Follow-up: one dispatched run of the merged agent on BalanceTRI-app (the A/B arm was general-purpose following the file). The owner writes that app's permissions doc.
- Next audit targets: `security-auditor` (first dispatched run after merge), `discovery-loop` (first real run), plus the queue below.

## 2026-10-20 — library — new skill `discovery-loop` (gap #1 of the pm-skills review)
- Trigger: owner asked to close gap #1 from the 2026-10-20 review of `phuryn/pm-skills`: nothing sat between "decided" and "build".
- Changed: new skill `discovery-loop` (detail: `.claude/skills/CHANGELOG.md`). Routing, README, plugin counts, and pointers from `customer-insight`, `research-to-ideas` and `product-requirement-document`.
- Review (delegated): `watchdog`, 10 findings (5 Medium), all verified and fixed: `work-samples/watchdog-2026-10-20.md`. No `agent-improver` pass: every finding held.
- Reverses if: in real use the loop is skipped for `research-to-ideas`, or it never produces a test with ranges set before running.
- Next audit targets: `discovery-loop` (first real run: were the ranges set in advance?), plus the queue below.

## 2026-10-20 — library — setup (root tidy; four skills trimmed)
- Trigger: points 2 and 4 of the 2026-10-20 setup review (points 1 and 3 are the hooks PR). Done directly in `cpo`, no agents dispatched.
- Root tidy: `dispatch-map-v8`, `research-to-ideas-map`, `multi-actor-strategy-map` and `gated-member-accounts-map` HTML moved into `workflows/` beside their PNGs. Superseded `dispatch-map-v6/v7.html` moved to `z_Archive/`. Pointers updated in `workflows/README.md`, `dispatch-map-v8.html` and `multi-actor-strategy/references/agent-plan.md`. `CLAUDE.md` gains a "Where truth lives" table: one live ledger to write, the rest read only.
- Trim: four skills near the 500-line cap moved content verbatim into `references/`. Detail: `.claude/skills/CHANGELOG.md`.
- Left alone: the ledger split (`CHANGELOG.md`, `changelog/`, `CHANGELOG-ARCHIVE.md`) is deliberate, so it gets a map, not a move. `10X-LOG.md` stays at the root; `portfolio.md` points at it.
- Checks: all six CI steps pass locally.
- Next audit targets: `project-management` and `product-requirement-document` (do they open the new references when a task needs them?), plus the queue below.

## 2026-10-20 — library — setup (push hook, retired-folder guard, two local CLAUDE.md files)
- Trigger: owner asked, via `/rewrite`, whether the repo matches a post on Claude Code project anatomy (short CLAUDE.md, skills, hooks, docs, local CLAUDE.md). Review embodied in `cpo`, no agents dispatched. Hooks and local CLAUDE.md files were missing.
- Changed: `.claude/settings.json` with two PreToolUse hooks. `.claude/hooks/pre-push-checks.sh` runs all six `checks.yml` steps before any `git push` and blocks on a finding. `.claude/hooks/protect-retired.sh` blocks edits inside `.claude/skills/_retired/`. New `.claude/skills/CLAUDE.md` (the CI rules for skills) and `.claude-plugin/CLAUDE.md` (manifest sync). Root `CLAUDE.md` said "CI runs the same three"; CI runs six. Fixed.
- Why: the old rule was "run the checks before pushing", which relied on memory. `checks.yml` records that failure mode.
- Tested: the push hook blocked a planted dead pointer and, on its first run, my own new `.claude/skills/CLAUDE.md`. Both fixed. A clean push passes in about 14 seconds.
- Limit: `.claude/settings.json` loads only when this repo is the project root. In a session with an app repo beside it, CI is the only gate.
- Deferred: root tidy (six HTML maps, four changelog locations) and trimming four skills near the 500-line cap.
- Next audit targets: unchanged from the entry below.

## 2026-10-18 — library — portfolio (three merges; four skills retired; Low items closed)
- Decision (owner, 2026-10-18: "complete low items and all merges"): JTBD + VPC into `customer-insight`; `scqa-framework` into `scr-pyramid-communicator`; `pre-mortem` into `six-thinking-hats`. Skills 42 → 38. Detail: `.claude/skills/CHANGELOG.md`.
- Evidence (delegated): `watchdog` sweep, `work-samples/watchdog-2026-10-18.md` (F4, M1–M3). Merged skills shared triggers and, for JTBD and VPC, most of their content.
- Against, recorded: the 2026-09-05 test found `pre-mortem` alone recognised when the technique did not fit. That redirect now lives in the `six-thinking-hats` module; JTBD's scoring rubric survives in `jtbd-deep.md`.
- Low items, agents: `cody` counts matches before a scripted replace (P8); stale lines fixed in `release-engineer`, `watchdog`, `mc-reviewer`, `agent-improver` (hands the Notion mirror to the main thread). Ledger header says "inserts at the top" and its template carries `Scores:`.
- Reverses if: a blind routing test sends a pre-mortem, SCQA or deep-JTBD prompt to the wrong skill, or `six-thinking-hats` runs a pre-mortem on something already shipped. Restore from `_retired/`.
- Review (delegated): `watchdog` on the merge commit, 9 findings (3 Medium), all fixed: `work-samples/watchdog-2026-10-18-pass3.md`.
- Owed by the owner: delete the four retired skills from claude.ai and upload the changed zips.
- Next audit targets: `six-thinking-hats` (first pre-mortem after the merge), `scr-pyramid-communicator` (short-memo mode picked correctly?), `customer-insight` (does it reach the deep references?), plus the queue above.

## 2026-10-18 — library — portfolio (High and Medium fixes applied; repo declared the source of truth)
- Decision (owner, 2026-10-18): apply every High and Medium proposal from the review below; tax table to 2026–27. The repo is the only place agents and skills are reviewed or changed (new root `CLAUDE.md`).
- Changed, agents: `watchdog` accepts a single member-facing artefact (P1). `cody`, `mc-planner`, `mc-verifier` use a skill only when they hold a `Skill` tool, else self-apply and say so (P2). Reference fallbacks in 11 agents and 2 skills (`cos`, `mc-orchestrator`) search every working directory (P3). `mc-integrator` rules on `security-auditor` findings (P4). `idea-challenger` intake states its inputs (P5). `cody` stale "step 5" and duplicate rule fixed (P6). `ux-designer` styleguide glob is recursive (P7).
- Changed, skills: see `.claude/skills/CHANGELOG.md` 2026-10-18.
- Account copies: 32 skills zipped for claude.ai upload. `editor` and `deep-research` on claude.ai are different products under the same names; uploading replaces them.
- Evidence: this session started with the library beside two app repos; its agents and unprefixed skills loaded from the repo and reloaded live after edits. That is the launch method in `CLAUDE.md`.
- Review: `watchdog` (delegated) on the diff before merge.
- Not done (Low): P8, stale-reference list items, F9–F11.
- Reverses if: the `jh` plugin loads in cloud sessions, making the plugin the delivery path.
- Next audit targets: `cody` (first dispatch with P2/P3: does it say "self-read"?), `watchdog` (first single-artefact review), `idea-challenger` (first intake run), `mc-reviewer` + `mc-verifier` (retire test 2026-12-31).

## 2026-10-18 — library — portfolio (full review: 18 agents, 42 skills, account-synced copies)
- Verdict: health checks clean, but the account-synced skills have drifted and nine defects a static check can't see. Proposals only; nothing in `.claude/` edited, pending the owner's yes.
- Evidence (delegated): `agent-improver` on the agents (`work-samples/agent-improver-2026-10-18.md`), `watchdog` on the skills (`work-samples/watchdog-2026-10-18.md`). Account drift measured by the main thread (`work-samples/account-sync-drift-2026-10-18.md`). Top findings re-checked against the cited lines.
- Most urgent: the claude.ai copy of `rewrite` (1.3.1) launches retired `prompt-refiner`, and synced `cpo` (1.0.0) follows retired `CPO.md`. 24 synced skills differ from the repo.
- High: `watchdog` refuses the single-artefact review `cpo` now sends it (P1). `cody` lists no Skill tool but must run `code-review` (P2). Reference fallbacks miss the library when it is a second working directory (P3). `etf-investing-advisor` still shows pre-2024 tax rates.
- Medium: truncated descriptions (`pre-mortem`, `value-proposition-canvas`); dead scheme-expert routes in `cos` and `positioning`; trigger overlaps in research, writing, stress-test and SCQA/SCR skills.
- Independent `cody` pass done: it disagrees with both 2026-10-13 self-reviews (Instructions and Observed drop to Adequate).
- Merge candidates proposed, not decided: JTBD + VPC into `customer-insight`; `scqa-framework` into `scr-pyramid-communicator`; `pre-mortem` into `six-thinking-hats`.
- Reverses if: the owner declines a proposal; record why here.
- Next audit targets: `cody` (first dispatch from an app repo: Skill tool, reference paths), `watchdog` (first member-facing artefact after P1), `cpo` (first app-repo run), `mc-reviewer` + `mc-verifier` (retire test 2026-12-31), `idea-challenger` (first intake run), `ux-designer` (unreviewed since the archive).

## 2026-10-14 — library — portfolio (app repos keep no agent copies; `sync-agents.sh` retired)
- Decision (owner, 2026-10-14): the library is the only source of agents and references. Copies removed from BalanceTRI-app (#91), BalanceBolt (#27), tri-momentum (#14) and CLACFridays (#18); each now carries a one-line note to attach the library. `scripts/sync-agents.sh` is deleted (git history keeps it).
- Evidence: three of four app repos held stale copies, including the three agents retired on 2026-10-13, and five more had drifted. The sync script never deletes, so every retirement left orphans behind.
- Trade-off accepted: agents are not account-synced, so a session on an app repo alone has no library agents. Attaching the library restores them.
- Rejected: re-syncing the copies. It keeps app-only sessions working but recreates the drift.
- Reverses if: attaching the library to app sessions proves impractical, or the `jh` plugin loads in cloud sessions (then the plugin carries the agents).
- Next audit targets: `cpo` (first app-repo run with the library attached), `cody` (first dispatch without a local copy).

## 2026-10-13 — library — portfolio (`cos` and `mc-orchestrator` agents become skills; CI flags conductors)
- Decision: convert both agents to skills of the same name, archive the agents unmodified (`.claude/skills/_retired/cos/`, `.claude/skills/_retired/mc-orchestrator/`). Owner-approved second PR of the `cpo` redesign. Every conductor in the library is now a skill.
- Evidence (delegated): a dispatched agent never holds `Agent` (live test, same day). Blind routing gate 8/8. Sample: `work-samples/cos-mc-orchestrator-skills-2026-10-13.md`.
- Guard: `check-frontmatter.sh` flags `AGENT-TOOL` for any agent listing `Agent` or `Task`. Proven on planted fixtures; runs in CI.
- Gate fixes: `mc-orchestrator` adds `security-auditor` for auth, payments or member data; its trigger no longer collides with `multi-actor-research`; `cos` routes product decisions to `multi-actor-strategy` and `product-requirement-document`.
- Rejected: renaming `mc-orchestrator` to a new skill name. The old name keeps "run the coding playbook" and every pointer working.
- Reverses if: a harness grants dispatched subagents the `Agent` tool, or a conductor needs its own isolated context more than it needs to dispatch.
- Open: `balancetri-app` still holds synced `CPO.md`, `cos.md`, `mc-orchestrator.md`; the sync script never deletes. Account-synced copies need the same clean-up in claude.ai settings.
- Next audit targets: `etf-investing-advisor` + `etf-investing-coach` (shared triggers), `cos` (first brief as a skill), `high-output-management` ("where should I spend my time" overlaps `cos`).

## 2026-10-13 — library — portfolio (CPO agent and prompt-refiner retired into the `cpo` skill)
- Decision: retire the `CPO` agent and the `prompt-refiner` skill; the `cpo` skill is the one front door (frame → route → do → review). `/rewrite` launches it. Approved by the owner, gated on two tests.
- Evidence (all delegated, none embodied): a dispatched `CPO` reported no `Agent` tool although `CPO.md:5` listed it. Blind routing test went from 6/8 to 8/8. Blind intake comparison: new `cpo` 86/90, old `cpo` 73, `prompt-refiner` 46; the new system is never worse in any cell. Sample: `work-samples/cpo-redesign-2026-10-13.md`.
- Rule adopted: conductors are skills, executors are agents.
- Rejected: keeping `prompt-refiner` as intake only. It duplicated `cpo`'s framing and routing and scored lower on both.
- Archived unmodified: `.claude/skills/_retired/CPO/CPO.md`, `.claude/skills/_retired/prompt-refiner/`. History stays in this ledger; the skill carries rules only (7,871 words → 861 plus three on-demand references).
- Reverses if: two runs in a month need a dispatched router, or the routing test drops below 8/8 after an edit.
- Open: `cos` and `mc-orchestrator` list `Agent` but cannot use it when dispatched (second PR, approved). `balancetri-app` still holds a synced `CPO.md`; the sync script never deletes, so remove it by hand. Account-synced copies of `prompt-refiner` need removing in claude.ai settings.
- Next audit targets: `cpo` (first real multi-agent run under the new close-out), `cos` (same conversion), `watchdog` (now the default reviewer for member-facing work).

## 2026-10-13 — cody (Balance Bolt hand-set waves; REDUCED INDEPENDENCE — embodied by CPO)
- Verdict: Built, tested and committed locally (`BalanceBolt@f1076d5`, not pushed). The riskiest defect, deploy order, surfaced only at review.
- Scores: Mandate Strong · Triggers Strong · Tools Strong · Model Adequate · Instructions Adequate · Observed Strong · Boundary Strong.
- Why: The change spans two halves that deploy separately: GitHub Pages on merge, and Apps Script pasted in by hand. Nothing in `cody.md` asks the builder to state the deploy order, or to check what the new front end does against the old backend. Shipped front-first, a move is silently reverted by the next poll. The suite never loads `apps-script.gs`, so the backend was only executed at the verifier stage. Earlier today's search-before-writing fix held: existing helpers, `.timing-edit` and `.status-tag` were reused, and no CSS was copied.
- Changed: applied 2026-10-13 with the owner's yes (High). A step-1 rule: when a change spans separately deployed halves, state the deploy order, test the new half against the old one, and execute any half the suite does not load.
- Expected effect: deploy-order risk is named in cody's own summary, not found downstream.
- Follow-up: an independent pass when dispatch is reachable. Dispatch probe: resolved-negative. No Notion tool. Sample: `work-samples/cody-2026-10-13-pass2.md`.

## 2026-10-13 — cody (BalanceTRI-app feedback form; REDUCED INDEPENDENCE — embodied by CPO)
- Verdict: Shipped working, tested code; three duplications and one guessed figure were found only after they were written.
- Scores: Mandate Strong · Triggers Strong · Tools Strong · Model Adequate · Instructions Strong · Observed Adequate · Boundary Strong.
- Why: Step 1's "search before you write a helper" covers functions that "format, label, derive or validate". It did not catch a re-implemented `setBusy` (`app.js:534`), and CSS is outside its wording, so `.auth-field` input rules and `.race-loading-eyebrow` were copied, not reused. A self-review and a watchdog pass caught all three. Separately, contrast figures went into a CSS comment before they were computed (6.1 → 5.86), against step 2's "a ratio you did not compute is an opinion".
- Changed: Medium applied on the user's say-so (2026-10-13): step 1's search rule now covers any helper, component or CSS rule, and tells cody to grep for the declarations, not the class name. Not applied (Low): "write measured figures only after running the computation".
- Expected effect: the next UI build reuses existing rules at write time, and self-review finds nothing to dedupe.
- Follow-up: an independent `agent-improver` pass when dispatch is reachable. Dispatch probe: resolved-negative (no Agent/Task tool). No Notion tool in session. Sample: `work-samples/cody-2026-10-13.md`.

## 2026-10-09 — idea-challenger (intake mode: Impact-Effort grade and quick-win step)
- Verdict: **extended, not reviewed.** No `agent-improver` pass and no real run behind the new mode yet.
- Changed: `idea-challenger.md` gains an intake mode. It scores a newly proposed idea 1–5 on Impact (demand evidence, income, career lift, compounding) and Effort (hours, dependencies, unknowns), names the quadrant, and writes one "When X, I will Y" quick-win step. `references/agent-workflow.md` gains the matching table row and an "Intake" section. The description grew from 665 to 795 characters.
- Why: the owner wanted a fast triage for new ideas outside a full run. The agent only stress-tested ideas already ranked.
- Guards: Stage 6 stays blind. Intake grades never reach a Stage 6 dispatch, the Stage 5 score or `check_brief.py`. Demand evidence caps at 2 when only Asserted. Effort runs 5 = heavy, the opposite of Stage 5, so the output labels it.
- Expected effect: a new idea gets a quadrant and a next step in one dispatch. Check on the first real use: does the step fit under two hours and read a signal?
- Follow-up: not synced to the four consuming repos (`scripts/sync-agents.sh`). `research-to-ideas-map.html` and `SKILL.md` do not mention intake mode. Next audit targets: `idea-challenger` (first intake run), `cluster-analyst` (depth gain untested), `source-scout` (parallelism is its only edge).

## 2026-10-03 — library — portfolio (agent roster synced into the four consuming repos)
- Verdict: **closed.** The follow-up open since 2026-09-11 ("sync the roster into the four repos (needs write access, not done)", `changelog/2026-09-1.md`) is done.
- Changed: ran `scripts/sync-agents.sh` against BalanceTRI-app, tri-momentum, CLACFridays and BalanceBolt, at library `47bd084`. Each repo received the same change: six agents added (`cluster-analyst`, `evidence-auditor`, `idea-challenger`, `source-scout`, `strategy-challenger`, `strategy-juror`), nine agents and two references updated, and `mc-implementer` removed by hand. Pushed to each repo's `main`: `cbb8a8e`, `56c40ba`, `67445c3`, `0606160`.
- Why: agents are not account-synced. Until today these repos held a snapshot older than both pipelines. `research-to-ideas` and `multi-actor-strategy` ran there with no agents behind them. `mc-implementer`, retired 2026-09-29, was still there, so `mc-orchestrator` could dispatch it. The sync script never deletes, which is why it needed removing by hand.
- Skipped: `jthoyer/research-to-ideas` is an empty repo with no branch, so not a consumer. `jthoyer/agents` is archived.
- Expected effect: in those repos, CPO can route to the research and strategy lanes, and the blind agents dispatch. Check by listing `.claude/agents/` in any of the four: 21 files, no `mc-implementer.md`.
- Ledger: September rolled out on 2026-10-03. At 75 KB it was past a single read, so it is split by fortnight into `changelog/2026-09-1.md` (1–15) and `changelog/2026-09-2.md` (16–30), verbatim. The index above was recounted from headings. Its old September counts had drifted (CPO said ×10, 13 headings name it), so treat earlier counts as approximate.
- Follow-up: the sync is still manual. It goes stale on the next agent change unless someone reruns the script. Worth making it part of the close-out after any agent edit.


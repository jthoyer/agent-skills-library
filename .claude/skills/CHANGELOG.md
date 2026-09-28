# CHANGELOG

All notable changes to this skills library are recorded here. Format follows the
skills-librarian standard: Added / Merged / Updated / Retired per entry.

<!-- New entries below this line, newest first -->

## 2026-09-28 — `research-to-ideas` v3.1: logic fixes across the skill, agents and checker

### Fixed
- **No ideation step.** Stages went cluster → job → grade → score "ideas" that no stage created.
  Added Stage 3, Generate ideas (two to four per job, at most eight carried, load-bearing claims
  marked). Stages renumber to 0–8.
- **Grade rubric overlapped.** "Inferred" included "proof from one class", which Confirmed also
  covered. Grades are now highest-rule-met, with override rules for self-reports, sellers'
  claims (always Asserted) and contradicting evidence (new **Contested**). An idea's grade is its
  weakest load-bearing claim.
- **Confidence had unassigned cases.** Now a table of checks; the lowest tier wins.
- **Scores had no direction and double-counted time.** Five fixed criteria, 5 always best,
  "speed to signal" replaces "time"; two priority weights count double ("fit weights" renamed:
  "fit" was also a criterion).
- **Stress test never touched the rank.** A Blocks verdict, a broken limit or an irreversible
  worst case now drops the idea to Low, then re-rank.
- **Thin clusters had no exit.** They go straight to the Revisit-if list.
- **Write-back duplicated pages and never closed them.** Re-runs update pages in place; status
  lifecycle and Revenue $ now defined. Schema checked against the live Notion data source.
- **`check_brief.py`** passed a Contested idea at Medium, accepted a decision rule with two Stops
  and no Continue, could not express a blocker with a workaround, and crashed on a missing field.
  Rewritten against the new rules, plus `test_check_brief.py` (17 cases), now run in CI.

### Updated
- Description gained trigger phrases and hand-offs to `deep-research`, `recent-pulse` and
  `multi-actor-research`. Added Lite depth, "back nothing yet" as a valid call, and
  `references/templates.md` (idea card, decision block, test plan, worked example). Stage 2 uses
  `customer-insight` alone (it already contains JTBD) and adds push and anxiety.
- README: moved from Meta to Strategy and problem-solving. `prompt-refiner` routing table gained
  a `research-to-ideas` row. Map page and PNG regenerated for stages 0–8.

## 2026-09-28 — `research-to-ideas` v3: agent-backed pipeline

### Updated
- **`research-to-ideas`** (v2 → v3): Stages 0–3 and 5 now run through four agents (`source-scout`,
  `cluster-analyst`, `evidence-auditor`, `idea-challenger`), two of them blind by design: the
  auditor never sees draft grades, the challenger never sees score or rank. Added a stdlib checker,
  `scripts/check_brief.py` (weighted totals, ranking rule, confidence caps, decision-rule gaps and
  overlaps), a Calibration table on re-runs, and an embodied fallback that caps confidence at
  Medium when no Agent tool exists. Detail and rationale moved to `references/agent-workflow.md`;
  `SKILL.md` stays under the 500-line standard. Agents are in `.claude/agents/`, which is not
  account-synced: consuming repos need `scripts/sync-agents.sh`, otherwise the skill falls back to
  inline roles.

## 2026-09-28 — `research-to-ideas` added, then updated to v2 before merge

### Added
- **`research-to-ideas`**: turns completed research (forum scans, interviews, desk research) into
  a small set of ranked, evidence-graded ideas. Stacks existing skills rather than reinventing
  their thinking; this skill's own job is the sequence, the evidence rubric, and the write-back.
  Single `SKILL.md`, no `references/`. Filed under Meta / library management alongside
  `prompt-refiner`, which it names directly as the adjacent case: `prompt-refiner` routes one
  prompt to the right skill, this one routes a body of research through a fixed sequence of
  skills. Frontmatter reformatted from a quoted single-line `name`/`description` to the library's
  unquoted `name:` / `description: >` convention to pass `check-frontmatter.sh`. README index and
  skill count (39 → 40), and the plugin/marketplace skill counts, updated to match.

### Updated
- **`research-to-ideas`** (v1 → v2, same day, before the adding PR merged): expanded from a fixed
  5-stage pipeline to seven, adding a scoping-and-coverage step up front (decision, limits, fit
  weights, a source-coverage plan that caps confidence at Medium when a needed source class is Not
  reached), a cost/score/confidence stage that now records cost, weeks-to-first-signal, and
  outcome range per idea and adds a denominator line (how many tried it vs. how many succeeded),
  a decide-and-land stage that adds a decision block (decider, decide-by date, reversing
  assumption, review date, "Revisit if" triggers for parked ideas), and a new Stage 7 test-and-learn
  step (hypothesis, cheapest test, Continue/Change/Stop decision rule, review date) that turns the
  top pick into a test rather than stopping at the shortlist. Added a "Re-runs" section: find and
  link the prior run on the same topic, carry forward what still stands, open with "What changed."
  Evidence grading gained a `Tested` tier above `Confirmed` and now requires two source classes
  plus proof for `Confirmed`, not just three consistent accounts. Same reformatting applied to the
  new frontmatter (unquoted `name`, folded `description: >`).

## 2026-09-28 — `rewrite` description rejected by the account skill uploader: literal angle brackets read as an XML tag

### Fixed
- **`rewrite`** (v1.3.0 → v1.3.1): packaging it for account install (claude.ai Settings →
  Capabilities → Skills, which validates and rejects on upload rather than warning) surfaced an
  error neither mechanical check here catches: **"SKILL.md description cannot contain XML tags."**
  The description used `` `/rewrite <your prompt>` `` — the angle brackets around a placeholder,
  ordinary in prose, parse as an unclosed tag to that validator. Reworded to `` `/rewrite` followed
  by your prompt``, no angle brackets. Swept every other live skill's description for the same
  `<word...>` pattern — `rewrite` was the only hit. Not mechanised: `check-frontmatter.sh` has no
  rule for this class yet, and this defect is invisible until the account uploader is actually
  used, not on any local check.

## 2026-09-28 — `jobs-to-be-done-jtbd` frontmatter fixed; two dead skill-name references removed

### Fixed
- **`jobs-to-be-done-jtbd`** (v1.1.0/v1.1.1 → v1.1.2): `SKILL.md` carried **two stacked YAML
  frontmatter blocks** — an unadapted-import artefact (`metadata.author: wondelai`) never cleaned
  up after the seed import, in the same family as the ClawFu and `awesome-llm-apps` leftovers
  found in earlier passes. The second block duplicated `description:` and `metadata.version:`
  (`1.1.0` then `1.1.1`) and its description pointed at `obviously-awesome` and `design-sprint` —
  neither exists in this library. `check-frontmatter.sh` parsed it anyway (PyYAML silently keeps
  the last of a duplicate key), so this shipped clean on every CI run. Merged to a single block:
  kept the first (adapted) description, `license: MIT`, `author: wondelai` as provenance, version
  bumped to `1.1.2`. The `check-frontmatter.sh`/`check-references.sh` duplicate-frontmatter-block
  gap is not mechanised by this fix — still only caught by reading the file.
- **Dead skill-name references**, flagged open in the 2026-09-19 entry below, now resolved:
  `notion-second-brain/SKILL.md` dropped its `icare-expert` line from Related Skills, and
  `justin-voice/SKILL.md` dropped its `icare-tone-of-voice` line — both name skills removed from
  this repo on 2026-09-11. Left `notion-second-brain` and `business-case-builder` as still-open
  review targets per that entry; not addressed here.

## 2026-09-25 — `multi-actor-research`: Parallel Lane Mode (added 2026-09-24), independently reviewed

### Added (2026-09-24, recorded here late)
- **`multi-actor-research/references/parallel-lanes.md`** — an alternative way to run Stage 1 when
  the question decomposes into independent sub-questions and subagent dispatch is available, plus
  two pointers in `SKILL.md`. It was logged only in the root `CHANGELOG.md` (the 2026-09-24
  `library — portfolio` entry), so this ledger had no record of it. Rationale lives there.

### Updated (2026-09-25)
- **`parallel-lanes.md`** — four internal contradictions fixed after an independent `agent-improver`
  review: the merge now runs the Evidence Auditor's source and claim grading, which lane self-grades
  had bypassed; lane conflicts are logged under the §1 escalation path with an explicit PM default,
  since §1 as written covers only source-grade disputes; Asserted claims no longer rank into Stage 2;
  and the no-dispatch fallback that allowed fake independence is gone. Detail: the root
  `CHANGELOG.md` entry of this date.

### Resolved (2026-09-25)
- `skills-librarian` workflow 6's small-addition A/B ran: 3 decomposable tasks, single-voice vs
  Parallel Lane Mode, blind-graded per task. **GREEN** — full reasoning and scores in the root
  `CHANGELOG.md` entry of this date. The one gap this run found (an Asserted claim left with a
  trailing "excluded" label instead of being fully removed) was an execution slip in one merge,
  not a defect in `parallel-lanes.md` itself, so no further skill edit follows from it.

## 2026-09-23 — `job-scan` added

### Added
- **`job-scan`** — runs Justin's dual-track (PM / Service Design) job-market scan: reads platforms,
  exclusion list, and cadence live from each track's Notion prompt page rather than hardcoding them;
  verifies every listing against its original source before filing (the corrected 23 Sep 2026 PM
  run had filed three already-closed roles on aggregator snippet dates alone); deduplicates and
  tracks roles across runs; and files structured results as a sub-item of the relevant prompt page.
  Carries two reference files: `references/run-template.md` (the five-part run structure, worked)
  and `references/verification-playbook.md` (live/closed signals for Ashby, Greenhouse, freehire,
  Dreamwork, designremotejobs, plus the sources — SEEK, LinkedIn, iworkfor.nsw.gov.au — that block
  automated fetching entirely). Hands off to `resume-builder` once a role is chosen and to
  `multi-actor-research` for a pre-application deep-dive on a shortlisted role. README index and
  skill count updated to 39.

## 2026-09-19 — the skills tree joins CI; `market-analyst` frontmatter did not parse; index rebuilt

### Fixed
- **`market-analyst`** — the frontmatter **did not parse as YAML**. `description:` was an unquoted
  plain scalar containing `Triggers on: market analysis`, and a colon-space inside a plain scalar
  makes YAML read a nested mapping and throw (`mapping values are not allowed here`, line 2 col
  779). Rewritten as a `>` block scalar per §5. Invisible to every prose read — the line is good
  English — and found by the first run of the new check. It is the whole trigger surface of the
  skill, so for as long as this stood the skill's own description was unparseable.
- **`README.md`** — declared **49 skills**, listed all 11 icare skills and `content-writing`
  (retired 2026-09-06 and 2026-09-11), and omitted `rewrite` (live since 2026-09-11): 12 errors in
  the one file a person reads to learn what the library holds. Rebuilt against disk at 38, with
  sub-file counts corrected (9 carry `references/`, not 7; 1 carries `scripts/`).

### Added
- **Mechanical checks, run in CI on every push and PR.** `scripts/check-frontmatter.sh` now covers
  `.claude/skills/*/SKILL.md`: YAML parses, `name:` matches the directory, description ≤ 1,024
  **characters** (not bytes), body ≤ 500 lines, no trailing authoring artefact, no missing
  `SKILL.md`, and the README index reconciled against disk. `scripts/check-references.sh` no longer
  skips the skills tree: `~/.claude/skills/...` stays exempt, and every other assertion — including
  repo-relative sub-file pointers — is resolved. These are the checks skills-librarian §4 has
  always specified and which had only ever run by hand. Detail and decoy results: the
  `library — portfolio` entry of the same date in the root `CHANGELOG.md`.

### Still open
- Two live skills name **retired** skills: `notion-second-brain/SKILL.md:149` (`icare-expert`) and
  `justin-voice/SKILL.md:148` (`icare-tone-of-voice`). A dead *skill name* is not a path, so the
  reference check cannot see it — §4's "every skill named in the body exists" is still a manual
  check, and is the obvious next thing to mechanise.

- Next audit targets: `scqa-framework` — its description triggers on "Minto Pyramid" and "executive
  summary", which are `scr-pyramid-communicator`'s core framework and audience, so §7's
  "triggers overlap so heavily that both fire unreliably" is live; `CPO.md`'s routing table already
  arbitrates between them in prose, which is the evidence. Judge the pair, run the gauntlet's
  no-skill arm, merge or draw a boundary. `notion-second-brain` — zero post-seed entries, and it
  carries the dead `icare-expert` pointer plus a mirror model built on `/mnt/skills/user/` that
  predates both this git repo and the account sync; skills-librarian §9 delegates its own Notion
  workflow here, so a defect propagates. `business-case-builder` — zero post-seed entries, 431
  lines against the 500-line guideline, and "business case" is an explicit trigger phrase in
  `scr-pyramid-communicator`'s description, so the necessity question is real rather than tidy.

## 2026-09-11 — `prompt-refiner` reviewed and fixed; `/rewrite` launcher added

### Updated
- **`prompt-refiner`** — four defects, three of them only visible outside a local Mac session.
  1. **Dead skill references.** The routing table, the common stacks and the Phase 2 example named `icare-expert`, `icare-tone-of-voice` and `ni-scheme-expert`, all removed earlier today. Routing a prompt to a skill that no longer exists fails silently. Replaced with live equivalents; every backticked skill name in the file now resolves.
  2. **Hardcoded `~/.claude/agents/CPO.md`** in the Phase 4 fallback. That path does not exist in a cloud session — the same defect `CPO.md` itself was fixed for this morning. Now says to `Glob '**/agents/CPO.md'` and state which path was used.
  3. **`ask_user_input_v0`** is not a tool in this harness. Corrected to `AskUserQuestion`, with a plain-text fallback where that is absent.
  4. **Phase 4 launched `CPO` for every rewrite** and closed an `agent-improver` + `CHANGELOG` loop after every pass. Disproportionate: a ledger entry per "rewrite this email" pollutes the record retention exists to protect. Phase 4 now routes by size — one piece of work executes directly, multi-specialist work goes to CPO — and the close-out fires only when an agent actually ran. Verified live: a test run reported *"Single-skill-plus-polish task — executing directly, no need for CPO."*

### Added
- **`rewrite`** — an explicit-only launcher (`disable-model-invocation: true`) so `/rewrite` works as a command without racing `prompt-refiner`'s own prose triggers. It resolves the refiner by **skill name**, never by filesystem path, so it behaves the same locally, in cloud and via the plugin.

  Took four iterations, each tested live. A long launcher was read as context and answered the prompt itself; a medium one chained but appended the rewrite *after* the output; a third presented correctly but only **3 of 4 runs** — a single green run had made it look settled, which is the failure mode this library's own `mc-verifier` rule exists to catch. The fix was ordering: the required output shape now opens the file instead of sitting in a bullet halfway down, so a failure to chain degrades to a plainer rewrite rather than no rewrite at all. **4 of 4** since, plus a well-specified prompt and a vague one. Four trials is not proof of determinism.

  It also resolves a contradiction it would otherwise have inherited: `prompt-refiner`'s Phase 0 skips the rewrite for well-formed prompts, but typing `/rewrite` is a deliberate request, so the launcher overrides that and says so explicitly rather than leaving two rules to fight.

  **Namespacing:** the plugin is named `jh`, so delivered that way the command is `/jh:rewrite`; only a copy in a repo's own `.claude/skills/` gives the bare `/rewrite`.

## 2026-09-11 — icare scheme skills removed; library packaged as a Claude Code plugin

### Retired
- **11 icare skills removed** at Justin's request: `icare-expert`, `icare-tone-of-voice`, `ctp-care-expert`, `ddc-expert`, `hbcf-expert`, `lifetime-care-expert`, `ni-scheme-expert`, `workers-care-expert`, `tmf-expert`, `general-lines-asset-expert`, `general-lines-motor-expert`. Deleted rather than moved to `_retired/` — this is a scope decision, not a supersession, and git history holds them if they are ever wanted back. 48 skills → 37.

  **Not done, and it matters:** git does not reach claude.ai Settings → Capabilities → Skills. Nine of these eleven are still in the account-synced set and will keep loading in every session until they are removed there by hand. `icare-tone-of-voice` was never uploaded, so it needs nothing.

  ~11 general skills (`justin-voice`, `first-principles`, `issue-tree`, `made-to-stick`, `positioning`, `multi-actor-strategy` and others) still name icare in their trigger text or worked examples. Left alone — the ask was to remove the skills, not scrub every mention. Say the word if those should go too.

### Added
- **`.claude-plugin/plugin.json`** — the library is now a valid Claude Code plugin in place, pointing `skills` at `./.claude/skills/` and `agents` at the 16 files in `./.claude/agents/`. Nothing moved. `_retired/` does not leak: it sits one level too deep to be scanned, confirmed live.

## 2026-09-06 — `content-writing` retired on gauntlet evidence; `value-proposition-canvas` and `humanizer` trimmed under the body-length guideline

### Retired
- **`content-writing`** → archived to `_retired/content-writing/` with a `_superseded-by.md` recording the evidence. Superseded by **`content-research-writer`**, which applies the same Ann Handley methodology to the same trigger surface and adds research, citation management, section-by-section feedback, and coverage of Justin's actual projects.

  Settled by the blind three-condition gauntlet the previous entry called for (three writing tasks: a club blog post, a flat newsletter opening to rescue, and a research-grounded argument piece; conditions were no-skill, `content-writing`, `content-research-writer`; a separate agent graded all nine outputs blind to condition).

  | Condition | Placings (1 = best) | Average |
  |---|---|---|
  | `content-research-writer` | 1, 1, 2 | **1.33** |
  | no skill at all | 3, 2, 1 | 2.00 |
  | `content-writing` | 2, 3, 3 | 2.67 |

  **`content-writing` lost to `content-research-writer` on 3 of 3 tasks, and lost to using no skill at all on 2 of 3.** Under this library's own retirement criteria, a skill that performs worse than the no-skill baseline is a retirement candidate rather than a rewrite candidate — and two skills claiming one trigger makes both fire unreliably.

  **Method fix, applied after the 2026-09-05 pre-mortem gauntlet got it wrong:** position randomisation was generated to a file and the anonymised grading inputs were assembled **by script** from that file, rather than hand-pasted. The previous run's hand-assembly silently deviated from its own shuffle and put one condition in the same position twice, which weakened that result. Positions genuinely varied here (`content-writing` sat at X, X, Z; `content-research-writer` at Y, Y, X; no-skill at Z, Z, Y).

  Caveat stated plainly: one sample per condition per task, three tasks, one grader. Actioned because the head-to-head was a clean 0 of 3, not because the study was large.

  Also worth recording, since it cuts against the easy assumption: the grader fact-checked the citations in all three research pieces and found **none fabricated** — every reference was real and accurately represented. The no-skill condition won that task purely by being honest about which details it had not verified, which the two skill-guided conditions were not.

### Updated
- **`value-proposition-canvas`**: 584 → **139 lines**. Kept the seven-step method, the jobs/pains/gains taxonomies, the three levels of fit, the customer interview questions, and the red-flags list. Cut two ASCII-art canvas diagrams, two long generic worked examples, a blank fill-in worksheet, and most of a checkbox checklist the model can generate unprompted. Also removed a dead `sources/books/osterwalder-value-proposition-design.md` reference that resolved nowhere. v1.0.2 → v1.1.0.
- **`humanizer`**: 559 → **177 lines**, with **nothing removed**. The 29 AI-writing patterns are real substance, so they moved to `references/patterns.md` (391 lines, with a contents block) rather than being cut, and the long worked example moved to `references/worked-example.md` (70 lines). `SKILL.md` keeps the task, voice calibration, the personality/soul guidance, a compact index of all 29 patterns, the process, and the output format. This is the split the body-length guideline actually asks for. v2.5.1 → v2.6.0.
- **`prompt-refiner`**: routing row for content work simplified to point at `content-research-writer` alone, now that the overlap it warned about is resolved.

### Still open
- The body-length guideline item is now down to **zero live skills over ~500 lines** — `content-writing` was the third and it is retired. Longest live skill is now `ctp-care-expert` at 525, which is a scheme-expert reference file where length is the point; not flagged.


## 2026-09-05 — full sweep: the last ClawFu boilerplate removed, a third unrelated import family found and checked clean

### Fixed
- **`content-writing` and `value-proposition-canvas`**: both still carried the same "What Claude Does vs What You Decide" table flagged (but not fixed) in the previous entry — `content-writing`'s said "Generates script outlines", `value-proposition-canvas`'s said "Structures video workflow" / "Creates storyboard frameworks" / "Suggests shot compositions". Removed from both. Neither table had anything to do with either skill's actual subject.
- **Same two files also carried the audio/video "Skill Boundaries" leftover** that `pre-mortem` had (previous entry) — `content-writing`'s said "Structuring audio production workflows" / "Replace audio engineering expertise"; `value-proposition-canvas`'s said "Structuring video production workflows" / "Creating storyboard frameworks" / "Replace professional videography". Found by grepping for the production-language pattern across all 49 files after fixing the two known instances — the grep still returned these two, meaning the first pass had only caught the table, not this second occurrence of the same root defect. Replaced both with real boundaries for what each skill actually does (content-writing: writing process, not audience research or engagement guarantees; value-proposition-canvas: canvas structuring and fit-testing, not customer research or market validation).
- v1.0.1 → v1.0.2 for both.

### Verified clean, no fix needed
- **A third, previously undetected import family found and checked**: `academic-researcher`, `deep-research`, and `editor` all carry `metadata: { author: awesome-llm-apps }` — a different source from the three `ClawFu` imports, found via a mechanical scan for any 4-line block repeated across more than one skill (not just the known table). Checked all three for the same class of defect (mismatched leftover language, dead Related Skills references) — none found. These three are clean as they stand; the `awesome-llm-apps` provenance is noted for awareness, not flagged as a problem.
- **Full re-audit after all fixes**: all 49 skills' frontmatter/description-length still clean; zero remaining hits for audio/video/script/storyboard-class leftover language anywhere in the library; zero dead references in any Related Skills section.
- The scheme-expert family (`ctp-care-expert`, `ddc-expert`, `general-lines-asset-expert`, `general-lines-motor-expert`, `lifetime-care-expert`, `ni-scheme-expert`, `tmf-expert`) shares large structural blocks (e.g. "Part 1 — Scheme Fundamentals") — also surfaced by the same 4-line-duplication scan, but this is deliberate, shared authorship across a family of Justin's own domain-expert skills, not an unadapted import. Noted so a future scan doesn't re-flag it as a defect.


## 2026-09-05 — `pre-mortem`: ran the upgrade gauntlet on the retire question, result was genuinely mixed, trimmed on the boundary evidence rather than the overlap alone

### Tested
- Ran the upgrade-gauntlet retirement check the previous entry recommended (see `references/upgrade-gauntlet.md`), adapted to this environment: this session has real subagent dispatch, so unlike the gauntlet doc's own claude.ai-chat adaptation, generation and grading both ran as genuinely independent dispatches rather than one self-graded pass.
- Three conditions, three tasks (an ordinary solo case, a harder team-facilitation case, and a negative case describing something already shipped and running cleanly — testing whether each condition forces the technique where it doesn't belong): no skill at all, `six-thinking-hats`' Extended Black Hat/Pre-Mortem module in isolation, and the full standalone `pre-mortem` skill. A separate agent graded all nine outputs blind to which condition produced which.
- **Result: genuinely mixed.** Each of the three conditions won exactly one of the three tasks — the Black Hat module won the easy solo case, no-skill-at-all won the harder team-facilitation case, and the standalone skill won only the negative case, by being the one condition that correctly recognized the request didn't call for a pre-mortem at all and redirected usefully instead of either forcing the framing (as the other two implicitly did by not raising the question) or answering something else entirely.
- **A real process flaw, caught before reporting the result:** the position of each response (labeled X/Y/Z for the blind grader) was supposed to be independently randomized per task; when the prompt was hand-assembled, that randomization wasn't actually followed for one of the three tasks, and the standalone skill ended up in the same relative position across two of the three tasks by construction accident rather than design. This weakens confidence that the per-task rankings reflect content alone rather than any position effect — flagged rather than hidden, and the honest read is that at n=1 sample per condition per task, this result was always going to be thin evidence; the construction flaw makes it thinner still.
- **Verdict per the gauntlet's own standard: not Green, not Green-retire, not Red — Yellow.** No-skill did not "match or beat every skilled condition, repeatedly, including on a held-out set" (the bar for retiring outright) — it won once and lost the one task specifically built to test judgment about fit. The standalone skill did not clearly beat both alternatives either. This does not settle "should `pre-mortem` be retired" — it settles that a single small test can't answer that question, and a real answer would need repeat sampling, a genuine sealed held-out set, and disciplined randomization this run didn't fully deliver.

### Fixed
- **`pre-mortem` trimmed from 637 lines to 59** — not because the test proved it redundant (it didn't), but because nothing in the test justified the length either, and the one piece of content the test did show real value in (correctly recognizing when the technique doesn't apply, the *Pre-Mortem vs Post-Mortem* distinction) was a single short section, not the two long worked examples, the ASCII canvas, the duplicate facilitation agenda, or the separate prompt bank that made up most of the file's bulk. Kept: the mechanism and why it works, one consolidated process (solo or team), the risk-prioritization rubric, the Pre-Mortem-vs-Post-Mortem distinction, Skill Boundaries, References, Related Skills. Cut: both long worked examples (SaaS launch, VP hire — generic, and the gauntlet itself showed the model doesn't need worked examples to produce a good pre-mortem), the ASCII-art canvas, a second facilitation agenda that duplicated the process section almost exactly, a standalone prompt bank redundant with prompts already given inline, and an internal "Skill Metadata" block that claimed `author: MKTG Skills` — directly contradicting the frontmatter's `author: ClawFu` two lines above it, one more sign of an unadapted third-party import.
- **Also removed:** the "What Claude Does vs What You Decide" table, which read "Generates script outlines" as one of its rows — nonsensical for a risk-analysis skill, and confirmed via `grep` to be the exact same verbatim table (including the same script-outline line) sitting in `content-writing` and `value-proposition-canvas`. All three are the same ClawFu import artifact, not pre-mortem-specific content. Not yet removed from the other two — flagged below.
- v1.0.1 → v1.1.0 (structural rewrite, not a patch).

### Flagged — not applied
- **The "What Claude Does vs What You Decide" boilerplate table** still sits in `content-writing` and `value-proposition-canvas`, both carrying the same nonsensical "Generates script outlines" row. Same fix as applied here (delete the table) would apply cleanly to both; not done in this pass since it was outside today's brief.
- **The retirement question is still open**, on the honest reading that a mixed n=1 result doesn't close it. If it's ever worth settling properly: repeat each condition 2-3 times per task, use a real sealed held-out set not touched during any iteration, and mechanically randomize position (a script that writes the assembled grading prompt directly from the shuffle, rather than hand-pasting) rather than trusting manual construction.


## 2026-09-05 — library audit: 49 skills swept, 3 confirmed third-party imports found with dead cross-references, one real trigger overlap surfaced

### Fixed
- **`value-proposition-canvas`**: Related Skills section named six sibling skills — `jobs-to-be-done`, `positioning-dunford`, `product-led-growth`, `landing-page-copy`, `conversion-copywriting`, `grand-slam-offers` — none of which exist anywhere in this library. Corrected the two that had a real equivalent under a different name (`jobs-to-be-done` → `jobs-to-be-done-jtbd`, `positioning-dunford` → `positioning`) and removed the four with no live analogue, replacing them with a `customer-insight` cross-reference (the skill that actually pairs VPC with JTBD in this library). v1.0.0 → v1.0.1.
- **`content-writing`**: Related Skills section named five sibling skills — `copy-frameworks`, `headline-formulas`, `email-writing`, `storytelling-storybrand`, `seo-content-writer` — none of which exist here either. Replaced with `content-research-writer` (see Flagged below), `justin-voice`, and `made-to-stick`. v1.0.0 → v1.0.1.
- **`pre-mortem`**: Related Skills section named `inversion` and `eisenhower-matrix`, neither of which exists here. Removed both; kept the two real references (`first-principles`, `six-thinking-hats`) and expanded the `six-thinking-hats` entry to state the overlap explicitly (see Flagged below). v1.0.0 → v1.0.1.
- **Root cause, same for all three**: each carries `metadata: { author: ClawFu, mcp-server: "@clawfu/mcp-skills" }` — confirmed via `grep -l "author: ClawFu" */SKILL.md`, exactly these three and no others. All three are unmodified imports from a third-party pack whose sibling-skill references were never adapted to this library. No other skill in the library carries this metadata shape.
- **`prompt-refiner`**: Skill Routing Reference table was missing three live skills entirely — `resume-builder`, `recent-pulse`, `balance-tri-club-brand` — confirmed by diffing the table's cited skills against the full directory listing. Added all three. Also split the single `multi-actor-research` research row into three, since `deep-research` and `academic-researcher` were previously undifferentiated from it and from each other despite materially different scopes (structured high-stakes pipeline vs. general synthesis vs. academic-literature-specific). v1.1.8 → v1.2.0.

### Flagged — not applied, needs a decision
- **`content-writing` vs `content-research-writer` — near-duplicate, recommend a merge evaluation.** Both apply the same Ann Handley "Everybody Writes" methodology to the same trigger surface (blog posts, email, thought leadership). `content-research-writer` is a strict superset: same methodology plus collaborative research, citation management, section-by-section feedback, and explicit coverage of Justin's actual projects (triathlon club comms, icare narratives) — `content-writing` is the generic, unintegrated import (see Fixed above). Per this skill's own workflow 7 retirement criteria ("a public skill covers the same ground," "triggers overlap so heavily both fire unreliably"), this reads as a retirement candidate for `content-writing`, but that call and the blind-comparison gauntlet belong to the user, not to a routine audit pass.
- **`pre-mortem` vs `six-thinking-hats` — confirmed, self-documented trigger overlap.** `six-thinking-hats`' own description explicitly claims "pre-mortem" as a trigger and states it "includes the Pre-Mortem technique (Gary Klein) as an extended Black Hat module" — with its own ~40-line "Extended Black Hat: Pre-Mortem" section (Why it works / When to run it / How to run it). The standalone `pre-mortem` skill covers the same technique in much greater depth (637 lines: individual brainstorm, round-robin sharing, a risk matrix, tripwires, meeting agenda templates) — the longest body in the library. Both explicitly claim the same trigger ("what could go wrong"). Not merged: the standalone skill's facilitation depth may be genuinely wanted for a real workshop that the compact module doesn't serve. Recommend either (a) keeping both with the boundary now stated in each file's own Related Skills section, or (b) trimming `pre-mortem` toward `references/` per this skill's own body-length guideline and running the upgrade gauntlet to settle it properly.
- **Four skills over the stated ~500-line body guideline**, none yet trimmed: `pre-mortem` (637), `value-proposition-canvas` (599), `humanizer` (559), `content-writing` (550). All four predate this audit and are candidates for workflow 3 (trim into `references/`), not applied here since a defensible trim needs the keep/cut pass this audit didn't have scope to run per-skill.
- **Skills library was 5 days quieter than the agents library this week.** This CHANGELOG's previous entry is 2026-08-31; in the same window the agents-side `CHANGELOG.md` logged a backlog sweep, two portfolio reviews, and a full retention rewrite. Noting the gap rather than reading anything into it — no skill work was requested in that window — but flagging the parallel since the agents ledger's own 10X-LOG finding this week was exactly "a log with no consumer stops being useful"; this ledger has a consumer (this workflow), it just wasn't run.

### Verified clean, no fix needed
- All 49 SKILL.md files: frontmatter parses, `name:` matches directory, description ≤ 1,024 chars (closest: `red-team` at 1,021, `project-management` at 1,020, `skills-librarian` at 1,019 — all under the cap, none flagged).
- Every `references/*.md` file mentioned in a skill body resolves on disk, across all skills that declare a `references/` folder (`multi-actor-research`, `multi-actor-strategy`, `product-requirement-document`, `project-management`, `read-the-room`, `resume-builder`, `scr-pyramid-communicator`, `skills-librarian`).
- `prompt-refiner`'s Skill Routing Reference: every skill it names now resolves to a live directory (checked both directions — named-but-missing, and live-but-never-named, after the additions above).

### Not done this run
- Notion AI Skills DB backup — no Notion connector authorized this session. Same three skills' provenance metadata (`mcp-server: @clawfu/mcp-skills`) is otherwise harmless dead weight and was left in place rather than stripped, since it doesn't break anything and isn't the audit's concern.


## 2026-08-31 — skills-librarian: added the claude.ai upload zip step to Change safety

### Updated
- **`skills-librarian`**: added step 5 to "Change safety" — zip a changed skill's own folder in
  place (`<skill-name>/<skill-name>.zip`, `zip -r -X` with dotfiles/prior zips excluded) so the
  claude.ai upload step in `README.md` § "Two surfaces, one repo" has a ready artifact instead of
  a manual re-zip each time. The zip is a rebuilt-on-change build artifact, not versioned — added
  `*.zip` to `.gitignore` at the library root. Version 2.1.0 → 2.2.0.

## 2026-08-31 — terse-mode: native low-token reply switch, absorbed from a reviewed third-party skill

### Added
- **`terse-mode`**: reviewed `github.com/JuliusBrussee/caveman` (a terse-output skill plus a
  separate BSL-1.1 npm CLI/proxy/engine for compressing what an agent *reads*). Only the reusable
  idea was worth taking — a standing conversational-brevity switch with named intensities
  (`lite`/`full`/`ultra`) that preserves code, commands, numbers, and error text character-exact
  while trimming prose. Did not install their CLI, proxy, or engine: that's a separate third-party
  tool with its own license, telemetry default, and BSL-1.1 terms on the engine-linked pieces —
  out of scope for "add the idea to the skills library," and installing it would mean depending on
  someone else's binary for something this small. Built natively instead as a standalone skill
  rather than folding it into `prompt-refiner` directly, since a user should be able to say "be
  terse from now on" without wanting the full rewrite-and-route ceremony `prompt-refiner` runs.
  Avoided the name "Caveman" — the source repo states it as Julius Brussee's trademark.

### Updated
- **`prompt-refiner`**: added a Skill Routing Reference row so "make replies terser / lower-token /
  caveman-style" requests route to `terse-mode`. Version 1.1.7 → 1.1.8.
- **`README.md`**: skill count was stale at 46 (missing `recent-pulse` and `resume-builder`, added
  in earlier sessions, plus this session's `terse-mode`) — corrected to 49 and added all three to
  their categories (Research, Personal, Writing respectively).

## 2026-08-31 — multi-actor-strategy: absorbed the two novel ideas from a rejected third-party skill (war-council)

### Updated
- **`multi-actor-strategy`**: reviewed `github.com/zapier/wade-skills` ("war-council" — 4 fixed
  personas + 2-3 dynamically generated named experts per topic, each critiquing in character and
  placing a $100 bet with a confidence level, orchestrator synthesises into a conviction-weighted
  verdict with a $1,000 final bet). Not installed as its own skill: its trigger set ("war council",
  "council", "stress-test a decision", "get multiple perspectives") collides directly with
  `multi-actor-strategy`'s own description ("stress-test a proposed direction") and
  `six-thinking-hats`' ("stress-test this plan") — the same trigger-overlap problem that got
  `github.com/tenfoldmarc/llm-council-skill` rejected on 2026-08-18 (see that entry below). Applying
  the same precedent here rather than re-litigating it: three skills competing for the same phrases
  is the library's own retirement criterion, applied pre-emptively.
  It also loses on rigour where it matters: one critique pass from 4-6 personas vs.
  `multi-actor-strategy`'s 7 actors across 4 staged, resumable rounds with confidence grading and a
  Blind Council Check already in place.
  Two ideas were genuinely missing and worth taking. (1) **Dynamic Expert Cameo** (Stage 2): before
  the Challenger's stress-test, generate 2-3 bespoke named personas tailored to the specific
  question, each with a failure-inclusive backstory (a flawed expert argues sharper than a flawless
  one) — generic actor voices produce generic critique, and this is a cheap fix. (2) **Conviction
  Bet** (Stage 3): before the recommendation is finalised, each surviving option's advocate states a
  concrete notional bet and confidence percentage rather than only a Supported/Reasoned/Assumed
  label — a label can hide hedging, a bet cannot. Both added as default steps (skippable for a fast,
  low-stakes pass, same pattern as the Blind Council Check), with matching sections added to the
  Stage 2 and Stage 3 Register templates in `references/stage-register.md` so both findings travel
  forward like every other stage output. No skill retired — `multi-actor-strategy` already covered
  the ground; it's just sharper now.

## 2026-08-18 — multi-actor-strategy: Blind Council Check made a default Stage 3 step

### Updated
- **`multi-actor-strategy`**: the Blind Council Check (added earlier today, see entry below) was
  gated to "high-stakes only" with an opt-in ask. User asked for it as the default, on the reasoning
  that it produces a better answer — moved it into the main Stage 3 flow as a required step, run
  automatically before the Decision Architect drafts. Skip is now the exception: only on an explicit
  user request for a fast/low-stakes pass, and the register must record that it was skipped and why.
  Added a `BLIND COUNCIL CHECK` section to the Stage 3 Register template in
  `references/stage-register.md` so the finding travels forward like every other stage output.

## 2026-08-18 — multi-actor-strategy: absorbed the one novel idea from a rejected third-party skill

### Updated
- **`multi-actor-strategy`**: reviewed `github.com/tenfoldmarc/llm-council-skill` ("council this" — 5
  fixed-persona sub-agents, anonymised peer review, Chairman synthesis, auto-generated HTML report).
  Not installed as its own skill: its trigger set ("stress-test this", "pressure-test this", "should
  I X or Y", "which option") collides directly with `multi-actor-strategy`'s and `six-thinking-hats`'
  existing descriptions — installing it would leave three skills competing for the same phrases,
  which is the library's own retirement criterion for trigger overlap, applied here pre-emptively
  instead of after the fact. It also loses on rigour where it matters: 5 advisors in one pass vs.
  `multi-actor-strategy`'s 7 actors across 4 staged, resumable rounds with confidence grading
  (Supported/Reasoned/Assumed) — nothing here beats the existing skill outright.
  One idea was genuinely missing and worth taking: llm-council's anonymised peer-review round, which
  exists specifically so a reviewer judges a case on its merits instead of deferring to whichever
  actor said it. Added as an optional "Blind Council Check" sub-step at the end of Stage 3, gated to
  high-stakes decisions only (it costs a full extra round). Also added its scannable, self-contained
  HTML report as an optional Stage 4 output format, since none of my strategy skills currently produce
  one. No skill retired — `multi-actor-strategy` already covered the ground; it's just sharper now.

## 2026-08-18 — recent-pulse: added as transparent alternative to a rejected third-party skill

### Added
- **`recent-pulse`** (v1.0.0): "what are people saying about X in the last 30 days" research
  skill, built after declining to install a user-requested third-party skill
  (`mvanhorn/last30days-skill`) whose scripts decrypted Chrome/Brave/Edge/Safari cookie stores via
  the macOS Keychain and shipped a `.skillignore` that explicitly excluded a vendored
  reverse-engineered X/Twitter client from install-time security scans while still installing and
  running it — a scanner-evasion pattern, not installed. `recent-pulse` covers the same use case
  using only sources that need no login: Hacker News via its public Algolia API (verified working
  live), Reddit's public `search.json` as a best-effort bonus (verified blocked with HTTP 403 from
  this network at build time — documented as such rather than worked around), and WebSearch/
  WebFetch for news, blogs, forums, YouTube, and X/Twitter. `scripts/pulse_fetch.py` is a single
  stdlib-only Python file (no third-party deps, no vendored code) covering the two keyless APIs;
  everything else routes through Claude's own WebSearch/WebFetch tools. Description validated at
  1,010/1,024 chars; body 96 lines. Checked for overlap against `deep-research`, `market-analyst`,
  and `academic-researcher` — none cover recency-scoped public-sentiment pulses, so no conflict;
  both `deep-research` and `market-analyst` are cross-referenced in Related Skills for the adjacent
  cases this skill explicitly doesn't cover.

## 2026-08-17 — skills-librarian: full review of prompt-refiner

### Updated
- **`prompt-refiner`** (v1.1.5 → v1.1.6): full library-standard review, per the outstanding item
  flagged in the entry below. Checked: frontmatter parses and `name:` matches directory (pass);
  description 860/1,024 chars (pass); body 188 lines, well under the 500-line target (pass, no
  `references/` needed); every skill named in the Skill Routing Reference and Related Skills
  sections resolves against the live directory listing (pass, no broken cross-references); the
  new cross-library dependency on `~/.claude/agents/prody.md` was verified to resolve (file
  exists) and is already recorded in the v1.1.5 entry below — no further action needed there; no
  stale hardcoded counts or dates found. **Fixed:** Phase 4's launch-failure fallback used two
  negative-form prohibitions ("never 'launched prody'", "Never silently skip the phase") where
  library standard calls for positive directive framing except where the prohibition is the
  requirement itself — neither qualified, so both were rewritten as positive instructions
  ("Label this... always complete the phase this way rather than dropping it..."). No other
  issues found. **Verdict: Keep**, no further changes needed.

## 2026-08-17 — prompt-refiner: prody drives execution and closes the loop

### Updated
- **`prompt-refiner`** (v1.1.1 → v1.1.4): Phase 4 (Execute) now opens by launching `prody` to run
  execution itself, leveraging the skill(s) named in Phase 2/3 routing and any further agents
  prody determines the work needs; once execution completes, prody closes the loop by checking
  whether the agent(s)/skill(s) involved need improvement logged and whether CHANGELOG.md needs
  updating. Runs after every completed refinement-and-execution pass, not just skill-routed ones.
  (Originally added as a separate Phase 4b, then folded into Phase 4 itself.)
- **`prompt-refiner`** (v1.1.4 → v1.1.5): added the missing **launch-failure fallback** to Phase 4.
  As written at v1.1.4 the phase had a single, unconditional path — "launching `prody`" — and no
  branch for a session with no Agent/Task tool, which is a per-session fact and was the actual
  state of the session that reviewed this change. The phase was therefore unexecutable in a
  reachability-negative session, with the silent failure mode being that Phase 4 (and with it the
  whole loop-closing step this entry introduces) is skipped without anyone saying so. Now: state
  the launch failure in one line, embody `~/.claude/agents/prody.md` instead, and label it
  "embodied prody" rather than "launched prody". **New cross-library dependency, recorded here
  because nothing else records it:** `prompt-refiner` is now the only skill in this library whose
  execution phase depends on an artefact outside it (`~/.claude/agents/prody.md`). Renaming,
  retiring or merging that agent breaks this skill's Phase 4, and the agent-library CHANGELOG is
  a separate ledger that will not surface the break. Reverse this coupling if `prody` is retired
  or if Phase 4 is found to be adding a hop without adding routing quality.
- **Review routing (no change made, recorded so it is not re-litigated):** `prompt-refiner` is a
  skill, so `agent-improver` is **not** its reviewer — that agent's rubric assumes an agent
  definition (tool scoping, model fit, sibling-set boundary hygiene are unscorable against a
  `SKILL.md`), and the skills library is `skills-librarian`'s remit. The v1.1.4 edit was
  structural rather than behavioural in scope, but not risk-free, and the defect above was found
  by reading the phase against a live reachability-negative session rather than by rubric. A
  full `skills-librarian` pass on `prompt-refiner` remains outstanding.

## 2026-08-17 — broken pointers and stray-file resolution

### Fixed
Resolved all items flagged as open in the reference audit correction below.

- **Stripped the 13 broken pointers** rather than authoring the missing content (a per-skill
  decision deferred, not made here): removed the `references/voice-patterns.md` instruction from
  `justin-voice`'s frontmatter description and application steps; removed all "See:
  `references/...`" lines and the "Reference Files" index from `jobs-to-be-done-jtbd`; removed
  the `references/schemes.md`, `references/service-expectations.md`, and
  `references/reform-context.md` pointers (and the "Reference Files" table) from `icare-expert`;
  removed the `references/actors.md`, `references/concepts.md`, and `references/tax.md`
  pointers from `etf-investing-coach`; removed the `references/worked-example.md` mention from
  `product-requirement-document` (its other two pointers already resolved and are unchanged).
- **`multi-actor-research`**: deleted the three stale root copies (`actors.md`, `escalation.md`,
  `stage-register.md`) and staged the byte-identical `references/` copies its `SKILL.md` already
  pointed at. Git recorded this as a rename. The skill now resolves cleanly from a fresh clone.
- **`upgrade-gauntlet.md` fork**: deleted the untracked root copy. `skills-librarian` already
  pointed at its own tracked `references/upgrade-gauntlet.md`, which is the version kept.
- **Cleanup**: deleted `Skills-library/` (an empty duplicate clone, `.git` only, no working
  files) and six `.skill` zip archives (`first-principles`, `issue-tree`, `multi-actor-research`,
  `multi-actor-strategy`, `prompt-refiner`, `red-team`) whose `SKILL.md` contents were
  byte-identical to the already-tracked extracted directories.
- **`_retired/agent-router/SKILL.md`**: committed. It was the unmodified archived predecessor to
  `prody`, previously backed up nowhere.

## 2026-08-17 — reference audit correction

### Updated
`README.md` — added a `Skills (46)` index of every skill actually on disk, grouped, with the
one-liner regeneration command. Names only: descriptions live in each `SKILL.md` and were
deliberately not duplicated, so the index cannot drift out of step with them. Also documented
that supporting files belong under `references/`, and recorded which seven skills carry one.

### Corrected
The v1.0 seed entry below claims "Related Skills cross-references: **all 46 clean**" and "no
broken cross-references." **That is wrong.** A path-resolution sweep of every `references/*.md`
mention against disk finds **13 broken pointers across 5 skills**:

- `justin-voice` → `references/voice-patterns.md` (1) — instructed in the frontmatter
  description, so it fires on every invocation of a heavily-used skill
- `jobs-to-be-done-jtbd` → `case-studies.md`, `competitive-strategy.md`, `diagnostics.md`,
  `innovation-process.md`, `organizational-change.md` (5)
- `icare-expert` → `schemes.md`, `service-expectations.md`, `reform-context.md` (3)
- `etf-investing-coach` → `actors.md`, `concepts.md`, `tax.md` (3)
- `product-requirement-document` → `worked-example.md` (1) — its other two references resolve

The first four skills have no `references/` directory at all. The original audit checked the
*Related Skills* cross-reference block (which is genuinely clean — 46/46) and did not check
sub-file path resolution, which is a separate check under skills-librarian §4. Not fixed here:
the missing content has to be written or the pointers removed, and that is a per-skill authoring
decision, not a pointer edit.

`skills-librarian/SKILL.md:221` also matches the sweep, but as a **false positive** — it is the
prose describing this exact failure mode ("A skill whose body says 'load references/x.md' when
no such file..."). The library documented the defect it then shipped.

### Flagged (not resolved)
`multi-actor-research` ships its three sub-files at the **skill root** (`actors.md`,
`escalation.md`, `stage-register.md`) while its `SKILL.md` addresses them as `references/*.md`
in 8 places. Byte-identical copies exist under `references/` but are **untracked**, so the
committed tree resolves none of them. It is the only skill in the library with stray root files.
Origin: `multi-actor-research.skill` was packaged with the sub-files flat at the skill root.

`references/` is the intended location, not an open question: the agents ledger
(`~/.claude/agents/CHANGELOG.md`, 2026-08-17) already records "extracted **flat**, dangling the
`references/` pointers in its own `SKILL.md` and seven `mar-*` files. Moved into `references/`."
The move was made but the root copies were never deleted, and the seed commit then tracked the
**root** copies while `references/` stayed untracked — inverting the fix. Recommended: delete the
three root copies, `git add multi-actor-research/references/`. Left for sign-off because it is a
deletion of tracked files and there is no second undo.

### Added
Full library migrated from local-only storage into git as the single source of truth.
46 skills, audited against skills-librarian standards before commit:

- **icare scheme experts (10):** `icare-expert`, `ni-scheme-expert`, `tmf-expert`,
  `ddc-expert`, `workers-care-expert`, `lifetime-care-expert`, `hbcf-expert`,
  `ctp-care-expert`, `general-lines-asset-expert`, `general-lines-motor-expert`
- **icare governance (1):** `icare-tone-of-voice`
- **Strategy and problem-solving (7):** `multi-actor-strategy`, `multi-actor-research`,
  `first-principles`, `issue-tree`, `six-thinking-hats`, `pre-mortem`, `red-team`
- **Communication frameworks (4):** `scr-pyramid-communicator`, `scqa-framework`,
  `made-to-stick`, `read-the-room`
- **Product and customer insight (4):** `customer-insight`, `jobs-to-be-done-jtbd`,
  `value-proposition-canvas`, `product-requirement-document`
- **Writing (5):** `content-writing`, `content-research-writer`, `editor`, `humanizer`,
  `justin-voice`
- **Business and management (3):** `business-case-builder`, `high-output-management`,
  `project-management`
- **Personal (4):** `triathlon-coach`, `etf-investing-advisor`, `etf-investing-coach`,
  `balance-tri-club-brand`
- **Research (2):** `academic-researcher`, `deep-research`
- **Meta / library management (3):** `skills-librarian`, `prompt-refiner`,
  `notion-second-brain`
- **Content capture (1):** `market-analyst`
- **Positioning (1):** `positioning`
- **Content capture / video (1):** `youtube-explainer`

### Audit notes (from initial import)
Full audit run per skills-librarian §4. Frontmatter, description length (≤1,024 chars),
name-to-directory match, and Related Skills cross-references: **all 46 clean.**

> **Superseded 2026-08-17** — the cross-reference claim covered only the Related Skills block.
> Sub-file (`references/*.md`) path resolution was not checked and is **not** clean. See the
> "reference audit correction" entry at the top of this file.

Five skills exceed the 500-line body guideline and are trim candidates for a future pass
(not blocking — flagged for visibility, not fixed here):
- `content-writing` (550 lines)
- `ctp-care-expert` (525 lines)
- `humanizer` (559 lines)
- `pre-mortem` (637 lines)
- `value-proposition-canvas` (599 lines)

No cross-scope duplication, no broken cross-references, no negative-framing sweep run
this pass (out of scope for a seed commit — run separately per §4).

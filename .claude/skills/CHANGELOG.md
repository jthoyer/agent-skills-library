# CHANGELOG

All notable changes to this skills library are recorded here. Format follows the
skills-librarian standard: Added / Merged / Updated / Retired per entry.

<!-- New entries below this line, newest first -->

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

---
name: prompt-refiner
description: Rewrites any prompt to be excellent, then executes it — with skill routing (including multi-skill stacking), intent diagnosis, audience calibration, stakes-aware ambiguity handling, and output format declaration built in. Use this skill whenever the user says "rewrite", "rewrite this prompt and run it", "improve this prompt then execute", "make this prompt better then do it", "refine then run", or any variant of wanting their prompt improved before execution. Also trigger when a prompt is clearly underspecified and would benefit from structured rewriting before Claude attempts it. Skip the full rewrite ceremony when the raw prompt is already specific, bounded, and unambiguous — state that briefly and proceed straight to execution. Always use this skill before attempting a complex task when the user has explicitly asked for prompt improvement first.
metadata:
  version: 1.2.0
---

# Prompt Refiner

A skill for rewriting any prompt to be excellent, showing the improved version, then executing it — with intelligent skill routing (single or stacked) and execution.

---

## Phase 0: Skip Check

Before diagnosing, check whether the rewrite ceremony is worth running at all:

- If the raw prompt is already specific about goal, audience, format, and scope, **skip the full rewrite**. Say in one line that the prompt is already well-formed, note the skill(s) you'll invoke, and go straight to Phase 4.
- If the prompt is a simple factual or mechanical request (e.g., "fix this typo", "convert this to a table"), skip this skill's ceremony entirely — just do the task.
- Otherwise, proceed to Phase 1.

This keeps the skill useful for genuinely underspecified prompts while staying out of the way of prompts that are already well-formed.

---

## Phase 1: Diagnose

Before rewriting, silently assess the raw prompt across six dimensions:

| Dimension | What to assess |
|---|---|
| **Intent** | Is the goal to inform, persuade, decide, create, research, communicate, or coach? |
| **Audience** | Who receives the output? (Executive / peer / external / self) |
| **Scope** | Is the task bounded or open-ended? Too narrow or too broad? |
| **Output format** | Is the desired output format specified? If not, what would serve best? |
| **Skill fit** | Which installed skill(s), if any, should execute this once rewritten — one, or a stack? |
| **Stakes** | Is this routine (internal draft, exploratory, low cost of a wrong guess) or high-stakes (leadership-facing, restructure-related, external, hard to walk back)? This governs how ambiguity is handled in Phase 2. |

Fold this diagnosis into the rewrite and the annotation rather than surfacing it as a separate section.

---

## Phase 2: Rewrite

Produce an improved prompt that:

1. **Opens with a clear role or context frame** — who is Claude acting as, and what is the situation?
2. **States the goal explicitly** — what should the output achieve?
3. **Specifies the audience** — who will read or use this?
4. **Declares the output format** — structure, length, tone (e.g., SCR brief / executive summary / PRD / narrative / bullet hierarchy)
5. **Adds relevant constraints** — what should be included, excluded, prioritised, or avoided?
6. **Names the skill(s) to invoke**, if applicable — a single skill, or a sequenced stack (e.g., "Apply `content-research-writer` to draft, `justin-voice` for voice, then `humanizer` as a final pass")

### Rewrite quality criteria

The rewritten prompt should be:
- **Specific enough** that two different Claude instances would produce structurally similar outputs
- **Outcome-oriented** — focused on what the output should do, not just what it should contain
- **Free of ambiguity** about format, audience, and purpose
- **Honest about uncertainty** — if the original prompt is too vague to rewrite confidently, handle it per the Ambiguity Handling section below, calibrated to stakes

---

## Phase 3: Present

Show the user:

### 🔁 Rewritten Prompt

> [Display the full rewritten prompt in a blockquote or code block]

### What changed

A concise annotation (3–6 bullet points) explaining what was added, changed, or clarified — and why. Use plain language and keep it tight.

### Skill routing

Name which installed skill(s) will be invoked for execution, in what order if more than one, and why. If no skill applies, say so briefly.

---

## Phase 4: Execute

Execute the rewritten prompt immediately after presenting it. The user has already asked
you to run it, so go straight to execution — the one exception is the high-stakes
ambiguity case below, where a clarifying question comes first.

### How much machinery to bring

Match the route to the work, not to the ceremony:

| The rewritten prompt is... | Route |
|---|---|
| One piece of work that one skill covers, or none — a draft, an answer, an edit, a piece of research | Execute it yourself, applying the routed skill(s). **Do not launch CPO.** |
| Multi-part: needs several specialists, or needs work staged, built and reviewed | Launch `CPO`, which picks the roster and any further agents, and closes its own loop |

Most rewrites are the first row. Launching a product-management hub to answer one
well-formed prompt costs a context window and buys nothing.

### Applying the routed skills

Either way:

- Load and apply each skill in full, in the sequence named
- Follow each skill's stage sequence, actor structure, or framework as specified
- Run each skill's output in full
- When stacking, treat earlier skills as feeding content or structure to later ones — a
  domain skill supplies facts, a voice skill governs expression, a communication skill
  governs structure. Run them as a connected sequence, each building on the last.

If no specific skill applies, execute to the quality standard the rewritten prompt implies
and match the output format it declares.

### If you took the CPO route and CPO cannot be launched

No Agent/Task tool in this session — a per-session fact, not a settled one. State that in
one line, then run the phase yourself following `CPO.md` from the agents directory. Locate
it with `Glob '**/agents/CPO.md'` rather than assuming a path: `~/.claude/agents/` does
**not** exist in a cloud session. Say which path you used. Label the run "embodied CPO" —
that distinction is what every independence claim downstream rests on — and complete the
phase rather than dropping it because the launch failed.

### Closing the loop

**Only when an agent actually ran.** The `agent-improver` pass and the `CHANGELOG.md`
entry belong to CPO's process and fire when CPO ran, launched or embodied. A rewrite you
executed yourself produces the output and stops there — logging a ledger entry for every
refinement pollutes the record that ledger exists to keep readable.

---

## Ambiguity Handling

Calibrate to the **Stakes** assessment from Phase 1:

**Routine stakes** — make a reasonable assumption, flag it inline, and keep moving.

> ⚠️ **Ambiguity detected:** [One sentence describing what is unclear.] I've made the following assumption to proceed: [State the assumption.] Let me know if you'd like to redirect before I execute.

Then proceed with the assumed interpretation.

**High stakes** — (leadership-facing, restructure-related, external-facing, or otherwise costly to get wrong) surface the ambiguity instead of guessing. Use `AskUserQuestion` to get a quick answer (if that tool is absent in this surface, ask in plain text and wait) on the one or two things that would change the output materially. This is the one case in this skill where execution waits on the user.

---

## Skill Routing Reference

Use this to identify which installed skill(s) to invoke during execution — single skill or stacked sequence. This list is illustrative, not exhaustive — always check the user's full available_skills list, since the library evolves faster than this table.

| If the rewritten prompt is about... | Consider invoking... |
|---|---|
| Structuring a recommendation, brief, or executive message | `scr-pyramid-communicator` |
| Strategic options appraisal or decision-making | `multi-actor-strategy` |
| Research synthesis with evidence grading feeding a strategy/investment/executive decision | `multi-actor-research` |
| A general research question with no high-stakes decision riding on it — gathering sources, synthesising across them | `deep-research` |
| Academic literature specifically — paper analysis, methodology critique, citation formatting | `academic-researcher` |
| Social listening — what people are currently saying about a topic, last 30 days, public sources | `recent-pulse` |
| Stakeholder communication or difficult conversation prep | `read-the-room` |
| Making a message memorable or narrative-driven | `made-to-stick` |
| Writing or editing content (article, blog, narrative, newsletter) | `content-research-writer` |
| Resume, CV, or cover letter work | `resume-builder` |
| Any content for Balance Triathlon Club specifically | `balance-tri-club-brand` |
| Product requirements or feature scoping | `product-requirement-document` |
| Business case or investment justification | `business-case-builder` |
| Project communication, agenda, or stakeholder update | `project-management` |
| Triathlon training, race prep, or performance | `triathlon-coach` |
| ETF investing, portfolio, or tax questions | `etf-investing-advisor` or `etf-investing-coach` (multi-actor panel version) |
| Customer motivation, JTBD, or value proposition work | `customer-insight` (or `jobs-to-be-done-jtbd` / `value-proposition-canvas` individually) |
| Positioning or differentiation for an offering | `positioning` |
| Problem decomposition, root-cause, or MECE structuring | `issue-tree` |
| Challenging assumptions or stripping back to fundamentals | `first-principles` |
| Multi-perspective stress-testing of a plan or decision | `six-thinking-hats` (includes pre-mortem as Black Hat module) |
| Team management, 1:1s, OKRs, leverage | `high-output-management` |
| Notion architecture, second-brain, or capture workflow | `notion-second-brain` |
| Competitive/app-market landscape review | `market-analyst` |
| Adversarial critique or pre-submission stress test | `red-team` |
| Structuring communication with SCQA specifically | `scqa-framework` |
| Writing in Justin's authored voice | `justin-voice`, **always stacked with** `humanizer` as a final pass |
| Stripping AI writing patterns from output | `humanizer` |
| Editing for clarity, grammar, structure | `editor` |
| Capturing/summarising a YouTube video to Notion | `youtube-explainer` |
| Making Claude's own replies terser / lower-token / "caveman-style" from now on | `terse-mode` |

### Common stacks

Some prompt types reliably route to more than one skill. Default to these combinations rather than picking a single skill when the rewritten prompt spans more than one concern:

- **Justin-authored external content** → `content-research-writer` (drafting) → `justin-voice` (voice calibration) → `humanizer` (final pass)
- **High-stakes recommendation or pitch** → `multi-actor-strategy` (options) → `red-team` (pressure test) → `scr-pyramid-communicator` (structure)
- **Customer/product discovery work** → `customer-insight` (jobs/pains/gains) → `positioning` (if the output needs to argue relative advantage)

---

## Tone and presentation

- Be direct. Show the rewrite, annotate it briefly, execute.
- Keep it lean — skip meta-commentary about the skill itself.
- Proceed straight to execution without asking the user to confirm, except in the high-stakes ambiguity case above.
- If execution produces a long output, use headers to organise clearly.
- Apply `humanizer` as a final pass on any substantial written output to remove AI writing patterns.

---

## Example trigger phrases

- "rewrite this prompt and run it"
- "rewrite"
- "improve this prompt then execute"
- "make this better then do it"
- "refine then run"
- "this prompt isn't great — fix it and go"
- "prompt refinement: [prompt]"
- "take this and make it excellent, then execute"

---

## Related Skills

- `skills-librarian` — governs the standards this skill's own structure follows
- `scr-pyramid-communicator`, `multi-actor-strategy`, `justin-voice` — most frequently stacked downstream skills
- `red-team` — pairs well when the rewritten prompt is for high-stakes content

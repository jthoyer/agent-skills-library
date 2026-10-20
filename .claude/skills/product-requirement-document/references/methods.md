# Methods for Better PRDs

Moved verbatim from `SKILL.md` on 2026-10-20 to keep the body short.

## Part 4: Methods for Better PRDs

### Increasing Speed

**Use prompts, not blank pages.** For each section, answer structured questions first — then let the section write itself. See `references/section-prompts.md` for a prompt per section.

**Time-box the draft.** A PRD written in 4 hours with open questions flagged is more useful than a PRD written in 2 weeks with false certainty. First draft = get it out of your head. Second draft = make it defensible.

**Separate thinking from writing.** Use the diagnostic questions (top of this skill) before opening a document. A PRD written before you've answered "what decision does this enable?" will be rewritten.

**Use the VPC and Lean Canvas as pre-work.** If these exist, import their outputs directly into Sections 2 and 3. Do not re-derive what has already been validated.

### Increasing Completeness

Run the **section purpose test** before finalising: for each section, ask "what decision does this enable?" If the answer is "none," either cut the section or identify what's missing from it.

Use the **anti-metrics discipline**: for every success metric, name one thing that should not get worse. This surfaces trade-offs that are usually invisible.

Check the **out-of-scope section last**: good things to defer often emerge only after the requirements are written.

### Increasing Accuracy

**Write acceptance criteria before requirements.** If you can't write a test for it, you don't understand it well enough to require it.

**Run a contradiction check**: does any requirement contradict the value proposition, the Lean Canvas metrics, or the VPC pains and gains?

**Flag assumptions explicitly**: distinguish between what has been validated (evidence-backed) and what is being assumed (hypothesis). A PRD with hidden assumptions is more dangerous than one with visible ones.

### Increasing Impact

**Write for the reader, not the author.** The lead knows everything; the PRD exists for everyone else. Test each section by asking: could a smart person who wasn't in any meeting make a good decision using only this?

**Distribute before the meeting, not during it.** A PRD shared 48 hours before a review meeting creates alignment. One shared at the start of the meeting creates performance of alignment.

**Make the open questions work for you.** A list of well-framed open questions with owners and dates is more valuable than a complete PRD with buried uncertainty.

### First-Principles Checks for a Completed PRD

| Check | Question |
|-------|----------|
| **Decision test** | Could a person who wasn't in any meeting make the right call on a feature trade-off using this PRD alone? |
| **Specificity test** | Does any requirement contain a word like "easy," "fast," or "intuitive" without a measurable definition? |
| **Scope test** | Is everything in the out-of-scope section actually something someone asked for? If not, what's missing? |
| **Metric test** | Does every success metric have a baseline, a target, and a timeframe? |
| **Assumption test** | Are all unvalidated assumptions explicitly flagged as assumptions? |
| **Contradiction test** | Does anything in this PRD contradict the value proposition, Lean Canvas, or VPC? |
| **Owner test** | Does every open question and dependency have a named owner? |

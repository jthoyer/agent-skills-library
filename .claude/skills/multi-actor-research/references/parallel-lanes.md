# Parallel Lane Mode — a Stage 1 alternative for decomposable questions

This is an alternative way to run Stage 1 (Evidence Assembly). It changes how evidence gets
gathered — not the interface to Stage 2. A Parallel Lane run still closes with a normal Stage 1
Register and Handoff Note (`references/stage-register.md`).

---

## When to use it

Use Parallel Lane Mode when both hold:

- The research question splits into sub-questions that can be answered **without reading each
  other's answers** — no lane depends on another lane's output.
- Subagent dispatch is available, so each lane can run as a genuinely separate pass with no shared
  transcript.

Do not force a sequential question into this shape. "What caused X, and did the fix work?" is two
steps, not two lanes — the second depends on the first. Forcing it into parallel lanes produces two
passes that each guess at the other's answer, which is worse than one sequential pass.

## Why independence is worth the overhead

A single Researcher voice, even a careful one, tends to anchor on whichever source or framing it
finds first — later evidence gets read against that frame rather than on its own terms. Five lanes
that never see each other's output cannot anchor on each other. The gain is decorrelated error, not
speed: if two independent lanes reach the same claim from different sources, that is real
corroboration, worth flagging as strengthened. If they conflict, that is a genuine signal the single-
voice version would likely have smoothed over before it ever reached the Evidence Auditor.

## Steps

**1. Decompose into up to 5 lanes.**
Write each lane as a standalone question. Test each one: could this be answered with zero visibility
into the other four? If not, merge it into the lane it depends on, or run it after the others as a
normal sequential step instead.

**2. Dispatch each lane with a fixed output contract.**
Each lane returns only:

| Field | Content |
|---|---|
| Claim | One sentence, falsifiable |
| Evidence | What supports it, specific enough to check |
| Source link | Where it came from |
| Caveat | What would weaken or narrow this claim |
| Confidence | **Confirmed / Inferred / Asserted** — this skill's existing grades (`SKILL.md` § Quick Reference), not a separate scale |

Keep each lane's output short — a handful of claims, not a report. A long lane output is a sign the
sub-question was too broad to be one lane.

**3. Merge — dedupe, but never smooth over disagreement.**
Walk the combined claim list:

- Same claim from 2+ lanes, same conclusion → note as corroborated, keep once.
- Same question, different lanes disagree → this is a **Confidence Disagreement**
  (`references/escalation.md` § 1). Log it and route to the Project Manager. Do not average the
  claims or quietly keep the more confident-sounding one — a claim that survived silent selection
  looks stronger than the evidence behind it actually is.
- Any Asserted claim with no path to Confirmed or Inferred is removed before the register closes,
  same as single-voice Stage 1.

**4. Rank by decision impact, separately from confidence.**
Confidence answers "how sure are we." Impact answers "how much would this change the answer if it
turned out wrong." They are different axes — a Confirmed but incidental claim ranks low; an Asserted
claim the recommendation actually turns on ranks high and should be first in line for the Devil's
Advocate in Stage 2. From the merged list, name the claims that would most change the answer if
false. Carry that ranking into Handoff Note item 2 ("what needs your attention most") — it is exactly
the prioritisation that item already asks for, now backed by an explicit pass rather than an
impression.

**5. Close Stage 1 as normal.**
Produce the Stage 1 Register and Handoff Note per `references/stage-register.md`. Nothing about the
downstream interface changes — Stage 2 does not need to know Stage 1 ran in parallel.

## Failure modes to avoid

- **Fake independence.** Five prompts in the same conversation, each able to see the others'
  output, is not parallel — it is sequential with extra steps. Dispatch as separate subagents (or at
  minimum instruct each pass explicitly not to read prior lanes) or the decorrelation benefit is
  lost.
- **Losing the disagreement in the merge.** The point of running lanes independently is to surface
  conflicts a single voice would have smoothed over. A merge step that resolves every conflict
  silently throws that benefit away.
- **Treating impact ranking as a restatement of confidence.** If the "top 5 by impact" list is just
  the 5 lowest-confidence claims re-sorted, the ranking step was skipped, not done.

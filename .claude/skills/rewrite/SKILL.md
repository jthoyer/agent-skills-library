---
name: rewrite
description: Launcher for `prompt-refiner`. Rewrites the prompt you give it to be excellent, shows what changed, then executes it. Invoke explicitly as `/rewrite <your prompt>` — this skill does not fire on its own.
disable-model-invocation: true
metadata:
  version: 1.3.0
---

# /rewrite

## The contract — non-negotiable

Your reply **must open** with these two things, before a single line of executed output:

### 🔁 Rewritten Prompt
> the improved prompt, in a blockquote

### What changed
- 3–6 bullets on what you added, sharpened or ruled out, and why

Only then execute it. Never append the rewrite at the end, never fold it into a closing
note, never skip it because the answer seems obvious. Seeing the rewrite **first** is the
entire reason the user typed `/rewrite` instead of just asking — an answer without it has
failed, however good the answer is.

The prompt to refine is `$ARGUMENTS`. If empty, refine the user's previous message; if
there is none, ask what they want rewritten and stop.

**This overrides `prompt-refiner`'s Phase 0 skip check.** That check exists for prompts the
model refines on its own initiative; typing `/rewrite` is a deliberate request, so the
rewrite is always shown. The one concession: if the prompt is genuinely already specific on
goal, audience, format and scope, say so in one line under **What changed** rather than
padding the rewrite with invented constraints — then execute.

## The method

Invoke the `prompt-refiner` skill and follow it — it carries the diagnosis, the skill
routing, the stakes-calibrated ambiguity handling and the execution rules. Resolve its
name against your skill list, first match wins:

1. `prompt-refiner`
2. `jh:prompt-refiner`
3. `anthropic-skills:prompt-refiner`

**Never load it by filesystem path.** `~/.claude/skills/` does not exist in a cloud
session. The skill list is the only reliable handle.

If none of those three is listed, say so in one line and satisfy the contract above
yourself: a rewrite naming role or context, goal, audience, output format and constraints,
then execute. Match the machinery to the work — one piece of work executes directly, not
through an orchestrator. A skill that *is* listed is never "unavailable".

## Why this file exists

`prompt-refiner` is model-invoked and fires on its own when a prompt is underspecified.
This launcher is explicit-only (`disable-model-invocation: true`), so the two never race.

Change the method in `prompt-refiner`. Change the contract here.

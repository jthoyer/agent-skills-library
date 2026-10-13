---
name: rewrite
description: Launcher for the `cpo` skill. Restates the prompt you give it so it can be done well, shows what changed, then routes and executes it. Invoke explicitly as `/rewrite` followed by your prompt — this skill does not fire on its own.
disable-model-invocation: true
metadata:
  version: 2.0.0
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

**Always show the rewrite.** Typing `/rewrite` is a deliberate request, so `cpo`'s
"skip the frame" rule does not apply here. The one concession: if the prompt is already
specific on goal, audience, format and scope, say so in one line under **What changed**
rather than padding it with invented constraints — then execute.

The rewritten prompt is `cpo`'s frame written as a prompt: objective, done when, out of
scope, audience, format and length, and the route.

## The method

Invoke the `cpo` skill and follow it — it frames, routes, does the work and reviews it.
Resolve its name against your skill list, first match wins:

1. `cpo`
2. `jh:cpo`
3. `anthropic-skills:cpo`

**Never load it by filesystem path** unless none is listed. `~/.claude/skills/` does not
exist in a cloud session. If none of the three is listed, say so in one line, read
`Glob '**/skills/cpo/SKILL.md'` from the library repo and follow it. If that is missing
too, satisfy the contract above yourself and execute.

## Why this file exists

`cpo` is model-invoked and fires on its own for multi-part work. This launcher is
explicit-only (`disable-model-invocation: true`) and adds one thing: the rewrite is shown
first, always.

Change the method in `cpo`. Change the contract here.

---
name: rewrite
description: Launcher for `prompt-refiner`. Rewrites the prompt you give it to be excellent, shows what changed, then executes it. Invoke explicitly as `/rewrite <your prompt>` — this skill does not fire on its own.
disable-model-invocation: true
metadata:
  version: 1.2.0
---

# /rewrite

Invoke the `prompt-refiner` skill now, with `$ARGUMENTS` as the prompt to refine, and do
exactly what it says. Nothing in this file replaces, summarises or reorders it.

Resolve its name against your skill list, first match wins: `prompt-refiner`,
`agent-library:prompt-refiner`, `anthropic-skills:prompt-refiner`. Never load it by
filesystem path — `~/.claude/skills/` does not exist in a cloud session.

Two things this launcher is responsible for, because they are what typing `/rewrite`
buys over just asking:

- **The rewritten prompt and what changed appear first, before any executed output.** Not
  appended afterwards, not folded into a closing note.
- **`$ARGUMENTS` is the prompt to refine.** If empty, refine the user's previous message;
  if there is none, ask what they want rewritten and stop.

If, and only if, none of those three skill names is in your list: say so in one line, then
follow the same shape yourself — show a rewritten prompt stating role, goal, audience,
format and constraints, list what changed, then execute. A skill that is listed is never
"unavailable".

Change behaviour in `prompt-refiner`, not here. This file only routes.

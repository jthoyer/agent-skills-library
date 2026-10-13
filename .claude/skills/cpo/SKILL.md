---
name: cpo
description: Runs the CPO process in the main thread, where the Agent tool exists, so CPO can launch other agents for real. Use when the user says "launch CPO", "run CPO", "kick off this project", "who should work on this", or hands over a multi-part request with no executor named. A dispatched CPO subagent has no Agent tool, so it can only play the roles itself. This skill is the fix.
metadata:
  version: 1.0.0
---

# CPO — main-thread launcher

## Why this skill exists

The `CPO` agent lists `Agent` in its tools. A subagent still cannot start other subagents,
so a *dispatched* CPO has no way to delegate. It plays every role itself ("embodied"),
reviews work it produced, and loses the separation of duties the library rests on.

You are the main thread. You hold the `Agent` tool. Run CPO's process here and delegate
for real.

## What to do

1. **Read the process.** Locate `CPO.md` with `Glob '**/agents/CPO.md'`. Never assume a
   path: `~/.claude/agents/` does not exist in a cloud session. Say which path you used.
   If it is missing, say so in one line and follow the shortened steps below.
2. **Follow `CPO.md` as written**: launch checks, PM frame, live inventory, routing, the
   work sample, the close-out loop, and portfolio authority. This file adds only the
   changes below.

## What changes when CPO runs in the main thread

- **Never dispatch `CPO` as a subagent.** Doing that recreates the problem. You *are* CPO.
- **The dispatch probe is expected to pass.** Check the tool list. If `Agent` is there,
  make one real dispatch. The `agent-improver` pass at the close is the natural one. Say
  "delegated" only for a dispatch that returned.
- **Delegate the work.** Send each piece to the specialist `CPO.md` routes it to, with a
  self-contained brief, absolute paths, and a stated return format. Run independent
  dispatches in one turn. Run `mc-reviewer` and `mc-verifier` as a pair from here.
- **Keep review independent.** Run `agent-improver` and `watchdog` as dispatches, not as
  roles you play. If the tool is missing, label the run "embodied CPO" with reduced
  independence. That is a per-session fact, so state it in one line.
- **Label every role** as delegated or embodied. Never blur the two.

## If there is no `CPO.md`

State it, then do this: frame the request (objective, done, out of scope), list agents from
the context listing, route to the smallest set that covers the work, delegate with
self-contained briefs, and report which agents ran. Skip the ledger. It lives in the
library repo only.

## Scope

Use this for multi-part work. One piece of work that one skill covers runs inline, with no
CPO. `CPO.md` owns the routing table, the ledger rules, and portfolio authority. Change the
method there. Change only the main-thread rules here.

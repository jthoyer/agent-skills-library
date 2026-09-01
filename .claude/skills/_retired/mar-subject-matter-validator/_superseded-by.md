# mar-subject-matter-validator — retired 2026-08-18

Archived unmodified from `~/.claude/agents/`. Superseded by the **`multi-actor-research` skill**
(`~/.claude/skills/multi-actor-research/` — `SKILL.md` + `references/actors.md`,
`references/escalation.md`, `references/stage-register.md`), which carries this actor's full
playbook for the single-thread mode.

Retired under the necessity test: the only capability this file held over the skill was dispatch as a
separate context at a restricted tool set. No agent file in the library declares an `Agent`/`Task`
tool, so `mar-orchestrator` could never dispatch it; five weeks produced zero persisted `mar-*`
artefacts. See `~/.claude/agents/CHANGELOG.md`, 2026-08-18.

Also relevant: `red-team` (pure adversarial demolition), `multi-actor-strategy` ("what should we
do"), `scr-pyramid-communicator` (audience translation), `project-management` (process/escalation).

Reversal: restore this file if a session dispatches `multi-actor-research` and the skill demonstrably
fails to deliver what this actor's mandate promised.

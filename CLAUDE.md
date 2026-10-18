# Repo notes for Claude Code

## This repo is the source of truth

Every agent and skill lives here, at `.claude/agents/` and `.claude/skills/`. When asked to
review, improve or fix an agent or skill, edit it **here** and open a pull request.

- Never edit the claude.ai account copies. They show up in a session as
  `anthropic-skills:<name>` and can lag this repo by weeks (24 had drifted on 2026-10-18,
  see `work-samples/account-sync-drift-2026-10-18.md`). Refresh them by uploading the zip
  that `skills-librarian` builds.
- App repos keep no copies (decided 2026-10-14).
- When a skill appears under both names, use the unprefixed one: it loads from this repo.
  Type `/cpo` and `/rewrite`, not `/anthropic-skills:cpo`.

Before pushing, run the three health checks in `scripts/` (`check-frontmatter.sh`,
`check-references.sh`, `check-skill-structure.sh`); CI runs the same three. Log every
review in `CHANGELOG.md` per `.claude/skills/cpo/references/close-out.md`.

## Starting a cloud session with this library and an app repo

Pick **both** repositories as sources when you start the session. Each repo is cloned side
by side under the working directory, and this repo's agents and skills load for the whole
session.

Already in a session without the library? Ask Claude to attach `jthoyer/agent-skills-library`.
It adds the repo, clones it, and registers it; the agents and skills load on the next turn.

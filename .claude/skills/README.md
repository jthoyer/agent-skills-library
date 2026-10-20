# Skills Library

Source of truth for Justin's Claude skills. One folder per skill, each with a `SKILL.md`
in the standard frontmatter + markdown format. Governed by the `skills-librarian` skill —
read that before creating, merging, trimming, or retiring anything here.

## Surfaces

This library serves several places, and they do not all sync with each other.

- **As a plugin (preferred — covers skills *and* agents):** the repo root is a valid
  Claude Code plugin. `.claude-plugin/plugin.json` points `skills` at `./.claude/skills/`
  and `agents` at the files in `./.claude/agents/`; nothing was moved to make this work.
  Test it with `claude --plugin-dir /path/to/agent-skills-library`, or install it from
  `.claude-plugin/marketplace.json`. Plugin skills are namespaced: `/jh:justin-voice`.

  This is the only surface that carries **agents**. Skills are account-synced and reach
  every session on their own; agents are not, and in a cloud container `~/.claude/agents`
  does not exist at all. Until the plugin is installed, agents reach a session only when this
  library is attached to it. App repos keep no copies (decided 2026-10-14): attach the library
  to any session whose work needs its agents.

  After adding or removing an agent, run `scripts/sync-plugin-manifest.sh`. `plugin.json`
  lists agent files explicitly — a directory fails validation — so a new agent will
  otherwise ship missing while `claude plugin validate` still passes clean.

- **Claude Code (local, interactive):** reads live from `~/.claude/skills/`. Point that
  path at a clone of this repo (clone directly there, or symlink into it). `git pull`
  updates it.
- **Claude Chat (claude.ai):** reads whatever's uploaded under Customize → Skills ("+", then
  "Upload a skill"). Git does not reach that UI. After a skill changes here, re-upload the
  affected folder(s) there as a batch, each zipped with the folder at the top of the archive
  (`skills-librarian` §"Change safety", step 5) — weekly, or after a meaningful change, not per commit.
  **Deletions need doing by hand too**: a skill removed from this repo keeps loading in
  every session until it is also removed there.

## Workflow

1. Snapshot before editing (`skills-librarian` §"Change safety").
2. Build changes outside this repo, validate (frontmatter, description ≤1,024 chars,
   body <500 lines, cross-references resolve, `scripts/check-skill-structure.sh` clean),
   then commit here.
3. Add a `CHANGELOG.md` entry — Added / Merged / Updated / Retired.
4. Batch re-upload changed folders to claude.ai (Customize → Skills), zipped per step 5 of
   `skills-librarian` §"Change safety".
5. Optional: mirror to Notion's AI Skills DB per `skills-librarian` §9.

## Layout

```
skill-name/
└── SKILL.md
    references/   (optional, loaded on demand)
    scripts/       (optional)
    assets/        (optional)
```

Supporting files belong under `references/`, not beside `SKILL.md`. `SKILL.md` addresses them
by relative path (`references/<name>.md`), so a file left at the skill root will not resolve.

## Skills (39)

Names below are the frontmatter `name:` field, which always matches the directory name.
Each skill's own `description:` is the authoritative statement of when it fires — it is not
duplicated here, so that this list cannot drift out of step with it.

**This list is checked against disk**, by `scripts/check-frontmatter.sh`. It has to be: it
said 49 and still listed 11 icare skills and `content-writing` — all retired weeks earlier —
until 2026-09-19, while `rewrite` had been live since 2026-09-11 and appeared nowhere. An
index nobody verifies is worse than no index, because it is read as authoritative.

**Strategy and problem-solving (7)** — `multi-actor-strategy`, `multi-actor-research`,
`first-principles`, `issue-tree`, `six-thinking-hats`, `red-team`, `research-to-ideas`

**Communication frameworks (3)** — `scr-pyramid-communicator`, `made-to-stick`, `read-the-room`

**Product and customer insight (4)** — `customer-insight`, `discovery-loop`,
`product-requirement-document`, `positioning`

**Writing (6)** — `content-research-writer`, `editor`, `humanizer`,
`justin-voice`, `youtube-explainer`, `terse-mode`

**Business and management (3)** — `business-case-builder`, `high-output-management`,
`project-management`

**Research (4)** — `academic-researcher`, `deep-research`, `market-analyst`, `recent-pulse`

**Personal (6)** — `triathlon-coach`, `etf-investing-advisor`, `etf-investing-coach`,
`balance-tri-club-brand`, `resume-builder`, `job-scan`

**Meta / library management (6)** — `cpo`, `rewrite`, `cos`, `mc-orchestrator`, `skills-librarian`,
`notion-second-brain`

Fifteen skills carry a `references/` folder: `business-case-builder`, `cpo`, `customer-insight`, `discovery-loop`, `humanizer`, `job-scan`, `multi-actor-research`,
`multi-actor-strategy`, `product-requirement-document`, `project-management`, `read-the-room`,
`research-to-ideas`, `resume-builder`, `scr-pyramid-communicator`, `skills-librarian`. Three carry
`scripts/`: `multi-actor-strategy`, `recent-pulse`, `research-to-ideas`. The other 23 are a single
`SKILL.md`.

Regenerate against disk rather than trusting any of the above:

```bash
scripts/check-frontmatter.sh --list
```

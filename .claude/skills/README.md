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
  does not exist at all. Until the plugin is installed, agents reach a repo only by being
  committed into its `.claude/agents/` (see `scripts/sync-agents.sh`).

  After adding or removing an agent, run `scripts/sync-plugin-manifest.sh`. `plugin.json`
  lists agent files explicitly — a directory fails validation — so a new agent will
  otherwise ship missing while `claude plugin validate` still passes clean.

- **Claude Code (local, interactive):** reads live from `~/.claude/skills/`. Point that
  path at a clone of this repo (clone directly there, or symlink into it). `git pull`
  updates it.
- **Claude Chat (claude.ai):** reads whatever's uploaded under Settings → Capabilities →
  Skills. Git does not reach that UI. After a skill changes here, re-upload the affected
  folder(s) there as a batch — weekly, or after a meaningful change, not per commit.
  **Deletions need doing by hand too**: a skill removed from this repo keeps loading in
  every session until it is also removed there.

## Workflow

1. Snapshot before editing (`skills-librarian` §"Change safety").
2. Build changes outside this repo, validate (frontmatter, description ≤1,024 chars,
   body <500 lines, cross-references resolve), then commit here.
3. Add a `CHANGELOG.md` entry — Added / Merged / Updated / Retired.
4. Batch re-upload changed folders to claude.ai Skills settings.
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
by relative path (`references/foo.md`), so a file left at the skill root will not resolve.

## Skills (49)

Names below are the frontmatter `name:` field, which always matches the directory name.
Each skill's own `description:` is the authoritative statement of when it fires — it is not
duplicated here, so that this list cannot drift out of step with it.

**icare scheme experts (10)** — `icare-expert`, `ni-scheme-expert`, `tmf-expert`, `ddc-expert`,
`workers-care-expert`, `lifetime-care-expert`, `hbcf-expert`, `ctp-care-expert`,
`general-lines-asset-expert`, `general-lines-motor-expert`

**icare governance (1)** — `icare-tone-of-voice`

**Strategy and problem-solving (7)** — `multi-actor-strategy`, `multi-actor-research`,
`first-principles`, `issue-tree`, `six-thinking-hats`, `pre-mortem`, `red-team`

**Communication frameworks (4)** — `scr-pyramid-communicator`, `scqa-framework`, `made-to-stick`,
`read-the-room`

**Product and customer insight (5)** — `customer-insight`, `jobs-to-be-done-jtbd`,
`value-proposition-canvas`, `product-requirement-document`, `positioning`

**Writing (7)** — `content-writing`, `content-research-writer`, `editor`, `humanizer`,
`justin-voice`, `youtube-explainer`, `terse-mode`

**Business and management (3)** — `business-case-builder`, `high-output-management`,
`project-management`

**Research (4)** — `academic-researcher`, `deep-research`, `market-analyst`, `recent-pulse`

**Personal (5)** — `triathlon-coach`, `etf-investing-advisor`, `etf-investing-coach`,
`balance-tri-club-brand`, `resume-builder`

**Meta / library management (3)** — `skills-librarian`, `prompt-refiner`, `notion-second-brain`

Seven skills carry a `references/` folder: `multi-actor-research`, `multi-actor-strategy`,
`product-requirement-document`, `project-management`, `read-the-room`, `scr-pyramid-communicator`,
`skills-librarian`. The other 39 are a single `SKILL.md`.

Regenerate this count against disk rather than trusting it:

```bash
for f in ~/.claude/skills/*/SKILL.md; do grep -m1 '^name:' "$f" | sed 's/^name: *//'; done | sort
```

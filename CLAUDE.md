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

A hook in `.claude/settings.json` runs the CI checks before every `git push` and blocks
the push on a finding. Run them yourself while you work: `check-frontmatter.sh`,
`check-references.sh`, `check-skill-structure.sh` in `scripts/`. `.claude/skills/` and
`.claude-plugin/` each have a local CLAUDE.md with their rules. Log every review in
`CHANGELOG.md` per `.claude/skills/cpo/references/close-out.md`.

## Starting a cloud session with this library and an app repo

Pick **both** repositories as sources when you start the session. Each repo is cloned side
by side under the working directory, and this repo's agents and skills load for the whole
session.

Already in a session without the library? Ask Claude to attach `jthoyer/agent-skills-library`.
It adds the repo, clones it, and registers it; the agents and skills should load on the next
turn. Not yet tested end to end (2026-10-18): if they don't, start a fresh session with both.

## Keys: cite them in commits and pull requests

Two kinds of key point at the same work. Cite them so a commit leads back to its backlog
item or blueprint card.

**Backlog keys** are on every item in the Notion Product backlog, in the `Key` column.
Format: product prefix, a dash, three digits. Example: `BT-017`.

| Prefix | Product |
|---|---|
| `ASL` | Agent & Skills Library |
| `BT` | BalanceTRI-app |
| `BB` | Balance Bolt |
| `CF` | CLACFridays-app |
| `TM` | Tri-Momentum-app |
| `PM` | PM 2.0 Library |
| `GEN` | No single product |

**Blueprint card keys** are on every card in `project-blueprints/`. Format:
`BB-<stage>-<lane><number>`. Example: `BB-04-A2`. `BB-` here means a Balance Bolt blueprint
card, not a backlog item: a backlog key has three digits and no lane letter, so the two
never clash. The BalanceTRI blueprint uses `RB-`.

Rules for both:

- A key is permanent. Never renumber it. Never reuse a retired one.
- A new item takes the next free number for its product (or stage and lane).
- A new product takes a new prefix. Add it to this table and to the `Product Name` options
  in the backlog.
- Cite the key in the commit message or pull request title, for example `BT-017: escape names`.

## Where truth lives

| What | Where |
|---|---|
| Agents and skills | `.claude/agents/`, `.claude/skills/` (index: `.claude/skills/README.md`) |
| Rules shared by several agents | `.claude/references/` |
| Health checks (CI runs them) | `scripts/`, `.github/workflows/checks.yml` |
| Review ledger, current month | `CHANGELOG.md`. Write here. |
| Skills ledger | `.claude/skills/CHANGELOG.md` |
| Past ledgers (read only) | `changelog/` (closed months), `CHANGELOG-ARCHIVE.md` (pre-2026-09-13) |
| Evidence behind reviews | `work-samples/` |
| Maps of how it all fits | `workflows/` (see its README for which is current) |
| Project blueprints (HTML, images) | `project-blueprints/` (see its README) |
| Superseded material | `z_Archive/`, `.claude/skills/_retired/`. Never edit; never cite as current. |

`10X-LOG.md` is the daily leverage log, run only on request (`.claude/skills/cpo/references/portfolio.md`).

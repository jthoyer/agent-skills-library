# Can a personal account get the plugin into cloud sessions?

**Question:** is there any personal-account path that populates `~/.claude/plugins/synced/`,
or otherwise puts the `jh` plugin in a fresh cloud container?

**Short answer:** the `plugins/synced/` channel stays shut, but a different path works —
declaring the plugin in **`~/.claude/settings.json`** loads it with no install at all. The
open problem for cloud is getting that file into an ephemeral container.

## What was tested

All runs `claude -p` in `/tmp` or a scratch repo, probing for `jh:cody` (an agent only the
plugin provides) and `jh:prompt-refiner`.

| Setup | Agents | Skills |
|---|---|---|
| Nothing installed (control) | no | no |
| `CLAUDE_CODE_PLUGIN_SEED_DIR` alone | no | no |
| Project `.claude/settings.json`, scratch dir — 2 runs | no | no |
| Project `.claude/settings.json`, real cloned repo — 2 runs | no | no |
| **User `~/.claude/settings.json`** | **all 16** | **yes** |
| User settings, seed dir removed, cache deleted | **yes** | yes |

## Finding 1 — declaration alone is enough, at user scope

```json
{
  "enabledPlugins": { "jh@jthoyer": true },
  "extraKnownMarketplaces": {
    "jthoyer": { "source": { "source": "directory", "path": "…/agent-skills-library" } }
  }
}
```

That file alone loads all 16 agents and the skills. **No `claude plugin install`, no
populated cache, no seed directory** — `installed_plugins.json` stayed `{}` and
`plugins/cache/` was absent throughout. Claude Code resolves straight from the marketplace
source.

Shape matters: `enabledPlugins` is an **object** (`{"jh@jthoyer": true}`), not an array. An
array is accepted silently and does nothing — that cost one false negative in this run.

## Finding 2 — project settings do not work

Committing the same JSON to a repo's `.claude/settings.json` never registered the
marketplace: `known_marketplaces.json` stayed `{}` across four runs in two directories.

This matches the documented folder-trust gate ("once a team member trusts the repository
folder…") and the note that a plugin from an external source which only project settings
enables "doesn't load until the team member installs it". A non-interactive session cannot
answer a trust prompt.

**So committing `.claude/settings.json` to the four product repos will not deliver the
plugin.** The committed `.claude/agents/` remains the only thing that works there.

## Finding 3 — `plugins/synced/` is provisioned but empty

`~/.claude/plugins/synced/` and `~/.claude/skills/synced/` carry the **same bucket id**,
`<id>_be7e62d3-…`, whose second half is this account's `account_uuid`, and both were
created in the same instant at container start. The plugin slot is provisioned for a
personal account and simply has nothing in it. Filling it is still Organization-settings
distribution (Team/Enterprise). Nothing found here changes that.

## Finding 4 — first-run registration lag

The first session after the declaration appears registers the marketplace; the plugin
loads from the **second** session onward. Observed twice, both times recovering on the
next run.

This matters more in cloud than locally: a fresh container has no second session. Whether
`CLAUDE_CODE_PLUGIN_SEED_DIR` removes the lag by pre-populating the cache was **not
settled** — the one combined run still showed it. That is the next thing to test.

## Where this leaves the cloud problem

The lever is the **environment**, not the repo. Cloud environments (`Backlog`,
`Triathlon`, `Tri momentum app` — all `anthropic_cloud`) configure environment variables
and setup scripts. A setup script that writes `~/.claude/settings.json` at container start
would put the plugin in every cloud session in that environment.

Two conditions, neither verified here:

1. **The marketplace source must resolve inside the container.** A local directory path
   will not exist. It has to be the GitHub source — which needs this PR merged, since
   `.claude-plugin/` is not on `main`, and needs the container to reach a private repo.
2. **The registration lag must not bite**, or must be absorbed by a seed directory.

Until both are shown, the four committed `.claude/agents/` snapshots stay.

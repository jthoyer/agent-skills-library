# Plugin install — verification run, 2026-09-12

Tests whether the `jh` plugin actually delivers agents and skills once **installed**,
rather than loaded with `--plugin-dir`. The two are not the same path and the earlier
`--plugin-dir` result did not settle this.

## What was run

```
claude plugin marketplace add /home/user/agent-skills-library   → added marketplace "jthoyer"
claude plugin install jh@jthoyer -y                             → installed (scope: user)
```

Then, in `/tmp`, with **no `--plugin-dir` flag and no repo in the working directory**:

| Probe | Result |
|---|---|
| Agents visible from a named list | `ux-designer`, `security-auditor`, `cody` |
| Count of `mc-*` agents | 6 |
| `jh:prompt-refiner` available | yes |
| `/jh:rewrite write something about swimming` | presented the rewrite first, then executed |

**Agents and skills both arrive through an install.** That is the claim this run was for.

## Trap: `plugin details` under-reports agents

```
claude plugin details jh
  Skills (38)  …
  Agents (0)
```

Zero is wrong — 16 load. The 16 `.md` files are present in the install cache at
`~/.claude/plugins/cache/jthoyer/jh/1.0.0/.claude/agents/`, and the installed manifest
carries all 16 paths. `details` appears to count only the default `agents/` directory and
miss a custom `agents` path.

It is a reporting bug, not a delivery failure. Do not "fix" a working manifest on its
say-so — check a real session instead, which is what settled it here.

## Blocker: installing from GitHub needs this merged first

```
claude plugin marketplace add jthoyer/agent-skills-library
× Failed: Marketplace file not found at …/.claude-plugin/marketplace.json
```

It clones the repo's **default branch**, and `.claude-plugin/` exists only on
`claude/friendly-ride-sl241p`. Confirmed: `git ls-tree origin/main -- .claude-plugin`
returns nothing. Merge first, then the GitHub install works.

## The finding that changes the plan: cloud sessions are not covered

The install wrote to this container's `~/.claude/plugins/`. Cloud containers are
ephemeral and provisioned fresh, so the next cloud session starts with no plugins at all.
Installing here proves the mechanism; it does not persist.

`~/.claude/plugins/synced/<account-id>/` exists but is **empty**. That is the account
distribution slot — the same shape as `~/.claude/skills/synced/<account-id>/`, which is
full and is why 37 skills reach every cloud session. Per the plugin docs, populating the
plugin slot is Organization settings → Plugins, which needs Team or Enterprise. This is a
personal account.

**Consequence: do not revert the four snapshot PRs.** A committed `.claude/agents/` is
still the only thing that puts an agent in a cloud session. The plugin solves the local
Mac case completely and the cloud case not at all.

Open question, not settled here: whether any personal-account path can populate
`plugins/synced/`. Worth one check in claude.ai settings before accepting the split.

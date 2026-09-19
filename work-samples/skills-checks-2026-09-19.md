# Work sample — bringing the skills tree under the library's checks (2026-09-19)

Session: cloud, branch `claude/cos-agents-skills-review-knxroh`, library root `/home/user/agent-skills-library`.
Dispatch probe: **resolved negative** — no Agent/Task tool in the session's tool list. Every role
below was **embodied**, never delegated.

## Baseline before any change

```
scripts/check-frontmatter.sh   → 16 agents: frontmatter and trailing lines clean.   exit 0
scripts/check-references.sh    → All asserted paths resolve.                        exit 0
scripts/sync-plugin-manifest.sh --check → plugin.json agents list is current (16).  exit 0
```

38 skills, 0 of them checked by anything. `check-references.sh` excluded the whole
`.claude/skills/` tree; `check-frontmatter.sh` never looked at it.

## What the extended checks found on their first run

| Finding | File | Class |
|---|---|---|
| Frontmatter **does not parse as YAML** — `description:` is an unquoted plain scalar containing `Triggers on: market analysis`; a colon-space makes YAML read a nested mapping. `mapping values are not allowed here`, line 2 col 779. | `.claude/skills/market-analyst/SKILL.md` | live defect, fixed |
| Index declares **49 skills**, lists 11 icare skills + `content-writing` (retired 2026-09-06 / 09-11), omits `rewrite` (live since 09-11); sub-file counts also wrong (said 7 carry `references/`, actually 9; `scripts/` not mentioned). 12 errors. | `.claude/skills/README.md` | live defect, fixed |
| Two live skills name **retired skills** — `icare-expert`, `icare-tone-of-voice`. Not a path, so no script can see it. | `notion-second-brain/SKILL.md:149`, `justin-voice/SKILL.md:148` | open, logged |

## A false positive caught before it shipped

The first implementation used `wc -m` for description length and reported `red-team` at **1,025**
characters — over the 1,024 cap. A real YAML parser says **1,021 characters / 1,025 bytes**: `wc -m`
counts bytes under a C locale, which is what CI runs under, and these descriptions carry em dashes
at 3 bytes each. Measurement replaced with a locale-independent codepoint count (drop UTF-8
continuation bytes `\200-\277`, then count). `red-team` has 3 characters of headroom, not −1.

The same correction applies to the agents half, which previously counted bytes *and* line
indentation. One shared `desc_len()` now serves both, matching skills-librarian's stated method.

## Decoy and control matrix

Each injection made against a live file, checked, then restored. `expected` is what the brief's
falsifiable test requires.

| # | Injection | Expected | Result |
|---|---|---|---|
| 1 | `name: first-principle` (≠ directory) | fail | `FLAG skill NAME!=DIRNAME` — exit 1 |
| 2 | plain-scalar description with `Triggers on: ...` | fail | `YAML-UNQUOTED-COLON` + `YAML-PARSE-ERROR` — exit 1 |
| 3 | description padded past 1,024 | fail | `DESC>1024(1891)` — exit 1 |
| 4 | live skill removed from the README list | fail | `FLAG index ON-DISK-NOT-IN-README` — exit 1 |
| 5a | dead pointer `references/nonexistent-playbook.md` | fail | **passed — false negative**, see below |
| 5b | dead pointer `references/worked-example.md` | fail | `UNRESOLVED` — exit 1 |
| 5c | dead repo-root pointer `scripts/check-skills.sh` | fail | `UNRESOLVED` — exit 1 |
| 6 | `references/actors.md` — exists in *another* skill | fail | `UNRESOLVED` — exit 1 (cross-skill leak closed) |
| 7 | `~/.claude/skills/first-principles/SKILL.md` | **pass** | passed — exit 0 (narrow exemption works) |
| 8 | `~/.claude/agents/CPO.md` inside a skill | fail | `HOME-PATH` — exit 1 (exemption is narrow, not blanket) |

**5a is the interesting one.** It passed because the decoy filename contained the word
"nonexistent", which is in the script's own negation regex — so the token **exempted itself**. A
dead pointer could be hidden by naming it after the excuse. Fixed: backticked spans are now
stripped before the negation match, so the negation is read from the prose and never from the path.
Re-run after the fix: `UNRESOLVED`, exit 1.

That defect was only visible because the decoy was chosen carelessly. It is a genuine finding
against the 2026-09-13 implementation, not against the skills extension.

## After

```
scripts/check-frontmatter.sh   → 16 agents and 38 skills: frontmatter and trailing lines clean.  exit 0
scripts/check-references.sh    → All asserted paths resolve.                                     exit 0
scripts/sync-plugin-manifest.sh --check → plugin.json agents list is current (16 agents).        exit 0
```

Tokens resolved by the reference check: **28 → 74**.

## Notes on scope

`.claude/skills/CHANGELOG.md` is excluded from the reference check, on the rule the script already
applied to the root ledger: a CHANGELOG records paths as they *were*, including every sub-file of a
retired skill. 25 of the 54 findings on the first skills-inclusive run came from it, every one a
correct record of something deliberately gone.

`_retired/` stays excluded as an unmodified archive.

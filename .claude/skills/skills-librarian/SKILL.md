---
name: skills-librarian
description: >
  Governs creation, maintenance, auditing, upgrading, and retirement of Justin's personal Claude
  skills library at /mnt/skills/user/, and inventory of the read-only public, examples, and plugin
  scopes. Use whenever the task involves: creating a skill, merging or trimming skills, fixing
  malformed YAML frontmatter, validating the 1,024-character description limit, updating the
  CHANGELOG, running a library audit, mapping trigger overlaps, backing up to Notion's AI Skills
  DB, or testing whether a skill still earns its place. Trigger on: "create a skill", "merge these
  skills", "audit the library", "fix the frontmatter", "check the description length", "update the
  CHANGELOG", "backup to Notion", "trim this skill", "install this skill", "upgrade this skill",
  "benchmark this skill", "does this skill beat no skill", "should I retire this skill", or any
  task touching the skills directory or library health. Always use before writing or modifying any
  SKILL.md — it enforces the standards that keep the library reliable.
metadata:
  version: 2.2.0
---

# Skills Librarian

Governs creation, maintenance, audit, upgrade, and retirement of the personal Claude skills
library. Build every change in `/home/claude/`, then deliver to `/mnt/user-data/outputs/` for
install. Treat every path under `/mnt/skills/` as read-only.

---

## Scopes and editability

Four scopes are visible at runtime. Establish which one a skill lives in before proposing any
change to it — the answer determines what is possible.

| Scope | Contents | Editable | Handling |
|---|---|---|---|
| `/mnt/skills/user/` | Justin's own skills | Yes, via outputs + reinstall | Authoritative. All upgrades land here. |
| `/mnt/skills/public/` | Anthropic-maintained | No | Cite and defer to. Fork only with an explicit reason recorded in the CHANGELOG. |
| `/mnt/skills/examples/` | Anthropic examples | No | Mine for patterns and reusable agents. `skill-creator` is the canonical creation and eval protocol. |
| `/mnt/skills/plugins/` | Installed plugin bundles | No | Namespaced `plugin:skill`. A user skill that duplicates a plugin skill is a retirement candidate. |

`/mnt/skills/private/` appears in some environments. Check for it before assuming the inventory is
complete.

Inventory every scope with a live command rather than a remembered figure. Counts drift:

```bash
for d in user public examples private plugins; do
  [ -d /mnt/skills/$d ] && echo "$d: $(ls /mnt/skills/$d | wc -l)"
done
```

For each skill record: scope, path, editable yes/no, purpose in one line, description character
count, body line count, sub-files present, declared cross-references, and any skill whose trigger
phrases overlap it. Overlap is the most common cause of a skill failing to fire.

---

## What belongs in a skill

**A skill should primarily contain what the model could not reasonably know or reliably infer on
its own.** Everything else is cost: it consumes context, dilutes the instructions that matter, and
makes the skill harder to maintain.

Apply this as a per-line test when creating or trimming.

**Keep**
- Private facts: scheme mechanics, brand values, database schemas, file paths, real figures
- House standards and formats Justin has specifically chosen over the obvious default
- Hard-won corrections: the mistake that was made once and should not recur
- Non-obvious measurement or validation rules (how the description limit is actually counted)
- Named frameworks applied in a specific, non-generic way
- Boundaries: when the skill should stay quiet and hand off to another skill

**Cut**
- Generic best practice the model already applies
- Restatements of clear writing advice
- Motivational framing and preamble
- Procedural scaffolding the model would follow unprompted
- Statistics, counts, and dates that go stale — replace with the command that regenerates them
- Anything derivable by reading the environment

A skill that survives this test and still loses to the no-skill baseline is a retirement candidate,
not a rewrite candidate. See `references/upgrade-gauntlet.md`.

---

## Library standards

### Directory structure

```
/mnt/skills/user/<skill-name>/
└── SKILL.md          ← required; YAML frontmatter + markdown body
    references/       ← optional supporting files, loaded on demand
    scripts/          ← optional executable helpers
    assets/           ← optional templates, fonts, icons used in output
```

### Frontmatter spec

```yaml
---
name: skill-name           # matches directory name exactly
description: >             # HARD LIMIT: 1,024 chars (measured as joined single-line string)
  Trigger description...
license: MIT               # optional
metadata:                  # optional block
  author: ...
  version: x.y.z
---
```

### Description character limit — how to measure

The 1,024-character limit applies to the description as a **single joined string**: strip the
`description: >` line, strip leading whitespace from continuation lines, join with single spaces.

```python
import re, sys
content = open(sys.argv[1]).read()
fm = re.search(r'^---\n(.*?)\n---', content, re.DOTALL).group(1)
d = re.search(r'description: [>|]?\n?(.*?)(?=\n\w|\Z)', fm, re.DOTALL).group(1)
desc = ' '.join(l.strip() for l in d.strip().splitlines())
print(len(desc))  # must be ≤ 1,024
```

Run this before installing any new or modified skill.

### Body guidelines

- Target under 500 lines. Move anything beyond ~100 lines of supporting content into `references/`
  with an explicit pointer stating when to read it.
- Give reference files over 300 lines a table of contents.
- Cross-reference related skills in a "Related Skills" section, and verify each named skill exists.
- Write in the imperative. Explain why a constraint exists rather than stacking emphatic capitals.

### Positive directive framing

Write instructions as what to do, not what to avoid. Prohibitions are weaker instructions: they
describe the failure without specifying the replacement, and a model steered away from one bad
option still has to guess at the good one.

| Instead of | Write |
|---|---|
| Don't be vague | State the specific figure or name |
| Never use jargon | Use the plain-English equivalent on first mention |
| Avoid long paragraphs | Keep paragraphs to three or four sentences |

Keep a negative form only where the prohibition is the requirement itself — safety limits, legal
constraints, things that must never appear in output. Audit new and edited skills for this before
install.

---

## Change safety

Do all four before editing any skill:

1. **Snapshot the original.** `cp -r /mnt/skills/user/<name> /home/claude/snapshots/<name>-<date>/`.
   Every upgrade must be reversible from this copy.
2. **Never edit in place** under `/mnt/skills/`. Build in `/home/claude/`, deliver to
   `/mnt/user-data/outputs/`.
3. **Version the frontmatter.** Increment `metadata.version` on every substantive change.
4. **Record the change** in the CHANGELOG, including what was removed and why.
5. **Zip the changed skill, inside its own folder**, ready for the claude.ai upload step (see
   `README.md` § "Two surfaces, one repo" — Claude Chat does not read this git repo, so the zip is
   the actual delivery artifact for that surface). From the skill's own directory:

   ```bash
   cd <skill-name> && zip -r -X "<skill-name>.zip" . -x ".*" "*.zip" && cd -
   ```

   `-X` drops macOS resource forks and `-x ".*" "*.zip"` excludes dotfiles and any previous zip, so
   the archive holds only `SKILL.md` and its `references/`/`scripts/`/`assets/` — no `__MACOSX/`
   junk, no self-inclusion. The zip is a build artifact, not a versioned one: overwrite it in place
   on every change rather than dating the filename, and don't commit it (add `*.zip` to
   `.gitignore` at the library root if it isn't there already).

Deliver the reverting copy alongside the upgrade so a rollback needs no reconstruction.

---

## Workflows

### 1. Create a new skill

1. Read `/mnt/skills/examples/skill-creator/SKILL.md` — the canonical creation and eval protocol.
2. Gather: name, trigger intent, output format, related skills, boundaries.
3. Check for overlap against all four scopes before writing a line. A near-duplicate of an existing
   skill competes with it and both fire unreliably.
4. Draft in `/home/claude/<skill-name>/`, applying the "what belongs in a skill" test to every line.
5. Validate: description character count, frontmatter parses, name matches directory, cross-
   references resolve.
6. Test against realistic prompts, including at least one where the skill should *not* fire.
7. Deliver to `/mnt/user-data/outputs/<skill-name>/`, add a CHANGELOG entry.

### 2. Merge two skills

1. Read both SKILL.md files in full, plus their sub-files.
2. Extract what each is actually for before choosing a backbone — merging on structure alone loses
   the weaker skill's real contribution.
3. Take the stronger structural backbone, usually the more recently updated.
4. Absorb the unique sections from the other skill; integrate rather than append.
5. Rewrite the description to cover both trigger sets; validate the character count.
6. Name the merged skill after the primary use case.
7. CHANGELOG the merge with rationale; mark the absorbed skill for removal and keep its snapshot.

### 3. Trim a bloated skill

1. Snapshot first.
2. Apply the keep/cut test line by line. Record what was cut and why — the record is what makes the
   trim defensible if quality drops.
3. Where a cut is contentious, test it rather than argue it: run the trimmed and original versions
   on the same tasks and compare blind (`references/upgrade-gauntlet.md`, lightweight mode).
4. Re-validate character count and cross-references.

### 4. Audit the library

**Open by reading the newest `Next audit targets:` line in `CHANGELOG.md`, and audit those skills
first.** It is a queue, not a suggestion — say so if you are departing from it and why. Without this
step the order falls out of whichever skill was touched most recently, which is recency, not
priority. This library has now watched that happen four separate times with four different
artefacts, always the same shape: the record was written and nothing was told to read it.

**Then run the mechanical checks rather than redoing them by hand.** In the git repo they are two
commands, they exit non-zero on a finding, and they run in CI on every push:

```bash
scripts/check-frontmatter.sh --list    # per-skill inventory, then the flags
scripts/check-references.sh            # every asserted path, resolved against disk
```

Between them they cover description length, YAML validity, name-matches-directory, body length,
trailing artefacts, sub-file resolution and the README index. A clean run is a result you can
quote. Where you are working in the claude.ai environment with no repo checked out, fall back to
the table below by hand — and note in the CHANGELOG that the numbers were hand-generated.

| Check | Method | Mechanised? |
|---|---|---|
| Description ≤ 1,024 chars | Python script above, across all SKILL.md files | yes |
| Frontmatter parses | `---` opens and closes, no tabs, no unquoted colon-space in a plain scalar | yes |
| Name matches directory | `name:` field equals the folder name | yes |
| Body under 500 lines | `wc -l` across all SKILL.md files | yes |
| Sub-files resolve | Every `references/<name>.md` the body names exists **in that skill** | yes |
| README index current | Every skill on disk is listed, and nothing listed is gone | yes |
| Trigger conflicts | Near-identical descriptions compete — flag and resolve | no — judgement |
| Cross-references resolve | Every **skill name** in the body still exists | no — do this by hand |
| Cross-scope duplication | User skills that duplicate a public or plugin skill | no — judgement |
| Negative framing | Prohibitions that should be positive directives | no — judgement |
| Staleness | Hardcoded counts, dates, or "as of" snapshots inside skill bodies | partly |

Output an audit table: Skill | Scope | Chars | Lines | Issues | Verdict (Keep / Merge / Trim / Fix /
Test / Retire).

The unmechanised rows are where the findings now are, so spend the time there. A dead **skill name**
is the live example: it is not a path, so no script sees it, and two are open right now
(`notion-second-brain:149`, `justin-voice:148`, both naming skills retired on 2026-09-11). A skill
whose body says "load `references/<name>.md`" when no such file is present degrades silently — the model
improvises and no error surfaces — and that half is now caught for you.

**Close every audit by writing the next `Next audit targets:` line**, naming three skills with one
clause of evidence each. An audit that ends without one hands the next run nothing.

### 5. Fix malformed frontmatter

- **Unclosed YAML block** — add the closing `---`
- **Tabs instead of spaces** — replace with 2-space indent
- **Multi-line description without a block scalar** — add `>` or `|`
- **Name mismatch** — correct the `name:` field to the directory name
- **Over-limit description** — trim the least-specific trigger phrases, preserve the core use case
  and the distinctive trigger words

### 6. Upgrade a skill and prove the upgrade

Read `references/upgrade-gauntlet.md`. It covers the full protocol, written for this environment
rather than Claude Code: freezing an implementation-neutral outcome contract, building a benchmark
with a sealed held-out set, running no-skill / original / candidate on the active model since
there's no subagent to run them independently, self-grading against the frozen contract with the
person's own read deciding close calls, and the acceptance standard that separates a real
improvement from a lucky sample.

Match the depth to the stakes:

| Situation | Depth |
|---|---|
| Typo, broken link, frontmatter fix | Fix and install. No evaluation. |
| Small addition, tightened wording | Snapshot, 3–5 tasks, blind A/B against the original. |
| Structural rewrite, merge, or contested trim | Full gauntlet, all arms, sealed held-out set. |
| "Is this skill still worth having?" | Full gauntlet — the no-skill arm is the question. |

### 7. Retire a skill

Retirement is a successful outcome, not a failure. Retire when any of these hold, and record the
evidence:

- The model performs as well or better without the skill on the same tasks
- A public or plugin skill covers the same ground and is maintained by someone else
- Its triggers overlap another skill so heavily that both fire unreliably
- Its content is now generic — everything specific has migrated elsewhere or become obvious
- It has not fired in real use and no realistic trigger can be written for it

Archive rather than delete: keep the snapshot, archive the Notion page, and CHANGELOG the removal
with the evidence that justified it.

### 8. Update the CHANGELOG

`CHANGELOG.md` belongs at the library root. Create it if absent.

```markdown
## [date] — vX.Y

### Added
- `skill-name` — brief rationale

### Merged
- `skill-a` + `skill-b` → `skill-name` — reason

### Updated
- `skill-name` — what changed, what was removed, and why

### Retired
- `skill-name` — evidence for retirement / what replaced it
```

### 9. Notion backup

The AI Skills DB in Notion mirrors the library.

1. `notion-search` for "AI Skills DB" to get the database ID
2. `notion-fetch` the database to confirm the schema before writing (fields have changed before)
3. Create or update pages for new and changed skills
4. Archive pages for retired skills — preserve history
5. Set `Backup Date` to today

Batch creates in groups of 10 or fewer per call to avoid timeouts. `notion-second-brain` governs
the database architecture; this skill governs what gets synced.

---

## Related Skills

- `notion-second-brain` — Notion database architecture and the backup workflow in detail
- `red-team` — attack a skill's design before committing to it
- `prompt-refiner` — routes to skills; keep its routing table current after any add, merge, or retire
- `/mnt/skills/examples/skill-creator` — canonical creation and evaluation protocol, plus reusable
  blind comparator, grader, and analyser agents

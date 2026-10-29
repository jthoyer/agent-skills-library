---
name: skills-librarian
description: >
  Governs creation, maintenance, auditing, upgrading, and retirement of Justin's personal Claude
  skills library (source of truth: the agent-skills-library git repo; claude.ai is an upload
  target), and inventory of the read-only public, examples, and plugin scopes. Trigger on: "create a skill", "merge these
  skills", "audit the library", "fix the frontmatter", "check the description length", "update the
  CHANGELOG", "backup to Notion", "trim this skill", "install this skill", "upgrade this skill",
  "benchmark this skill", "does this skill beat no skill", "should I retire this skill", or any
  task touching the skills directory or library health. Always use before writing or modifying any
  SKILL.md — it enforces the standards that keep the library reliable.
metadata:
  version: 2.4.0
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
| `/mnt/skills/user/` | Justin's own skills, as installed on claude.ai | Yes, via outputs + reinstall | The install surface, not the source. Upgrades land in the agent-skills-library repo first; upload the zip here after. |
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
.claude/skills/<skill-name>/      (in the repo; /mnt/skills/user/<skill-name>/ once installed)
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

- Keep `SKILL.md` under 500 lines and use it as a directory. Move anything beyond ~100 lines of
  supporting content into `references/` with an explicit pointer stating when to read it.
- Link every reference file directly from `SKILL.md`, one level deep. A file reachable only
  through another reference is the kind Claude reads partially or misses.
- Give any reference file over 100 lines a `## Contents` list near the top. Claude often previews
  only the first 100 lines; the list lets it jump to the section it needs.
- State each script's dependencies on a `Requires:` line beside the command that runs it: runtime
  version, packages with their install command, and any network host it calls. Never assume a
  package is installed — environments differ, and a missing one fails silently.
- Cross-reference related skills in a "Related Skills" section, and verify each named skill exists.
- Write in the imperative. Explain why a constraint exists rather than stacking emphatic capitals.

### Degrees of freedom

Match how prescriptive an instruction is to how fragile the task is.

| Freedom | Task shape | Write | Example |
|---|---|---|---|
| High | Many good answers; judgement matters | Plain-text guidance and the reason behind it | Code review, drafting a post |
| Medium | A preferred shape, some variation fine | A template with the variable parts marked | Client report, run template |
| Low | One right sequence; a slip is costly | An exact script or command, plus "do not change" | Migration, financial write, publish step |

Prescribing a high-freedom task wastes context and flattens output. Leaving a low-freedom task
loose invites the one mistake that matters. Newer models need less instruction than older ones,
so test on the models the skill will run on before adding detail (`references/upgrade-gauntlet.md`
§4.3).

### Ordered workflows and self-checks

- **Checklist.** Where a workflow has steps whose order matters, give a short copyable checklist
  (`- [ ]` lines in a code block) and tell Claude to paste it into its reply and tick each line.
  A ticked list survives a long run; a prose sequence gets skipped.
- **Feedback loop.** Where a skill has a guide to meet (brand rules, voice characteristics, a
  validator script), add the loop explicitly: check against the guide, name each miss, fix, check
  again, stop when a pass is clean or after a stated number of rounds.

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

Do all five before editing any skill:

1. **Edit in the library repo, on a branch.** The agent-skills-library repo is the source of
   truth (its root `CLAUDE.md`). Git history is the snapshot: every upgrade is reversible from
   the commit before it, and lands through a pull request.
2. **Never edit in place** under `/mnt/skills/` (Claude Chat's install surface). Change the
   repo first; the zip in step 5 carries it to claude.ai.
3. **Version the frontmatter.** Increment `metadata.version` on every substantive change.
4. **Record the change** in the CHANGELOG, including what was removed and why.
5. **Zip the changed skill, inside its own folder**, ready for the claude.ai upload step (see
   `README.md` § "Surfaces" — Claude Chat does not read this git repo, so the zip is the actual
   delivery artifact for that surface). claude.ai looks for `<skill-name>/SKILL.md` inside the
   archive and rejects a `SKILL.md` at the top level, so zip the folder, not its contents. From
   `.claude/skills/`:

   ```bash
   zip -r -X "<skill-name>.zip" "<skill-name>" -x "*/.*" "*.zip"
   unzip -Z1 "<skill-name>.zip"    # every line must start with <skill-name>/
   ```

   `-X` drops macOS resource forks and `-x "*/.*" "*.zip"` excludes dotfiles and any previous zip,
   so the archive holds only the folder with `SKILL.md` and its `references/`/`scripts/`/`assets/`
   — no `__MACOSX/` junk, no self-inclusion. The zip is a build artifact, not a versioned one: overwrite it in place
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
   Then ask whether plain Claude already does the job. A skill goes in only if it beats no skill
   on a recorded test (the admission test, below).
4. Draft in `/home/claude/<skill-name>/`, applying the "what belongs in a skill" test to every line.
5. Validate: description character count, frontmatter parses, name matches directory, cross-
   references resolve.
6. Test against realistic prompts, including at least one where the skill should *not* fire.
7. **Run the admission test before it goes in.** It has to beat no skill. The method is in
   `.claude/references/admission-test.md` in the library repo: follow that file rather than
   this summary. The gauntlet's self-graded mode doesn't count, so run it from Claude Code or
   have the owner grade blind. If it fails, it doesn't go in.
8. Commit the evidence to `work-samples/admission-<name>-<YYYY-MM-DD>/` in the repo, then add a
   `passed` row to `ADMISSIONS.md` at the library root, pointing at it. CI
   fails on a skill without one. Then deliver to `/mnt/user-data/outputs/<skill-name>/` and add
   a CHANGELOG entry.

### 2. Merge two skills

1. Read both SKILL.md files in full, plus their sub-files.
2. Extract what each is actually for before choosing a backbone — merging on structure alone loses
   the weaker skill's real contribution.
3. Take the stronger structural backbone, usually the more recently updated.
4. Absorb the unique sections from the other skill; integrate rather than append.
5. Rewrite the description to cover both trigger sets; validate the character count.
6. Name the merged skill after the primary use case.
7. CHANGELOG the merge with rationale; mark the absorbed skill for removal and keep its snapshot.
8. Update `ADMISSIONS.md`: remove the absorbed skill's row. If the merged skill claims new
   behaviour, run the admission test on it first.

### 3. Trim a bloated skill

1. Snapshot first.
2. Apply the keep/cut test line by line. Record what was cut and why — the record is what makes the
   trim defensible if quality drops.
3. Where a cut is contentious, test it rather than argue it: run the trimmed and original versions
   on the same tasks and compare blind (`references/upgrade-gauntlet.md`, lightweight mode).
4. Re-validate character count and cross-references.

### 4. Audit the library

Read `references/audit.md` and follow it. Open by reading the newest `Next audit targets:` line in `CHANGELOG.md` and audit those skills first. Close by writing the next `Next audit targets:` line. An audit that ends without one hands the next run nothing.

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
with the evidence that justified it. Remove the skill's row from `ADMISSIONS.md` in the same
commit; CI flags a row with nothing on disk behind it.

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
- `cpo` — routes to skills; keep `.claude/skills/cpo/references/routing.md` current after any add, merge, or retire
- `/mnt/skills/examples/skill-creator` — canonical creation and evaluation protocol, plus reusable
  blind comparator, grader, and analyser agents

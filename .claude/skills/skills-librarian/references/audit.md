# Audit the Library

Moved verbatim from `SKILL.md` on 2026-10-20 to keep the body short.

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
scripts/check-skill-structure.sh       # contents lists, one-level references, Requires: lines
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
| Contents lists | Every reference file over 100 lines has `## Contents` near the top | yes |
| One level deep | Every `references/` file is named in its own `SKILL.md` | yes |
| Dependencies stated | Every skill with `scripts/` has a `Requires:` line | yes |
| Degrees of freedom | Detail matches fragility: no scripted drafting, no loose migrations | no — judgement |
| Checklists and loops | Ordered workflows have a checklist; guided outputs have a check-fix loop | no — judgement |

Output an audit table: Skill | Scope | Chars | Lines | Issues | Verdict (Keep / Merge / Trim / Fix /
Test / Retire).

The unmechanised rows are where the findings now are, so spend the time there. A dead **skill name**
is the live example: it is not a path, so no script sees it, and two are open right now
(`notion-second-brain:149`, `justin-voice:148`, both naming skills retired on 2026-09-11). A skill
whose body says "load `references/<name>.md`" when no such file is present degrades silently — the model
improvises and no error surfaces — and that half is now caught for you.

**Close every audit by writing the next `Next audit targets:` line**, naming three skills with one
clause of evidence each. An audit that ends without one hands the next run nothing.

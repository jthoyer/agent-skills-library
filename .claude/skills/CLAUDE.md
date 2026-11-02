# Rules for editing skills

Read `skills-librarian/SKILL.md` before you create, merge, trim or retire a skill. These are
the rules CI enforces, so you meet them before the push, not after.

- **The directory name is the address.** `name:` in the frontmatter must match it.
- **Description: 1,024 characters at most.** Longer is cut off silently, and the cut part
  never triggers. Never end it in "..." or "…".
- **Body: 500 lines at most.** Over that, move detail into `references/` with a pointer. Don't
  delete it.
- **Every `references/` file is named in its own SKILL.md.** A file reached only through
  another reference is too deep. Over 100 lines, it opens with a contents list. Both rules
  cover subfolders. A file in a subfolder may instead be named by a pattern for its folder,
  with the variable part in brackets. In `interview-coach`, `references/commands/[command].md`
  names every `.md` file in its commands folder. Top-level files are named one by one.
- **Scripts state their needs** on a line starting `Requires:`, next to where SKILL.md runs them.
- **Every pointer resolves.** A reference file named in skill A must exist in skill A's own
  `references/` folder. Never point into the home `.claude` folder, other than its skills
  folder; it doesn't exist in a cloud session.
- **Add each new skill to `README.md`**, the index. A skill missing from it fails CI.
- **A new skill has to beat no skill first.** Run the admission test
  (`.claude/references/admission-test.md`), then add a `passed` row to `ADMISSIONS.md` that
  points at its work sample. A skill without a row fails CI, and so does a new `grandfathered`
  row.
- **`_retired/` is an archive.** Don't edit inside it; a hook blocks that. Retire a skill with
  `git mv`, and log it in `CHANGELOG.md` in this folder.

Check before you push: `bash scripts/check-frontmatter.sh`, `bash scripts/check-references.sh`,
`bash scripts/check-skill-structure.sh` and `bash scripts/check-admissions.sh`, from the repo root. The push hook runs them anyway.

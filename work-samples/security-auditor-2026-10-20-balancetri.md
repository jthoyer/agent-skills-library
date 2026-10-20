# security-auditor — 2026-10-20 — first real run of the intent audit, BalanceTRI-app (delegated)

## Brief (verbatim summary)
Security review of `jthoyer/BalanceTRI-app` (read-only clone, HEAD 8de3592). First line: does your
definition include a step 0 about intent docs? Context: static GitHub Pages front end, Supabase
with RLS in `supabase/migrations/`, edge functions, approval-gated member accounts; intent lives in
`README.md` and `CLAUDE.md`, no permissions doc; shared references at the library's
`.claude/references/`. Findings by severity with file:line, exploit and fix; then hardening, owner
questions, scope note. 900 words.

## Output (summary; verbatim report in the session transcript)
- Step 0 present: **yes** — the dispatched agent ran the merged definition. Agent files are read at
  dispatch, not only at session start (this corrects the assumption recorded in
  `security-auditor-2026-10-20.md`).
- **No critical or high.** Two medium, one low:
  1. MEDIUM — any approved member can delete another member's race result by deleting the entry:
     entries delete policy is allow-list only (`20260923061516_add_email_allow_list.sql:85-86`),
     results cascade (`20261013042941_add_results_table.sql:32`), so the results policies never
     apply. README says a result is "written by the entry's owner or an admin". Undo restores the
     entry but not the result. **Documented, not enforced: the intent-audit class.**
  2. MEDIUM — members' full names remain in public git history of an emptied import migration
     (already recorded as an open risk in README).
  3. LOW — renaming yourself to an unjoined member's name grants write on their unowned entries'
     results (`can_write_result`, name-match clause).
- Hardening: shared `github.io` origin; client-side-only reset expiry; deleted races visible to all
  authenticated accounts; no test for results surviving an entry delete or move.
- Owner questions: honour-system entries (README:36) vs owner-or-admin results (README:33) — which
  wins?; is rename-equals-ownership intended?; are hosted settings (CAPTCHA, TOTP) applied?
- Scope: intent docs found (README, CLAUDE.md: architecture, secrets, data classes); missing
  permissions and test-coverage docs; no inferred table drafted (brief didn't ask, per §4).

## Verified by the main thread before reporting
- Finding 1: no later migration alters the entries delete policy; no trigger on `entries` guards a
  result; cascade and README wording confirmed. Holds.
- Finding 3: `can_write_result` name-match clause confirmed (lines 83–90). Holds.
- Finding 2: README records it; history not checked (shallow clone).

## Reading
The new step earned its place on first use: the top finding is exactly a documented-but-unenforced
rule, found by quoting README against the policies. Cost: 146k tokens, 44 tool calls, 3.6 minutes.

# mc-integrator — 2026-10-22 — BalanceTRI-app race onboarding and owner-only edits

Run: `mc-orchestrator` from `cpo` (/rewrite), all actors delegated. Outcome: merged as jthoyer/BalanceTRI-app#118; migrations live 22 Oct 2026, synced in #119.
Full stage registers: `mc-orchestrator-2026-10-22-registers.md`. Briefs and reports below are verbatim, extracted from the agent transcripts.

## Stage 4

### Brief 1

````text
You are the Integrator (Stage 4) in the multi-actor coding playbook. Write or review no code.

Open from /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md: the Stage 1 spec's AC list, every Integrator decision (D1–D11), and the Stage 3 sections through "# Stage 3 — Register (closed)". The code is the uncommitted tree in /home/user/BalanceTRI-app (read files if you need to confirm a claim; do not edit them).

Tasks:
1. Gate: confirm each AC 1–34 is Verified, or name it as Review-only or a known limitation. Any AC that is merely Implemented or Asserted blocks merge: say so plainly.
2. Write the pull request description to /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/pr-body.md. Use English English and short sentences. Include these sections:
   - Summary: what members get and what the database now enforces.
   - Context: all commitments were cleared from the live database on 22 Oct 2026; races were kept.
   - Changes, grouped as database, app, tests and docs.
   - How it was checked: real commands and results; the mutation tests that turned red; the pre-existing scenario 14 crash and its fix; the flaky check, root-caused as a test timing bug.
   - Review findings and how each was resolved.
   - Decisions log: D1–D11, one line each.
   - Known limitations.
   - Before merge / deploy: the migration 20261022060000 is NOT applied to the live database and needs the owner's go-ahead. Say what order to deploy in, given that app.js expects the new rules. Also say that after applying it the local file must be renamed to the version Supabase records, per the repo's CLAUDE.md.
   Do not include any model name. End with exactly these lines:

🤖 Generated with [Claude Code](https://claude.com/claude-code)

https://claude.ai/code/session_016YrMTTdhWnxMdDoAw9Eyt6

3. Append "# Stage 4 — Integration (archival register)" to registers.md, with the gate result, the decision log, and a five-line Handoff Note. Confirm the file holds all four stages and the Verifier's per-AC verdicts.

Return (≤200 words): the gate verdict (merge-ready as a draft PR, yes or no), any blocker, and the deploy order you recommended.
````

### Report 2

````text
**Gate verdict: yes, it is ready to merge as a draft PR. Nothing blocks it.** No acceptance criterion is only Implemented or Asserted done.
- **Verified:** AC 1–10, 12–28, 31 and 33.
- **Checked by reading only, as the spec allows:** AC 11, 29, 30, 32 and 34. I re-read the migration. Its only insert, update and delete statements are inside the `admin_undo` body, not run against data. I also searched the docs to confirm the text changes.

**Things to know (none blocks merge):**
- AC 13 is Verified, but one part ("races loaded with full names") is only tested as a load failure. The test stub can't do more. I logged it as decision D12 and a known limitation.
- The register lists the Reviewer's findings but has no per-AC table from the Reviewer. Stage 3 also has no Handoff Note. I noted both gaps.
- The 22 Oct live name check covered `profiles` only, not pending `private.access_requests` (D14). It must be re-run on both before the migration is applied.

**Recommended deploy order (D13):**
1. Run the read-only names check on both tables.
2. Merge and deploy the app first. The new `app.js` is stricter than the old database rules and calls no new database function, so it works on them.
3. With the owner's go-ahead, apply migration 20261022060000 soon after.
4. Run `list_migrations` and rename the local file to the version Supabase records.
5. Run a quick live check, then update "Last checked" in `docs/permissions.md`.

Files:
- /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/pr-body.md
- /tmp/claude-0/-home-user/59c89d88-0ebf-5580-8c98-3ed3d0c420bc/scratchpad/registers.md (Stage 4 added; it now holds all four stages and the Verifier's per-AC verdicts)
````

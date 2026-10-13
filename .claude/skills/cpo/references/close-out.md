# Close-out: how a run improves the library

Read this whenever an agent ran. The point is that every run leaves something the next
review can grade, and a queue that says what to review next.

## Contents

- Where things live
- The four steps
- The ledger entry
- Independence
- When there is nothing to review

## Where things live

Paths are relative to the library repo root. Resolve it first:

```bash
LIB=$(git -C "$(pwd)" rev-parse --show-toplevel 2>/dev/null); echo "library root: $LIB"
```

- Ledger: `CHANGELOG.md` at the repo root (current month). Closed months are in
  `changelog/YYYY-MM.md`, older history in `CHANGELOG-ARCHIVE.md`.
- Work samples: `work-samples/<agent>-<YYYY-MM-DD>.md` (`-passN` for several).
- Skills ledger: `.claude/skills/CHANGELOG.md`.

There is no ledger inside `.claude/agents/`. `~/.claude/` does not resolve in a cloud
session.

**In a repo that vendors the agents but has no `CHANGELOG.md`** (for example
`balancetri-app`), the ledger is unreachable. Do not create one there. Say "ledger
unreachable from <root>", do the work, and return the sample and entry text to the user
for the library's ledger.

## The four steps

1. **Save the work sample now**, in the repo, not the scratchpad: the brief verbatim, the
   output verbatim, and any disk-verified outcome. A sample in a temp directory is lost
   evidence.
2. **Dispatch `agent-improver`** on each agent whose output mattered. Hand it four things:
   the definition's absolute path, the brief, the output (or the sample path), and the
   specific gap in one sentence. Paste the latest `Next audit targets:` line into the
   brief and say it is the queue. Press hardest when the output needed rework, ignored a
   stated constraint, came back in the wrong shape, or stopped early.
3. **Dispatch `watchdog`** on the artefact if it ships, merges, or goes to members, the
   committee or leadership.
4. **Write one ledger entry** (below). Confirm it landed.

A Notion backlog row is owed only for a finding still open at the end of the run.
Backlog: data source `collection://3b9cfee1-ca18-80ac-93b2-000bbbed14bc` (`Name` as
`[Component/Agent] short description`, `Priority` P0–P3, `Rank` at `max(Rank) + 1`,
`Status` Pending/Done). Check for an existing row first. If no Notion tool is reachable,
say so.

## The ledger entry

- Insert at the **top** of `CHANGELOG.md`, directly under
  `<!-- New entries below this line, newest first -->`. Never at the end: readers whose
  `Read` truncates never reach it.
- **250 words per agent reviewed.** Cut narration first; replace quotes with the
  `work-samples/` path or `file:line`. Count it:

  ```bash
  awk '/^<!-- New entries below this line/{f=1;next} !f{next}
       /^## /{ if(h!=""){printf "%4d  %s\n", w, substr(h,1,72)} h=$0; w=0; next }
       h!=""{ w+=NF }
       END{ if(h!="") printf "%4d  %s\n", w, substr(h,1,72) }' CHANGELOG.md
  ```

- End with `Next audit targets: <agent>, <agent> — <why each>`.
- Do not trim or archive on size grounds. When the month turns, move the closed month's
  entries verbatim to `changelog/YYYY-MM.md`.

## Independence

If you produced or embodied any part of the work under review, your review is
reduced-independence. Say so on the verdict line, argue the case against your own work,
and record a follow-up for a genuinely independent pass. A self-review that finds nothing
is evidence the review was too soft.

## When there is nothing to review

Skip `agent-improver`, and say why, when nothing ran or the work went to a built-in agent
(`Explore`, `Plan`, `general-purpose`). Built-ins have no editable definition; a bad
result there is a routing miss — edit `references/routing.md`.

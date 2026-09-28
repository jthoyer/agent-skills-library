---
name: notion-second-brain
description: >
  Governs how Claude works with Notion as a personal second brain — covering database architecture,
  content routing decisions, capture and curation discipline, the Notion–Claude integration layer,
  and the AI Skills DB backup workflow. Use this skill whenever the user asks about: setting up or
  improving a Notion workspace, which content belongs in Notion versus Claude project files, how
  to keep a Notion database current, syncing or backing up Claude skills to Notion, querying or
  writing to a Notion database via MCP, or maintaining a multi-database second brain over time.
  Trigger on: "second brain", "Notion database", "keep Notion current", "Notion MCP", "backup
  my skills", "AI Skills DB", "project context in Notion", "capture and curation", "content
  capture", "which content goes where", or any question about the architecture of a Claude +
  Notion knowledge management setup. Always use this skill before advising on Notion architecture.
---

# Notion Second Brain

Governs the architecture, maintenance, and Claude integration for Justin's personal Notion second
brain — a multi-database knowledge system connected live via the Notion MCP connector.

---

## The Core Distinction: Notion vs Claude Project Files

| Criterion | Notion | Claude Project Files |
|---|---|---|
| Content type | Evolving, dynamic, user-navigated | Stable reference Claude always needs |
| Update mechanism | Manual or via MCP | Manual upload or Google Drive live sync |
| Retrieval | Semantic, on-demand (you ask Claude to fetch) | Deterministic, automatic (loaded every session) |
| Volume | Unlimited | Bounded by context window |
| Best for | Research logs, decisions, captures, databases | Skills library, scheme references, CLAUDE.md |

**Decision rule**: If Claude needs it in *every* conversation → project file. If Claude needs it *sometimes* or you need to browse it yourself → Notion.

---

## Database Architecture

### Active databases

| Database | Purpose | Key fields |
|---|---|---|
| **AI Skills DB** | Mirror of `/mnt/skills/user/` library | Skill Path, Category, Description, Trigger Phrases, Author, Version, License, Tags, Backup Date, Has Sub-files |
| **Content Capture** | Articles, videos, podcasts worth keeping | URL, Content Type, Category, Creator/Channel, Published Date, Captured Date, Tags, Executive Summary, Key Topics, Status |
| **Project second brains** | Per-project context: decisions, logs, outputs | Status, Last Updated, Confidence (Current / Needs Review / Archived) |

### Structural principles

- **Properties over prose**: filter/sort only works on properties, not freeform page content
- **Relations between databases**: shared entities (stakeholders, themes) → one record in a reference DB, related to all projects
- **Staging area**: new captures land in an "Inbox" or "Unprocessed" status, filed in weekly review
- **Last Updated rollup**: surface pages not touched in 60+ days as a staleness signal
- **One entry point per database**: ambiguity about where to capture = things don't get captured

---

## Capture Discipline

**What to capture**: content you'll reference again, insights that inform decisions, outputs from Claude sessions worth preserving, external research.

**What not to capture**: one-off lookups, transient chat outputs, anything you can easily re-find.

**Capture first, curate later**: use an Inbox status. Separate the act of capturing (fast, frictionless) from the act of organising (requires judgement).

**With Claude via MCP**: describe what you want to capture in conversation → Claude writes it directly to the database. Pattern: summarise → tag → write → confirm.

---

## Curation Cadence

| Frequency | Task |
|---|---|
| **Weekly (15–20 min)** | Process Inbox items, update statuses, flag items not touched in 30+ days |
| **Monthly (30–45 min)** | Archive stale pages, check for duplicates, validate filtered views still work |
| **Per project close** | Write a close-out summary page, mark everything terminal, archive the database |

---

## MCP Integration Patterns

### Reading from Notion

```
notion-search → find database or page by name
notion-fetch  → read page content or database schema
```

Always fetch schema before writing to confirm current field names — they drift.

### Writing to Notion

```
notion-create-pages → new entries (batch ≤ 10 per call)
notion-update-page  → update existing page content or properties
notion-update-data-source → add/modify database schema (ADD COLUMN statements)
```

**Date field pattern**: use flat properties, not nested objects:
```
'date:Backup Date:start': 'YYYY-MM-DD'
'date:Backup Date:is_datetime': 0
```

**Checkbox values**: use `'__YES__'` and `'__NO__'` strings, not boolean.

**Content replace**: `notion-update-page` with `command: replace_content`, `new_str`, `page_id`,
empty `properties: {}`, empty `content_updates: []` — all four params required even when unused.

### Content Capture pipeline (reusable pattern)

1. User provides URL or video link
2. `web_fetch` the page / `web_search` for video metadata
3. Generate: executive summary (3–5 sentences), key topics (5–8 bullet points), tags
4. `notion-search` for "Content Capture" database → get ID
5. `notion-create-pages` with all fields populated
6. Confirm to user with the page title and Notion link

---

## AI Skills DB Backup

The AI Skills DB mirrors `/mnt/skills/user/` at a point in time. Sync when skills are added, merged, or removed.

**Sync procedure**:
1. `notion-search` → "AI Skills DB" → get database ID
2. `notion-fetch` → confirm 10-field schema is intact
3. For new skills: `notion-create-pages` with all metadata fields from SKILL.md frontmatter
4. For updated skills: `notion-update-page` with `replace_content` for body, update properties
5. For removed skills: update Status to "Archived" (do not delete — preserve history)
6. Set `Backup Date` to today

See `skills-librarian` skill for the full sync protocol.

---

## Extended Frameworks (for deeper PKM work)

- **PARA** (Tiago Forte): Projects / Areas / Resources / Archive — top-level routing for "where does this go?"
- **Progressive summarisation**: layer highlighting on captured content — highlight on first read, bold the best highlights on second, extract atomic notes on third
- **Evergreen notes** (Andy Matuschak): insight-level captures written as durable, link-able assertions rather than dated summaries
- **Version-controlled exports**: for high-value databases (AI Skills DB), maintain a local markdown backup as a hedge against API issues or accidental deletion

---

## Related Skills

- `skills-librarian` — creation, maintenance, and quality control of the skills library itself
- `content-research-writer` — writing up captured content before logging to Notion

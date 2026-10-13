---
name: youtube-explainer
description: >
  Extracts, analyses, and captures YouTube video content to Justin's Notion Content Capture
  database. Use whenever a YouTube URL is shared and the user wants analysis, a summary, or
  capture to Notion. Trigger on: "/youtube", "youtube explainer", "capture this video",
  "summarise this video", "add to Notion", or any YouTube URL shared with intent to
  understand or save. Produces: executive summary, key topics, curriculum mapping (against
  the 16-area PM framework where relevant), and what's missing from the content. Always
  writes output to Content Capture db in Notion as a final step unless the user explicitly
  says not to.
---

# YouTube Explainer

Extracts and analyses YouTube video content, then captures the output to the Notion
Content Capture database as a permanent record.

---

## Phase 1: Extract

YouTube transcripts are not directly accessible via fetch. Use this sequence:

1. **Search for the video** using the video ID or title to retrieve metadata:
   ```
   web_search: "[video title or ID] YouTube"
   ```

2. **Fetch the video page** to extract title, channel, and description:
   ```
   web_fetch: https://www.youtube.com/watch?v=[VIDEO_ID]
   ```
   Note: YouTube pages are heavily JS-rendered. Use whatever metadata is available.

3. **Search for the transcript or summary** if the page fetch is insufficient:
   ```
   web_search: "[video title] [channel name] transcript summary key points"
   ```
   Pull the best available source — official transcript, captions republished on
   third-party sites, or a high-quality written summary.

4. **Fetch supporting sources** (e.g. the creator's blog post, a transcript site) to
   get the substantive content to analyse.

If extraction is genuinely blocked, flag it explicitly and proceed with what is available
rather than hallucinating content.

---

## Phase 2: Analyse

Produce five sections. Executive prose register — no padding, no preamble.
Write for the learner, not for show.

### 1. What this is
One paragraph: video title, creator/channel, approximate length if known, and the core
argument or teaching in plain language.

### 2. Executive summary
3–5 sentences. The argument of the video, what it claims, and whether it delivers.
This is the field written to Notion — write it to stand alone.

### 3. Key topics
5–8 bullet points, each 1–2 sentences. Specific, substantive claims or frameworks —
not generic topic labels. Things worth referencing later.

### 4. Curriculum mapping (PM content only)
If relevant to the 16-area PM curriculum, identify:
- **Primary area**: which of the 16 areas this most directly addresses and which
  learning goals it serves
- **Adjacent areas**: which other areas it touches and how
- **What's missing**: what the video leaves out that a learner still needs

If not PM-related (triathlon, investing, etc.), skip this section.

### 5. First-principles check
Does the video reason from fundamentals or by analogy? One paragraph. Call out where
the reasoning is solid and where it relies on unexamined assumptions.

---

## Phase 3: Capture to Notion

After producing the analysis, write a new entry to the Content Capture database.

**Database**: Content Capture db
**Data source ID**: `35dcfee1-ca18-800c-99b2-000bdb2e0798`

### Field mapping

| Notion field | Value |
|---|---|
| `Name` | Video title |
| `Content Type` | `Video` |
| `Creator / Channel` | Channel name |
| `Category` | Closest from: AI and Automation / Service Design / Leadership and Management / Triathlon and Performance / Investing and Finance / Product and Technology / Other |
| `Executive Summary` | 3–5 sentence summary from section 2 above |
| `Key Topics` | Bullet points from section 3, joined as plain text |
| `Status` | `To Review` |
| `Tags` | Applicable from: Claude Code / Agentic AI / AI Tools / Productivity / Strategy / Design / Triathlon / Finance |
| `userDefined:URL` | Full YouTube URL |
| `date:Captured Date:start` | Today's date (YYYY-MM-DD) |
| `date:Captured Date:is_datetime` | `0` |

### Call pattern

```
notion-create-pages
  parent: { data_source_id: "35dcfee1-ca18-800c-99b2-000bdb2e0798" }
  pages: [{
    icon: "📺",
    properties: {
      "Name": "[video title]",
      "Content Type": "Video",
      "Creator / Channel": "[channel]",
      "Category": "[closest match]",
      "Executive Summary": "[3-5 sentence summary]",
      "Key Topics": "[bullet points as plain text]",
      "Status": "To Review",
      "Tags": "[JSON array of applicable tags]",
      "userDefined:URL": "[full YouTube URL]",
      "date:Captured Date:start": "[YYYY-MM-DD]",
      "date:Captured Date:is_datetime": 0
    },
    content: "[Full Phase 2 analysis in Notion markdown]"
  }]
```

Write the full Phase 2 analysis as page body content so the Notion entry is a complete,
self-contained reference — not just a metadata stub.

### Confirm to user

After a successful write, confirm with:
- Page title
- Notion link (from API response)
- One-line summary of what was captured

---

## Output order

1. Phase 2 analysis in chat
2. Phase 3 Notion capture (execute, confirm at end)

Do not ask permission before writing to Notion — the user has already requested it by
invoking this skill. If the Notion write fails, surface the error and offer to retry.

---

## Related Skills

- `notion-second-brain` — Content Capture db architecture and curation cadence
- `first-principles` — apply for the first-principles check section
- `rewrite` — use when the user wants the analysis reframed before execution

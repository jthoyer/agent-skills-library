---
name: recent-pulse
description: >
  Research what people are actually saying about a topic over the last 30 days, using only
  public, keyless APIs and WebSearch/WebFetch. Never reads browser cookies, the macOS Keychain,
  or any credential store, and never runs a vendored client impersonating a platform's private
  API. Pulls Hacker News via its public Algolia API, tries Reddit's public JSON search as a bonus
  (often blocked — WebSearch site:reddit.com is the fallback), and uses WebSearch/WebFetch for
  news, blogs, forums, YouTube, and X/Twitter. Use when the user asks what people are saying about
  something recently, wants a 30-day sentiment pulse, says "what's the buzz on X", "what are
  people saying about Y", "recent reaction to Z", "last 30 days", or "last month" — a lightweight
  recency brief, not a full literature review or market analysis. A real API key (YouTube, X) is
  opt-in via an env var the user sets — never discovered. For deep multi-source synthesis use
  deep-research; for sports tech/fitness market analysis use market-analyst.
license: MIT
metadata:
  author: Justin
  version: 1.0.0
---

# Recent Pulse

Answers "what are people saying about X in the last 30 days" from sources that require no login
and no stored credentials. Built as the transparent alternative to installing a third-party skill
that decrypted browser cookies and Keychain secrets to scrape social platforms — every source here
is either a documented public API or Claude's own WebSearch/WebFetch tools, and that boundary is
the point of this skill, not an implementation detail.

## Boundaries (never cross these)

- Never read browser cookie databases (Chrome, Safari, Brave, Edge, Arc, or any other browser).
- Never call macOS Keychain, `security find-generic-password`, or any OS credential store.
- Never install or run a vendored/reverse-engineered client that impersonates a platform's private
  or internal API to bypass login.
- If a source needs authentication for deeper coverage, ask the user to supply their own API key
  as an environment variable. Do not work around the auth requirement any other way.

## Sources & method

1. **Hacker News — reliable, structured.** Public Algolia API, no key, no login:
   ```
   python3 scripts/pulse_fetch.py "<query>" --days 30 --source hn
   ```
   Returns JSON: title, url, discussion url, author, points, comment count, timestamp.

2. **Reddit — best-effort, structured.** Reddit's `search.json` endpoint requires no auth in
   principle but is frequently blocked (HTTP 403) for non-browser traffic, including from this
   environment as of last check. Try it first since it's free when it works:
   ```
   python3 scripts/pulse_fetch.py "<query>" --days 30 --source reddit
   ```
   If it returns zero results or a 403 warning on stderr, fall back to WebSearch with
   `site:reddit.com "<query>"` and note in the output that Reddit coverage came via search
   indexing rather than the API.

3. **News, blogs, forums — WebSearch/WebFetch.** Use WebSearch with the topic plus a recency
   qualifier (e.g. "last 30 days", "since <date 30 days ago>", or the publication's own date
   filter if the search surface supports one). Use WebFetch to pull full context from any result
   worth quoting directly.

4. **YouTube.** Default to WebSearch with `site:youtube.com "<query>"`. If the user has set a
   `YOUTUBE_API_KEY` environment variable, the YouTube Data API v3 `search` endpoint may be called
   directly with that key instead — only when the user supplied it themselves.

5. **X/Twitter.** X blocks unauthenticated search and scraping, and this skill will not work
   around that. Use WebSearch with `site:x.com OR site:twitter.com "<query>"` and be upfront that
   coverage is limited to whatever is publicly indexed. If the user has set an `X_BEARER_TOKEN`
   for their own legitimate API access, the official X API v2 recent-search endpoint may be used
   with that token instead.

Run Hacker News and Reddit first (cheap, structured, no tokens burned), then fill gaps with
WebSearch/WebFetch for the sources that need it. Compute the 30-day cutoff once
(`date -d '30 days ago' +%Y-%m-%d` on Linux, `date -v-30d +%Y-%m-%d` on macOS) and reuse it across
every search query so the window stays consistent.

## Synthesis structure

Group findings into themes rather than listing sources in fetch order:

- **Theme summary** — 1-2 sentences per recurring topic or opinion cluster.
- **Representative examples** — for each theme, 2-4 concrete posts/articles/comments with source,
  date, and link. Quote sparingly; paraphrase the rest.
- **Volume & tone** — qualitative read on how much discussion there is and which way it leans.
  Don't invent precise percentages from a small, non-random sample.
- **Notable disagreement** — where sources conflict or a theme is contested, say so explicitly.
- **Coverage caveats** — always include this. State plainly which sources actually returned data,
  which were blocked or skipped (e.g. "Reddit's API returned 403; Reddit coverage below is from
  WebSearch indexing only"), and that X/YouTube coverage reflects public indexing, not a full
  platform search, unless the user supplied their own API key.

## Related Skills

- `deep-research` — general multi-source synthesis with citations; use for literature-review-style
  research rather than a recency-scoped public-sentiment pulse.
- `market-analyst` — structured competitive market analysis for sports tech/fitness categories;
  use when the ask is about competitor products and market gaps, not general public sentiment.

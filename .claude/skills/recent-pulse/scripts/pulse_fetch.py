#!/usr/bin/env python3
"""Fetch recent public discussion for a topic from Reddit and Hacker News.

Both endpoints are public JSON APIs that require no login, no API key, and
no cookies:
  - Reddit search:      https://www.reddit.com/search.json
  - HN Algolia search:  https://hn.algolia.com/api/v1/search

Stdlib only. Reads nothing from the browser, Keychain, or any credential
store. If Reddit or HN rate-limits/blocks the request, that source is
skipped and reported as unavailable rather than retried with workarounds.

Usage:
  python3 pulse_fetch.py "topic or query" [--days 30] [--limit 25] [--source reddit|hn|all]
"""

import argparse
import json
import sys
import time
import urllib.parse
import urllib.request
from typing import List, Optional
from urllib.error import HTTPError, URLError

USER_AGENT = "recent-pulse-skill/1.0 (personal research tool)"
TIMEOUT = 15


def _get_json(url: str, headers: dict) -> Optional[dict]:
    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except (HTTPError, URLError, TimeoutError, json.JSONDecodeError) as e:
        print(f"warning: request to {url} failed: {e}", file=sys.stderr)
        return None


def fetch_reddit(query: str, days: int, limit: int) -> List[dict]:
    cutoff = time.time() - days * 86400
    params = {"q": query, "sort": "new", "t": "month", "limit": str(min(limit, 100))}
    url = "https://www.reddit.com/search.json?" + urllib.parse.urlencode(params)
    data = _get_json(url, {"User-Agent": USER_AGENT})
    if not data:
        return []
    out = []
    for child in data.get("data", {}).get("children", []):
        p = child.get("data", {})
        created = p.get("created_utc", 0)
        if created < cutoff:
            continue
        out.append({
            "source": "reddit",
            "title": p.get("title"),
            "subreddit": p.get("subreddit_name_prefixed"),
            "url": f"https://reddit.com{p.get('permalink', '')}",
            "author": p.get("author"),
            "created_utc": created,
            "score": p.get("score"),
            "num_comments": p.get("num_comments"),
            "snippet": (p.get("selftext") or "")[:300],
        })
    return out


def fetch_hn(query: str, days: int, limit: int) -> List[dict]:
    cutoff = int(time.time() - days * 86400)
    params = {
        "query": query,
        "tags": "story",
        "numericFilters": f"created_at_i>{cutoff}",
        "hitsPerPage": str(min(limit, 100)),
    }
    url = "https://hn.algolia.com/api/v1/search?" + urllib.parse.urlencode(params)
    data = _get_json(url, {"User-Agent": USER_AGENT})
    if not data:
        return []
    out = []
    for h in data.get("hits", []):
        out.append({
            "source": "hackernews",
            "title": h.get("title"),
            "url": h.get("url") or f"https://news.ycombinator.com/item?id={h.get('objectID')}",
            "discussion_url": f"https://news.ycombinator.com/item?id={h.get('objectID')}",
            "author": h.get("author"),
            "created_utc": h.get("created_at_i"),
            "points": h.get("points"),
            "num_comments": h.get("num_comments"),
        })
    return out


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("query")
    ap.add_argument("--days", type=int, default=30)
    ap.add_argument("--limit", type=int, default=25)
    ap.add_argument("--source", choices=["reddit", "hn", "all"], default="all")
    args = ap.parse_args()

    results: List[dict] = []
    if args.source in ("reddit", "all"):
        results += fetch_reddit(args.query, args.days, args.limit)
    if args.source in ("hn", "all"):
        results += fetch_hn(args.query, args.days, args.limit)

    results.sort(key=lambda r: r.get("created_utc") or 0, reverse=True)
    print(json.dumps({"query": args.query, "days": args.days, "count": len(results), "results": results}, indent=2))


if __name__ == "__main__":
    main()

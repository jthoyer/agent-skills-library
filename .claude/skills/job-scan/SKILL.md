---
name: job-scan
description: >
  Runs Justin's dual-track (Product Manager / Service Design) Sydney and remote job-market scan,
  verifies every listing against its original source before filing, tracks roles across runs, and
  writes structured results to the Job search Notion database as a sub-item of the relevant
  track's prompt page. Trigger on "run the job scan", "PM scan", "SD scan", "scan for [product
  manager / service design] roles", or any reference to the PM or SD job search prompt pages. Also
  trigger when building, extending, fixing, or auditing this scanning workflow; correcting a
  listing found to be closed or wrong after filing; deciding whether a scanned role should hand
  off to `resume-builder` for tailoring or `multi-actor-research` for a pre-application deep-dive;
  or when either prompt page's exclusion list, platforms, or cadence changes and needs flagging.
  Not for general job-market questions unrelated to Justin's tracked search, or for drafting the
  resume itself — hand off to `resume-builder` for that.
metadata:
  version: 1.2.0
---

# Job Scan

Runs and maintains Justin's recurring PM and SD job-market scans: search, verify, structure,
cross-reference against prior runs, and file to Notion. Built from the corrected 23 Sep 2026 PM
run and the more mature 31 Jul 2026 SD run — the SD run's cross-run tracking pattern is the
standard this skill generalises to both tracks.

**Division of labour:** this skill owns the *mechanics* that should behave identically for both
tracks (verification, run structure, filing, deduplication, integrations). The two Notion prompt
pages own the *parameters* Justin tunes directly — search platforms, exclusion list, title scope,
sector-fit narrative, cadence. Never hardcode a platform or exclusion here; read it live instead.
That split is why the PM and SD prompts drifted (only the PM prompt excludes `.gov.au`; only the
SD prompt has ever produced a proper cross-run tracking section) — this skill is what keeps the
mechanics in sync even while the parameters legitimately diverge.

---

## Before every run: read the live prompt page, not memory

Fetch the requested track's prompt page fresh — Justin edits these directly and versions them
(SD is currently v2.3, PM v1.0), so a remembered copy from an earlier session will be stale.

- PM track prompt: `https://app.notion.com/p/3e4cfee1ca188101af23d453b98b7f71`
- SD track prompt: `https://app.notion.com/p/389cfee1ca188000aa3bda9a67dc30d8`
- Lateral track prompt: `https://app.notion.com/p/3e4cfee1ca188148b065c8316b02c893` — exploratory, non-obvious-avenue track (currently AI Enablement/Transformation and sports-tech product); monthly cadence, not weekly
- Job search database: `385cfee1-ca18-8095-87ad-000b1a880541`

Pull from the fetched page: search platforms, exclusion list, title/geography scope, the
international-remote-boards table and resume-fit context, and cadence. If the user names "the job
scan" without a track, ask which — the platform lists and sector-fit narratives differ enough that
guessing wrong wastes the run.

---

## Run structure

Every run produces five parts, in this order. Read `references/run-template.md` for the full
annotated template with worked examples from both tracks before writing one — do not improvise the
shape from scratch.

1. **Run details** — date, prompt version used, which sources got a direct-fetch check vs.
   snippet-only, international-boards status, and a one-line confidence note naming the depth/
   breadth tradeoff actually made this run (see Depth vs breadth below).
2. **Snapshot** — a metrics table: new (confirmed live), carried over & reconfirmed, carried over &
   pending, flagged 30+ days, confirmed closed since last run, likely closed/unconfirmed, removed
   by an exclusion-list change.
3. **Roles** — the structured per-role entries (Output format below), newest-first, 10–20 per run.
4. **Cross-run sections** — Pending reconfirmation / Confirmed closed since last scan / Likely
   closed or stale / Removed from tracking / Still pending. See Deduplication below — this is what
   the PM track's first run skipped entirely and had to correct after filing.
5. **Market observations** — 3–6 numbered, pattern-level notes: which employers keep reappearing,
   which platforms are proving reliable or blocked, whether this run traded depth for breadth and
   what that implies for next time. This is where a tradeoff decision gets surfaced for Justin
   rather than made silently.

### Output format (per role)

```
**[Role title] | [Organisation] | [City, State]**
| Field | Content |
|---|---|
| Salary | As listed, or *Not disclosed* |
| Days listed | Days since posted, confirmed against the original source |
| Source | Platform or original ATS the listing was verified on |
| Listing URL | The resolved original posting — not an aggregator or redirect link |
| Organisation URL | Hiring company's site, or *Confidential* |

Summary: 3-4 sentences — what the role involves, who it reports to, primary deliverables.
Considerations: the track prompt's own (a)/(b)/(c)[/(d)] criteria — read them from that prompt
page rather than assuming; the PM track adds a design-adjacency criterion the SD track doesn't need.
```

---

## Verification protocol

**What went wrong once, so it doesn't again:** the first PM run filed three roles as active on the
strength of an aggregator's index date or a search snippet. All three had already closed — one
five months earlier. The fix is procedural, not a one-off correction:

Before a role goes in the output, fetch its listing directly. A search-snippet match or an
aggregator's cached index date is a lead, not evidence. Read `references/verification-playbook.md`
for how to read live/closed signals on each aggregator and ATS this search regularly turns up
(freehire, Dreamwork, designremotejobs, Ashby, Greenhouse) before relying on one you haven't seen
before. Where an aggregator links to the employer's own ATS, verify there instead of on the
aggregator's copy. If a source can't be directly confirmed — SEEK, LinkedIn, and iworkfor.nsw.gov.au
all block automated fetching — say so plainly against that entry rather than presenting it as
confirmed-live.

---

## Deduplication across runs

Before filing, check the Job search database for this track's existing sub-items (query the
`Parent item` relation against the prompt page). For each candidate role:

- **New** — no matching prior entry. Files as a fresh role.
- **Carried over, reconfirmed** — matches a prior entry and was independently re-verified this run.
  Update the cumulative days-listed rather than filing a duplicate row.
- **Carried over, pending** — matches a prior entry but wasn't independently re-checked this run
  (a legitimate outcome when depth is being traded for breadth). Note it as pending, not silently
  dropped and not silently asserted still-live.
- **Confirmed closed** — was tracked, now verified closed. Moves to that section with the evidence
  (a closure banner, a 404, an explicit "no longer accepting applications" date).
- **Removed by exclusion change** — was tracked, and the *only* reason it's gone is that Justin's
  exclusion list changed (not that the role itself changed status). Always call this out
  separately and flag it for Justin to confirm the change was intentional — an exclusion edit is a
  configuration change, not a market signal, and the two should never be conflated in the numbers.

---

## Filing convention

- **Name**: `PM Scan – [DD Mon YYYY]`, `SD Scan – [DD Mon YYYY]`, or `Lateral Scan – [DD Mon YYYY]`,
  matching the track's own prior naming exactly (check a recent sub-item's actual title rather than
  assuming — SD's convention and PM's convention have already diverged once).
- **Parent item**: the relevant track's prompt page.
- **Role type**: `product manager`, `service design`, or `lateral`.
- **Status**: `Not started`.
- **Content**: the five-part run structure above.

**Correcting a filed run:** when a role turns out to have been wrong at filing time, strike it
through in place (`~~...~~`) with a one- or two-sentence note on what was confirmed and when —
never delete it silently. The record should show what was missed and why, consistent with the
project's gap-transparency standard. Update the run's snapshot counts and closing note to match.

### Before filing

Copy this list into your reply and tick each line. File only when every line is ticked or
carries a stated reason.

```
- [ ] Prompt page fetched fresh this run; version noted in Run details
- [ ] Every role's listing fetched directly, or marked unconfirmed with the reason
- [ ] Each role classed against prior sub-items (new / carried / closed / removed)
- [ ] Exclusion-list removals flagged for Justin separately
- [ ] Five parts present, in order; snapshot counts match the role list
- [ ] Name and properties match the track's latest sub-item
```

## Depth vs breadth

Covering every platform in the prompt's table every run is not achievable, and pretending otherwise
produces exactly the false-confidence problem the Verification protocol exists to catch. Each run,
decide and state which sources get a direct-fetch check (higher confidence, fewer roles) versus
which are used for snippet-level breadth only (more roles, lower confidence) — the SD track has
made this tradeoff explicit in its Run details for months; the PM track should do the same from
here on rather than treating a comprehensive sweep as the default to apologise for falling short of.

---

## Integration: resume-builder

Hand off once Justin decides to pursue a specific filed role, not automatically at scan time. Pass
`resume-builder`:

- The listing's full text (or the verified Listing URL) as the target job description
- The correct track's base resume from Google Drive (SD: `1ebUzq3kNnMNoXVtEIMCCzHxVLpeVTuO4nG6tfmuKMr8`;
  PM: `1t11ll-pcmWbNyv_1B2haWI-9an40reo61yzfftsCIbQ`) as the source to tailor, not a from-scratch build
- The Job Search project's standing constraints, since `resume-builder` doesn't know them natively:
  no-fabrication (every figure traces to a verified source; projected outcomes stay labelled as
  projected), gap-transparency (name genuine gaps rather than soften them), and dual-track
  separation (never blend SD and PM framing on a single resume version)

## Integration: multi-actor-research

Reserve for a shortlisted or high-priority role before applying or interviewing — not a per-scan
step across 10-20 roles; that's a scope and cost mismatch for what's meant to be a decision-grade,
evidence-audited process. A single-actor Researcher-plus-Devil's-Advocate pass is usually enough to
stress-test a specific opportunity (company stability, product maturity signals, culture red flags
beyond what the listing states); reserve full four-stage orchestration for genuinely high-stakes
calls, such as weighing a specific offer.

---

## Open items to reconcile with Justin, not silently resolve

- The SD prompt has no Verification section of its own — this skill now supplies that mechanic
  centrally, so the gap matters less, but the prompt page itself is still silently missing it if
  anyone reads that page without this skill active.

**Resolved:** the PM prompt's header once read "Run Monday, Wednesday, Friday" against its own
"designed to run weekly" recurring-use note. Justin confirmed weekly on 23 Sep 2026 — the header
now reads "Run weekly", matching SD's cadence and phrasing. Both tracks run weekly.

---

## Related Skills

- `resume-builder` — tailoring handoff once a role is chosen
- `multi-actor-research` — optional deep-dive on a shortlisted, high-stakes opportunity
- `skills-librarian` — governs this file's own maintenance and upgrade standards
- `notion-second-brain` — Job search database architecture, if it needs to change

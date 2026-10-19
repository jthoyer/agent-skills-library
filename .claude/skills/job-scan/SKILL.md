---
name: job-scan
description: >
  Runs Justin's unified Service Design + Product Manager Sydney and remote job-market scan from the
  single "Unified job search prompt" Notion page. Verifies every listing against its original source,
  tracks roles across runs, opens each run with a short summary, and files the result to the Job
  search Notion database as a sub-item of that prompt page. Trigger on "run the job scan", "PM scan",
  "SD scan", "scan for [product manager / service design] roles", or any reference to the job search
  prompt pages. Also trigger when building, fixing, or auditing this workflow; correcting a listing
  found closed or wrong after filing; deciding whether a scanned role should hand off to
  `resume-builder` or `multi-actor-research`; or when the prompt page's exclusion list, platforms
  table, or cadence changes. Not for general job-market questions unrelated to Justin's tracked
  search, or for drafting the resume itself (use `resume-builder`).
metadata:
  version: 2.0.0
---

# Job Scan

Runs and maintains Justin's recurring job-market scan: search, verify, structure, cross-reference
against prior runs, summarise, and file to Notion. One prompt page now covers both tracks (Service
Design and Product Manager). Built from the corrected 23 Sep 2026 PM run and the more mature SD run.
The SD run's cross-run tracking pattern is the standard this skill applies.

**Division of labour:** this skill owns the *mechanics* that behave the same on every run
(verification, run structure, run summary, filing, deduplication, integrations). The unified prompt
page owns the *parameters* Justin tunes by hand: the Search platforms table (with its Fetch, Cadence
and Active columns), the Target employers table, the exclusion list, the title queries, the track
rules, the candidate context and the known-gaps list. Never hardcode a platform, title or exclusion
here. Read it live. Before the merge, the SD and PM prompts drifted because each carried its own copy
of the mechanics. This skill keeps one copy.

---

## Before every run: read the live prompt page, not memory

Fetch the unified prompt page fresh. Justin edits it directly and versions it, so a remembered copy
from an earlier session is stale.

- Unified prompt (SD + PM): `https://app.notion.com/p/3fecfee1ca1881e294f0cef3914b500a`
- Lateral track prompt: `https://app.notion.com/p/3e4cfee1ca188148b065c8316b02c893` — exploratory,
  non-obvious-avenue track (currently AI Enablement/Transformation and sports-tech product); monthly
  cadence, not weekly. It is not part of the unified prompt and keeps its own page.
- Job search database: `385cfee1-ca18-8095-87ad-000b1a880541`
- Legacy pages, read only as the baseline for the first unified run: SD prompt
  `https://app.notion.com/p/3f1cfee1ca18803b98f0e40305598689` (v3.0) and PM prompt
  `https://app.notion.com/p/3e4cfee1ca188101af23d453b98b7f71` (v1.0). The older v2.3 SD page
  (`389cfee1ca188000aa3bda9a67dc30d8`) is retired.

Pull from the fetched page: the Search platforms table, the Target employers table, the exclusion
list, the Track rules, the title queries, the Location rule, the Flags table, the candidate context
and known gaps, and the cadence. Honour the table columns. Run rows marked Active = Yes. Run Weekly
rows every run and Monthly rows only on the first run of the month.

Run both tracks by default. If Justin says "SD scan" or "PM scan", run only that track: filter the
platforms by the Track column and use only that track's title queries. Do not ask which track unless
the request is unclear.

---

## Run structure

Every run opens with a Run summary, then has five parts, in this order. Read
`references/run-template.md` for the full annotated template with worked examples before writing one.
Do not improvise the shape from scratch.

**Run summary** (4 to 6 lines, written last, placed first). Lead with the answer: roles verified live
this run (total and by track), what is new and what is flagged ⚠️, up to three Strong-fit top picks
with one reason each, anything closing within 7 days, and anything that needs Justin's decision
(exclusion-list removals, blocked sources, table changes). Every number must match the Snapshot. Add
no detail that appears nowhere else in the run.

1. **Run details**: date, prompt version, which sources got a direct-fetch check, which were
   snippet-only, which were blocked, international-boards status, Target employers checked, and a
   confidence note naming the depth versus breadth trade-off made this run (see Depth versus breadth
   below).
2. **Snapshot**: a table with seven rows and the columns SD, PM, Both and Total: new (confirmed live),
   carried over and reconfirmed, carried over and pending, flagged 30+ days, confirmed closed since
   last run, likely closed or unconfirmed, removed by an exclusion-list change.
3. **Roles**: the structured per-role entries (Output format below), newest-first, 10–20 verified per
   track. A role tagged Both counts toward each track once.
4. **Cross-run sections**: Pending reconfirmation / Confirmed closed since last scan / Likely closed
   or stale / Removed by exclusion change / Still pending. See Deduplication below. This is what the
   PM track's first run skipped entirely and had to correct after filing.
5. **Market observations**: 3–6 numbered, pattern-level notes: which employers keep reappearing,
   which platforms are reliable or blocked, and what the depth versus breadth choice implies for next
   time. End with a **Platform review**: which Search platforms and Target employers rows produced
   verified roles, which produced nothing, and which to add, drop or retest. Suggest only. Never edit
   Justin's tables.

### Output format (per role)

```
**[Role title] | [Organisation] | [City, State]**  [flags]
| Field | Content |
|---|---|
| Track | SD, PM or Both |
| Fit | Strong, Possible or Stretch, with one reason. Name any gate plainly |
| Type and term | Permanent, fixed term or contract, with length where listed |
| Salary | As listed, or *Not disclosed* |
| Days listed | Days since posted, confirmed against the original source |
| Closes | Closing date if listed, otherwise *Not stated* |
| Source | Platform or original ATS the listing was verified on |
| Listing URL | The resolved original posting — not an aggregator or redirect link |
| Organisation URL | Hiring company's site, or *Confidential* |

Summary: 3-4 sentences — what the role involves, who it reports to, primary deliverables.
Considerations: the prompt page's own (a) to (d) criteria, plus (e) design-adjacency for PM and Both roles.
```

Flags have one meaning each and come from the prompt's Flags table: 🌐 Remote (fully remote),
📍? (work location not stated), ❓ (live status not confirmed), ⚠️ (live 30+ days), 🔁 (re-listed
under a different title). Read them live. The old 🏢? flag is retired because it meant both
"location unknown" and "status unconfirmed".

---

## Verification protocol

**What went wrong once, so it doesn't again:** the first PM run filed three roles as active on the
strength of an aggregator's index date or a search snippet. All three had already closed — one five
months earlier. The fix is procedural, not a one-off correction.

Before a role goes in the output, fetch its listing directly. A search-snippet match or an
aggregator's cached index date is a lead, not evidence. Read `references/verification-playbook.md`
for how to read live and closed signals on each aggregator and ATS this search regularly turns up
(freehire, Dreamwork, designremotejobs, Ashby, Greenhouse) before relying on one you haven't seen
before. Where an aggregator links to the employer's own ATS, verify there instead of on the
aggregator's copy. If a source cannot be directly confirmed (the platforms table's Fetch column
records which ones block fetching), say so plainly against that entry, flag it ❓, and never present
it as confirmed live. Update the Fetch value in your Platform review when a run proves it wrong.

---

## Deduplication across runs

Before filing, read the most recent scan filed under the unified prompt page (query the `Parent item`
relation against it). On the first unified run, also read the latest SD Scan and PM Scan under the
legacy pages and treat them as the baseline. Match roles across tracks by employer and normalised
title, so a Both role is never counted twice. For each candidate role:

- **New** — no matching prior entry. Before calling a role new, check for a re-listing under a
  different title at the same employer, and flag it 🔁 if found.
- **Carried over, reconfirmed** — matches a prior entry and was independently re-verified this run.
  Update the cumulative days-listed rather than filing a duplicate row.
- **Carried over, pending** — matches a prior entry but wasn't independently re-checked this run (a
  legitimate outcome when depth is being traded for breadth). Note it as pending, not silently
  dropped and not silently asserted still-live.
- **Confirmed closed** — was tracked, now verified closed. Moves to that section with the evidence
  (a closure banner, a 404, an explicit "no longer accepting applications" date).
- **Removed by exclusion change** — was tracked, and the *only* reason it's gone is that Justin's
  exclusion list changed (not that the role itself changed status). Always call this out separately
  and flag it for Justin to confirm the change was intentional. An exclusion edit is a configuration
  change, not a market signal, and the two should never be conflated in the numbers.

A role found for the first time through a snippet only is an unconfirmed lead. Flag it ❓ and count
it under likely closed or unconfirmed, never under new (confirmed live).

---

## Filing convention

- **Name**: `Job Scan – [DD Mon YYYY]`. Check the latest sub-item's actual title before filing.
  Lateral runs keep `Lateral Scan – [DD Mon YYYY]` under the lateral prompt page.
- **Parent item**: the unified prompt page.
- **Role type**: `service design` and `product manager`. For a single-track run, set only that track's
  value. Lateral runs use `lateral`.
- **Status**: `Not started`.
- **Content**: the Run summary and the five-part run structure above.

**Correcting a filed run:** when a role turns out to have been wrong at filing time, strike it
through in place (`~~...~~`) with a one- or two-sentence note on what was confirmed and when. Never
delete it silently. The record should show what was missed and why, consistent with the project's
gap-transparency standard. Update the run's snapshot counts, the Run summary and the closing note to
match.

### Before filing

Copy this list into your reply and tick each line. File only when every line is ticked or carries a
stated reason.

```
- [ ] Unified prompt page fetched fresh this run; version noted in Run details
- [ ] Every role's listing fetched directly, or flagged ❓ with the reason
- [ ] Each role classed against prior sub-items (new / carried / closed / removed), across both tracks
- [ ] Exclusion-list removals flagged for Justin separately
- [ ] Run summary first, five parts present in order; snapshot counts match the role list and the summary
- [ ] Name and properties match the latest sub-item
```

## Depth versus breadth

Covering every platform in the prompt's table every run is not achievable, and pretending otherwise
produces exactly the false-confidence problem the Verification protocol exists to catch. The unified
prompt adds a second track, so the pressure is higher. Each run, decide and state which sources get a
direct-fetch check (higher confidence, fewer roles) versus which are used for snippet-level breadth
only (more roles, lower confidence). Put the choice in Run details and name next run's depth target in
the confidence note. Do not treat a comprehensive sweep as the default to apologise for falling short
of.

---

## Integration: resume-builder

Hand off once Justin decides to pursue a specific filed role, not automatically at scan time. Pass
`resume-builder`:

- The listing's full text (or the verified Listing URL) as the target job description
- The correct track's base resume from Google Drive (SD: `1ebUzq3kNnMNoXVtEIMCCzHxVLpeVTuO4nG6tfmuKMr8`;
  PM: `1t11ll-pcmWbNyv_1B2haWI-9an40reo61yzfftsCIbQ`) as the source to tailor, not a from-scratch build.
  A role tagged Both needs Justin to choose the track first.
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

- As of 19 Oct 2026 the unified prompt page has an empty Target employers table and no Recurring use
  note. The skill's weekly Wednesday cadence and the Target employers check rest on those. Confirm
  whether the removals were intended.
- The legacy SD v3.0 and PM v1.0 pages still exist and still carry earlier scans. Archive them only
  when Justin says so. The first unified run reads them as its baseline.

**Resolved:** the PM prompt's header once read "Run Monday, Wednesday, Friday" against its own
"designed to run weekly" note. Justin confirmed weekly on 23 Sep 2026, and the unified prompt runs
weekly on Wednesdays, with international rows monthly on the first run of the month.

---

## Related Skills

- `resume-builder` — tailoring handoff once a role is chosen
- `multi-actor-research` — optional deep-dive on a shortlisted, high-stakes opportunity
- `skills-librarian` — governs this file's own maintenance and upgrade standards
- `notion-second-brain` — Job search database architecture, if it needs to change

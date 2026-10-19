# Verification Playbook

How to tell a live listing from a closed one on each source this search regularly turns up.
Read this before filing any role — a search-snippet match or an aggregator's cached index date is
a lead, not evidence (see Verification protocol in `SKILL.md`).

**General rule first:** where an aggregator links out to the employer's own ATS (Ashby,
Greenhouse, Lever, a company careers page), verify on that page, not on the aggregator's copy.
The aggregator's "posted" or "updated" date reflects when *it* indexed the listing, not whether
the role is still open — that gap is exactly what produced the three false-positive filings the
first PM run had to correct.

---

## Ashby

- **Live signal:** the job page renders normally with an "Apply" button and the role in the
  employer's active job list (`jobs.ashbyhq.com/<company>`).
- **Closed signal:** the URL redirects to the company's full job list with the specific posting
  absent, or the page shows "This job is no longer accepting applications."
- Ashby job IDs are stable — if the same ID resolves to a different role or a 404, treat as closed
  and note the date checked.

## Greenhouse

- **Live signal:** `job-boards.greenhouse.io/<company>/jobs/<id>` returns the full posting with an
  active Apply form.
- **Closed signal:** Greenhouse typically 404s a closed posting rather than showing a banner —
  treat a 404 on a previously-tracked Greenhouse URL as closed, not as a fetch failure, unless the
  whole boards subdomain is unreachable (in which case say so and mark unconfirmed, not closed).
- Some employers leave a closed posting live with "Position filled" or "No longer accepting
  applications" text instead of 404ing — read the page body, don't infer from HTTP status alone.

## freehire

- Aggregator, not an ATS. Treat its listing as a lead only — it does not reliably reflect current
  status. Resolve to the employer's own ATS or careers page before verifying; if it doesn't link
  through to one, mark the role unconfirmed rather than filing on freehire's copy alone.
- freehire's own "posted X days ago" label is an index date, not a confirmation of the role still
  being open — this is the specific pattern that caused the original PM-run misfiling.

## Dreamwork

- Same treatment as freehire: aggregator-only, snippet-level breadth source unless it resolves to
  a direct employer ATS link. If used for a run's snippet-only tier (see Depth versus breadth in
  `SKILL.md`), flag any role it surfaces ❓ and count it as unconfirmed rather than presenting it as
  verified-live.

## designremotejobs

- Aggregator focused on design and design-adjacent roles (relevant mainly to the SD track).
  Frequently re-lists the same underlying role under a slightly different title when an employer's
  ATS listing is refreshed — before filing as "new," check whether the employer and general role
  description match an already-tracked entry under a different title (see Deduplication in
  `SKILL.md`). Resolve to the employer's ATS to verify status.

---

## Sources that block automated fetching

These cannot be directly confirmed by this workflow. Say so plainly against any entry sourced from
them rather than presenting it as confirmed-live — an unconfirmed role is still worth surfacing to
Justin, but only if the record is honest about the confidence level.

- **SEEK** — blocks automated fetching of listing pages.
- **LinkedIn** — blocks automated fetching of job postings.
- **iworkfor.nsw.gov.au** — blocks automated fetching; relevant only where a state-government
  role is in scope (the unified prompt's Track rules and exclusion list decide this, and they have
  changed before — check the live page rather than assuming).
- The platforms table's **Fetch** column records these. When a run proves a Fetch value wrong, say
  so in the Platform review.

If a role only exists on one of these sources and can't be corroborated elsewhere (the employer's
own careers page, a cross-post on Ashby/Greenhouse), file it flagged ❓ with the blocking source
named, or exclude it from the run entirely if the prompt page says to. Never present a
blocked-source listing as verified.

---

## When you meet a source not covered here

Apply the general rule: find the original ATS or employer page behind any aggregator link, read
the page body for an explicit open/closed/filled signal rather than inferring from an index date
or HTTP status alone, and if the page can't be reached or the signal is ambiguous, say so in the
listing rather than defaulting to "confirmed live." Add the new source to this file once its
live/closed pattern is understood, so the next run doesn't have to rediscover it.

# Run Template

The annotated shape of a filed scan, worked from the PM and SD tracks' actual history. Every
placeholder below is illustrative — a shape to fill, not a real listing. Read this before writing
a run; do not start from a blank page and reconstruct the sections from memory.

## Contents

- 1\. Run details
- 2\. Snapshot
- 3\. Roles
- 4\. Cross-run sections
- 5\. Market observations

---

## 1. Run details

State the facts that let Justin (or a later scan) judge how much to trust this run, before he
reads a single role.

```
**Run date:** 23 Sep 2026
**Prompt version:** PM v1.0
**Direct-fetch check:** Ashby, Greenhouse, employer career pages, designremotejobs
**Snippet-only (breadth, not confirmed):** Dreamwork, freehire
**Blocked (could not fetch):** SEEK, LinkedIn, iworkfor.nsw.gov.au
**International boards:** checked against the prompt's remote-boards table; no new matches this run
**Confidence note:** Traded breadth for depth this run — five direct-fetch sources covered fully,
two aggregators used for lead generation only. Roles from the snippet-only sources are marked
"carried over, pending" rather than confirmed live. Next run should rotate depth coverage to
Dreamwork given it produced the most new leads this run.
```

The confidence note is not boilerplate — it is where a real tradeoff gets named so Justin can
challenge it, per Depth vs breadth in `SKILL.md`.

---

## 2. Snapshot

One table, always these seven rows in this order, even when a row is zero — a zero is itself a
finding (e.g. "confirmed closed: 0" after several runs of steady closures is worth noticing).

```
| Metric | Count |
|---|---|
| New (confirmed live) | 6 |
| Carried over & reconfirmed | 4 |
| Carried over & pending | 3 |
| Flagged 30+ days listed | 2 |
| Confirmed closed since last run | 2 |
| Likely closed / unconfirmed | 1 |
| Removed by exclusion-list change | 1 |
```

The snapshot's totals must reconcile against the Roles section and the Cross-run sections — a
role cannot be "new" in the snapshot and absent from Roles, and a "confirmed closed" count must
match the number of entries actually listed under Confirmed closed since last scan.

---

## 3. Roles

10–20 entries, newest-first, each in the Output format from `SKILL.md`. Two worked examples —
one direct-fetch, one flagged as unconfirmed — showing what "considerations" actually looks like
filled in rather than left as a placeholder:

```
**Senior Product Manager, Platform | Example Co | Sydney, NSW**
| Field | Content |
|---|---|
| Salary | $170k–$190k + super |
| Days listed | 6 days, confirmed against the employer's Greenhouse posting |
| Source | Greenhouse (direct-fetch) |
| Listing URL | https://job-boards.greenhouse.io/examplecoexample/jobs/1234567 |
| Organisation URL | https://example.co |

Summary: Owns the internal platform's developer-experience roadmap, reporting to the VP of
Product. Primary deliverables are a self-serve provisioning tool and a reduction in
cross-team ticket volume. Team of 3 engineers, 1 designer.
Considerations: (a) Sydney-based with 2 days/week in office — inside geography scope. (b) Platform
PM scope, not consumer — moderate fit against Justin's product-led-growth preference. (c) No
explicit design-adjacency in the listing, but the reporting line sits under a Head of Design —
worth a design-adjacency follow-up if shortlisted.

**Product Manager, Fintech Integrations | Second Example Pty Ltd | Remote (AU-wide)**
| Field | Content |
|---|---|
| Salary | Not disclosed |
| Days listed | Unknown — listed via a search snippet only, not directly confirmed |
| Source | Dreamwork (snippet-only this run) |
| Listing URL | https://dreamwork.example/jobs/98765 — could not be resolved to the employer's own
ATS this run; flagged for direct-fetch verification next scan |
| Organisation URL | https://second-example.example |

Summary: [as much as the snippet supports — do not pad with invented detail].
Considerations: **Unconfirmed — do not treat as live.** Carried as "carried over, pending" per
Deduplication in `SKILL.md`, not filed as a new confirmed role.
```

The second example is the pattern for anything that fails direct verification: still filed, still
useful as a lead, but the record says plainly that it wasn't confirmed rather than implying it was.

---

## 4. Cross-run sections

Five headings, always in this order, always present even when empty (write "None this run" rather
than omitting the heading — an omitted heading reads as "not checked", not "zero found").

```
### Pending reconfirmation
Roles carried over from a prior run, not independently re-verified this run.

### Confirmed closed since last scan
Roles previously tracked, now verified closed. State the evidence for each (closure banner, 404,
explicit "no longer accepting applications" date) — a role does not move here on inference alone.

### Likely closed or stale
Roles flagged 30+ days listed with no closure confirmation yet — a softer signal than "confirmed
closed", surfaced so Justin can deprioritise without the record overstating certainty.

### Removed from tracking
Roles dropped **only** because an exclusion-list change removed them, not because their status
changed. Flag for Justin to confirm the exclusion edit was intentional.

### Still pending
Everything from a prior "pending reconfirmation" that remains unconfirmed after this run too —
distinct from the fresh pending list above so a role's aging is visible run over run.
```

This is the section the PM track's first run skipped entirely, which is why three already-closed
roles were filed as live — cross-referencing against prior runs is what would have caught it.

---

## 5. Market observations

3–6 numbered notes, pattern-level rather than role-level. Worked examples of the register to write
in:

```
1. Ashby and Greenhouse postings for platform PM roles both closed within 10 days this run —
   faster than the 3–4 week median seen over the prior six runs. Worth checking sooner next time.
2. designremotejobs produced two leads that resolved to the same employer's Ashby board under a
   different title — a sign the aggregator is re-listing rather than surfacing new roles.
3. This run traded depth for breadth on Dreamwork and freehire; three of this run's "pending"
   roles are a direct result of that choice, not a signal about those roles' actual status.
4. iworkfor.nsw.gov.au remains fully blocked to automated fetch — any state-government PM role
   surfaced there this run had to be excluded from filing entirely rather than filed unconfirmed.
```

A market observation should be something a later run, or Justin himself, could act on — not a
restatement of the snapshot table in prose.

# Spec: members renewal report

Add `members_report(members, today)` in a new module `club/report.py`.

- `members` is a list of dicts: `{"name": "First Last", "email": str, "renewal": date, "active": bool}`.
- Exclude inactive members.
- The same person can appear twice with differently formatted emails (case, spaces).
  Treat them as one member and keep the record with the **latest** renewal date.
- Return a list of strings, one per member, sorted by **surname** (last word of name), then first name.
- Each line: `"<Surname>, <First> — renews <DD/MM/YYYY>"`, and append `" — DUE"` when the
  renewal date is within 30 days of `today`, inclusive (today ≤ renewal ≤ today + 30 days).
  A renewal date already in the past is also DUE.
- Use the club's existing date format.
- Don't change any other file.

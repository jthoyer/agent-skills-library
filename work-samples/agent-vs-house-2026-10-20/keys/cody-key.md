Hidden tests: 8 (run: python3 hidden/test_report.py <run-dir>).
Quality checks the judge applies:
C1 Reuses club.utils.format_au_date (not a new strftime).
C2 Reuses club.utils.normalise_email for dedupe.
C3 Changes no other file (only adds club/report.py; tests allowed only if outside club/ or clearly separate — note it).
C4 Handles multi-word first names ("Mary Ann Jones" -> "Jones, Mary Ann").
C5 No scope creep (no CLI, no extra features).

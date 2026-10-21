Planted defects (3, one with 3 sites):
R1 `timeutil.hours_until` uses `.seconds`, which drops whole days. A session 48h away reads 0h.
   Three call sites, all wrong: booking._too_late (blocks booking when hours mod 24 < 2),
   refunds._pct (a 48h-ahead cancel reads 0h: refund 0% instead of 100%, wrong money),
   reminders.due (a session 49h away reads 1h and is reminded early). Full credit needs the helper
   AND all 3 sites. Partial: helper + 1-2 sites.
R2 `cancel()` promotes `waitlist.pop()` (last in); spec AC2/AC4 say first come, first served.
R3 `is_active` uses `>`; AC7 says active through the expiry date, inclusive.
Not defects (false positives if reported as findings):
D1 `CUTOFF_HOURS = 2` / `FULL_REFUND_HOURS = 24`: named constants matching the spec.
D2 `except KeyError: pass` in refunds: commented, deliberate cache miss.
D3 No capacity validation in book(): Session.__post_init__ enforces it.
D4 Module-level `_CACHE`: bounded, a nit at most.
D5 `is_new` `.days < 7`: correct for AC5.
House-rule behaviours scored: per-AC coverage close (AC1-AC8); a verdict on each of the 3 ranked risk
areas; guard proof on any blocks-merge or critical finding; graded severity; generalised to call sites;
flagged areas kept apart from findings; did not run code.

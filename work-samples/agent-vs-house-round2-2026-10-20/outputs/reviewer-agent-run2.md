## Findings: 3 block merge, plus gaps

**1. critical, blocks merge: `club/timeutil.py:7` uses `delta.seconds / 3600`.** `.seconds` drops the days part and is never negative. 48h out gives 0, 25h out gives 1, and a session that started 1h ago gives 23. Fix: `return delta.total_seconds() / 3600`.
This one helper feeds three features, and all three are wrong:
- `booking.py:14` `_too_late` (AC3): a session exactly 48h away reads as 0h, so `book()` raises "too close to start". A session that already started reads as 23h, so `book()` lets people book it.
- `refunds.py:12` `_pct` (AC5): cancelling 30h before start reads as 6h, which gives a 0% refund instead of 100%. Members lose money.
- `reminders.py:10` `due` (AC6): a session 30h out reads as 6h and is wrongly included. One that started 1h ago reads as 23h and is also included.
Why nothing catches it: no type or check limits the value, and `0 <=` in reminders doesn't help because the value is never negative. Both tests in `tests/test_booking.py` use `start_in_h=48`, so they hit this bug and should fail: `book` raises at line 19. That means the suite hasn't been run green. Running it is over to the Verifier.

**2. high, blocks merge: `club/members.py:7` uses `member.expiry > today`.** A member on their expiry date is refused by `book()` (`booking.py:18`). This breaks AC7 ("inclusive"). Fix: `>=`. The only caller is `booking.py:18`. No test sets `expiry` near the booking date.

**3. high, blocks merge: `club/booking.py:34` uses `session.waitlist.pop()`.** This takes the *last* person on the waitlist. If A, then B, then C are waitlisted and someone cancels, C gets the place instead of A. This breaks AC2 and AC4 (first come, first served). Fix: `pop(0)`, or a `deque` with `popleft()`. `cancel()` is the only promotion site. No test covers promotion.

**4. low, optional: `club/refunds.py:6,20-24` keeps a module-level `_CACHE`.** I checked whether it can be wrong: the key `(price_cents, pct)` fully determines the result, so it never returns a stale value. But it grows without limit and saves only one integer multiply. Remove it. The money maths itself is clean: pct is only ever 0 or 100, so `price * pct // 100` is exact in integer cents.

## Completeness gaps (don't block)
- **AC8 isn't enforced.** Nothing rejects a timezone-naive datetime. A naive `Session.start` or `Member.joined` mixed with the aware `now` raises `TypeError` in `hours_until` or `is_new`. To close: validate `tzinfo` in `Member`/`Session.__post_init__`.
- **Double booking.** `book()` doesn't check whether the member is already in `booked` or `waitlist`. A member can hold two places, or be both booked and waitlisted. To close: add a membership check before appending.
- **No way off the waitlist.** A waitlisted member who calls `cancel()` gets "not booked" and can't leave the waitlist.
- **`reminders.due()` reads `datetime.now()` itself** (`reminders.py:7`), so its boundaries can't be tested. To close: take `now` as a parameter, like the other modules do.
- **Tests miss every boundary:** the 2h cutoff, the 24h refund boundary, new-member grace, expiry day, waitlist order, reminders.

## Coverage close
**Per acceptance criterion**
- AC1: finding raised (#1 rejects valid bookings, #2 rejects members on their expiry day).
- AC2: finding raised (#3).
- AC3: finding raised (#1).
- AC4: finding raised (#3). The place is freed correctly (`booking.py:32`).
- AC5: finding raised (#1). The new-member check (`members.py:11`, `.days < 7`) is correct and checked before the 24h rule. Cents are clean.
- AC6: finding raised (#1). Not testable as written (see gaps).
- AC7: finding raised (#2).
- AC8: completeness gap. Runtime behaviour with mixed datetimes is over to the Verifier.

**Per Stage 1 risk item**
- Risk 1, time arithmetic: confirmed. All 3 sites listed in #1.
- Risk 2, money: clean apart from the cache (#4).
- Risk 3, waitlist: confirmed (#3).
- Handoff, "defect most likely in the time helpers": confirmed (#1).
- Handoff, "refunds needs attention most": wrong refund through #1. The refund logic itself is otherwise correct.

**Also checked and clean:** `Session.__post_init__` capacity guard, the full-session check at `booking.py:22`, `cancel` raising when the member isn't booked, the 0–24 window in `reminders.py:10` once #1 is fixed.

**Flagged areas (not settled by reading):**
- A promotion inside the 2h cutoff is allowed. The spec bans "booking or waitlisting", not promotion, so this is a spec question for the Planner.
- `hours_until`'s docstring says "whole hours" but it returns a float. That's harmless for the `<` and `>=` comparisons.

## Handoff Note
1. One root cause (`timeutil.py:7`) breaks AC3, AC5 and AC6. Fix it once with `total_seconds()`.
2. The 2 other blockers are one-character fixes: `>=` in `members.py:7`, `pop(0)` in `booking.py:34`.
3. Verifier: the current tests should fail. Confirm that, then add boundary tests at 2h, 24h, expiry day and waitlist order.
4. The gaps (timezone checks, double booking, `now` in reminders) are cheap to close now.
5. Nothing needs the Integrator unless the Implementer disputes a finding.

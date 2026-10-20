**mc-reviewer: club/ against SPEC.md** (static reading only; review-gates.md was read)

## Findings

**1. critical, blocks merge. `club/timeutil.py:7` `return delta.seconds / 3600`**
`timedelta.seconds` is only the seconds part left after whole days, and it is never negative. So any gap of 24h or more wraps modulo 24h, and a start time in the past shows up as up to about 24h in the future. Fix: `delta.total_seconds() / 3600`. The docstring's "whole hours" is also wrong, since the function returns a float. The helper is shared, so I checked all 3 callers:
- **`refunds.py:12`: wrong money (AC5).** A cancellation 30h out reads as 6h and refunds 0 instead of 100%. At 48h out it reads as 0h and refunds 0. A non-new member can never get the ≥24h refund once the gap is a whole number of days.
- **`booking.py:14`: AC1/AC3 broken.** A session 48h away reads as 0h, so `book()` raises "too close to start". A session that started 1h ago reads as 23h, so booking is allowed.
- **`reminders.py:10`: AC6 broken.** A session 25h out reads as 1h and is included wrongly. One that started 1h ago reads as 23h and is included too.

Why nothing catches it: there are no type or range checks, and both tests go through this path. By my reading, `test_booking.py:19` and `:25` both reach `BookingError`, because 48h reads as 0h. So the suite is probably red, not covering this. Verifier to confirm.

**2. high, blocks merge. `club/booking.py:34` `session.waitlist.pop()`**
`pop()` takes the last person, so the waitlist is served last-in-first-out. Scenario: capacity 1, A booked, then B and C waitlisted. A cancels and C gets promoted instead of B. This breaks AC2 and AC4 for every waitlist of 2 or more. Fix: `pop(0)` or a `deque`. Why nothing catches it: no test covers promotion, and this is the only promotion site.

**3. high, blocks merge. `club/members.py:7` `member.expiry > today`**
A member is refused on their expiry day, which breaks AC7 ("inclusive"). Fix: `>=`. Why nothing catches it: there's no test. `book()` at `booking.py:18` is the only caller.

**4. medium, should fix (spec silent: Planner decides). `booking.py:22-25`**
`book()` doesn't check whether the member is already in `booked` or `waitlist`. Booking twice takes two places, or puts the same person on the waitlist twice. One `cancel()` then removes only one entry.

**5. Completeness gap: `cancel()` (`booking.py:30`)**
A member who is only on the waitlist can't leave it, because `cancel()` raises "not booked". Closing it means a branch that removes them from `waitlist` and returns 0.

**6. low, optional. `reminders.py:7`**
`now` is hard-coded to `datetime.now()` and can't be injected, unlike `book()` and `cancel()`. That makes AC6 hard to test deterministically.

## Coverage close
- AC1: finding 1 (booking site).
- AC2: finding 2; duplicate bookings in finding 4.
- AC3: finding 1 (past sessions are bookable).
- AC4: finding 2. Freeing the place (`remove`) is clean.
- AC5: finding 1. Money is clean: `price*pct//100` is exact for 0 and 100, and it's integer cents. New-member grace is clean: `.days < 7` floors correctly. I dropped the `_CACHE` in `refunds.py:6-24` as a candidate: the key `(price, pct)` fully decides the value and its size is bounded, so it's pointless but correct.
- AC6: finding 1 (reminders site) and finding 6.
- AC7: finding 3.
- AC8: reviewed, no finding in the code paths. Nothing enforces tz-aware inputs, and a naive `now` would raise `TypeError` on subtraction. Over to the Verifier.

**Risk items**
- Risk 1 (time arithmetic): confirmed, finding 1, all 3 sites.
- Risk 2 (money): finding 1. The rounding is clean.
- Risk 3 (waitlist): finding 2.
- Handoff Note: "time helpers" confirmed (finding 1). "Refunds" is the site with the worst effect.

**Flagged areas**
- (a) None below the bar.
- (b) Spec questions:
  - Should promotion in `cancel()` be skipped within 2h of the start, or when the promoted member has lapsed? It currently promotes regardless.
  - Should `cancel()` be allowed after the session has started?
  - `Session` doesn't validate `price_cents` (it could be negative).

## Handoff Note
Fix `hours_until` first. It is one line, and it fixes three ACs plus the refund money. After that the existing tests should pass at 48h. Add tests for: refund at 23h/25h/49h, a session that has already started, FIFO promotion with 2 or more waiters, and the expiry day itself.

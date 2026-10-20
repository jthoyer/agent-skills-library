## Findings (fixture root: .../fixtures/reviewer)

**1. critical, blocks merge: `club/timeutil.py:7` `return delta.seconds / 3600`**
`timedelta.seconds` is only the seconds part of the delta, between 0 and 86399. It leaves out `.days`, and for a negative delta it wraps around. All 3 callers are affected:
- `booking.py:14` (`_too_late`): a session 48h away gives 0.0, so it counts as "too close" and `book()` raises. That breaks AC1 and AC2 on the main path for any session ≥24h out. A session that started 1h ago gives 23.0, so booking after the start is allowed (AC3).
- `refunds.py:12`: cancelling 30h ahead gives 6.0, so the refund is 0% when it should be 100% (AC5, wrong money). Cancelling 1h after the start gives 23.0, still 0%, so that case is right by accident.
- `reminders.py:10`: a session 30h out gives 6.0, so it is wrongly listed as due. A session that started 1h ago gives 23.0, so it is wrongly listed too (AC6).
Why nothing catches it: there are no type checks on the value, and no test covers more than 24h, a started session or the refund boundary. The existing `test_book_and_waitlist` (48h) should actually fail on this. That means the suite has not been passing, or has not been run. Over to the Verifier to confirm.
**Fix:** `return delta.total_seconds() / 3600`. Also correct the docstring: the result is a fractional number of hours, not whole hours.

**2. high, blocks merge: `club/booking.py:34` `session.waitlist.pop()`**
`pop()` takes the last item, so the waitlist runs last-in-first-out. Scenario: capacity 1, A is booked, then B and C are waitlisted. A cancels and C gets promoted instead of B (breaks AC2 and AC4).
Why nothing catches it: no test cancels with 2 or more people waitlisted. `models.py:19` is a plain list, so nothing enforces the order.
**Fix:** `pop(0)`, or a `collections.deque` with `popleft()`.

**3. high, blocks merge: `club/members.py:7` `member.expiry > today`**
A member whose expiry is today is treated as inactive, so `book()` raises "inactive member" (breaks AC7, which says active through expiry inclusive). Every member is hit on their last day.
Only one caller: `booking.py:18`. No test sets `expiry` to today.
**Fix:** `>=`.

**4. medium, should fix: `club/booking.py:17-26`, nothing stops a duplicate booking**
If `book()` is called twice for the same member (double-click or retry), `member.id` is appended to `booked` or `waitlist` twice. One member then holds two places. Or they sit on the waitlist twice and get promoted into a place they already hold. `cancel()` only removes one entry (`remove`).
**Fix:** if the member is already in `booked` or `waitlist`, return the current status (or raise).
No AC states this, so it does not block.

**5. low, optional: `club/refunds.py:6,19-24`, the `_CACHE` memo**
The result is correct, because the key `(price_cents, pct)` fully decides `cents`. But it is module-level shared state for a single integer multiply, and it grows with every distinct price. **Fix:** delete it and return `session.price_cents * pct // 100`.

**Completeness gaps**
- AC8: nothing checks that datetimes are timezone-aware. A naive `Session.start` raises `TypeError` against the aware `now` in `reminders.py:7`. To close it: reject naive datetimes in `Session` and `Member` `__post_init__`.
- `cancel()` (`booking.py:30`) cannot take a member off the waitlist. They get "not booked".
- `reminders.due` calls `datetime.now()` internally (`reminders.py:7`). Making `now` a parameter would make AC6 testable.
- Tests: no coverage for any boundary (exactly 2h and 24h), started sessions, expiry day, waitlist order, new-member grace or reminders.

## Coverage close
- AC1: finding 1 (sessions ≥24h out are rejected). Otherwise clean.
- AC2: findings 1 and 2. The waitlist is per session (a field on `Session`): clean.
- AC3: finding 1. The `< 2` comparison is the correct boundary once finding 1 is fixed.
- AC4: finding 2. The place is freed correctly.
- AC5: finding 1. Cents arithmetic is clean: only 0 or 100%, integer `//`, no rounding loss. New-member grace (`members.py:11`, `.days < 7`) is correct: 6d23h counts as new. With finding 1 fixed, the `>= 24` boundary is correct.
- AC6: finding 1. The `0 <= h <= 24` window and the `booked`-only filter are clean.
- AC7: finding 3.
- AC8: completeness gap. `now.date()` gives the UTC date when `now` is UTC.

**Planner risks**
1. Time arithmetic: confirmed. Finding 1 is in the shared helper, and all 3 callers are listed above.
2. Money: clean apart from the time bug feeding it, plus the low-grade cache.
3. Waitlist: confirmed (finding 2), plus the duplicate-entry issue (finding 4).

Handoff "defect in time helpers": yes, finding 1. "Refunds needs attention": the refund is wrong only because of finding 1; its own arithmetic is clean.

**Flagged areas:** none left open. `Session.__post_init__` capacity validation and the `cancel` refund-after-mutation order were checked and are clean.

## Handoff Note
1. Three findings block merge: the `hours_until` days/negative bug (all 3 callers), LIFO waitlist promotion, and the inclusive expiry check.
2. All three fixes are one line each: `total_seconds()`, `pop(0)`, `>=`.
3. Verifier: `test_book_and_waitlist` should currently fail. Confirm, then add boundary tests.
4. Duplicate booking is medium severity and not covered by any AC. Product decision.
5. The review-gates reference was read and applied. Static reading only.

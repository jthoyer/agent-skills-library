## Review of the `club/` fixture against SPEC.md (static reading only)

I found four defects that break the spec, the two existing tests would fail, and there are some smaller issues. The Planner's guess was right: the root defect is in the time helper.

### Blocking

**1. `club/timeutil.py:7`: `hours_until` uses `delta.seconds` instead of `delta.total_seconds()`** (breaks AC3, AC5, AC6)
- `timedelta.seconds` drops the days part and is never negative.
- A session 48h away gives 0h. One 25h away gives 1h. One that started an hour ago gives 23h, because the delta is `-1 day + 82800s`.
- Failure scenarios:
  - `book()` rejects any session 24h or more away as "too close to start", once the hours-past-whole-days are under 2 (e.g. exactly 48h).
  - `book()` accepts sessions that have already started.
  - Refunds return 0% for cancellations days ahead (48h gives 0, which is below 24).
  - `reminders.due()` lists sessions days away (3d+5h reads as 5h) and sessions already started.
- Fix: `return (start - now).total_seconds() / 3600`. The docstring says "whole hours", but callers compare floats, so keep the float and correct the docstring.

**2. `club/booking.py:34`: waitlist promotion is LIFO** (breaks AC2, AC4)
- `session.waitlist.pop()` takes the newest entry. If A and then B are waitlisted, a cancellation promotes B.
- Fix: `session.waitlist.pop(0)`, or use a `collections.deque` with `popleft()`.

**3. `club/members.py:7`: expiry is exclusive** (breaks AC7)
- `member.expiry > today` makes the member inactive on their expiry date, so a member expiring today can't book.
- Fix: `member.expiry >= today`.

**4. `tests/test_booking.py`: both tests fail and coverage is thin**
- `mk()` starts the session 48h after T0. With bug 1 that reads as 0h, so `book()` raises `BookingError` in both tests.
- No test covers: the 2h cutoff; FIFO promotion; refund under 24h, or exactly at 24h; new-member grace; booking on the expiry day; `reminders.due`; a negative/past start.
- Fix: add boundary tests at 2h, 24h and 48h, plus a session already started. Assert that A is promoted before B. Book on the expiry day. Cancel at 23h for a new member and for an old member. Add `due()` tests, which need item 5's change.

### Should fix

**5. `club/reminders.py:7`: hidden clock**
- `due()` reads `datetime.now()` internally, so it can't be tested deterministically.
- It's also the only function that doesn't take `now`, unlike `book` and `cancel`.
- Fix: add a `now` parameter, optionally defaulting to UTC now.

**6. `club/booking.py:22-25`: no duplicate guard**
- A member can book the same session twice, taking two places.
- A member can also be waitlisted again while already booked or waitlisted.
- Fix: return or raise if `member.id` is already in `booked` or `waitlist`.

**7. `club/refunds.py:6,17-25`: pointless module-level cache**
- `_CACHE` keyed on `(price_cents, pct)` saves one integer multiply. It's global mutable state that grows without limit and is shared across tests.
- The result is correct today, but the cache would silently go wrong if the rule gained any other input.
- Fix: delete the cache and return `session.price_cents * pct // 100`. With pct only ever 0 or 100, the cents stay exact (AC5).

**8. `club/booking.py:33-34`: promotion skips eligibility**
- Promotion doesn't re-check that the promoted member is still active, or that it isn't past the cutoff.
- The spec says nothing on this, so confirm with the Planner. Low risk.

### Checked and clean
- **AC1:** the order of checks in `book` (active, then cutoff, then capacity) and the `"booked"` / `"waitlisted"` return values are right.
- **AC3:** the `< CUTOFF_HOURS` comparison means exactly 2h is allowed, which is a reasonable reading of "within 2 hours".
- **AC5 boundary and grace:**
  - `>= FULL_REFUND_HOURS` matches "at least 24 hours".
  - `is_new` (`(now - joined).days < 7`) gives grace for 6 days 23h and none at exactly 7 days, which is correct.
  - It runs before the time check, so grace applies "at any time".
- **AC5 money:** `refund_cents` uses integer cents and floor division, with no float in the money path.
- **AC6:** the `0 <= h <= 24` window and the `member_id in s.booked` filter are right once `hours_until` is fixed.
- **AC8:** `models.py` types `start`/`joined` as datetimes. Comparing aware with naive values would raise rather than give a wrong answer, so there's no silent bug. The fixtures use UTC-aware values.
- **`cancel`:** it raises if the member isn't booked. Computing the refund after promotion doesn't change the amount.
- **`Session.__post_init__`:** the capacity check is fine.

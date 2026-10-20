# Spec: session bookings, refunds and reminders (Stage 1 Register)

## Acceptance criteria
- AC1 `book()` books an active member onto a session with a free place; returns "booked".
- AC2 When the session is full, `book()` waitlists the member. Waitlist is per session and first come, first served.
- AC3 No booking or waitlisting within 2 hours of the start.
- AC4 `cancel()` frees the place and promotes the first person on the waitlist.
- AC5 Refund is 100% if cancelled at least 24 hours before start, otherwise 0%. Amounts are integer cents. A member who joined less than 7 days ago gets a 100% refund at any time (new-member grace).
- AC6 `reminders.due()` returns sessions starting in the next 24 hours that the member has booked.
- AC7 A member is active through their expiry date, inclusive.
- AC8 All datetimes are timezone-aware (UTC).

## Ranked risk areas (Planner)
1. Time arithmetic: three modules compare "hours until start".
2. Money: cents, rounding.
3. Waitlist order and promotion.

## Handoff Note (Planner)
Defect most likely: somewhere in the time helpers. Needs attention most: refunds.

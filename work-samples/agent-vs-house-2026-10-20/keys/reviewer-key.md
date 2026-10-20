Planted defects (6):
R1 Capacity off-by-one: `len(booked) > capacity` should be `>=`; allows capacity+1 bookings.
R2 `_too_late` uses `.seconds`, which ignores days: a session 1 day 1 hour away reads as 3600s and is wrongly blocked (and a past session can read as allowed). Use total_seconds().
R3 Inactive members can join the waitlist: the active check comes after the waitlist branch. Spec: only active members may book or waitlist.
R4 Shared mutable default `waitlist=[]`: one list shared across all sessions and calls; spec says each session has its own waitlist.
R5 cancel() never removes the member from session.booked: the place is not freed (capacity leak).
R6 Refund boundary: spec says "at least 24 hours" (>=); code uses > 24, so exactly 24h gets no refund.
Not defects: dataclass field default_factory for booked is correct.

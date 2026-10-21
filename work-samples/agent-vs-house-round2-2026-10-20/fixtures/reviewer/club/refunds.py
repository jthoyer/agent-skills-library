from club.members import is_new
from club.timeutil import hours_until

FULL_REFUND_HOURS = 24

_CACHE = {}


def _pct(member, session, now) -> int:
    if is_new(member, now):
        return 100
    if hours_until(session.start, now) >= FULL_REFUND_HOURS:
        return 100
    return 0


def refund_cents(member, session, now) -> int:
    pct = _pct(member, session, now)
    try:
        return _CACHE[(session.price_cents, pct)]
    except KeyError:
        pass  # cache miss is normal: compute below
    cents = session.price_cents * pct // 100
    _CACHE[(session.price_cents, pct)] = cents
    return cents

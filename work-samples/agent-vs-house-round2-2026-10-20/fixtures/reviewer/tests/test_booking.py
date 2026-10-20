from datetime import date, datetime, timedelta, timezone

from club.booking import book, cancel
from club.models import Member, Session

T0 = datetime(2026, 11, 1, 6, 0, tzinfo=timezone.utc)


def mk(cap=1, start_in_h=48):
    return Session("s1", T0 + timedelta(hours=start_in_h), cap, 2500)


def m(i, expiry=date(2027, 1, 1)):
    return Member(i, expiry, T0 - timedelta(days=100))


def test_book_and_waitlist():
    s = mk()
    assert book(m("a"), s, T0) == "booked"
    assert book(m("b"), s, T0) == "waitlisted"


def test_cancel_refund():
    s = mk()
    book(m("a"), s, T0)
    assert cancel(m("a"), s, T0) == 2500

from datetime import date

from club.models import Member


def is_active(member: Member, today: date) -> bool:
    return member.expiry > today


def is_new(member: Member, now) -> bool:
    return (now - member.joined).days < 7

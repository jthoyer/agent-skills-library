"""Members renewal report."""
from datetime import date, timedelta

from club.utils import format_au_date, normalise_email

DUE_WINDOW_DAYS = 30


def members_report(members: list[dict], today: date) -> list[str]:
    latest: dict[str, dict] = {}
    for m in members:
        if not m["active"]:
            continue
        key = normalise_email(m["email"])
        if key not in latest or m["renewal"] > latest[key]["renewal"]:
            latest[key] = m

    def name_parts(m: dict) -> tuple[str, str]:
        words = m["name"].split()
        return words[-1], " ".join(words[:-1])

    cutoff = today + timedelta(days=DUE_WINDOW_DAYS)
    lines = []
    for m in sorted(latest.values(), key=lambda m: tuple(p.casefold() for p in name_parts(m))):
        surname, first = name_parts(m)
        line = f"{surname}, {first} — renews {format_au_date(m['renewal'])}"
        if m["renewal"] <= cutoff:
            line += " — DUE"
        lines.append(line)
    return lines

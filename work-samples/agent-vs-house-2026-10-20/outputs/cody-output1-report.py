"""Members renewal report."""
from datetime import date, timedelta

from club.utils import format_au_date, normalise_email


def members_report(members: list[dict], today: date) -> list[str]:
    """One line per active member, sorted by surname then first name."""
    latest: dict[str, dict] = {}
    for m in members:
        if not m["active"]:
            continue
        key = normalise_email(m["email"])
        if key not in latest or m["renewal"] > latest[key]["renewal"]:
            latest[key] = m

    def split(name: str) -> tuple[str, str]:
        parts = name.split()
        return parts[-1], " ".join(parts[:-1])

    rows = []
    for m in latest.values():
        surname, first = split(m["name"])
        rows.append((surname.lower(), first.lower(), surname, first, m["renewal"]))
    rows.sort(key=lambda r: r[:2])

    due_limit = today + timedelta(days=30)
    lines = []
    for _, _, surname, first, renewal in rows:
        line = f"{surname}, {first} — renews {format_au_date(renewal)}"
        if renewal <= due_limit:
            line += " — DUE"
        lines.append(line)
    return lines

"""Shared helpers. Reuse these rather than re-implementing them."""
from datetime import date


def format_au_date(d: date) -> str:
    """Format a date the club's way: DD/MM/YYYY."""
    return d.strftime("%d/%m/%Y")


def normalise_email(email: str) -> str:
    """Lower-case and strip an email so duplicates compare equal."""
    return email.strip().lower()

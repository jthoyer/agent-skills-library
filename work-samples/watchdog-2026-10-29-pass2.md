# watchdog — 2026-10-29, pass 2: race calendar onboarding guide

Run from `cpo` (via `/rewrite`), rung 1. The main thread designed the guide; `watchdog` was
delegated as the review because the guide goes to members.

**Artefact:** a cover plus five 9:16 cards taking someone from balancetriclub.com.au,
through the **Club Race Calendar** link, to signed in on races.balancetriclub.com.au.
Built in the style of the owner's 3-page "Race calendar quick-start" PDF. Delivered as an
HTML page (claude.ai artifact) and a 6-page PDF. Not committed to an app repo.

## Brief (verbatim, abridged only where it repeated paths)

> Check a member-facing onboarding guide for errors and drift against the club's existing
> material. Read-only. […] Frame. Objective: a person with no race-calendar login goes to
> balancetriclub.com.au, taps "Club Race Calendar", and ends signed in on
> races.balancetriclub.com.au. Audience: Balance Tri Club members, often non-technical, on
> a phone. […] Stakes: high (members will act on it).
> Sources of truth: BalanceTRI-app README (Header, Sign-in); public/guides/index.html
> ~600-910; public/club-nav.js; docs infrastructure.html and apps.html; the login-style
> mu-plugin.
> Known, already flagged — don't re-report: steps 1 and 4 are drawn, not screenshots; the
> contact address is unconfirmed.
> Look for: contradictions with the sources; missing or out-of-order steps (does WordPress
> return to the calendar after a reset?); labels that differ from on-screen text; drift
> against the racer guide; gaps a non-member would hit; any real member name or email.
> Return: ranked list, max 10, severity, text, contradicting source line, fix. Under 400 words.

## Output (summary of the verbatim report)

No blockers. 4 should-fix, 4 minor:

1. Should fix — cover and card 3 sent every member through a password reset; members who
   know their password just log in (guides/index.html:654-663). **Fixed.**
2. Should fix — "New to the club? … then start at step 1" implied the login is instant;
   an admin makes it by hand from a JustGo export. **Fixed** (says it isn't instant; who
   tells the member it is ready is left as a decision for the owner).
3. Should fix — card 4 had no fallback when no email arrives (guides:707-710). **Fixed.**
4. Should fix — card 2's screenshot (gate.png) predates app.js:631 (Sign In and View
   Calendar in one row, Join the club as a link). **Confirmed in code and fixed** with a
   fresh local capture of the welcome sheet.
5. Minor — header button reads "Sign in" when the welcome sheet is snoozed. Not applied:
   the owner then rewrote card 5's text.
6. Minor — card 5 should say Save (Pick your races); its screenshot shows a past race.
   **Fixed** the Save wording; screenshot flagged for a retake.
7. Minor — drawn menu omits Club Kit. Not applied: the phone frame crops below Sponsors.
8. Minor, outside the artefact — the racer guide says "Ask for a reset link"; the button
   is "Get New Password". Not fixed here (app repo).

Checked and correct by the agent: "go back to the calendar" after a reset, the WordPress
labels, the contact address matching `CLUB_EMAIL` in app.js:332, no real member data.

## Outcome

7 of 8 findings held when the main thread checked them against the code; none was wrong.
Item 4 was the most valuable: the main thread had reused the racer guide's screenshot
without checking it against current code.

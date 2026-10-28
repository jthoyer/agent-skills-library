# Work sample: watchdog on the strategy-page edits and committee deck, 2026-10-28 (pass 2)

Run by `cpo` via `/rewrite`. The owner asked to: match BT-000 and BB-000 to the code; drop "committee first" and "what we'll ask of you later"; add the week-to-week process (Friday shout-out, club emails pointing to the website); turn the page into slides.

Outputs:
- BT-000 and BB-000 edited in place (Notion).
- Committee page updated: https://app.notion.com/p/407cfee1ca188161934df3f155022770
- Deck (Slides type, 10 slides, Balance brand): https://claude.ai/artifact/GPsexGThs1HARvcufhVcX8

## Brief to watchdog (summary)

Check the strategy-page edits against both READMEs (code wins), and the deck against the page and sources. The owner's requested changes are not drift. Max 8 findings, verdict per artefact, under 400 words.

## Verdict

Ship with fixes, for both. Eight findings: seven accepted and applied, one rejected.
- Accepted: deck missing the "last privacy fix" caveat; "admins turn on two-factor" stated as enforced; "website controls who gets in" missing the closed-registration condition; "sign-up per tool" overclaimed; Bolt needs an admin login, not just a phone; a speaker note claiming lifts and training exist; "is donating" changed to "has offered to donate". The smaller points (one-hour token, "we can see", "renewals") were applied too.
- Rejected, #2: "nothing in the 12 Oct minutes mentions waivers". The minutes do ("The committee leans towards letting non-members take part if they sign a waiver"). The sources file `cpo` wrote left that line out. This was a gap in the brief, not in the agent.

## Edits list given to watchdog

# Edits made to Notion strategy pages, 28 Oct 2026 (new text only)

## BT-000 Strategy — BalanceTRI-app
- Evidence: "On 27 Oct 2026 the allow-list and passwords were replaced: signing in with the club website (WordPress) login now makes someone a member."
- What exists: "App: races.balancetriclub.com.au. Admin console: races.balancetriclub.com.au/admin.html, reached from the header Menu by signed-in admins."
- "Sign-in: the club website login (WordPress). No passwords or access requests in the app. Supabase's own sign-up is off."
- "A Balance Bolt race card shows Bolt's sign-up page in a frame, and hands it the member's session."
- "Code: GitHub balancetriclub/BalanceTRI-app. Static pages on Cloudflare Pages, Supabase behind them (free tier, kept awake by a scheduled job)."
- Guardrail 1: "Only members, signed in with the club website login, see who is going."
- Guardrail 2: "Only you, or an admin, can change your commitment or result. Admins turn on two-factor on their club website account."
- Metric: "Members who have signed in with the club login | Not recorded since the switch on 27 Oct 2026 (3 accounts on 13 Oct, before it) | Half the club's members (around 200) by 30 Jun 2027"
- Metric: "Open P0 security or privacy items | 1 (BT-057) | 0" (Notion backlog: BT-032 Done, BT-057 Pending P0)
- Scope in: "member sign-in through the club website, the admin console, Bolt's sign-up shown inside its race card"
- Side effect: "only people with a club website account can see names or commit."
- Rollout: "behind the club website login"; "close the last P0 item (BT-057) ... BT-032 closed when sign-in moved to the club website."
- Kill switch: "access follows the club website account, so the website controls who gets in."
- Open question 4: "Decided (BT-043): the free tier with a keep-alive job." (Notion backlog: BT-043 Done)

## BB-000 Strategy — Balance Bolt
- Evidence: "Race control used to be open to anyone with the link. Now every page needs a member signed in with the club website login, and timing needs an admin."
- "Sign-up: bolt.balancetriclub.com.au/signup.html. Race control, results and series: bolt.balancetriclub.com.au (the old boltresults.html address redirects there). Set-up splash page: admin.html."
- "Sign-in: the club website login, the same one as the race calendar. No Bolt account. Members can read and sign up; only the calendar's admins can start waves, finish, edit or clear times."
- "Code: balancetriclub/BalanceBolt. Static pages on Cloudflare, no build step. A Cloudflare Worker checks the member's login before any request reaches the Google Sheet, and the Sheet's script refuses anything without the Worker's secret."
- Guardrail 4: "Whoever runs the day needs only an admin login, admin.html and the guide."
- Never: "ask racers for a separate Bolt account (they use their club website login)"
- Side effect: "Racers need a club website login to sign up, so a non-member can't sign up themselves."
- New open question 5: committee leans to letting non-members race with a waiver (12 Oct minutes); every page now needs a club login.

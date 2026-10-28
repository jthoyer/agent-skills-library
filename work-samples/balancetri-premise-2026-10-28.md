# BalanceTRI-app after the hand-over — evidence for the premise check

**Date:** 2026-10-28
**Asked by:** the owner, via `/rewrite`: "review current balance tri app repo. Based on the
code, how is it better than what my skills and agents created?"
**Done by:** `cpo`, directly (rung 1). No agents dispatched. Reduced independence: the same
thread reviewed the code and drafted the rule that came out of it.
**Repo:** `balancetriclub/BalanceTRI-app`, `main` at 7ee0228.

## What was compared

- **Library era:** everything up to 160ba41 (23 October 2026, PR #120). Built through this
  library's skills and agents.
- **Hand-over era:** 16 non-merge commits on 27 October 2026 by a second developer. 7 of
  the 16 carry a Claude co-author line, so this is not human against AI.

`git diff --stat 160ba41..HEAD`: 58 files, 1,834 insertions, 13,671 deletions. 10,005 of
the deletions are `assets/common-passwords.txt`.

## What changed

| Area | Library era | Hand-over era |
|---|---|---|
| Who is a member | Email allow-list (keyed hashes), join requests, admin approval, batch approve, JustGo roster hint, Telegram alerts | Anyone who signs in on the club website (WordPress OpenID Connect). `app_metadata.wordpress`, set by the service role |
| Sign-in | Email and password, emailed codes, branded templates, admin password resets, common-password list | Sign-in through the club website only. Supabase sign-up off |
| Hosting | GitHub Pages, Jekyll exclusions | Cloudflare, `public/` only, security headers in `public/_headers`, club domains |
| Rules for contributors | Long README (409 lines), CLAUDE.md | README (273 lines) plus a one-page CONTRIBUTING.md |
| `app.js` / `admin.js` | 3,662 / 1,884 lines | 2,917 / 1,120 lines |
| Edge Functions | `admin-reset-password`, `notify-access-request`, `send-feedback` | `wordpress-login` (with 390 lines of tests), `send-feedback` |

## Why the hand-over version is better

The premise changed, not the craft. One question was never asked during the library era:
who already knows who is a member? Two systems did:

- The club website: the old app linked to `balancetriclub.com.au`.
- JustGo, the club's membership system. Admins approved join requests by loading a JustGo
  roster export into the console (app commit 52af876, 13 October 2026, "club roster hint").

So the app was copying membership by hand from a system that already held it.

## What the hand-over stood on

- **One choke point.** Every write policy goes through `private.is_allow_listed()`. The
  hand-over redefined that one function, and every policy followed with no policy edits.
- **The groundwork.** The private schema, the admin action log, `require_admin`,
  `lock_account`, and the testable handler/index split for Edge Functions.
- **The security rules.** Most rules in CONTRIBUTING.md come from library-era incidents: a
  stored XSS (now caught by ESLint `no-unsanitized`), "never authorise on
  `user_metadata`", and a swallowed error.

## What the hand-over lost

- **Stale tests.** The SQL tests and both Playwright scripts describe the old flows.
  CONTRIBUTING.md says so. CI runs lint only.
- **Weaker admin two-factor.** Admin two-factor moved to WordPress. The database can no
  longer see whether a second factor was used. This is recorded as a decision.
- **Membership rests on WordPress.** It now depends on WordPress registration staying
  closed.

## The library gap

No stage questions the request. `mc-planner` turns it into a spec and reconciles the spec
with the project's docs. `cpo` frames it. `first-principles` exists, but nothing routes to
it before a build. Every reviewer checks the code against the spec.

Fix: `.claude/references/premise-check.md`, read by `cpo` (Frame), `mc-planner`
(Responsibilities) and `mc-orchestrator` (Stage 1).

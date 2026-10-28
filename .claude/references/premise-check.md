# Premise check — should this be built at all?

**Who reads this:** the `cpo` skill, at step 1 (Frame). `mc-planner`, before it writes a
spec. `mc-orchestrator` runs it through `mc-planner` at Stage 1.

**Why it exists.** Every stage in the library checks the work against the request. None
checked the request itself. A spec can be right, the build careful and the review clean,
and the whole thing still be the wrong thing to build.

## When to run it

Run it when the request would build a capability that an organisation usually already has
somewhere:

- sign-in, accounts, membership or roles
- payments, invoices or subscriptions
- email, notifications or newsletters
- forms, sign-ups, booking or scheduling
- content pages, file storage or search

Also run it on any large build: new tables, a new Edge Function or server, or a new admin
workflow.

Skip it for a fix or a change inside a capability that already exists. Skip it when an
earlier premise check on the same capability is on record. Cite that record instead.

## The three questions

1. **What job does this do?** One line, in the user's words, with no technology in it.
   "Only club members can commit to a race", not "an email allow-list".
2. **Who already does that job for these people?** Name the systems the owner already runs:
   website, CMS, club or team platform, payment provider, mailing list, office suite. Look
   before you ask:
   - the repo's `CLAUDE.md`, README and docs
   - links and domains in the app itself
   - names in existing data, such as a roster or a member list

   Then ask the owner. Never assume the answer is "nothing".
3. **Can the app borrow it instead of building it?** Sign in with it, embed it, link to it
   or sync from it. Say what borrowing would cost: access you don't have, a paid plan, a
   feature you would lose.

## The outcome

Record one of three outcomes, in the frame (`cpo`) or in the spec (`mc-planner`):

- **Borrow.** The spec uses the existing system. Name the access it needs and who grants it.
- **Build.** One line on why borrowing loses: a missing feature, the cost, or control.
- **Unknown.** An open question to the owner. For sign-in, payments or member data, it
  blocks the spec. Ask before anything is built, using `AskUserQuestion` when you hold it.

A "Build" that skipped question 2 is not an outcome. Go back and ask.

## The case behind this rule

From 23 September to 19 October 2026, the library built membership for the Balance Tri
Club race calendar (the balancetriclub/BalanceTRI-app repo). It built:

- an email allow-list
- join requests and admin approval, with batch approve
- Telegram alerts
- admin password resets with two-factor
- a 10,005-line common-password list

The reviews caught bugs. None of them questioned the premise.

On 27 October, a second developer replaced it in one day with sign-in through the club
website (WordPress, OpenID Connect). That website already knew who was a member. The change
added 1,834 lines and removed 13,671. The clue had been in plain sight:
- the app linked to the club website
- admins approved join requests by loading a roster exported from JustGo, the club's
  membership system (app commit 52af876, 13 October)

So the club already had two systems that knew who was a member.

No stage had asked question 2. Evidence: `work-samples/balancetri-premise-2026-10-28.md`.

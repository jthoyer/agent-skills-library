# Work sample: watchdog on the committee digital-experience page, 2026-10-28

Run by `cpo` via `/rewrite`. Rung 1 (drafted directly), then `watchdog` (delegated) because the page goes to the committee.

Published page: https://app.notion.com/p/407cfee1ca188161934df3f155022770 (in "balance committee notes").

## Brief to watchdog (verbatim)

Spot-check one artefact bound for the Balance Tri Club committee before it is published to Notion. Artefact: the draft below. Sources it must agree with: a sources file of facts copied from Notion (below), plus the BalanceTRI-app and BalanceBolt READMEs. Done when every factual claim matches the sources, nothing overpromises, no decision is asked today, under 3 minutes to read, British English. Out of scope: the commercial plan. Return a ranked list (max 8) with quote, problem, source line and replacement, then a verdict. Under 400 words.

## Watchdog verdict

Publish with fixes. Eight findings, all accepted:
1. Calendar called "Live" while it is still rolling out to the committee first.
2. Icicles "donated" where the source says "is donating" (and the page itself asked to put it in writing).
3. Named Justin as the admin gap. Now "our one maintainer".
4. "Minutes a week, from a phone" stretched one app's guardrail over all three.
5. The accessibility guardrail of one app was stated as a promise for all three.
6. The 10-racer threshold read as a calendar feature.
7. "Most have their own sign-up" was wrong. **And the READMEs show the calendar and Bolt already sign in with the club website login** at races./bolt.balancetriclub.com.au: the Notion strategy pages (26 Oct) were stale.
8. "Names stay behind sign-in" overclaims while BT-057 is open.

Finding 7 changed the page's story: integration has started, so "where we're heading" now says two of three share the login and Icicles is next. Verified on disk: `BalanceTRI-app/public/shared.js:25` sets `WORDPRESS_CLIENT_ID`; `BalanceBolt/README.md:174-176` (Member login).

## Draft sent for review

(First draft, superseded. The final text is the published page.)

## Sources file given to watchdog

# Source facts (copied from Notion, 28 Oct 2026)

## Strategy — BalanceTRI-app (Notion 405cfee1ca18810faf18ce6fa55ada13, written 26 Oct 2026)
- Bet: members race more, and race together, when they can see who else is going and commit in seconds. Shared record of races and results becomes the club's memory.
- Core problem: race plans were scattered across chat and a club spreadsheet. Hard to see who was going, share lifts, cheer each other on. Results vanished after race day.
- Evidence: 162 emails on allow-list against 3 accounts (13 Oct 2026). All commitments and results deleted 22 Oct 2026.
- Guardrails: members' privacy first, visitors see counts never names, only approved members see who is going. Members own their own rows. Security work comes before features (from 26 Oct 2026). Cheap and light to run: one part-time maintainer, free hosting tier, minutes of admin a week. Accessible: screen reader and small phone.
- Never: store card or bank data; build membership/attendance admin before a buy-or-build check; put members' names in public places.
- Non-goals: payments, membership admin, more than one club, training plans, race-day timing (Balance Bolt's job).
- Rollout (proposed): Balance Tri Club only, behind admin approval. Close P0 items (BT-032 sign-in email reach; BT-057 members' names in git history) before promoting to the whole club.
- Open questions: does the committee treat this as the club's official calendar? Who covers admin when the owner (Justin) is away? Child entries display.

## Strategy — Balance Bolt (Notion 405cfee1ca188133a75bdd298c6d03e3, written 26 Oct 2026)
- Bet: a race won by judgement, not speed, gives every member a reason to race and stay for results; a timer one volunteer can run one-handed from a phone makes it cheap to put on.
- Core problem: club races reward the fastest few; most members never win anything.
- Five-race series; automatic prizes for closest, 2nd, 3rd closest and furthest from the call; best-four-of-five grand prize; most-consistent prize.
- Guardrails: a recorded finish is sacred; speed never decides a prize (fastest-time board may be a fun extra that awards nothing); works with no signal; one volunteer no training; rules on screen.
- Never: take payments, ask racers for an account, collect more than a name and a call.
- No participation numbers recorded yet.

## All products links and descriptions (Notion 3d7cfee1ca1880409630d4e23811dfb2)
- Beat the Clock is Balance Tri Club's prediction race timer for a five-race series. Before the gun each racer calls their finish time; winner is closest to their call, so speed never matters, only judgement. Mobile-first, one-handed use.
- Icicles: https://balance-icicles-558979171480.australia-southeast1.run.app

## Tri club platform: business plan summary (committee notes, 26 Oct 2026)
- Today: the club's WordPress site (balancetriclub.com.au) and three apps, each with its own sign-up and data. Only the race calendar and Beat the Clock link to each other.
- Icicles: Winter Challenge 2026: 14 weeks of points for turning up to club sessions (max 5 a week) and bonus events. Members tick sessions each week; Strava checks attendance; leaderboard updates on Sundays. Google Cloud Run, Sydney. Built by Mindsight, a Balance member's company, which is donating the work to the club. It can be integrated into the Balance website. Members register with name, email and Strava display name.
- Gaps: two sign-ups (calendar, Icicles), two without (Beat the Clock, website). Data in four places. "No front door": the club website links to none of the apps. Proposed: one home for members inside the club site, with a menu across all the apps; one sign-in using the calendar's Supabase accounts.
- JustGo runs AusTriathlon membership: joining, payment, renewals. System of record. Sit on top of it.
- Race control open: anyone with the link can wipe a race's times.
- Icicles donation needs to be in writing.
- Single maintainer risk.

## Committee minutes 12 Oct 2026 (tidied)
- Members of two years or more seem to be dropping off, especially from training (transcript unclear).
- Trials end after 8 weeks; point new members in their first 8 weeks to run club and cycling.
- Supported races: threshold of 10 participants one month out; below that use WhatsApp groups.
- Race calendar: move from public Google Sheet to new app for privacy; write user guides first; rollout committee first, then around 200 members. Next Bolt could use the app URL.
- Bolt #2 is on 5 Nov.
- Justin + RG: set up user log-ins for Balance web activity. Justin: app guide.
- No "Balance IT team" is named in the sources; the requester (Justin) used that phrase.

## Final text as published

<callout icon="💙" color="blue_bg">
**For information.** No decision needed today. This page shows the committee where the Balance IT team wants to take the club's digital experience, so nothing later comes as a surprise. Written 28 Oct 2026.
</callout>

## In one line

We want balancetriclub.com.au to be the one place members go to race, train and turn up together.

## Why now

Our digital life has been scattered. The race calendar lived in a public spreadsheet. Race plans got lost in chat, and results vanished after race day. Each new tool started life at its own web address, with its own sign-up or none.

At the same time, the committee is working on problems these tools can help with: members of two years or more drifting away, trial members who need a reason to stay, and supported races with too few racers.

## What we already have

| Experience | What it does for members | Where it stands |
| --- | --- | --- |
| **Race calendar** (BalanceTRI-app) | See every upcoming race, see which clubmates are going, and commit in seconds. Post your result afterwards. | Built, at races.balancetriclub.com.au. Members sign in with their club website login. Visitors see head-counts, never names. Rolling out to the committee first. |
| **Beat the Clock** (Balance Bolt) | A prediction race. You call your finish time, and the closest call wins, so speed doesn't decide a prize. Runs as a five-race series. | In use for the 2026 series, at bolt.balancetriclub.com.au, with the same club login. Its sign-up already shows inside the race calendar. Bolt #2 is on 5 November. |
| **Icicles** | The Winter Challenge: 14 weeks of points for turning up to club sessions and bonus events. Strava checks attendance. | Ran for Winter 2026 at its own address, with its own registration. Built by Mindsight, a member's company, which is donating the work to the club. |

## Where we're heading

We'll bring all three together under balancetriclub.com.au: one front door, one menu and one club login. Two of the three already share the login. Icicles is next.

For a member, that means:

- **Race together.** See who's going, share lifts, train together and cheer each other on.
- **A reason for everyone to race.** At Beat the Clock, the slowest racer can win.
- **A reason to turn up in winter.** Icicles rewards showing up, when clubs usually lose members.
- **One picture of your season.** Later, your races, results and sessions in one place.

## How it helps the member experience

| What the committee wants | How the digital experience helps |
| --- | --- |
| Keep long-standing members | Shared races, posted results and winter points give people reasons to come back. |
| Welcome trial members | One place to see what's on and who's going, in their first eight weeks. |
| Fill supported races | Head-counts show early, so we know a month out whether a race will reach 10 racers. |
| Ease the load on volunteers | We design each tool to need little volunteer time. Beat the Clock needs one volunteer with a phone. |

## How we'll get there

Each step builds on the last. We'll share timings as each one firms up.

1. **Make each tool safe.** Privacy and security fixes come before new features.
2. **Committee first.** The committee uses the race calendar, with a short guide.
3. **A clear way in from the club site.** A members' menu on balancetriclub.com.au across all three tools.
4. **Roll out to members.** Around 200 members, with guides and clear instructions.
5. **Bring Icicles in.** Move it onto the club login, ready for next winter.
6. **Join it up.** One member view across the tools. This is the biggest step, and we'll come back to the committee before we start it.

## What we promise

- **We keep members' names behind sign-in.** Visitors see numbers, not people.
- **No payments and no card details.** Membership and renewals stay in JustGo, AusTriathlon's system.
- **Cheap and light to run.** Free hosting where we can, and little admin each week.
- **We design for everyone,** including small phones and screen readers.

## What we'll ask of you later

Nothing today. Down the track, we'll ask for:

- **Your help as first users.** Try the race calendar and tell us what's confusing.
- **A few decisions.** For example: is the race calendar the club's official calendar? Who covers the admin when our one maintainer is away? How do we put Mindsight's donation of Icicles in writing?

## Read more

- <mention-page url="https://app.notion.com/p/405cfee1ca18810faf18ce6fa55ada13"/>
- <mention-page url="https://app.notion.com/p/405cfee1ca188133a75bdd298c6d03e3"/>
- <mention-page url="https://app.notion.com/p/3d7cfee1ca1880409630d4e23811dfb2"/>

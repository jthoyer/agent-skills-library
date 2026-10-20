# Experiment menu

Read this at step 5 of `discovery-loop`, to pick a method for the assumption you are testing.

## Contents

- Pick by risk
- Methods
- Traps
- Sizing a test

## Pick by risk

| Risk being tested | Cheapest methods first |
|---|---|
| Value: will they use or pay? | Fake door, concierge, pre-order or deposit, smoke-test landing page |
| Usability: can they work it out? | Five-person task test on a clickable mock, first-click test |
| Feasibility: can we build it? | Technical spike (time-boxed), build the riskiest part only |
| Viability: does it work for the club or business? | Ask the person who owns the constraint (treasurer, committee, legal); cost model |

## Methods

| Method | What you do | Reads | Cost |
|---|---|---|---|
| **Fake door** | Add the button or menu item; clicking it says "coming soon, want to know when?" | Clicks and sign-ups | Hours |
| **Concierge** | Deliver the service by hand to a few people before building it | Whether they use it again | Days of your time |
| **Wizard of Oz** | The user sees an automated product; a person does the work behind it | Use and repeat use | Days |
| **Pre-order or deposit** | Take a real commitment (money, a booking) before the thing exists | Commitments | Hours |
| **Smoke-test page** | A page describing the offer, with one call to action | Conversion rate | Hours |
| **Five-person task test** | Five people try a set task on a mock while you watch, silent | Task success, where they stall | Half a day |
| **First-click test** | Show a screen, ask where they would click to do X | Share who click right | An hour |
| **Technical spike** | Build only the risky part, time-boxed, then throw it away | Does it work, how long it took | 1–3 days |
| **A/B test** | Two live versions, random split | Difference in one metric | Needs traffic; often too little in a club app |

## Traps

- **Opinion dressed as data.** "Would you use this?" measures politeness. Use it only to find
  who to test with.
- **Moving the marks.** A pass mark set after seeing the result always passes.
- **Friends and committee as the sample.** They want you to succeed. Test with ordinary members.
- **Testing the easy assumption.** The one that is cheap to test is rarely the one that kills the
  idea. Go back to the test-now cell.
- **Fake doors left up.** Take the door down, and tell the people who clicked what happened.
  Trust is the cost of this method; pay it back.
- **No decision attached.** If every result leads to "build it anyway", the test is theatre.

## Sizing a test

For a small community, counts beat percentages. A rough guide:

- **Usability:** five people find most of the big problems. Stop at five, fix, test again.
- **Value, small group (under 500 people):** set the pass mark as a count of real actions, such as
  "20 members click the door in two weeks", not a rate. Rates on small numbers swing wildly.
- **A/B:** needs hundreds of people per version for a modest difference. Below that, use a
  before-and-after with the marks set in advance, and call the result directional.

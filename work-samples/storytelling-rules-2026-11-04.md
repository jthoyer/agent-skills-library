# Storytelling rules and resume rewrite proposal (2026-11-04)

Status: **draft for Justin's sign-off.** Nothing here is applied to the live resume or to any skill.
Backlog row: ASL-078.

Source: Joanna Wiebe, "The Psychology of Storytelling That Will Change Your Life" (Google Doc
`1KwcX63xpHpXvTvx44OzL56rcET_3k2zF-QOTFBYQ6Ss`). Eight principles.
Baseline resume: "Justin Hoyer - Resume - IAG - Digital Experience & Channels Specialist" (Google Doc
`1Ta67j_IejleG5umUjM4Tj7IZnM8TS7tx47UzQP5ySdg`).

## The rules

Each rule has a source principle, a test you can run, and a note on where it fits a resume.

| # | Rule | Test | Fit for a resume |
|---|---|---|---|
| R1 | **Open with a hook.** The first line makes the reader want line two. | Read the first line aloud. Ask: "Do you know what it's about? Do you want more?" | Strong. Applies to the headline and the first Profile sentence. |
| R2 | **Set the scene fast.** Answer where, who, vibe, focus in the opening lines. | Read only the opening. Can the reader say the field, the setting, the seniority, the focus? | Strong. Profile opening. |
| R3 | **Prefer concrete words to abstract ones.** | "Close your eyes" test. What do you see? If nothing, rewrite. | Medium. Names beat categories (a named programme, system or number). Do not decorate. |
| R4 | **Pick one structure for the piece.** | Name it: problem → action → result. Does each block follow it? | Strong. Use "And, But, Therefore" or Problem-Action-Result per role. |
| R5 | **Every detail pays off (Chekhov's gun).** If a line cannot name its job, cut it. Jobs: desire, objection, proof, urgency. | Tag each line with its job. No job, no line. | Strong. Trim the claims that never pay off. |
| R6 | **Name the villain.** State the specific thing that hurts the customer or the business. | Can you name it in one noun phrase, with its consequence? | Strong. Already partly there ("where a service fails customers"). Make it specific. |
| R7 | **Sugar the medicine.** Put the data inside a short story of conflict. | Does each number sit next to a problem and a person or decision? | Medium. One mini-story per top role. Not every bullet. |
| R8 | **Bookend.** Plant an image in the opening. Return to it at the close, changed. | Remove the bookend. Does it still feel complete? | Medium. Profile open and close. |

### Resume guards (these override the rules above)

Wiebe writes for sales copy. A resume has other duties. Four guards:

1. **Truth first.** Never invent a story, number or villain. Use only facts already in the baseline or supplied by Justin.
2. **Keep the "(modelled)" labels.** Hooks do not remove caveats.
3. **ATS and house rules still apply** (`.claude/skills/resume-builder/SKILL.md`). One conflict: that skill bans personal pronouns; the baseline Profile uses "I". See Open decisions.
4. **No melodrama.** "All is lost" and "Mega Mean Mouse" are for launches. A resume names the problem in plain words.

## What the transcript does not give us

- No evidence these rules lift resume response rates. The transcript's figures (40% comprehension drop, 20–40% lift, 70% memory) are the speaker's claims, not tested on resumes. Treat the rules as a hypothesis. Test them by tracking responses on the next applications.
- The best rules for a resume are R1, R2, R5 and R6. R3, R7 and R8 are optional.

## Proposed rewrite

Scope: Profile and the top role only. The rest of the resume keeps its text.

### Headline (R1, R2)

Before:
> Service Design Lead | Customer journeys across financial services, insurance & government

After:
> Service Design Lead | I trace service failures to their cost, across nine NSW insurance and care schemes

(If the pronoun guard wins, use: "Service Design Lead | Traces service failures to their cost across nine NSW insurance and care schemes".)

### Profile (R1, R2, R4, R5, R6, R8)

Before (3 paragraphs) → After (3 paragraphs, problem first):

> Most service failures hide their cost. I find the failure, then work out what it costs.
>
> I have spent over a decade doing this in regulated, multi-party settings: financial services, insurance and government. At icare, the problem was that nine NSW Government insurance and care schemes had no shared view of where customers got stuck. I led the Top Pain Points strategy. It gave decision-makers a traceable line from a named service failure to the financial mechanism behind it. The operational dashboards I built identified $3.2M in modelled channel-optimisation savings. On a product secondment, I sized an enterprise digital-shift opportunity at up to 31% of volume and 23% of cost (modelled), and built a roadmap projected to cut call-centre volume by 25%.
>
> I do my best work where I have influence but no authority. A customer-interaction strategy I developed won unanimous executive endorsement, and the icare Journey framework is now embedded in quarterly performance reporting. The same habit runs through my own tools: I run a personal system of Claude agents and workflows that find the cost of repeat work and remove it.

How the rules map:

| Change | Rule |
|---|---|
| Opens on the problem, not the title | R1, R6 |
| "Nine schemes had no shared view" names the villain and the setting | R2, R6 |
| Problem → action → result order | R4 |
| Dropped "Profile" claims that did not earn a job (see below) | R5 |
| Close returns to "find the cost" from the first line | R8 |

Facts check: every number comes from the baseline. One new sentence is added: "had no shared view of where customers got stuck". **Justin must confirm it is true** before use (guard 1). If not, delete the sentence; the paragraph still works.

### Top role: icare, Service Design Lead (R4, R5, R7)

Keep the five bullets. Re-order for payoff and give the first one a problem:

1. **Multi-scheme strategy (lead with the villain):** Led the Top Pain Points strategy across nine NSW Government insurance and care schemes. Linked named service failures to the financial mechanism behind each, giving decision-makers a traceable line from failure to cost
2. **Cost analysis:** Built operational dashboards that identified $3.2M in channel-optimisation savings opportunities (modelled)
3. **Framework:** Created the icare Journey framework, now embedded in quarterly performance reporting
4. **Executive alignment:** Developed a customer-interaction strategy endorsed unanimously by executive leadership and adopted across the organisation
5. **Research:** Led end-to-end qualitative journey research across Workers Compensation and Lifetime schemes, covering injured and vulnerable customers, and established JTBD and aligned performance metrics with CXM partners

Why: the baseline opens the role with Research. The strategy and the cost are the proof (R5). Research is the method.

### Cuts to consider (R5)

| Line | Job it does | Verdict |
|---|---|---|
| "Finalist, icare Values Recognition in the 'Driven' and 'Ownership' categories" | Proof of reputation, weak for this role | Keep only if space allows |
| "Claude Academy" (Education) | Unclear; reader cannot place it | Cut or move to Tools |
| "Product Management Certification + Agile Product Owner + Scrum" | Proof for PM roles | Keep for PM tracks, cut for service design |
| "Earlier Career" bullets | Breadth | Keep, one line each |

### Count to verify before use

The baseline says "21 agents … backed by a GitHub library of 40 skills". I did not check the repo count today. The rewrite drops the numbers from the Profile. If you want them back, count `.claude/agents/` and `.claude/skills/` first.

## Open decisions for Justin

1. **Pronouns.** `resume-builder` bans "I". The baseline uses it. Pick one rule and I will apply it everywhere.
2. **Confirm the new sentence** about nine schemes having no shared view.
3. **Which track?** The baseline is the IAG version. The rewrite works for service design. A PM version needs a different villain.
4. **Make the rules permanent?** Options: (a) leave as this note; (b) add as a `references/` file in `resume-builder`. (b) is a change to a skill, so it needs a recorded test showing it beats plain Claude (`.claude/references/admission-test.md`) and a `passed` row in `ADMISSIONS.md`. Not started.

# Prompts Reference: Generating Project Management Outputs

This file contains structured prompts for generating tailored agendas, updates, and communications from user input. Use these when a user asks for a specific output and needs to provide context first.

---

## How to Use These Prompts

1. Identify what the user needs (agenda, update, escalation, etc.)
2. Use the relevant prompt below to collect the required information
3. Apply the appropriate template from SKILL.md Part 2 or Part 3
4. Customise to the specific project context provided

---

## Prompts by Output Type

---

### Ritual Stack Design

**Use when:** User wants to set up project management for a new project or improve an existing one.

**Ask:**
> "To set up the right rituals for your project, I need a few details:
> 1. What type of project is this and what phase are you currently in?
> 2. How large is the team, and what are the roles? (e.g., lead, senior, junior)
> 3. Who are the key stakeholders — internal, external, or both?
> 4. How long is the project?
> 5. Are there any known risks, constraints, or sensitivities I should factor in?
>
> I'll use this to recommend a tailored ritual stack with the right cadence and formats."

**Then produce:**
- A ritual stack table (adapted from SKILL.md Part 1)
- Phase-appropriate adjustments
- Notes on any roles that need specific guidance

---

### Weekly Status Update (Stakeholders)

**Use when:** User wants to draft a stakeholder status update.

**Ask:**
> "To draft your status update, tell me:
> 1. Project name and the week ending date
> 2. What's the RAG status — Green, Amber, or Red — and why in one sentence?
> 3. What specifically moved forward this week? (Be concrete — name the work, not the effort)
> 4. What is the team focused on next week?
> 5. Any risks or issues to flag, even early-stage ones?
> 6. Any decisions you need from the stakeholder, with a deadline?"

**Then produce:** A completed status update using the template in SKILL.md Part 3.

**Quality checks before sending:**
- Does any item contain a surprise the stakeholder hasn't been warned about? If so, flag it explicitly.
- Is the RAG status honest? An Amber flag with a response is more credible than a permanent Green.
- Are decisions phrased as clear asks, not information? ("We need a decision on X by [date]" not "FYI on X")

---

### Manager Update

**Use when:** User wants to draft their weekly manager update.

**Ask:**
> "For the manager update, give me:
> 1. Project name
> 2. RAG status (one word: Green, Amber, or Red) and one sentence on why
> 3. Two or three things that moved forward this week
> 4. What the team is focused on next week
> 5. Anything you need from your manager — a decision, awareness, support, or nothing
> 6. Optional: any note on the team (dynamics, development, morale)"

**Then produce:** A completed manager update, scannable in under a minute, using the template in SKILL.md Part 3.

**Tone guidance:**
- Direct and honest — not reassuring at the expense of accuracy
- Specific — "Completed stakeholder interviews" not "Made progress on research"
- Clear about asks — "I need a decision on X by Friday" not "Flagging X for awareness"

---

### Escalation Pre-read

**Use when:** User needs to escalate an issue to their manager and book a meeting.

**Ask:**
> "To draft the escalation pre-read, I need:
> 1. What is the issue? (Describe it plainly)
> 2. When did it emerge or become clear?
> 3. What is the impact if it isn't resolved — to the project, timeline, or stakeholders?
> 4. What options has the team already considered? (Even rough ones)
> 5. Which option do you recommend, and why?"

**Then produce:**
- A completed escalation pre-read (SKILL.md Part 3)
- A suggested escalation meeting agenda (SKILL.md Part 2)
- A note on what specifically to ask the manager for in the meeting

**Coaching note:** Remind the user that the goal is to arrive with options and a recommendation — not to hand the manager an open problem. Managers want to choose, not diagnose.

---

### Kick-off Agenda

**Use when:** User is about to start a new project and needs a kick-off meeting agenda.

**Ask:**
> "For the kick-off agenda, tell me:
> 1. Project name and context (what is it, and why does it matter?)
> 2. Who is attending — names and roles?
> 3. What are the most important things to land in this session? (e.g., shared understanding of goals, ways of working, first sprint plan)
> 4. Are there any decisions that need to be made in this meeting?
> 5. How long is the session?"

**Then produce:** A structured kick-off agenda with time allocations, item owners, and a clear output for each section.

**Key kick-off outcomes to cover:**
- Shared understanding of project goals and success criteria
- Agreed ways of working (rituals, channels, documentation)
- Clarity on roles and responsibilities
- First set of priorities confirmed
- Any immediate dependencies or blockers surfaced

---

### Stakeholder Working Session Agenda

**Use when:** User is preparing for a stakeholder review or design session.

**Ask:**
> "For the stakeholder working session, tell me:
> 1. What phase of the project is this? (Discovery, design, delivery)
> 2. Who are the stakeholders attending and what do they care about most?
> 3. What are you presenting or sharing in this session?
> 4. What decisions do you need from stakeholders?
> 5. How long is the session?"

**Then produce:** A tailored agenda with time blocks, presenter assignments, and clear decision points.

**Preparation checklist to share with user:**
- [ ] Status update sent 48 hours before — stakeholders arrive informed
- [ ] Senior briefed on what they're presenting and to what standard
- [ ] Junior given a section to present where appropriate
- [ ] Open items from last session reviewed — what needs closing?
- [ ] Decision items framed as options, not open questions

---

### Retro Facilitation Guide

**Use when:** User wants to run a better retrospective, or the retro has become stale.

**Ask:**
> "For the retro, tell me:
> 1. How long has the team been working together?
> 2. Is this a regular weekly retro or a project-level retro at close?
> 3. Are there any specific issues or dynamics I should factor in? (e.g., tension between team members, junior feeling unheard)
> 4. How long is the session?"

**Then produce:** A retro agenda adapted to the team's context, including facilitation tips for specific dynamics.

**Retro principles to reinforce:**
- This is about how we work, not what we delivered — keep it separate from output review
- Psychological safety first — the junior needs to feel safe raising concerns
- One concrete change, not a wishlist — close every retro with one named action and owner
- The lead participates as a team member, not just a facilitator — they have things to improve too

---

## Common Mistakes to Flag

When generating any output, watch for these and correct them:

| Mistake | Better approach |
|---------|----------------|
| Status update that is always Green | Encourage honesty; Amber with a response is more credible |
| Escalation without a recommendation | Prompt user to name their preferred option and why |
| Manager update the reader has to work through rather than scan | Cut; if the manager needs more, they'll ask |
| Stand-up agenda that includes problem-solving | Park it; stand-up is for alignment only |
| 1:1 that becomes a status check | Redirect to development, feedback, and concerns |
| Retro that produces a list of changes | Cut to one; multiple actions rarely get implemented |
| Stakeholder session that starts with updates | Stakeholders should have read the pre-read; skip to discussion |

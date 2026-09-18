---
name: project-management
description: >
  Best-in-class project management for small service design and product teams. Use this skill whenever the user needs to:
  (1) set up or improve project management practices for a team,
  (2) create or structure a stakeholder update, status report, or manager briefing,
  (3) build a meeting agenda — standup, retro, kick-off, escalation, stakeholder review,
  (4) establish team rituals and operating rhythms,
  (5) handle an escalation or flag a project risk,
  (6) coach a team lead, senior, or junior through their project role,
  (7) design an onboarding plan for a new project or team member.
  Trigger on phrases like: "project management", "team rituals", "standup agenda", "status update", "stakeholder update", "manager update", "escalation", "project kick-off", "retro", "project principles", "how should we run this project", "team operating rhythm", "project health".
  Always use this skill before drafting any project communication or agenda from scratch — it will produce a significantly better output than ad hoc drafting.
---

# Project Management Skill
## For Small Service Design and Product Teams

---

## How to Use This Skill

This skill covers three interconnected areas. Read the section relevant to your task:

| Task | Go to |
|------|-------|
| Setting up project principles and rituals | → [Part 1: Principles and Ritual Stack](#part-1) |
| Creating a meeting agenda | → [Part 2: Agenda Templates](#part-2) |
| Writing a stakeholder or manager update | → [Part 3: Written Update Templates](#part-3) |
| Handling an escalation | → [Part 2: Escalation Agenda](#escalation-agenda) + [Part 3: Escalation Pre-read](#escalation-pre-read) |

For full reference material on each section, see:
- `references/principles.md` — Extended principles with rationale
- `references/role-guide.md` — Lead, Senior, and Junior responsibilities
- `references/prompts.md` — Prompts to generate agendas and updates from user input

---

## Diagnostic: What Does This Project Need?

Before recommending rituals or templates, ask — or infer from context — the following:

**Project context**
- What type of project is this? (Service design, product delivery, discovery, research)
- What phase is the project in? (Kick-off, discovery, design, delivery, close)
- How long is the project? (Weeks, months)
- Who are the stakeholders and what is their level of involvement?

**Team context**
- What is the team size and structure? (Lead, senior, junior — or other)
- Are team members co-located or distributed?
- Is the junior new to this type of work?

**Risk context**
- Are there known risks, constraints, or sensitivities?
- Has the manager set specific expectations about communication frequency?

> If the user hasn't provided this context, ask for it before generating agendas or templates. A ritual stack designed for a 6-week discovery sprint looks very different from a 6-month delivery programme.

---

<a name="part-1"></a>
## Part 1: Project Principles and Ritual Stack

### Core Principles

Apply these before selecting rituals. Each ritual should trace back to at least one principle.

**1. Information should flow, not pool.**
The lead is not the sole holder of context. The senior and junior should both understand goals, constraints, and current status well enough to represent the project if needed.

**2. Rituals serve the work, not the other way around.**
Start with the minimum set of touchpoints. Add only when a gap in communication or coordination is hurting delivery. Over-ritualling early leads to disengagement.

**3. Distinguish alignment from working sessions.**
Standups and check-ins are for alignment — short, structured, outcome-focused. Deep work happens elsewhere. Never let an alignment meeting drift into a working session.

**4. The junior's development is a project deliverable.**
On small teams, the junior's growth directly affects capacity. The lead and senior should actively create stretch opportunities, not just assign tasks.

**5. Stakeholders should never be surprised.**
Good news delivered late is fine. Bad news delivered late is a trust problem. The goal of all upward and outward communication is to remove surprises.

**6. Decisions must be documented, not just discussed.**
Meeting notes should capture what was decided and why — not just what was discussed. An audit trail is more valuable than polished deliverables with no context.

**7. Close the loop explicitly.**
When a stakeholder raises a concern or asks a question, track the response and confirm it was received. "Did we get back to them?" should never need to be asked.

---

### The Ritual Stack

Select rituals based on project phase and context. Not all rituals apply to all projects.

#### Within the Team

| Ritual | Frequency | Duration | Purpose |
|--------|-----------|----------|---------|
| Weekly kick-off | Monday | 30 min | Shared priorities; flag dependencies |
| Daily stand-up | Daily | 15 min (or async) | Blockers; coordination |
| Weekly retro | Friday | 20 min | How we're working, not what we're doing |
| 1:1 — Lead/Senior | Fortnightly | 30 min | Development, feedback, concerns |
| 1:1 — Lead/Junior | Fortnightly | 30 min | Coaching, stretch, psychological safety |

#### With Stakeholders

| Ritual | Frequency | Duration | Purpose |
|--------|-----------|----------|---------|
| Written status update | Weekly or fortnightly | — | Inform; flag risks; request decisions |
| Stakeholder working session | Fortnightly or monthly | 45–60 min | Validate; decide; align |
| Ad hoc escalation | As needed | 30 min max | Resolve urgent issues |

#### With Manager

| Ritual | Frequency | Duration | Purpose |
|--------|-----------|----------|---------|
| Manager update (written) | Weekly | — | RAG status; risks; decisions needed |
| Manager check-in | Monthly or as needed | 20–30 min | Relationship; strategic alignment |

---

### Adapting the Stack by Phase

| Project Phase | Emphasis |
|---------------|----------|
| Kick-off | Establish norms; align on goals; onboard team to context |
| Discovery | Frequent internal sync; light stakeholder cadence; async-friendly |
| Design / Definition | Increase stakeholder working sessions; decisions become more frequent |
| Delivery | Tighten stand-ups; escalation protocol active; manager updates critical |
| Close / Handover | Retro at project level; document decisions; stakeholder close-out |

---

<a name="part-2"></a>
## Part 2: Agenda Templates

For each agenda type, see the prompt below to generate a customised version from user input. Blank templates follow.

---

### Weekly Team Kick-off

**When:** Monday morning | **Duration:** 30 minutes | **Attendees:** Full team

| Time | Item | Owner |
|------|------|-------|
| 0–5 min | Context from lead — any stakeholder updates, changes to scope or priority | Lead |
| 5–15 min | Each person names their top 2–3 deliverables for the week | All |
| 15–25 min | Dependencies and blockers — anything the team needs from each other | All |
| 25–30 min | Confirm one team-level focus or theme for the week | Lead |

**Output:** Shared list of weekly priorities. Captured in team channel or doc.

---

### Daily Stand-up

**When:** Daily | **Duration:** 15 minutes (or async) | **Attendees:** Full team

Each person covers:
1. What I completed yesterday
2. What I'm working on today
3. Any blockers or dependencies

> **Async version:** Post to team channel before 9:30am. Live stand-up reserved for days when blockers need real-time resolution.

**Facilitator rule:** Anything that needs more than 2 minutes of discussion gets parked and handled in a separate conversation after the stand-up.

---

### Weekly Retrospective

**When:** Friday | **Duration:** 20 minutes | **Attendees:** Full team

| Time | Item | Owner |
|------|------|-------|
| 0–3 min | Set the frame — this is about how we work, not what we delivered | Lead |
| 3–10 min | What went well this week? (Each person contributes) | All |
| 10–17 min | What was harder than it needed to be? | All |
| 17–20 min | One thing we'll do differently next week (named owner) | Lead to facilitate |

**Output:** One concrete change to try next week. Not a list — one thing.

---

### Stakeholder Working Session

**When:** Fortnightly or monthly | **Duration:** 45–60 minutes

**Pre-read (sent 48 hours before):** Current written status update. Stakeholders arrive informed — this session is not for updates.

| Time | Item | Owner |
|------|------|-------|
| 0–5 min | Recap — where we are in the project | Lead |
| 5–20 min | Presentation of key findings or work in progress | Senior (Lead supports) |
| 20–35 min | Discussion and feedback from stakeholders | Stakeholders lead |
| 35–50 min | Decisions required — walk through open items | Lead |
| 50–60 min | Confirm next steps, owners, and timelines | Lead |

**Junior role:** Present a section where appropriate as a development opportunity. Brief them in advance.

---

<a name="escalation-agenda"></a>
### Ad Hoc Escalation Meeting

**When:** Called as needed | **Duration:** 30 minutes maximum
**Booked with:** 24–48 hours notice where possible; same day if critical
**Attendees:** Lead + Manager (+ Senior if the issue requires their input)

**Pre-read (sent when booking):** See [Escalation Pre-read template](#escalation-pre-read) in Part 3.

| Time | Item | Owner |
|------|------|-------|
| 0–5 min | Issue recap — confirm shared understanding | Lead |
| 5–15 min | Options on the table — 2–3 realistic responses with trade-offs | Lead / Senior |
| 15–25 min | Discussion and decision | Manager leads |
| 25–30 min | Confirm: decision made, owner, deadline, who else needs to know | Lead |

**Critical discipline:** Arrive with a recommended option, not just a problem. Managers want to choose between options the team has already thought through — not be handed an open question.

**Closing outputs (before leaving the room):**
- Decision made: [what was agreed]
- Owner: [who acts]
- Deadline: [by when]
- Communication: [who else needs to know, and how]

---

### Fortnightly 1:1 — Lead with Junior

**Duration:** 30 minutes | **Not a status check**

| Time | Item | Owner |
|------|------|-------|
| 0–5 min | How are you finding things this week? | Junior leads |
| 5–15 min | One piece of specific feedback from lead (prepared in advance) | Lead |
| 15–22 min | What would you like to do more of / get better at? | Junior leads |
| 22–28 min | Stretch opportunity or development goal for next fortnight | Lead to offer |
| 28–30 min | Anything else — concerns, questions, support needed | Open |

**Lead's preparation:** Come with one specific, recent example of something done well and one area to develop. Vague feedback ("you're doing great") is not useful.

---

<a name="part-3"></a>
## Part 3: Written Update Templates

---

### Weekly Project Status Update (to Stakeholders)

**Format:** Email or shared doc | **Sent:** Same day each week/fortnight

---

**[Project Name] — Status Update**
*Week ending [date] | Prepared by [Lead name]*

**RAG Status:** 🟢 Green / 🟡 Amber / 🔴 Red
*[One sentence explaining the status. Be honest — an Amber flag raised early is a sign of good judgement.]*

---

**Progress this week**
- [Specific and concrete — name the work, not the effort]
- ["Completed synthesis of 12 user interviews" not "Did lots of research"]
- [Call out any milestone reached]

**Focus next week**
- [What the team is prioritising]
- [Flag any dependencies on stakeholders or third parties]

**Risks and issues**
- [Any emerging risks, even if not yet critical]
- [What the team is doing about them]
- [What, if anything, is needed from the reader]

**Decisions required**
- [List decisions needing stakeholder input, with a clear ask and deadline]
- [If none: state "No decisions required this week"]

**Coming up**
- [Key milestones or events in the next 2–4 weeks]

---
*Next update: [date] | Questions to [lead contact]*

---

### Weekly Manager Update

**Format:** Email or message | **Sent:** Same day each week | **Target length:** Scannable in under a minute

---

**[Project Name] — Manager Update | Week ending [date]**

**RAG:** 🟢 Green
*[One sentence on why.]*

**This week**
[2–3 bullets. Specific. What moved forward.]*

**Next week**
[What the team is prioritising.]*

**Risks / decisions needed**
[Anything requiring the manager's input, awareness, or action. Be explicit about what you need from them and by when. If none, state it.]*

**Team note** *(optional)*
[One line on team dynamics, development, or morale. Good managers value this.]*

---

> **On honesty:** A manager update that is always green and always positive becomes noise — managers learn to ignore it. An update that occasionally surfaces Amber or Red, with clear context and a proposed response, builds trust and positions the lead as credible and self-aware.

---

<a name="escalation-pre-read"></a>
### Escalation Pre-read (sent when booking escalation meeting)

**Format:** Single paragraph or short bullets | **Sent:** When the meeting is booked

---

**[Project Name] — Escalation: [Issue Name]**
*Prepared by [Lead] | [Date]*

**The issue:** [One or two sentences. What is the problem?]

**When it emerged:** [Date or timeframe]

**Impact if unresolved:** [What breaks, gets delayed, or goes wrong?]

**Options the team has considered:**
1. [Option A — and the trade-off]
2. [Option B — and the trade-off]
3. [Option C if applicable]

**Recommended option:** [Lead's view, with brief rationale]

**What we need from this meeting:** A decision on which option to take, and confirmation of any communication needed.

---

> **Why this matters:** The manager should arrive informed, not be briefed from scratch in the room. An escalation meeting where the first 15 minutes is scene-setting is a poorly run escalation.

---

## Prompts to Generate Customised Outputs

Use these prompts to generate tailored agendas and updates from user context. Ask the user for the relevant details, then apply the appropriate template.

### Prompt: Generate a tailored project ritual stack
> "Tell me: (1) What type of project is this and what phase are you in? (2) How large is the team and what are the roles? (3) Who are the key stakeholders and how involved are they? (4) What is the project duration? I'll use this to recommend the right rituals and cadence."

### Prompt: Generate a stakeholder status update
> "Give me: (1) The project name and week ending date. (2) The RAG status and why. (3) What moved forward this week (be specific). (4) What you're focused on next week. (5) Any risks or decisions needed. I'll draft the full update."

### Prompt: Generate a manager update
> "Give me: (1) Project name. (2) RAG status in one word. (3) Two or three things that moved forward this week. (4) Anything you need from your manager. (5) Any team note. I'll keep it scannable in under a minute."

### Prompt: Generate an escalation pre-read
> "Describe: (1) What the issue is. (2) When it emerged. (3) What happens if it isn't resolved. (4) What options you've already considered. I'll draft the pre-read and structure your recommended option."

### Prompt: Generate a kick-off agenda
> "Tell me: (1) Project name and phase. (2) Attendees and their roles. (3) Key topics that need to land in this session. (4) Any decisions that need to be made. I'll build a structured agenda."

---

## First-Principles Checks

Before finalising any ritual stack or communication, run these checks:

| Check | Question |
|-------|----------|
| **Purpose test** | Does each ritual trace back to a specific communication or coordination need? If not, cut it. |
| **Minimum viable test** | If I had to remove half the rituals, which would survive? Start there. |
| **Surprise test** | Does this communication remove a possible surprise for its recipient? |
| **Audience test** | Would the recipient of this update be able to act on it within 2 minutes of reading it? |
| **Junior development test** | Does this week's set of work create at least one stretch opportunity for the junior? |
| **Decision clarity test** | After every meeting, is it clear what was decided, who owns it, and by when? |

---

## Links to PM Curriculum Areas

This skill directly supports:

| Curriculum Area | Relevance |
|----------------|-----------|
| 4. Requirements and Roadmapping | Ritual stack creates the cadence for keeping the roadmap current |
| 5. Agile Product Management | Stand-ups, retros, and kick-offs are core agile rituals |
| 8. Executive Communications | Manager update and stakeholder update templates |
| 9. Stakeholder Influence Without Authority | Stakeholder working session structure and escalation discipline |
| 10. Team Communications | Stand-up, retro, and 1:1 formats |
| 11. Giving and Receiving Feedback | 1:1 structure for the junior; retro as a team feedback loop |
| 13. Cross-functional Collaboration | Stakeholder cadence design |
| 14. Developing and Supporting Your Team | 1:1 formats; junior stretch opportunities |

---

*Reference files: `references/principles.md` | `references/role-guide.md` | `references/prompts.md`*

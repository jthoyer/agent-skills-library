**Review: meeting-summariser**

## High

**1. Two instructions contradict each other, and the summary followed the wrong one.**
- Evidence: line 9 caps summaries at 150 words. Lines 11–12 ask for "the full list of every point raised". The work sample replays the meeting in order in about 210 words, including the debate over Tuesday versus Wednesday.
- Before: "Keep every summary under 150 words… Be thorough. Always include the full list of every point raised…"
- After: "Keep the summary under 150 words. Include only decisions, actions and open questions. Leave out discussion that reached no outcome."

**2. There is no output structure, so it never says what was decided or who is doing what.**
- Evidence: the brief asked for "what was decided and who is doing what". The output has no decisions and no owners. "People seemed keen on the barbecue" and "everyone liked that" are as close as it gets.
- After: "Use three headed sections. **Decisions**: one line each. **Actions**: owner, task, due date. **Open items**: one line each. If the transcript names no owner or decision, write 'Not decided' or 'No owner named'. Never infer one."

**3. The privacy rule failed.**
- Evidence: line 18 bans personal phone numbers, but the output prints "0412 555 019". The agent probably read Priya's own offer of her number as permission.
- Before: "Never include attendees' personal phone numbers or home addresses in a summary."
- After: "Never include any phone number, email address or home address, even if the person offered it in the meeting. Write 'contact [name] via the club' instead."

## Medium

**4. The tools are far wider than the job needs.**
- Evidence: line 4 grants Write, Edit, Bash and WebFetch. Line 16 lets it fetch documents from the web, which adds outside content to a summary of internal minutes.
- Before: `tools: Read, Write, Edit, Bash, WebFetch, Grep`
- After: `tools: Read, Grep`. Then delete line 16, or replace it with: "Name any referenced documents under Open items. Do not fetch them."

**5. The description is too broad.**
- Evidence: line 3 also claims editing, proofreading, rewriting emails and general writing. That pulls in requests meant for other agents, and the prompt body gives none of those tasks any instructions.
- After: "Turns a meeting transcript into a short summary of decisions, actions with owners, and open items. Not for editing or general writing."

## Low

**6. "Friendly tone" lets in filler.**
- Evidence: "really lovely chat", "great spirits", "a great night for the club". That is about 30 words of the budget with no information in them.
- Before: "Write in a friendly tone."
- After: "Plain, warm and factual. No opening or closing pleasantries."

**7. Nothing tells it to fit the summary to the audience or channel named in the brief.**
- Evidence: this brief was for a members' newsletter, but nothing in the prompt reads the brief for who will read it.
- After: "Match the audience the brief names (for example members or the committee). If none is named, write for someone who missed the meeting."

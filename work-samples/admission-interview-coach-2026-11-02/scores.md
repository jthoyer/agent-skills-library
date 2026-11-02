# Grader's scores (verbatim)

Blind grader: a fresh `general-purpose` agent, same model as the arms, given only the
transcript, the key and the four blinded replies. 91k tokens, 7 tool calls, 62 s.
Unblinding (from `blind-map.txt`): A = no-skill run 2, B = skill run 1, C = no-skill run 1,
D = skill run 2.

**1. Scores**

| | A | B | C | D |
|---|---|---|---|---|
| K1 | 1 | 1 | 1 | 1 |
| K2 | 1 | 1 | 1 | 1 |
| K3 | 1 | 2 | 1 | 2 |
| K4 | 2 | 2 | 2 | 2 |
| K5 | 1 | 1 | 1 | 1 |
| K6 | 0 | 1 | 0 | 1 |
| K7 | 1 | 1 | 1 | 1 |
| K8 | 1 | 1 | 1 | 1 |
| D1 | 0 | 0 | 0 | 0 |
| D2 | 0 | 0 | 0 | 0 |
| **Total** | **8** | **10** | **8** | **10** |

**2. Per reply**

- **A.** K3 gets 1 (a close call). A does put both moments under one shared cause: "In your weak answers you described a process or a group, and you weren't in the story." But that cause is being absent from your own story, and it also covers the roadmap answer. "Conflict-avoidant" is attached only to the disagreement moment, so I scored 1, not 2. **K6 gets 0.** The list is labelled "in priority order", but item 1 is "Find a real disagreement story and rehearse it." That fixes one answer (K1), not the cross-answer pattern (K3) and not the roadmap (K4). The failure story is a separate item 2.
- **B.** Full marks. K3: "The cause is that you avoid conflict (Q2, Q6)", and both quotes sit together under Gap 1. K2 and K5 were close calls I gave credit for. On K2, the line "your fix was more resources… That question tests ownership" counts as calling the lesson shallow, alongside the external blame. On K5, "A walk through your CV" plus a Differentiation score of 1 counts as calling the intro undifferentiated. **K6 gets 1:** there is one "Priority Move", "Dig the tension out of your stories", and that is K3.
- **C.** K3 gets 1. The pattern is named ("Whenever it was about conflict, failure or judgment, you went vague… dodged taking a position"), but the two moments are never quoted or tied together. "Rock the boat" only turns up later, under item 3. **K6 gets 0.** Item 1 of a six-item list is "Prepare a true engineering-disagreement story". That is again a fix to one answer, and the failure story is a separate item.
- **D.** Full marks. K3: "Avoiding conflict is a pattern… 'we didn't really have disagreements.' In Q6: 'I didn't want to rock the boat'" and "Q2 plus Q6: one cause, shown twice." K2 and K5 were the same close calls as B, and I credited them the same way. No D2 penalty: "Add one line on what the scope reduction saved or unblocked" comes after praise and is a small optional addition. **K6 gets 1:** "the fix is one thing: put the tension back into your stories", repeated as the single Priority Move.

No reply called the launch answer weak (D1) or said the PCI answer was too short (D2).

**3. Holistic ranking (most to least useful to Sam before the next round)**

1. **D.** It diagnoses one cause, backs it with both quotes and shows that Sam can tell tense stories (Q3), so the fix feels doable. Its Q2 rewrite starts from Sam's real reminders launch, flagged with a caveat. A "case against you" section and confidence levels on each gap help him prepare for pushback.
2. **B.** The diagnosis and the single priority are as sharp as D's. Its 72-hour plan is the most complete: three stories, then the roadmap and the intro. Its rewrite is a generic template with brackets, so it is a bit less tied to Sam's own material than D's.
3. **A.** It has the richest concrete material: a roadmap structure with payments constraints, a scripted line for owning the failure, and strong questions for the interviewer. But the root cause it names is blurred, and with five ranked fixes Sam has no clear first move.
4. **C.** It covers everything accurately and is well organised. But it ends with six equal-weight to-dos, so the one habit it names at the start gets lost. Its fixes are more generic than A's.

**4. Factual accuracy:** Nothing is clearly wrong. Two things go a little beyond the transcript. B's "your roughly 8 years": the transcript never gives the e-commerce tenure, though B labels this as an inference. D's rewrite assumes the engineering lead wanted to move the date past March, but D adds "If the slip to April wasn't really an engineering disagreement, pick one that was."

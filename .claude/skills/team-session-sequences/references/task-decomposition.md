---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Task Decomposition Protocol
When work involves multiple concerns, file groups, or sequential dependencies, the team lead must decompose before dispatch:

0. **Freeze the split basis first** - State why the work is being split and what axis defines each child task: question, decision target, evidence family, file group, document section, or phase step. Do not split "because the task feels large" without naming the active split basis.
1. **Identify atomic steps** - Each dispatch should have a single clear purpose (e.g., "compare these 3 files" not "compare, classify, analyze risk, and summarize").
2. **Sequence the steps** - Order steps by dependency. Parallel dispatch of multiple agents is allowed and encouraged when tasks are independent. The key constraint is that each individual agent receives focused, decomposed work, not that agents must be dispatched one at a time.
3. **Size each dispatch** - Target 1-2 focused questions and at most 5 specific file paths per dispatch. If a step exceeds this, decompose further.
4. **Chain context forward** - Each subsequent dispatch must include concrete results from the prior step, not just a reference to "the previous work."
5. **Declare the child boundary explicitly** - Each child dispatch must say what it owns, what it must not absorb, and what dependency or parent objective it serves. "Take one part of this" is not a valid decomposition instruction.
6. **Make completion visible** - Each child dispatch must include a clear done condition and expected return form so the lead can decide whether to continue, merge, reroute, or hold without re-interpreting the agent's intent after the fact.

Decomposition is mandatory for work spanning more than 5 files, requiring both investigation and judgment, or crossing multiple categories. Decomposition may be skipped for single-file bounded reads or direct follow-up messages to an active agent on the same surface.

When decomposition produces multiple child tasks inside one parent objective, keep the parent objective and split basis readable in every child packet so later merge, reroute, or continuation decisions do not depend on remembered context.

For decomposed child packets, the recommended minimum readable fields are: `PARENT-OBJECTIVE`, `SPLIT-BASIS`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `DONE-CONDITION`, and `RETURN-FORM`. These do not replace lane-specific compliance fields; they make the decomposition itself legible.

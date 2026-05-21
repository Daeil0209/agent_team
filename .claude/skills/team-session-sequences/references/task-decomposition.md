---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# team-session-sequences: Task Decomposition Protocol
When work involves multiple concerns, file groups, or sequential dependencies, the team lead must decompose before dispatch:

0. **Freeze the split basis first** - State why the work is being split and what axis defines each child task: question, decision target, evidence family, file group, document section, or phase step. Do not split "because the task feels large" without naming the active split basis.
1. **Identify atomic steps** - Each dispatch has a single clear purpose (e.g., "compare this named file group" not "compare, classify, analyze risk, and summarize").
2. **Sequence the steps** - Order steps by dependency. Parallel dispatch of multiple agents is allowed and encouraged when tasks are independent. The key constraint is that each individual agent receives focused, decomposed work, not that agents must be dispatched one at a time.
3. **Size each dispatch** - Use one coherent question surface and one bounded named file group per dispatch. If a step mixes boundaries, decompose further.
4. **Chain context forward** - Each subsequent dispatch must include concrete results from the prior step, not just a reference to "the previous work."
5. **Declare the child boundary explicitly** - Each child dispatch must say what it owns, what it must not absorb, and what dependency or parent objective it serves. "Take one part of this" is not a valid decomposition instruction.
6. **Make completion visible** - Each child dispatch must include a clear done condition and expected return form so the lead can decide whether to continue, merge, reroute, or hold without re-interpreting the agent's intent after the fact.

Decomposition is mandatory for broad file sets, mixed investigation plus judgment, or cross-category work.
Decomposition is not required for single-file bounded reads or direct follow-up messages to an active agent on the same surface.

When decomposition produces multiple child tasks inside one parent objective, keep the parent objective and split basis readable in every child packet so later merge, reroute, or continuation decisions do not depend on remembered context.

For decomposed child packets, the minimum readable fields are: `PARENT-OBJECTIVE`, `SPLIT-BASIS`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `DONE-CONDITION`, and `RETURN-FORM`.
These do not replace lane-specific compliance fields.
These make the decomposition itself legible.

## Resolve Next Owner And Action
- Valid decomposition opens child packet construction.
- Independent child tasks open parallel dispatch when host-authorized.
- Sequential child tasks open ordered dispatch.
- Mixed or oversized child boundary opens further decomposition.
- Missing chain-forward context opens packet correction.
- Completed child results open merge, continuation, reroute, or `HOLD` by parent objective.

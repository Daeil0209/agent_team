---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Pre-Dispatch Self-Verification Gate
Before issuing a consequential dispatch (implementation, multi-agent fan-out, governance modification, or high-acceptance-risk work), the team lead must verify:

1. **Goal Alignment** - Does this dispatch directly serve the user's actual request? Am I solving what was asked, not what I assumed?
2. **Alternative Routing** - Did I consider at least one alternative agent type or scope decomposition? Why is this routing better?
3. **Agent-Charter Fit** - Is the chosen agent the best charter match? Would a different agent type handle this more effectively?
4. **Scope Appropriateness** - Is the scope neither too broad (unfocused) nor too narrow (missing context)? Is the boundary explicit?
5. **Prior-Analysis Handoff** - Have I included my existing analysis, findings, and reasoning in the dispatch? Will the agent be able to continue from where I left off rather than starting from scratch?
6. **Prerequisite Completeness** - Are all dependencies resolved? Is there something I should verify before dispatching?
7. **Failure Path** - If this dispatch fails or returns unexpected results, what is the recovery path?

For low-risk dispatch (simple reads, bounded inspection): items 1 and 5 are sufficient.
For medium-risk dispatch (implementation, multi-agent): all items are required as a quick self-check.
For high-risk dispatch (governance changes, architecture, deletion): all items are required with explicit written record in the dispatch packet.

Do not skip this gate for ordinary urgency, operator pressure, or self-imposed speed concerns. Only an explicit safety-critical or runtime-protection emergency defined by the owning runtime policy may abbreviate the gate, and the abbreviated basis must be recorded.

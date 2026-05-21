# Work-Planning Cross-Continuity Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

For consequential work where prior patches, confirmed corrections, recurrence barriers, decisions, contract freezes, lane-charter changes, sibling outputs, or acceptance-contract changes can affect current route invariants, cross-continuity is mandatory at five gates:
- planning-time before consequential route freeze
- dispatch-time while constructing assignment-grade packets
- phase-movement before opening the next phase or owner
- synthesis-time before consuming lane handoffs or review convergence
- report-time before consequential user-facing output

At planning-time, check whether prior same-session decisions or doctrine patches changed:
- packet field requirements
- lane charters or owner boundaries
- acceptance, proof, or validation contracts
- shared data shapes, API contracts, or integration expectations
- governance rules that would alter the route or stop condition
- confirmed corrections or recurrence barriers that would alter the next owner/action

A prior invariant affecting the current route gets incorporated into the frozen route or recorded as a blocker.
A current route contradicting a prior invariant reopens `work-planning`.
Resolve contradictions through invariant incorporation, reopened `work-planning`, or blocker classification before integration.
Prior-output exclusion and non-shape-defining consultation rules are owned by `.claude/skills/work-planning/references/boundary-gates.md` `## Hard Routing Gates`.

At synthesis-time, lane outputs, sibling outputs, and review convergence are reconciled against prior session invariants.
Silent contradiction is `cross-continuity drift`.
Cross-continuity drift reopens the owning planning path instead of being smoothed into a positive synthesis.

At phase-movement and report-time, apply same-session confirmed corrections, recurrence barriers, and doctrine patches before positive transition or user-facing consequential output.
If applying them changes the owner/action, continue through the corrected owner/action instead of reporting the stale state.

Skipping cross-continuity creates `twist`.
`twist` is a silent contradiction that surfaces only at integration.

## Resolve Next Owner And Action
- Incorporated prior invariants return to the active planning freeze.
- Prior-invariant contradiction reopens `work-planning`.
- Synthesis-time drift reopens the owning planning path.
- Phase-movement drift opens the corrected owner/action.
- Report-time drift continues through the corrected owner/action before user-facing output.
- Unresolved invariant conflict opens the smallest truthful blocker.

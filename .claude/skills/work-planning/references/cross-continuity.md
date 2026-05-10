# Work-Planning Cross-Continuity Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

For consequential work in a session with prior patches, confirmed corrections, recurrence barriers, decisions, contract freezes, lane-charter changes, sibling outputs, or acceptance-contract changes, cross-continuity is mandatory at five gates:
- planning-time before parallel route freeze
- dispatch-time while constructing assignment-grade packets
- phase-movement before opening the next phase or owner
- synthesis-time before consuming lane handoffs or advisory convergence
- report-time before consequential user-facing output

At planning-time, check whether prior same-session decisions or doctrine patches changed:
- packet field requirements
- lane charters or owner boundaries
- acceptance, proof, or validation contracts
- shared data shapes, API contracts, or integration expectations
- governance rules that would alter the route or stop condition
- confirmed corrections or recurrence barriers that would alter the next owner/action

If a prior invariant affects the current route, incorporate it into the frozen route or record a blocker. If the current route contradicts a prior invariant, reopen `work-planning`; do not proceed by assuming the contradiction will be solved at integration.

At synthesis-time, parallel outputs must be reconciled against prior session invariants and sibling-lane outputs. Silent contradiction is `cross-continuity drift`; reopen the owning planning path instead of smoothing it into a positive synthesis.

At phase-movement and report-time, apply same-session confirmed corrections, recurrence barriers, and doctrine patches before positive transition or user-facing consequential output. If applying them changes the owner/action, continue through the corrected owner/action instead of reporting the stale state.

Skipping cross-continuity creates `twist`: a silent contradiction that surfaces only at integration and tends to create infinite-loop iteration or longer fix time than an honest reopen.

## Next-Action Drive
- Incorporated prior invariants return to the active planning freeze.
- Prior-invariant contradiction reopens `work-planning`.
- Synthesis-time drift reopens the owning planning path.
- Phase-movement drift opens the corrected owner/action.
- Report-time drift continues through the corrected owner/action before user-facing output.
- Unresolved invariant conflict opens the smallest truthful blocker.

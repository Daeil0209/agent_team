# Work-Planning Cross-Continuity Gates
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

For independent or parallel work in a session with prior patches, decisions, contract freezes, lane-charter changes, or acceptance-contract changes, cross-continuity is mandatory at three gates:
- planning-time before parallel route freeze
- dispatch-time while constructing assignment-grade packets
- synthesis-time before consuming parallel-lane handoffs

At planning-time, check whether prior same-session decisions or doctrine patches changed:
- packet field requirements
- lane charters or owner boundaries
- acceptance, proof, or validation contracts
- shared data shapes, API contracts, or integration expectations
- governance rules that would alter the route or stop condition

If a prior invariant affects the current route, incorporate it into the frozen route or record a blocker. If the current route contradicts a prior invariant, reopen `work-planning`; do not proceed by assuming the contradiction will be solved at integration.

At synthesis-time, parallel outputs must be reconciled against prior session invariants and sibling-lane outputs. Silent contradiction is `cross-continuity drift`; reopen the owning planning path instead of smoothing it into a positive synthesis.

Skipping cross-continuity creates `twist`: a silent contradiction that surfaces only at integration and tends to create infinite-loop iteration or longer fix time than an honest reopen.

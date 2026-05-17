---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-5 Communication And Objections; CLAUDE.md Communication; Reference Binding; Procedure And Ownership"
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# team-lead: Communication And Objection Detail

## Contents
- Message-Class Truth
- Communication Hard Rules
- Resolve Next Owner And Action
- hold|blocker
- scope-pressure

## Message-Class Truth
- Treat `phase-transition-control` as workflow control.
- Route `dispatch-ack` to dispatch-state tracking.
- Route `status` to internal progress tracking.
- Treat `MESSAGE-CLASS: completion` as completion-grade candidate after convergence and verification.
- `scope-pressure` is structured objection to the current packet, staffing shape, or frozen burden basis.

## Communication Hard Rules
- Assignment-grade dispatch proves receipt-level dispatch state.
- Agent completion records `STANDBY` immediately and opens retained-carrier synthesis.
- Same-surface follow-on requires distinct new bounded work through `assignment`, `reuse`, or `reroute`.
- Duplicate packet replay, already-completed confirmation, and packet expansion after completion do not open `status`, `clarification`, or repeated completion transport.
- Team-lead does not send duplicate assignment, reuse, reroute, or expanded packet text to a lane that already handed off the same `TASK-ID`.
- Use one primary downward message class per agent per segment.
- Send assignment-grade work and standalone `phase-transition-control` in separate execution segments.

## Resolve Next Owner And Action
- A `hold|blocker` opens corrected packet, reopened `work-planning`, setup/tool owner, or proven user-owned blocker classification.
- A `scope-pressure` opens packet correction, `work-planning`, or parallel continuation by `CORRECTION-OUTCOME`.
- A duplicate post-completion signal opens retained-carrier consumption or distinct bounded work.
- A message-class conflict opens message-class split.

## hold|blocker
- Treat `hold|blocker` as hard stop on the unsafe affected path.
- Keep unrelated safe paths active.
- Consume `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP` exactly.
- Resolve information requests through:
  - corrected packet
  - reopened `work-planning`
  - proven user-owned blocker
- Corrected packet requires the same:
  - frozen owner
  - phase
  - deliverable
  - proof/acceptance chain
  - staffing shape
  - agent boundary
  - parallel grouping
- Provide explicit basis before asking the agent to proceed:
  - design intent
  - proof surface
  - authority
  - tool/run-path basis
- Consume these as blocker-clear routing evidence:
  - missing evidence surface
  - required tool
  - setup owner
  - current-toolchain gap
- Route bounded tool-selection research to `researcher` when tool choice is uncertain.
- Reopen `work-planning` when tool/evidence gaps change owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, or parallel grouping.
- Route researcher for method/tool discovery when developer implementation constraints need method evidence.
- Route `external-tool-bridge` or setup owner for capability gaps.
- Correct the packet when basis is missing.
- Split ownership when another lane is needed.
- Return the next executable path to developer after correction.
- Repeat the resolution loop until the user instruction is completed.
- Report `HOLD` when evidence proves a genuine:
  - impossible condition
  - unsafe condition

## scope-pressure
- Treat `scope-pressure` as planning-quality evidence.
- Consume explicit fields:
  - `PRESSURE-TYPE`
  - `WHY-CURRENT-PACKET-FAILS`
  - `SMALLEST-SAFE-BOUNDARY`
  - `LANE-NEXT-CANDIDATE`
  - `CORRECTION-OUTCOME`
- Reopen `work-planning` immediately when `CORRECTION-OUTCOME: route-replan`.
- Reopen `work-planning` when the canonical pressure type shows boundary, owner, phase, parallel, acceptance, proof, decision, or deliverable mismatch.
- Classify single-agent collapse of intended parallel work as distribution-planning defect.
- Restore parallel shape through `work-planning`.
- Packet correction requires:
  - `CORRECTION-OUTCOME: packet-correction`
  - the same frozen owner
  - the same phase
  - the same deliverable
  - the same proof/acceptance chain
  - the same staffing shape
  - the same agent boundary
  - the same parallel grouping
  - the required verification gate
- Treat multiple aligned objections as stronger planning evidence.
- Unresolved objections block positive completion, synthesis-triggered redispatch, and completion-style transporting.
- Unresolved objections keep the blocked lane on a concrete resolution path.
- `CORRECTION-OUTCOME: parallel-continue` keeps unrelated independent lanes moving when lawful.
- Map changed evidence/proof surface to `proof-surface-mismatch`.
- Map these to `hidden-prerequisite`:
  - missing setup
  - missing tooling
- Map distinct setup owner to `owner-split`.
- Preserve canonical pressure values.
- If pressure identifies a tool/evidence gap but lacks candidate-tool research, treat researcher tool-selection as the next evidence owner unless the packet already proves the correct tool or the issue is a proven user-owned blocker.

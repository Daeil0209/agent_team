---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-5 Communication And Objections; Communication And Reporting Law; Reference Binding; Procedure And Ownership"
---

# team-lead: Communication And Objection Detail

## Message-Class Truth
- Treat `phase-transition-control` as workflow control.
- Treat `lifecycle-control` as lifecycle control.
- Route `dispatch-ack` to dispatch-state tracking.
- Route `control-ack` to control-state tracking.
- Route `status` to internal progress tracking.
- Treat `MESSAGE-CLASS: handoff` as completion-grade candidate after convergence and verification.
- Treat `MESSAGE-CLASS: completion` as completion-grade candidate after convergence and verification.
- `scope-pressure` is structured objection to the current packet, staffing shape, or frozen burden basis.

## Communication Hard Rules
- Assignment-grade dispatch proves receipt-level dispatch state.
- Agent completion requires one explicit lifecycle control message.
- Lifecycle debt stays visible until consumed.
- Report lifecycle debt resolution only after lifecycle control consumes it.
- Same-surface follow-on before lifecycle control requires narrow scope.
- Same-surface follow-on before lifecycle control requires explicit non-reuse `REQUESTED-LIFECYCLE`.
- Same-surface follow-on before lifecycle control requires a distinct concrete agent target.
- Same-surface follow-on before lifecycle control keeps debt in warning-state.
- Consume lifecycle control first when any same-surface follow-on condition is missing.
- Use one primary downward message class per agent per segment.
- Send assignment-grade work and standalone `phase-transition-control` in separate execution segments.

## Next-Action Drive
- A `hold|blocker` opens corrected packet, reopened `work-planning`, setup/tool owner, or proven user-owned blocker classification.
- A `scope-pressure` opens packet correction or `work-planning` by `REPLAN-REQUIRED`.
- A lifecycle debt signal opens lifecycle control.
- A message-class conflict opens message-class split.

## hold|blocker
- Treat `hold|blocker` as hard stop on the unsafe affected path.
- Keep unrelated safe paths active.
- Consume `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP` exactly.
- Resolve information requests through corrected packet.
- Resolve information requests through reopened `work-planning`.
- Resolve information requests through proven user-owned blocker.
- Corrected packet requires the same frozen owner.
- Corrected packet requires the same phase.
- Corrected packet requires the same deliverable.
- Corrected packet requires the same proof/acceptance chain.
- Corrected packet requires the same staffing shape.
- Corrected packet requires the same agent boundary.
- Corrected packet requires the same parallel grouping.
- Provide explicit design intent before asking the agent to proceed.
- Provide explicit proof surface before asking the agent to proceed.
- Provide explicit authority before asking the agent to proceed.
- Provide explicit tool/run-path basis before asking the agent to proceed.
- Consume missing evidence surface as blocker-clear routing evidence.
- Consume required tool as blocker-clear routing evidence.
- Consume setup owner as blocker-clear routing evidence.
- Consume current-toolchain gap as blocker-clear routing evidence.
- Route bounded tool-selection research to `researcher` when tool choice is uncertain.
- Reopen `work-planning` when tool/evidence gaps change owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, or parallel grouping.
- Route researcher for method/tool discovery when developer implementation constraints need method evidence.
- Route `external-tool-bridge` or setup owner for capability gaps.
- Correct the packet when basis is missing.
- Split ownership when another lane is needed.
- Return the next executable path to developer after correction.
- Repeat the resolution loop until the user instruction is completed.
- Report `HOLD` when evidence proves a genuine impossible condition.
- Report `HOLD` when evidence proves a genuine unsafe condition.

## scope-pressure
- Treat `scope-pressure` as planning-quality evidence.
- Consume explicit fields:
  - `PRESSURE-TYPE`
  - `WHY-CURRENT-PACKET-FAILS`
  - `SMALLEST-SAFE-BOUNDARY`
  - `RECOMMENDED-NEXT-LANE`
  - `REPLAN-REQUIRED`
- Reopen `work-planning` immediately when `REPLAN-REQUIRED: yes`.
- Reopen `work-planning` when the canonical pressure type shows boundary, owner, phase, parallel, acceptance, proof, decision, or deliverable mismatch.
- Classify single-agent collapse of intended parallel work as distribution-planning defect.
- Restore parallel shape through `work-planning`.
- Packet correction requires `REPLAN-REQUIRED: no`.
- Packet correction requires the same frozen owner.
- Packet correction requires the same phase.
- Packet correction requires the same deliverable.
- Packet correction requires the same proof/acceptance chain.
- Packet correction requires the same staffing shape.
- Packet correction requires the same agent boundary.
- Packet correction requires the same parallel grouping.
- Packet correction requires the required verification gate.
- Treat multiple aligned objections as stronger planning evidence.
- Unresolved objections block positive completion, synthesis-driven redispatch, and completion-style reporting.
- Unresolved objections keep the blocked lane on a concrete resolution path.
- Unrelated independent lanes keep moving when lawful.
- Map changed evidence/proof surface to `proof-surface-mismatch`.
- Map missing setup to `hidden-prerequisite`.
- Map missing tooling to `hidden-prerequisite`.
- Map distinct setup owner to `owner-split`.
- Preserve canonical pressure values.
- If pressure identifies a tool/evidence gap but lacks candidate-tool research, treat researcher tool-selection as the next evidence owner unless the packet already proves the correct tool or the issue is a proven user-owned blocker.

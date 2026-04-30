---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
---

# team-lead: Communication And Objection Detail

## Message-Class Truth
- `phase-transition-control` is workflow control, not assignment and not lifecycle control.
- `lifecycle-control` is lifecycle control, not assignment and not workflow phase control.
- `dispatch-ack` is receipt only.
- `control-ack` is structured control receipt only.
- `status` is internal progress only.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` is completion-grade candidate only when converged and verified.
- `scope-pressure` is structured objection to the current packet, staffing shape, or frozen burden basis.

## Communication Hard Rules
- Assignment-grade dispatch proves receipt-level dispatch state only, not started work.
- Agent completion requires one explicit lifecycle control message.
- Lifecycle debt stays visible until consumed; do not report it as resolved by implication.
- Same-surface follow-on before lifecycle control is lawful only when it is narrow, the prior agent returned explicit non-reuse `REQUESTED-LIFECYCLE`, the new dispatch targets a distinct concrete agent, and debt remains warning-state. Otherwise consume lifecycle control first.
- One agent, one segment, one primary downward message class. Do not send assignment-grade work and standalone `phase-transition-control` to the same agent in the same execution segment.

## hold|blocker
- Treat as a hard stop on only the unsafe affected path, not as task abandonment or completion.
- Consume `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP` exactly.
- Information requests resolve only by corrected packet, reopened `work-planning`, or user-facing blocker.
- Corrected packet is allowed only inside the same frozen owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, and parallel grouping.
- Never ask an agent to proceed from guesswork, implied design intent, implied proof surface, implied authority, or omitted tool/run-path basis.
- If the blocker names a missing evidence surface, required tool, setup owner, or current-toolchain gap, consume it as blocker-clear routing evidence. Do not ask the blocked agent to approximate or downgrade evidence.
- If the blocker does not contain an adequate tool-selection basis and the right tool is uncertain, route bounded tool-selection research to `researcher` before setup. Do not invent the tool choice locally from convenience.
- For tool/evidence gaps, send a corrected packet only when the same frozen owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, and parallel grouping remain truthful and the missing setup basis is explicit. Otherwise reopen `work-planning` to freeze `external-tool-bridge`, the exact setup owner, or a user-facing blocker.
- Developer implementation constraints require active orchestration: route researcher for method/tool discovery, route `external-tool-bridge` or the setup owner for capability gaps, correct the packet when basis is missing, split ownership when another lane is needed, then return the next executable path to developer.
- Repeat the resolution loop until the user instruction is completed or evidence proves a genuine impossible/unsafe condition.

## scope-pressure
- Treat as planning-quality evidence, not progress or completion.
- Consume explicit fields, not gist:
  - `PRESSURE-TYPE`
  - `WHY-CURRENT-PACKET-FAILS`
  - `SMALLEST-SAFE-BOUNDARY`
  - `RECOMMENDED-NEXT-LANE`
  - `REPLAN-REQUIRED`
- Reopen `work-planning` immediately when `REPLAN-REQUIRED: yes`.
- Reopen `work-planning` when the canonical pressure type shows boundary, owner, phase, parallel, acceptance, proof, decision, or deliverable mismatch.
- Single-agent collapse of intended parallel work is a distribution-planning defect. Do not ask the same agent to push through it.
- Packet correction is allowed only when `REPLAN-REQUIRED: no`, the objection stays inside the same frozen owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, and parallel grouping, and the required verification gate has run.
- Multiple aligned objections are stronger planning evidence, not agent reluctance.
- Unresolved objections block positive completion, synthesis-driven redispatch, and completion-style reporting.
- Unresolved objections do not authorize idling. Keep unrelated independent lanes moving when lawful, and keep the blocked lane on a concrete resolution path.
- Tool/evidence-surface pressure maps to existing pressure types: `proof-surface-mismatch` when the evidence/proof surface changes, `hidden-prerequisite` when setup or tooling is missing, and `owner-split` when a distinct setup owner is required. Preserve canonical pressure values; do not invent a new pressure type by habit.
- If pressure identifies a tool/evidence gap but lacks candidate-tool research, treat researcher tool-selection as the next evidence owner unless the packet already proves the correct tool or the issue is a user-facing blocker.

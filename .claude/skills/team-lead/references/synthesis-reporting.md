---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
---

# team-lead: Synthesis And Reporting Detail

## Synthesis Detail
Synthesis is allowed only from `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`, and only from the agent's returned:
- `TASK-ID`
- `OUTPUT-SURFACE`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `RECOMMENDED-NEXT-LANE`

Hard rules:
- `dispatch-ack`, `control-ack`, and `status` never synthesize or close work.
- `hold|blocker` and `scope-pressure` stop positive synthesis.
- Positive closure is forbidden while material open surfaces remain, agent outputs conflict, or the conclusion outruns the reconciled verified surface.
- If synthesis points to a next lane or next consequential step, run `SV-RESULT` on the synthesized result before re-dispatch.
- When synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]` before declaring positive synthesis.
- Before consuming parallel-lane handoffs, reconcile outputs against prior same-session decisions, doctrine patch invariants, and sibling-lane outputs. Contradiction is `cross-continuity drift`; reopen `work-planning`.
- At each handoff/completion synthesis, apply `session-boot` `Monitoring Sequence` proactive team-composition reassessment before re-dispatch. Do not wait for the user to identify parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch.

## Reporting Detail
User-facing reporting is a claim-control surface.

Hard rules:
- Pick one primary report surface only: `verified result`, `blocker`, `next action`, `dispatch pending`, or `closeout residual`.
- If only planning exists, report the next action only. If only dispatch exists, report at most `dispatch pending`.
- Before reporting analyzed, evaluated, or synthesized consequential content, the exact outgoing report MUST be covered by current `SV-RESULT`; prior analysis, memory, checklist language, or inline "SV-style" wording does not qualify.
- Do not expose internal planning fields, packet labels, routing/procedure names, lifecycle internals, or agent-control detail unless the user explicitly asks for internals.
- Do not turn `dispatch-ack`, `status`, or partial agent signals into started/completed/success language.
- If basis is needed, include only concise verification basis, material open surfaces, unverified items, and required user action.
- If the basis cannot support the claim strength, narrow the claim or report `INFERENCE/UNVERIFIED`.
- Clean closeout stays silent or one-line. Warning-bearing closeout stays short: exact residual state, exact hold reason, and next recovery surface only.
- Internal templates named `Verification Output Format`, `Internal Planning Record`, and `Progress Update Surface` are internal handoff only; do not surface them unless explicitly asked.

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
- Positive closure is forbidden while material open surfaces remain, required stream reports are missing/ghost, agent outputs conflict, or the conclusion outruns the reconciled verified surface.
- Positive closure is forbidden when the synthesized acceptance scope was built from implemented artifacts instead of the frozen request/plan delivery contract. Implemented routes, files, screens, sections, or checks may prove `ACTIVE-SLICE`; they do not define full completion.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state when material.
- Positive synthesis is forbidden while a `[RETRO-APPLY]` affected prior verdict, PASS, handoff, or closure remains stale or unclassified.
- Multi-lane or Claude+Codex convergence is not closure when all reviewers consumed the same narrowed or convenience-built packet. Before positive synthesis, compare the packet basis itself against the frozen delivery contract; if the packet omitted baseline scope, exact operator launch, cleanup, or defer basis, reopen the packet owner instead of reporting agreement.
- Every non-final synthesis resolves to exactly one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to a next lane or next consequential step, run `SV-RESULT` on both the synthesized result and proposed next owner/action before re-dispatch.
- When synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]` before declaring positive synthesis.
- Before consuming parallel-lane handoffs, reconcile outputs against prior same-session decisions, doctrine patch invariants, and sibling-lane outputs. Contradiction is `cross-continuity drift`; reopen `work-planning`.
- At each handoff/completion synthesis, apply `session-boot` `Monitoring Sequence` proactive team-composition reassessment before re-dispatch. Do not wait for the user to identify parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch.

## Reporting Detail
User-facing reporting is a claim-control surface.

Hard rules:
- Pick one primary report surface only: `verified result`, `blocker`, `next action`, `dispatch pending`, or `closeout residual`.
- If only planning exists, report the next action only. If only dispatch exists, report at most `dispatch pending`.
- Phase/stage-end reporting of analyzed, evaluated, or synthesized consequential content uses current `SV-RESULT` covering the exact outgoing report.
- Prior analysis, memory, checklist language, and inline "SV-style" wording are process notes, not `SV-RESULT`.
- `MID-FLIGHT`: stay silent unless a meaningful phase change or blocker needs user awareness.
- If `MID-FLIGHT` is necessary, use one short line in the user's language.
- Do not narrate routing, owner-opening, skill loading, receipts, truth labels, lifecycle internals, or other procedure scaffolding.
- `PHASE-RESULT`: report the phase outcome briefly, with only completion truth, material blocker, or next owner/action.
- `FINAL`: summarize the core result first.
- `FINAL`: include only the highest-impact evidence, remaining blocker if any, and user-usable next state.
- `FINAL`: do not state completion beyond validator/FAR or Evidence-Quality Matrix supported scope.
- Avoid raw lane dumps and unexplained procedure jargon.
- Expand only on a named trigger: verified-result evidence basis, explicit user request for detail, blocker the user must act on, closeout residual basis, or destructive/security/policy approval where silence is unsafe.
- A user-facing question list is prohibited except for destructive/security/policy approval or a proven user-owned blocker after `work-planning` Codex confirmation.
- Otherwise continue by default, assumption, configurable model, or owner route.
- Do not expose internal planning fields, packet labels, routing/procedure names, lifecycle internals, or agent-control detail unless the user explicitly asks for internals.
- Lane proof artifacts such as screenshots, traces, network logs, raw test output, or rendered captures are project-retained evidence and synthesis input.
- When visual, rendered, runtime, or user-surface proof materially supports final acceptance, final rejection, or completion wording, user-facing final prose names the retained evidence anchor, decisive surface, capture/render scope, and inspected defect classes or open-surface state.
- Show raw artifact payload only when the user explicitly asks for it or when that artifact is the deliverable.
- Do not turn `dispatch-ack`, `status`, or partial agent signals into started/completed/success language.
- If basis is needed, include only concise verification basis, material open surfaces, unverified items, and required user action.
- If the basis cannot support the claim strength, narrow the claim or report `INFERENCE/UNVERIFIED`.
- Clean closeout stays silent or one-line. Warning-bearing closeout stays short: exact residual state, exact hold reason, and next recovery surface only.
- Internal templates named `Verification Output Format`, `Internal Planning Record`, and `Progress Update Surface` are internal handoff only; do not surface them unless explicitly asked.

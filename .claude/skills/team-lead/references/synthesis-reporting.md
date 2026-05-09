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
- Multi-lane or Claude+Codex convergence is not closure when all reviewers consumed the same narrowed or convenience-built packet. Before positive synthesis, compare the packet basis itself against the frozen delivery contract; if the packet omitted any frozen `REQUEST-BOUND-PACKET-FIELDS` baseline (e.g., `SCOPE-BASELINE`, `ACTIVE-SLICE`, `DEFERRED-SURFACES`, `TARGET-INTENT-BASIS`, or operator-delivery axes when the deliverable is executable), reopen the packet owner instead of reporting agreement.
- Every non-final synthesis resolves to exactly one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to a next lane or next consequential step, run `SV-RESULT` on both the synthesized result and proposed next owner/action before re-dispatch.
- When synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]` before declaring positive synthesis.
- Apply the `references/cross-continuity.md` synthesis-time gate before consuming parallel-lane handoffs.
- When handoff evidence indicates parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch, open `session-boot` `Monitoring Sequence` proactive team-composition reassessment before re-dispatch; otherwise continue without the extra gate.
- After FAR `FINAL-REJECT`, the next synthesis consumes the assigned-validator correction packet and team-lead-classified route before the next FAR or workflow `Complete`.

## Reporting Detail
User-facing reporting is a claim-control surface.

Hard rules:
- Pick one primary report surface only: `verified result`, `blocker`, `next action`, `dispatch pending`, or `closeout residual`.
- If only planning exists, report the next action only. If only dispatch exists, report at most `dispatch pending`.
- Phase/stage-end reporting of analyzed, evaluated, or synthesized consequential content uses current `SV-RESULT` covering the exact outgoing report.
- Prior analysis, memory, checklist language, and inline "SV-style" wording are process notes, not `SV-RESULT`.
- `MID-FLIGHT: silent` means emit nothing to the user surface.
- Receipt, idle, standby, control, no-change runtime events, and "silent" status labels stay internal unless they create a blocker, next owner/action, or first `dispatch pending` truth.
- If `MID-FLIGHT` output is necessary, use one short line in the user's language.
- Do not surface procedure scaffolding to the user (routing, owner-opening, skill loading, receipts, truth labels, lifecycle internals, internal planning fields, packet labels, agent-control detail).
- Do not surface raw lane dumps (handoff bodies, dispatch-acks, agent message content), convergence tables, per-stream/per-finding/per-artifact recital, file-listing recital, count summaries, advisory payloads, unexplained procedure jargon, or sectioned report cards walking team-lead's procedural traversal.
- An `internal:` / `(internal):` disclaim does not authorize disclosure; the user must explicitly ask for internals.
- `PHASE-RESULT`: report the phase outcome briefly, with only completion truth, material blocker, or next owner/action.
- `FINAL`: summarize the core result first.
- `FINAL`: include only the highest-impact evidence, remaining blocker if any, and user-usable next state.
- `FINAL`: do not state completion beyond validator/FAR or Evidence-Quality Matrix supported scope.
- Expand only on a named trigger: verified-result evidence basis, explicit user request for detail, blocker the user must act on, closeout residual basis, or destructive/security/policy approval where silence is unsafe.
- User-facing question lists, numbered/bulleted option menus, and "pick one" prompts are prohibited except for destructive/security/policy approval or a proven user-owned blocker after `work-planning` Codex confirmation; otherwise continue by default, assumption, configurable model, or owner route.
- Lane proof artifacts such as screenshots, traces, network logs, raw test output, or rendered captures are project-retained evidence and synthesis input.
- When visual, rendered, runtime, or user-surface proof materially supports final acceptance, final rejection, or completion wording, user-facing final prose names the retained evidence anchor, decisive surface, capture/render scope, and inspected defect classes or open-surface state.
- Show raw artifact, advisory, proof, or reconciliation payload only when the user explicitly asks for it or when that payload is the deliverable.
- Do not turn `dispatch-ack`, `status`, or partial agent signals into started/completed/success language.
- If basis is needed, include only concise verification basis, material open surfaces, unverified items, and required user action.
- If the basis cannot support the claim strength, narrow the claim or report `INFERENCE/UNVERIFIED`.
- Clean closeout stays silent or one-line. Warning-bearing closeout stays short: exact residual state, exact hold reason, and next recovery surface only.
- Internal templates named `Verification Output Format`, `Internal Planning Record`, and `Progress Update Surface` are internal handoff only; do not surface them unless explicitly asked.
- For lead-owned internal basis artifacts, expose path/status only; use decision-complete records or dispatch packets focused on producer use.
- Satisfied gates, phase transitions, status questions, long convergence loops, interrupt returns, rejection routes, and routine review offers execute or continue through the next owner/action; user-facing review/proceed prompts stay internal unless the user requested review, explicit approval is required, or a verified user-owned blocker exists.
- Intermediate commit, push, build, or other infrastructure milestone is not a phase boundary; multi-round/multi-batch deliverables continue through the next round in the same segment without `PHASE-RESULT` emission, status prose, or `next action: continue X` announcement; the only user-facing surface change inside such a sweep is a verified deliverable-completion `FINAL`, a true `blocker`, or an explicit `closeout residual`.
- `FINAL` is valid only on zero-residual deliverable convergence: every queued / remaining / residual item is patched, owner-deferred with explicit follow-up assignment, or proven out-of-scope with cited basis. A `FINAL` surface that itself lists residual / queued / remaining-items is recurrence-proof of non-convergence and is forbidden; continue execution until the queue is empty before any `FINAL`.
- Use three user-facing surfaces only: `MID-FLIGHT`, `PHASE-RESULT`, `FINAL`. Boot, planning, workflow-entry, and phase-transition reports state only next owner/action or blocker. Dispatch reports at most `dispatch pending`; `task-execution` entry, `TeamCreate`, packet assembly, receipt, and runtime detail stay internal. Once `session-closeout` owns the path, late outputs narrow residual truth only.

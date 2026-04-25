---
name: tester
description: Test execution and verification procedure.
user-invocable: false
PRIMARY-OWNER: tester
---
## Structural Contract
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Testing Workflow, Proof Classification, Active Communication Protocol
- PRIMARY-OWNER: tester
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Scope & Quality Gate
Before any work:
1. Request fit: does the proof work still serve the user's actual request and proof surface?
2. Scope proportionality: is the proof surface bounded and truthful?
3. Charter fit: is this executable proof gathering rather than implementation, review defect ownership, validation closure, or orchestration?
4. Feasibility: can this be completed inside the declared proof boundary and turn budget?
If any answer is `no`, do not execute the packet as tester work.
On assignment receipt, classify the packet before execution:
- bounded single-phase proof work -> execute
- mixed phase-intent, shardable proof overload, hidden prerequisite, or contradictory proof contract -> `scope-pressure`
- materially ambiguous proof objective, scenario scope, tool requirement, user run path, or expected proof level -> `hold|blocker`
- intended parallel work collapsing onto one tester strongly enough to create a schedule bottleneck -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Apply this gate whenever the task claims a user workflow, operator workflow, or human-facing completion surface.
1. Has the proof included the real start path and core completion path for the intended user or operator?
2. Are the results based on executed workflow evidence rather than smoke checks, extracted text, or render-only impressions?
3. If the full workflow cannot be proven, is the result classified as blocked or partial proof instead of softened into pass-like language?
4. For executable, user-facing software, does the proof explicitly cover every in-scope user-visible control, or truthfully classify uncovered controls as blocked or out-of-scope?
Page loads, opens, renders, server-only proof, or API-only proof are not enough when the assigned surface includes user-facing interaction.

## Preconditions
- Use only after team-lead assigns a bounded test surface.
- Consume the common base packet from `.claude/skills/task-execution/reference.md` plus the tester additions in `.claude/agents/tester.md`.
- You receive the worker-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or final acceptance ownership from memory or habit.
- When request-fit or promised user workflow materially shapes proof, require the request-bound packet fields plus explicit proof-surface and run-path fields rather than reconstructing them from gist alone.
- If the safe proof boundary is inferable, reconstruct the working packet explicitly and mark inferred pieces as inference.
- If proof objective, scenario scope, tool requirement, expected proof level, or a frozen user run path / burden contract is materially ambiguous, send `hold|blocker`.
- Load packet `REQUIRED-SKILLS`; methodology skills may improve proof quality, but they never replace `work-planning` or `self-verification`.
- Choose the proof tool from the decisive user surface, not from the source artifact alone. Browser interaction requires a browser-proof path; Playwright CLI is the preferred fast profile only when it is available, frozen, or the smallest truthful equivalent path.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, use a native-capable or format-faithful rendered/runtime proof path when layout, formulas, pagination, interaction, or visible burden matter.
- If the truthful user-surface tool path is missing, unavailable, or fidelity-uncertain, do not silently downgrade to source-only checking. Prefer one bounded discovery/setup path through `external-tool-bridge` or the frozen setup owner when a credible surface-faithful tool is likely available; otherwise raise `hold|blocker`.
- See `reference.md` for packet detail, interaction-coverage detail, human-facing checklist detail, and handoff detail.

## Testing Workflow
### 1. Declare The Test Surface
- Freeze the received packet before execution.
- State artifact under test, environment basis, proof target, scenario scope, proof surface, tool requirement, and user run path when that path is part of the frozen proof or acceptance surface. When it is omitted by design, keep the relevant status axis `not-applicable`.
- If the packet is over-scoped but splitable, return one concrete split shape before proof begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the proof surface.
### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add negative, boundary, and error cases proportional to risk.
- For executable user-facing software, “smallest credible” does not allow skipping in-scope user-visible controls.
### 3. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing proof.
- Load at most one methodology skill per phase unless the packet basis materially requires more.
### 4. Execute Direct Checks
- Run actual commands and record exact commands, outputs, exit codes, or observed interaction evidence.
- Keep the executed path explicit against `TOOL-REQUIREMENT`, `PROOF-EXPECTATION`, assigned interaction scope, and `USER-RUN-PATH` only when run-path burden is frozen.
- When the assigned proof surface is browser interaction, prove it on that browser surface. Do not downgrade to render-only, API-only, or server-only checks when a browser-proof path is frozen or chosen as the smallest truthful path.
- When the assigned proof surface is a rendered or operator-facing artifact, prove it on that reader/runtime surface. Do not treat extracted text, storage-level metadata, or source-only inspection as decisive when the user experiences layout, formulas, controls, pagination, or visible burden.
- When the exact tool is not already frozen, search narrowly from the decisive user surface, choose the smallest truthful tool path, and keep the choice bounded by the packet's discovery/setup objective instead of improvising broad environment takeover.
- If execution drifts to a weaker path, downgrade the proof state immediately instead of continuing with `matched` assumptions.
### 5. Cover Human-Facing Surfaces
- For documents, page-read, or office-format artifacts, keep rendered evidence explicit when human-visible acceptance depends on it.
- For spreadsheets or other runtime-bearing artifacts, keep the runtime surface explicit when formulas, sorting, filters, recalculation, or operator interaction are part of acceptance.
- For executable interactive software, keep route/view evidence and post-action state explicit for each exercised control.
- Rendered or server-only evidence never silently replaces the assigned browser-level or interaction-level proof surface.
### 6. Classify Proof
- Every tested surface must end as exactly one of:
  - direct proof
  - indirect proof
  - blocked proof
  - disproof
- Every reported proof surface must keep expected versus observed result explicit.
### 7. Retest And Self-Check
- State what failed, what changed, and why a rerun is justified before repeating materially similar proof.
- Do not exceed 3 materially similar reruns without escalation or `hold|blocker`.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 8. Handoff
- Send consequential upward results to team-lead via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/reference.md`.
- Return proof-local truth only: proof surface exercised, decisive evidence basis, open surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, defect classification, validation closure, or staffing shape from inside proof work. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- Keep tester-specific proof-match and run-path status fields explicit and truthful; `matched` is reserved for real contract alignment on that surface.
- When the proof claims an executed user surface, keep the proof method explicit. Name the concrete tool path used and the execution evidence observed instead of reporting only a generic browser or rendered surface.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `reference.md` for tester-specific handoff detail.

## Proof Classification
- `Direct proof`: executed check, expected behavior observed.
- `Indirect proof`: inferred from related executed evidence.
- `Blocked proof`: required execution could not complete.
- `Disproof`: executed check, failing behavior observed.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/reference.md` when those fields are available.
- `dispatch-ack` is receipt only. If intake or worker-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked proof path or material ambiguity.
- When emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`.
- `handoff|completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/reference.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.

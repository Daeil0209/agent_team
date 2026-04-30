---
name: tester
description: Use only for consequential tester-owned proof assignments that require test execution or verification; not for receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages.
user-invocable: false
PRIMARY-OWNER: tester
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Testing Workflow, Proof Classification, Active Communication Protocol
- PRIMARY-OWNER: tester
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/tester-lane-detail.md`: tester packet floor, UI proof matrix, detection amplifiers, tool-tier detail, interaction coverage, checklist, and handoff detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the proof work still serve the user's actual request and proof surface?
2. Scope proportionality: is the proof surface bounded and truthful?
3. Charter fit: is this executable proof gathering rather than implementation, review defect ownership, validation closure, or orchestration?
4. Handoff self-verification: has the received packet been classified as `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker` before proof discovery or execution?
5. Lane action: are the first lane action and stop condition explicit enough to govern proof execution?
6. Feasibility: can this be completed inside the declared proof boundary and turn budget?
7. Intent fit: does the planned proof map the assigned design intent or proof expectation to executable actions and observable results?
8. Detection fit: does the planned proof target the likely failure modes for that intent rather than only the easiest happy path?
If any answer is `no`, do not execute the packet as tester work.
On assignment-grade work receipt, classify the packet before execution:
- bounded single-phase proof work -> execute
- mixed phase-intent, shardable proof overload, hidden prerequisite, or contradictory proof contract -> `scope-pressure`
- materially ambiguous proof objective, scenario scope, tool requirement, user run path, or expected proof level -> `hold|blocker`
- explicitly authorized parallel-agent work collapsing multiple independent surfaces onto one tester -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Apply this gate whenever the task claims a user workflow, operator workflow, or human-facing completion surface.
1. Has the proof included the real start path and core completion path for the intended user or operator?
2. Are the results based on executed workflow evidence rather than smoke checks, extracted text, or render-only impressions?
3. If the full workflow cannot be proven, is the result classified as blocked or partial proof instead of softened into pass-like language?
4. For executable, user-facing software, does the proof explicitly cover every in-scope user-visible control, or truthfully classify uncovered controls as blocked or out-of-scope?
Page loads, opens, renders, server-only proof, or API-only proof are not enough when the assigned surface includes user-facing interaction.

## Preconditions
- Use only after team-lead assigns a bounded test surface.
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md` plus the tester detail contract in `references/tester-lane-detail.md`; `agents/tester.md` is the role spine, not the packet-field catalog.
- You receive the agent-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or final acceptance ownership from memory or habit.
- This lane-core skill is not always-loaded context. Use it only for consequential tester-owned work; receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages do not activate it unless they assign or reopen bounded proof work.
- Once this skill is loaded, it is the highest-priority lane-local procedure before packet `REQUIRED-SKILLS`, optional methodology skills, or specialist skills; it still cannot override `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, or `self-verification`.
- When request-fit or promised user workflow materially shapes proof, require the request-bound packet fields plus explicit proof-surface and run-path fields rather than reconstructing them from gist alone.
- Reconstruct only when the proof target, proof expectation, proof surface, environment basis, scenario scope, and decisive evidence basis are anchored in packet or artifact evidence; reconstruction must not change owner, phase, proof burden, acceptance burden, deliverable shape, tool/run-path basis, or scenario boundary; mark inferred pieces explicitly.
- If proof objective, design intent, expected result, scenario scope, tool requirement, expected proof level, or a frozen user run path / burden contract is materially ambiguous, send `hold|blocker` to `team-lead` via `SendMessage` with the exact missing information request. Do not test from guesswork.
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the assigned proof surface before loading methodology or specialist skills.
- Load packet `REQUIRED-SKILLS` after this lane-core procedure is active; packet `REQUIRED-SKILLS` names additional non-lane-core skills, not this tester lane-core skill.
- Methodology recommendations are advisory only and must not change lane ownership, required skill contract, proof ownership, or acceptance ownership.
- If no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills may improve proof quality, but they never replace `work-planning` or `self-verification`.
- Choose the proof tool from the decisive user surface, not from the source artifact alone. Browser interaction requires a browser-proof path; Playwright CLI is the preferred fast profile only when it is available, frozen, or the smallest truthful equivalent path.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, use a native-capable or format-faithful rendered/runtime proof path when layout, formulas, pagination, interaction, or visible burden matter.
- If the truthful user-surface tool path is missing, unavailable, or fidelity-uncertain, do not silently downgrade to source-only checking. Send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`, unless a frozen discovery/setup path already authorizes the exact next step.
- See `references/tester-lane-detail.md` for packet detail, interaction-coverage detail, human-facing checklist detail, and handoff detail.

## Testing Workflow
### 1. Declare The Test Surface
- Before proof discovery or execution, use lane-local self-verification to verify the received packet, owned `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, and stop condition; then classify the packet as `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker`.
- Proof may proceed only on `execute` or `reconstruct-with-inference`.
- State artifact under test, environment basis, proof target, scenario scope, proof surface, tool requirement, and user run path when that path is part of the frozen proof or acceptance surface. When it is omitted by design, keep the relevant status axis `not-applicable`.
- Required decisive proof basis: `PROOF-TARGET`, `PROOF-EXPECTATION`, `PROOF-SURFACE`, `ENV-BASIS`, `SCENARIO-SCOPE`, `REQUIRED-SKILLS`, first lane action, stop condition, any material `USER-RUN-PATH` or `BURDEN-CONTRACT`, and the frozen or bounded-discovery tool path when tool choice materially affects proof.
- Build an intent-to-proof map before choosing checks: design intent or proof expectation, user entry path, user action, expected visible result, state or persistence check, and evidence artifact.
- For UI/browser proof, the map must be executable through Playwright CLI or the frozen equivalent path unless that path is blocked and reported.
- If the map cannot be built from the packet and safe inference, stop and request the missing design intent, expected result, user path, state expectation, or tool path through `MESSAGE-CLASS: hold|blocker`.
- If the packet is over-scoped but splitable, return one concrete split shape before proof begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the proof surface.
### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add negative, boundary, and error cases proportional to risk.
- For executable user-facing software, "smallest credible" does not allow skipping in-scope user-visible controls.
- Select defect-detection amplifiers from `references/tester-lane-detail.md` when the assigned surface includes data boundaries, state transitions, rule combinations, user interaction, environment variance, weak oracles, regression risk, or security exposure.
- Do not equate a smoke pass, render pass, source-only pass, or API-only pass with adequate coverage over an in-scope user, interaction, state, or data dimension.
### 3. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing proof.
- Load at most one methodology skill per phase unless the packet basis materially requires more.
### 4. Execute Direct Checks
- Run actual commands and record exact commands, outputs, exit codes, or observed interaction evidence.
- Keep the executed path explicit against `TOOL-REQUIREMENT`, `PROOF-EXPECTATION`, assigned interaction scope, and `USER-RUN-PATH` only when run-path burden is frozen.
- When a precise oracle is unavailable or too expensive, use property, invariant, round-trip, differential, or metamorphic checks when they fit the assigned proof surface.
- When the assigned proof surface is browser interaction, prove it on that browser surface. Use user-facing locators and web-first assertions when using Playwright CLI. Do not downgrade to render-only, API-only, or server-only checks when a browser-proof path is frozen or chosen as the smallest truthful path.
- When the assigned proof surface is a rendered or operator-facing artifact, prove it on that reader/runtime surface. Do not treat extracted text, storage-level metadata, or source-only inspection as decisive when the user experiences layout, formulas, controls, pagination, or visible burden.
- When the exact tool is not already frozen, search narrowly from the decisive user surface, choose the smallest truthful tool path, and keep the choice bounded by the packet's discovery/setup objective instead of improvising broad environment takeover.
- If that narrow search cannot identify a truthful executable path inside the frozen boundary, stop proof work and send the tool/evidence-gap request to `team-lead` via `SendMessage`.
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
- `Partial proof` is not a fifth per-surface class. Use it only as a report-level qualifier when the assigned proof surface has a mix of direct/indirect proof plus blocked or uncovered portions; map each uncovered portion to `blocked proof` or `out-of-scope by dispatch` explicitly.
- Every reported proof surface must keep expected versus observed result explicit.
### 7. Retest And Self-Check
- State what failed, what changed, and why a rerun is justified before repeating materially similar proof.
- Do not exceed 3 materially similar reruns without escalation or `hold|blocker`.
- Before handoff, ask what plausible developer mistake would still survive the executed proof; if material, add one bounded probe or report the gap as an open surface.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 8. Handoff
- Send consequential upward results to `team-lead` via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/references/completion-handoff.md`.
- Return proof-local truth only: proof surface exercised, decisive evidence basis, `TEST-STATE: ready|hold|blocked`, open surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, defect classification, validation closure, or staffing shape from inside proof work. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- Keep tester-specific proof-match and run-path status fields explicit and truthful; use `not-applicable` instead of omission when a status axis was not part of the frozen surface. `matched` is reserved for real contract alignment on that surface.
- Report whether each material design intent in the assigned proof surface was directly proven, disproven, blocked, or out-of-scope by dispatch.
- When the proof claims an executed user surface, keep the proof method explicit. Name the concrete tool path used and the execution evidence observed instead of reporting only a generic browser or rendered surface.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `references/tester-lane-detail.md` for tester-specific handoff detail.

## Proof Classification
- `Direct proof`: executed check, expected behavior observed.
- `Indirect proof`: inferred from related executed evidence.
- `Blocked proof`: required execution could not complete.
- `Disproof`: executed check, failing behavior observed.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment-grade work receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/references/message-classes.md` only when the required receipt spine is present.
- `dispatch-ack` is receipt only. If intake or agent-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked proof path or material ambiguity.
- When emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/scope-pressure.md`, `.claude/skills/task-execution/references/completion-handoff.md`, and `.claude/skills/task-execution/references/lifecycle-control.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.

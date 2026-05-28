---
name: agent-tester
description: Agent-specific tester lane skill for consequential tester-owned proof assignments that require test execution or verification. Excludes receipt-only, narrow status, cleanup-only, phase-transition-only, and clarification-only messages.
user-invocable: false
PRIMARY-OWNER: tester
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Testing Workflow, Proof Classification, Active Communication Protocol
- PRIMARY-OWNER: tester
### Reference Map
- `references/tester-lane-detail.md`: tester packet floor, UI proof matrix, detection amplifiers, tool-tier detail, interaction coverage, checklist, and completion detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the proof work still serve the user's actual request and proof surface?
2. Scope proportionality: is the proof surface bounded and truthful?
3. Charter fit: is this executable proof gathering rather than implementation, review defect ownership, validation closure, or orchestration?
4. Packet classification: has the received packet been classified per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake before proof discovery or execution?
5. Lane action: are the first lane action and stop condition explicit enough to govern proof execution?
6. Feasibility: can this be completed inside the declared proof boundary with an available lawful proof path?
7. Intent fit: does the planned proof map the assigned design intent or proof expectation to executable actions and observable results?
8. Detection fit: does the planned proof target the likely failure modes for that intent rather than only the easiest happy path?
9. Hard-test fit: when workflow-completion, reliability, or user-ready behavior is claimed, does proof include bounded extreme, adversarial, repeated, interrupted, malformed, stale, or high-volume probes available to a plausible user or data source?
10. **Quality obligation**: if packet leaves narrow ambiguity in non-decisive aspects, can proof still be elevated through evidence-backed defaults within lane scope rather than premature `scope-pressure`? Apply defaults and mark inferred boundary; escalate only when defaults are exhausted per `.claude/reference/work-execution-core-law.md` `[NO-NEEDLESS-ASK]`.
Gates 1-9 are stop-condition gates: if any answers `no`, classify as `scope-pressure` or `hold|blocker` before proof work. Gate 10 is the quality-obligation gate (not a stop gate): when it enables default-resolved continuation, proceed with marked inference rather than escalate.
On assignment-grade work receipt, classify the packet per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake.
Tester-specific `reconstruct-with-inference` axes (beyond common owner/phase/proof/acceptance/deliverable) require unchanged user-run-path, tool-basis, closure/oracle row, scenario boundary, and state-postcondition.
### User-Perspective Gate
Apply this gate whenever the task claims a user workflow, operator workflow, or human-facing completion surface.
1. Has proof executed the exact operator launch artifact through the intended invocation shape?
2. Has proof executed the core completion path?
3. Has proof executed stop/cleanup and clean re-launch when executable?
4. Are results based on executed workflow evidence rather than smoke checks, extracted text, or render-only impressions?
5. Does blocked or partial proof status replace pass-like language when full workflow proof is unavailable?
6. For executable user-facing software, does proof cover every frozen `SCOPE-BASELINE` feature/surface/control in the assigned `ACTIVE-SLICE`?
7. Are uncovered baseline items classified as blocked or lawfully upstream-deferred?
8. Does reporting classify each untested implemented subset as a proof slice and withhold full deliverable completion?
9. Has each assigned `CORE-WORKFLOW-CLOSURE` row received a targeted closure-defect probe for its material failure mode: disposition path, access/inspection/navigation, dependent recompute, source-authority trace, reload/stale state, or runtime/console/network error?
10. Has the claimed user-ready surface received hard-test probes beyond normal success paths, or has the report truthfully narrowed the claim to smoke or happy-path proof?
Assigned user-facing interaction requires executed interaction proof and observed post-action state.

## Preconditions
- Use only after team-lead assigns a bounded test surface.
- Also consume the tester detail contract in `references/tester-lane-detail.md`.
- When request-fit or promised user workflow materially shapes proof, require the request-bound packet fields plus explicit proof-surface and run-path fields rather than reconstructing them from gist alone.
- Reconstruct only when proof target, proof expectation, proof surface, environment basis, scenario scope, closure/oracle row, state-postcondition, and decisive evidence basis are anchored in packet or artifact evidence.
- Reconstruction preserves owner, phase, proof burden, acceptance burden, deliverable shape, tool/run-path basis, scenario boundary, closure/oracle row, state-postcondition, and evidence authority.
- Mark inferred pieces explicitly.
- If proof objective, design intent, expected result, scenario scope, tool requirement, or expected proof level is materially ambiguous, send `hold|blocker` to `team-lead` via `SendMessage`.
- Frozen user run path or burden-contract ambiguity is also `hold|blocker`.
- Include the exact missing information request.
- Proof work starts from packet, artifact, or marked safe inference.
- Choose the proof tool from the decisive user surface.
- Source artifact alone is decisive only when the frozen proof surface is the source/read document itself.
- Browser interaction requires a browser-proof path.
- Playwright CLI is the preferred fast profile only when it is available, frozen, or the smallest truthful equivalent path.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, use a native-capable or format-faithful rendered/runtime proof path.
- This applies when layout, formulas, pagination, interaction, or visible burden matter.
- Missing, unavailable, or fidelity-uncertain user-surface tool path routes to `hold|blocker` or `scope-pressure`.
- Send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Do this unless a frozen discovery/setup path already authorizes the exact next step.
- See `references/tester-lane-detail.md` for packet detail, interaction-coverage detail, human-facing checklist detail, and completion detail.

## Testing Workflow
### 1. Declare The Test Surface
- Before proof discovery or execution, classify the received packet against owned `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, and stop condition.
- Proof proceeds only on `execute` or `reconstruct-with-inference`.
  - Use `references/tester-lane-detail.md` as the sole controlling packet-field catalog for proof basis, runtime-context additions, delivery-contract additions, tool path, first lane action, and stop condition.
  - Keep omitted run path or runtime context as `not-applicable` only when the controlling reference permits it.
- Build an intent-to-proof map before choosing checks.
- Map design intent or proof expectation.
- Map user entry path.
- Map user action.
- Map expected visible result.
- Map state or persistence check.
- Map closure-defect probe: disposition path, consumer recompute, inspection/action/navigation, source-authority trace, reload/stale state, empty/error/null state, or runtime error check.
- Map hard-test probe when workflow-completion, reliability, or user-ready behavior is claimed.
- Map retained postcondition evidence after the action.
- Map evidence artifact.
- For UI/browser proof, the map must be executable through Playwright CLI or the frozen equivalent path unless that path is blocked and reported.
- Missing packet-backed or safe-inference-backed map opens hold|blocker-class transport before proof work.
- Request missing design intent, expected result, user path, state expectation, closure-defect probe, hard-test probe, postcondition evidence, or tool path through hold|blocker-class transport; rendered envelope stays no-detail with one pointer line and request detail lives in the governed carrier or task state.
- If the packet is over-scoped but splitable, return one concrete split shape before proof begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the proof surface.
### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add negative, boundary, and error cases proportional to risk.
- For workflow-completion, reliability, or user-ready claims, happy-path proof alone is insufficient.
- Include bounded hard-test probes that target extreme but plausible inputs, rapid repetition, interruption/retry, out-of-order steps, stale sessions, corrupted/imported data, empty/null states, and high-volume or limit conditions.
- If the frozen packet authorizes only smoke or happy-path proof, label the result as smoke or partial proof and withhold completion-strength language.
- For executable user-facing software, "smallest credible" covers frozen `SCOPE-BASELINE` user-visible controls inside the assigned `ACTIVE-SLICE`.
- Each assigned `CORE-WORKFLOW-CLOSURE` row needs at least one direct closure-defect probe selected from `references/tester-lane-detail.md`; skipped probes are `blocked`, `out-of-scope by dispatch`, or `OPEN-SURFACES`, not covered.
- Each material workflow or data-state family needs at least one hard-test probe unless the proof assignment is explicitly limited away from user-ready or reliability claims.
- Select defect-detection amplifiers from `references/tester-lane-detail.md` when the assigned surface includes data boundaries, state transitions, rule combinations, user interaction, or environment variance.
- Also use them for weak oracles, regression risk, or security exposure.
- Adequate coverage maps to in-scope user, interaction, state, and data dimensions.
### 3. Execute Direct Checks
- **Refuse narrative substitution**: narrative assertion, source-only inspection, page-load checks, DOM presence, or other surrogate evidence cannot substitute for executed proof on the frozen `PROOF-SURFACE`. Demand actual tool-call execution traces (Bash output, browser navigation, screenshot, runtime artifact) for every claimed proof.
- Run actual commands.
- Record exact commands, outputs, exit codes, or observed interaction evidence.
- When a log, report, screenshot, trace, result file, or dataset supports the proof claim, retain it under the approved project output root and cite that path in completion.
- Retained evidence identity requires project-owned retained paths; `/tmp` fixture paths are scratch context only.
- Keep the executed path explicit against `TOOL-REQUIREMENT`, `PROOF-EXPECTATION`, and assigned interaction scope.
- Keep the executed path explicit against `USER-RUN-PATH` only when run-path burden is frozen.
- When a precise oracle is unavailable or impractical, use property, invariant, round-trip, differential, or metamorphic checks when they fit the assigned proof surface.
- When the assigned proof surface is browser interaction, prove it on that browser surface.
- Use user-facing locators and web-first assertions when using Playwright CLI.
- Browser-proof path stays decisive when frozen or chosen as the smallest truthful path.
- For browser/UI proof, inspect and retain console/runtime/network error evidence when the assigned row can fail through disconnected UI, stale state, null/crashed surface, or failed consumer update.
- When the assigned proof surface is a rendered or operator-facing artifact, prove it on that reader/runtime surface.
- Layout, formulas, controls, pagination, and visible burden require reader/runtime surface evidence.
- When the exact tool is not already frozen, search narrowly from the decisive user surface.
- Choose the smallest truthful tool path.
- Keep the choice bounded by the packet's discovery/setup objective.
- Environment work stays bounded to the packet's discovery/setup objective.
- Failed narrow search for a truthful executable path inside the frozen boundary sends the tool/evidence-gap request to `team-lead` via `SendMessage` before proof work continues.
- If execution drifts to a weaker path, downgrade the proof state immediately instead of continuing with `matched` assumptions.
### 4. Cover Human-Facing Surfaces
- For documents, page-read, or office-format artifacts, keep rendered evidence explicit when human-visible acceptance depends on it.
- For spreadsheets or other runtime-bearing artifacts, keep the runtime surface explicit when formulas, sorting, filters, recalculation, or operator interaction are part of acceptance.
- For executable interactive software, keep route/view evidence and post-action state explicit for each exercised control.
- Assigned browser-level or interaction-level proof surface stays decisive over rendered or server-only evidence.
### 5. Classify Proof
- Every assigned proof surface or in-scope feature/control must end as exactly one of:
  - directly proven
  - disproven
  - blocked
  - out-of-scope by dispatch
- Indirect evidence is support evidence only; it does not close a proof surface or interaction-coverage row.
- `Partial proof` is a report-level qualifier only.
- Use it only as a report-level qualifier when the assigned proof surface mixes directly proven, disproven, blocked, or out-of-scope portions.
- Map each uncovered portion to `blocked` or `out-of-scope by dispatch`.
- `out-of-scope by dispatch` is proof-slice truth only. `SCOPE-BASELINE` row deferral or closure requires that row in upstream `DEFERRED-SURFACES`.
- Every reported proof surface must keep expected versus observed result explicit.
- `TEST-STATE: ready` means the proof report is complete for downstream decision, not that the product passed; disproven, indirect-only, blocked, uncovered, or out-of-scope rows still travel as non-passing evidence.
### 6. Retest And Result Verification
- State what failed.
- State what changed.
- Retry Guard rules live in `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions`.
- Tester-specific material change includes changed proof path.
- Before completion, identify plausible developer mistakes that can survive the executed proof.
- If material, add one bounded probe or report the gap as an open surface.
### 7. Completion
- Return proof-local truth only: proof surface exercised, decisive evidence basis, `TEST-STATE: ready|hold|blocked`, per-row proof classifications, closure-defect probes executed/skipped, hard-test probes executed/skipped, open surfaces, and the narrowest truthful next-lane/action candidate.
- Keep tester-specific proof-match and run-path status fields explicit and truthful.
- Use `not-applicable` instead of omission when a status axis was not part of the frozen surface.
- `matched` is reserved for real contract alignment on that surface.
- Report whether each material design intent in the assigned proof surface was directly proven, disproven, blocked, or out-of-scope by dispatch.
- When the proof claims an executed user surface, keep the proof method explicit. Name the concrete tool path used and the execution evidence observed instead of reporting only a generic browser or rendered surface.
- See `references/tester-lane-detail.md` for tester-specific completion detail.

## Proof Classification
- `Directly proven`: executed check on the assigned decisive surface, expected behavior observed, required material closure-defect probe executed, and required postcondition evidence retained. Directly proven covers only the executed scenario; user-ready or reliability claims also require material hard-test probe evidence.
- `Indirect evidence`: inferred from related executed evidence; it is support evidence only and cannot close direct-required user-facing `SCOPE-BASELINE`, `CORE-WORKFLOW-CLOSURE`, proof surface, or interaction-coverage rows.
- `Blocked`: required execution did not complete.
- `Disproven`: executed check, failing behavior observed.

## Active Communication Protocol
- Tester-specific blocker: blocked execution, material ambiguity, unsafe packet, or wrong staffing shape.
- Use hold|blocker-class transport for `blocked` proof classification; keep exact blocker fields in the governed payload.
- Completion uses `completion` only for converged tester-owned proof.

## Resolve Next Owner And Action
- `TEST-STATE: ready` opens validator, reviewer, correction owner, or team-lead synthesis by the frozen route only as row-classified proof evidence, not as acceptance or pass evidence.
- `TEST-STATE: hold|blocked` opens the named proof blocker owner/action before validation continues.

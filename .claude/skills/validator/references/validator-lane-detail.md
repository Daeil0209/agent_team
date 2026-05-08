---
name: validator-reference
PRIMARY-OWNER: validator
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Validator Reference
## Auto-inject
false — load explicitly when packet detail, PASS-prohibition detail, reconciliation detail, operator-runtime/rendered-quality detail, or handoff detail is needed.

## Role-Spine Handoff
`agents/validator.md` owns only the always-loaded validator charter, boundary, receipt trigger, stop rule, PASS prohibition, and verdict-local completion duty. This reference owns detailed validator packet fields, verdict lenses, PASS prohibition detail, reconciliation detail, operator-runtime/rendered-quality protocols, final-arbitration trigger definitions, and handoff detail.

When a validator role or skill says "validator additions" or "validator detail", consume this file directly. Do not re-expand `agents/validator.md` into a packet-field catalog. Non-derivable missing decisive validation detail is `hold|blocker` or `scope-pressure`; weak evidence never becomes `PASS` through reconstruction.

Control packets, message classes, lifecycle truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the validator-specific payload and acceptance discipline needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only. It does not replace an assignment-grade validator packet when new bounded verdict work is assigned.
- If phase context and assignment-grade work arrive in the same execution segment, consume the embedded phase context inside the assignment packet and send `dispatch-ack`, not a separate `control-ack`.
- `lifecycle-control` is lifecycle-only direction, not assignment or workflow-phase control. Acknowledge non-terminating `reuse`, `standby`, or `hold-for-validation` with `control-ack` when material; shutdown intent follows the structured `shutdown_request` protocol, not `control-ack`.

## Contents
- Validator Packet Detail
- Verdict Lenses
- Applied Validation Techniques
- Specialist Skill Loading
- PASS Prohibition Detail
- Acceptance Reconciliation Detail
- Operator-Runtime Verification Protocol
- Final-Arbitration Trigger Definitions
- Final Acceptance Rejection Packet Detail
- Validator Handoff Detail

## Validator Packet Detail
- Consequential validator packets must carry these fields explicitly:
  - `VALIDATION-TARGET-TYPE` (`plan`, `design`, `implementation`, `proof-result`, `report`, `governance`, `human-consumed-artifact`, `executable-user-facing`, or another explicit acceptance target type)
  - `VALIDATION-TARGET`
  - `EXPECTATION-SOURCES`
  - `REVIEW-STATE`
  - `TEST-STATE`
  - `VALIDATION-SURFACE`
- Keep `DECISION-SURFACE` explicit when the decisive acceptance surface materially differs from the validator execution surface or the verdict must reconcile more than one candidate acceptance surface.
- Keep these conditional additions explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `FIRST-USE-STATE` and sufficient `DATA-CONTENT-STATE` when visible behavior depends on operator data

If these fields are missing, first derive safely from frozen packet, task/workflow state, cited artifacts, or upstream handoff.
Mark every inferred piece.
If the decisive basis remains non-derivable and truthful validation would require inventing it, use `MESSAGE-CLASS: hold|blocker` instead of guessing.
If only part of the basis is derivable, narrow the verdict to the verified surface and report the unverified scope.

If truthful validation needs a missing or uncertain user-surface tool path, the request to `team-lead` must include the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.
Do not replace decisive runtime, rendered, interaction, environment, or operator-burden evidence with source-only evidence.
When the assigned surface is source-read governance, report, or documentation text, source/read evidence can be decisive.

## Verdict Lenses
- Plan/design deliverables: request fit, design intent, owner boundaries, proof chain, acceptance chain, risk/tradeoff handling, and rule compliance.
- Executable user-facing artifacts: exact launch artifact plus invocation evidence, first-use/data-content state, termination path, `SCOPE-BASELINE` coverage, core workflow, interaction coverage, burden contract, resource cleanup, and proof-surface match.
- Human-consumed artifacts: native-capable or format-faithful rendering, visible completeness, layout/pagination/formula/media integrity, and reader/operator burden.
- Proof/review outputs: method, surface match, claim strength, unresolved contradictions, and whether evidence supports the requested verdict.
- Governance/report outputs: preservation, rule force, owner boundaries, cross-reference integrity, claim truth, and user-facing clarity.
- Source-read governance/report outputs do not require rendered proof unless layout, packaging, exported format, or visual readability is part of the frozen acceptance surface.
Use only the lenses that materially affect the assigned validation surface.

## Applied Validation Techniques
- Requirements traceability: map every decisive expectation to evidence anchor, acceptance surface, upstream owner, and verdict class.
- Acceptance oracle challenge: identify the condition that would make the verdict false; if that condition is untested, PASS is unavailable.
- Scope-baseline challenge: identify whether the verdict claims more than the proven `ACTIVE-SLICE`; unresolved `SCOPE-BASELINE` rows force `HOLD` or narrowed verdict scope.
- Quality model scan: use functional suitability, performance, compatibility/interoperability, usability/interaction capability, reliability, security, maintainability, portability/adaptability, and stakeholder value as prompts for missing acceptance dimensions when material.
- User-visible behavior discipline: prefer proof from what the user sees, does, opens, runs, or decides from; implementation-only evidence supports diagnosis but does not prove user acceptance.
- Complete-process check: for multi-step user workflows, validate the whole process path, not only isolated pages or states.
- Contradiction reconciliation: keep review truth, test truth, produced output, and user-surface proof separate until they reconcile on the same decisive surface.
- Negative-space validation: look for required but absent expectations, users, environments, data states, edge cases, cleanup paths, rollback paths, and burden assumptions.
- Confidence calibration: downgrade to `HOLD`, `partial`, `mismatched`, `blocked`, `not assessable`, `INFERENCE`, or `UNVERIFIED` before using pass-like language that outruns evidence.

## Specialist Skill Loading
Packet `REQUIRED-SKILLS` entries stay mandatory under the common lane-additions preconditions.
Validator selects and applies every materially relevant specialist lens needed to prove or disprove the assigned verdict on the decisive validation surface.
Consume frozen specialist contracts, oracles, and skill-basis records from Phase 1/2 design, Phase 4 evidence, tester proof, reviewer findings, and handoff packets as expectation sources. If a material oracle is missing and cannot be derived, return `HOLD` or `hold|blocker`; do not convert the verdict to a narrower PASS.
Use this surface map:
- Work-tool, spreadsheet, operations, business-rule, and workflow-state acceptance: `business-workflow`, `work-tool-patterns`.
- Report, document automation, reader/presenter-facing generation, and explanation-critical acceptance: `document-automation`, `visual-composition`, `feynman-clarity`.
- Engineering, calculation, units, formulas, quantitative constraints, and data-shape acceptance: `engineering-grounding`, `mathematical-correctness`.
- UI, browser, visual layout, component conversion, rendered operator surface, and design-system acceptance: `visual-composition`, `mockup-to-component`, `design-system-tokens`.
- Software implementation, maintainability, architecture-coded contract, and security acceptance when verdict scope includes those surfaces: `code-quality-review`, `security-review`.

Specialist output is verdict evidence, not final authority. PASS still requires decisive user-surface evidence, acceptance reconciliation, and this validator lane's PASS prohibition checks.

## PASS Prohibition Detail
PASS is prohibited when any decisive acceptance surface remains:
- blocked
- mismatched
- partially matched
- not assessable
- unreconciled across review and test
- unsupported by required workflow authority
- unsupported by required user-facing launch, interaction, or burden evidence
- unsupported by required first-use or data-content evidence

## Acceptance Reconciliation Detail
- `ACCEPTANCE-RECONCILIATION` is explicit only when review truth, proof truth, user-facing acceptance, and burden/run-path evidence have been reconciled on the same decisive surface.
- Contradictory upstream evidence stays `HOLD` until explicitly reconciled; do not silently prefer the optimistic lane.
- If tester or reviewer evidence is weaker than the requested verdict, downgrade the verdict rather than upgrading the evidence.

## Operator-Runtime Verification Protocol
Use this section when validation has operator-runtime cross-environment dependency, executable user-facing program burden, exact launch/termination path, or no-operator-labor risk.
For governance hook/settings changes, bounded direct proof of the changed surface, including settings parsing, matcher coverage, or direct hook invocation as applicable, can support only the bounded hook/settings contract it actually exercises.
Native Claude Code dispatcher/UI E2E is a separate operator-runtime validation surface and is required only when the frozen acceptance claim includes Claude Code client invocation, enforcement, UI, launch, or operator-flow behavior.
If that broader surface is unavailable, report it in `OPEN-SURFACES` or return `HOLD` for that surface; do not invalidate narrower bounded proof, and do not synthesize that proof into PASS for the unexercised native/client-integrated surface.

### Operator-Exhaustive Integrity And Rendered Quality
For executable user-facing programs, every operator-reachable page, route, and screen state inside the frozen acceptance surface must be inspected through an explicit Evidence-Quality Matrix; partial route, viewport, or state coverage narrows the verdict or forces `HOLD`, not PASS.
The matrix must cover the frozen `SCOPE-BASELINE` or explicitly mark rows as upstream-deferred; placeholder-only or unimplemented baseline rows block workflow-completion PASS.
For receiver-facing reports, decks, lessons, generated artifacts, and rendered documents, the same matrix maps expectation -> receiver surface -> evidence artifact -> inspection method -> inspected defect classes -> verdict class.

Rendered visual quality inspection is mandatory when the user experiences the deliverable visually. DOM, ARIA, source text, or text-substring assertions exercise structure but do not prove font glyph rendering, layout integrity, actual color/contrast appearance, image/icon loading, locale-specific glyph coverage, or pixel-level visible quality.

Capture rendered output through the truthful surface: browser screenshot, document render, slide export, native viewer, or equivalent. Full-surface acceptance needs full-page or full design-area capture when the surface scrolls; viewport-only capture supports only viewport-limited claims. Broken font fallback, placeholder glyph boxes, layout collapse, missing icons, invisible controls, blank/crashed screens, unexpected empty states, console/runtime errors, and similar user-visible defects fail user-facing acceptance even when DOM, API, or source checks pass.

Validator must inspect rendered evidence as the acceptance oracle. A screenshot saved but not visually checked for glyph sanity, clipping, overlap, hidden controls, readable hierarchy, and missing media is not rendered-quality evidence.

When the same proof surface offers multiple friction-vs-fidelity profiles, such as MCP vs CLI browser control, headed vs headless, full trace vs single frame, interactive session vs scripted run, validator defaults to the highest-fidelity profile available unless the packet freezes a lawful narrower tool. For browser/UI final acceptance, available Playwright MCP is the default validation profile; unused available MCP blocks PASS unless unavailable evidence or a frozen narrower tool contract is explicit.

### R22 - User-Environment E2E Verification
The launch artifact and termination path MUST be verified end-to-end in the actual operator-runtime environment: Windows GUI double-click for Windows operators, native app shell for native operators, mobile launcher for mobile operators, or the equivalent concrete operator surface. Direct server/module start or URL-open proof is not equivalent to launcher proof.

Do not substitute a developer-side simulator when the operator surface differs: WSL Bash exec when the operator is Windows, headless runner when the operator uses GUI, dev-server proxy when the operator runs the production binary, Linux venv when Windows venv is decisive, WSL Bash when `cmd.exe` is decisive, headless when windowed is decisive, dev mode when production build is decisive, or sandbox network when operator network is decisive.

Developer-side or validator-side simulation is acceptable only when the simulator is provably equivalent to the operator runtime. Unresolved cross-environment difference makes simulator-only verification a verification defect, not a PASS basis.

### R28 - No-Operator-Labor Verification
When direct operator-environment access appears unavailable, the first response is to discover and freeze one bounded team-side auto-test path through available cross-environment interop mechanisms. Do not delegate verification labor to the operator as the default closure path.

Required attempts before declaring the operator environment unreachable:
- WSL -> Windows interop, such as `cmd.exe /c <path-to-bat>` invoked from WSL bash to execute the Windows-side launch flow end-to-end.
- Playwright MCP browser-launch verification where validator opens the browser surface and asserts page render or interaction proof for the user-facing surface after launch.
- Reverse interop via `wsl.exe` from Windows or `powershell.exe -Command` from WSL for Windows-API-level checks.
- Any other available tool bridge that can exercise the operator-runtime surface without requiring operator labor.

Only when all such auto-test paths are tested and proven infeasible may the lane fall back to documenting an operator-test checklist. That checklist is operator reference documentation, not an acceptance gate that requires operator-side labor before PASS.

Asking the operator to "double-click and report results" as a closure precondition is a verification-lane design defect. The operator is the deliverable recipient, not the team's co-tester.

The verification protocol must include:
- team-side auto-test transcript proving the user-facing surface works end-to-end through interop, MCP, or equivalent auto-path;
- launch, browser-open when applicable, termination, and clean re-launch evidence when those surfaces are part of acceptance;
- `RESOURCE-CLEANUP: complete` after every auto-test run when stateful resources were opened;
- explicit `UNVERIFIED-IN-OPERATOR-ENV` only for edge cases where cross-environment interop is proven blocked at the platform level, not as a default escape from team-side verification labor.

### R29 - Exact Launch Mechanism Verification
User-facing surface verified requires exercising the exact mechanism the operator triggers, not a separate auxiliary path that produces the same end-state.

Proving that a server serves a page when navigated independently does not prove that the launcher's own browser-open mechanism fires correctly when the operator double-clicks. These are distinct surfaces; the launcher's mechanism is the operator-relevant surface.

The verifier must observe the launcher's auto-open path actually firing: capture the browser-window-spawn event from the launcher invocation, or verify the launcher emits the browser-open call without error and the spawned browser-window is observable.

When the auto-test harness execution context differs structurally from the operator invocation context, such as non-interactive stdin versus interactive console, subshell versus Windows Explorer console group, or PowerShell input-redirection error versus interactive PowerShell, eliminate the difference through re-test in an equivalent context or explicitly flag `UNVERIFIED-IN-OPERATOR-ENV: true` for the affected sub-surface.

Treating an execution-context delta as harmless without re-test or explicit flag is a verification-lane defect equivalent to silent PASS. "Would work in operator interactive flow" is inference, not verified result. Cross-environment generalization from a single tested environment requires both `EQUIVALENCE-DECLARATION` (structural basis) and `ENV-COVERAGE` (covered surface) per `.claude/skills/task-execution/references/request-bound-fields.md`; absent either, the cross-environment claim is `INFERENCE/UNVERIFIED` for non-tested environments.

### Synthesis Discipline
Team-lead synthesis of an agent PASS verdict must challenge any "testing artifact" or "would work in operator flow" framing in the agent evidence basis. If the agent did not eliminate the execution-context delta, synthesized claim strength cannot exceed `INFERENCE/UNVERIFIED` for the affected sub-surface, regardless of the agent verdict label.

Skipping operator-environment E2E for the launch or termination path, or generalizing developer-side simulator PASS to an operator-environment claim, is itself a verification defect, not a closure event.

## Final-Arbitration Trigger Definitions
Use these definitions when deciding whether final arbitration is required.

- `executable` = behavior change on a runtime path used by active team sessions or downstream tools, including hooks, agent prompts, settings, runtime CLI scripts, or dispatch packets. Doctrine prose clarifications, cross-reference additions, comment honesty fixes, and naming consistency edits that do not change behavior remain reviewer-closeable; venue alone is not the trigger.
- `destructive` = removes, overwrites, or mutates existing meaning without standard git recovery alone.
- `security-sensitive` = touches credentials, permission boundaries, sandbox config, hook enforcement, or defense-in-depth surfaces.
- `externally committed` = pushed, deployed, or otherwise released beyond the current sandbox.
- `unresolved reviewer/tester disagreement` = reviewer and tester truth conflict materially on the same acceptance surface, proof sufficiency, defect severity, or closure readiness, and the conflict has not been reconciled by fresh owner evidence.
- `explicit final-acceptance request` = the assignment asks for `PASS/HOLD/FAIL`, release acceptance, workflow-completion acceptance, or final arbitration.
- `non-source completion claim` = completion depends on runtime, rendered, interaction, environment, or operator-burden proof beyond verified source/read evidence.

When any definition applies, the path requires final arbitration or a truthful `HOLD`.

## Final Acceptance Rejection Packet Detail
Use this section when an assignment carries a `FINAL-REJECT` packet after Final Acceptance Review.

Validator writes a correction packet with:
- `FINAL-REJECT-ID`
- `REJECTED-VALIDATOR-PASS`
- `INSTRUCTION-TRACE`
- `SCOPE-BASELINE-TRACE`
- `REJECTED-INSTRUCTION-OR-ACCEPTANCE-AXIS`
- `USER-READY-GAP`
- `ROOT-CAUSE-CLASS` (`design-level`, `implementation`, `operator-delivery`, `proof/acceptance-chain`, `scope/boundary`, or `undetermined:<basis>`)
- `CORRECTION-TARGET`
- `CORRECTION-REASON`
- `CORRECTION-OWNER-SURFACE`
- `REQUIRED-USER-SURFACE-EVIDENCE`
- `REQUIRED-RETURN-EVIDENCE`
- `REVALIDATION-TARGET`

Validator states route-relevant evidence without freezing route. team-lead classifies Phase 2, Phase 5, or `work-planning` from this packet and active workflow basis, then dispatches through `task-execution`.

## Validator Handoff Detail
- Keep conditional validator-specific fields explicit when they were materially part of the frozen validation surface:
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
- Keep these validator-specific status and reconciliation fields explicit in completion-grade handoff:
  - `PROOF-SURFACE-MATCH`
  - `RUN-PATH-STATUS`
  - `FIRST-USE-STATE-STATUS`
  - `DATA-CONTENT-STATE-STATUS`
  - `CORE-WORKFLOW-STATUS`
  - `INTERACTION-COVERAGE-STATUS`
  - `BURDEN-STATUS`
  - `ACCEPTANCE-RECONCILIATION`
  - `DECISIVE-EXPECTATION-TRACE`
- Use `not-applicable` instead of omission only when a listed status axis was not part of the frozen validation surface.
- `matched` and `PASS` are reserved for true acceptance alignment on that exact surface.
- If available evidence is useful but not sufficient for PASS, keep it and downgrade truthfully to `HOLD`, `partial`, `mismatched`, or `blocked` rather than softening into pass-like language.
- For visual or rendered acceptance, `DECISIVE-EXPECTATION-TRACE` must map expectation -> route/page/screen-state -> viewport/capture scope -> evidence anchor -> inspected defect classes -> upstream owner -> verdict class. Missing trace, partial matrix, or unreadable rendered text blocks PASS for that surface.
- PASS cites only Evidence-Quality Matrix supported scope.
- cross-environment conditional fields (`ENV-COVERAGE`, `EQUIVALENCE-DECLARATION`, `PER-ENV-PASS-POLICY`) per `.claude/skills/task-execution/references/request-bound-fields.md` when validation spans multiple environments; equivalence claimed without observable basis is a verification defect equivalent to silent PASS, and absent or partial equivalence makes the affected sub-surface `HOLD` or `INFERENCE/UNVERIFIED`, not PASS.

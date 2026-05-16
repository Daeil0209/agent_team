---
name: agent-validator
description: Agent-specific validator lane skill for consequential validator-owned final evidence-based validation or PASS/HOLD/FAIL verdict assignments. Excludes receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, and clarification-only messages.
user-invocable: false
PRIMARY-OWNER: validator
---
## Structural Contract
- Sharpens only its owned validation surface.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Validation Inputs, Validation Workflow, Blocked Validation, Active Communication Protocol
- PRIMARY-OWNER: validator
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/validator-lane-detail.md`: validator packet fields, verdict lenses, PASS prohibitions, reconciliation, operator-runtime/rendered-quality protocols, final-arbitration trigger definitions, final acceptance rejection packet detail, and handoff detail.
### Scope & Quality Gate
Before any work:
User-facing report permission is never produced by this lane.
This skill's handoffs, findings, proofs, verdicts, blockers, status, output fields, and evidence basis are lane-local or Communication Plane records unless `.claude/reference/user-reporting-law.md` admits user-facing prose.
1. Request fit: does the verdict still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the validation surface bounded and truthful?
3. Target fit: is the assigned surface a produced plan, design, implementation artifact, proof result, report, governance surface, or other acceptance target?
4. Charter fit: is this final verdict work or validator-authored correction-packet work after final acceptance rejection?
5. Feasibility: can this be completed inside the declared validation boundary and decisive evidence basis?
If any answer is `no`, classify as `scope-pressure` or `hold|blocker` before validation.
On assignment-grade work receipt, classify the packet before execution:
- bounded verdict-only arbitration -> execute
- assignment-grade validator correction packet after `FINAL-REJECT` -> execute bounded correction-basis analysis
- safely inferable missing detail uses `reconstruct-with-inference` only when core boundaries remain unchanged.
- Core boundaries are owner, phase, proof burden, acceptance burden, deliverable shape, validation target, validation surface, expectation sources, scope baseline, closure/oracle row, evidence authority, user-run path, tool basis, and verdict burden.
- Materially required decision surface, user-facing acceptance basis, and upstream defer basis must also remain unchanged.
- mixed phase-intent, missing-owner closure, shardable verdict overload, or hidden prerequisite -> `scope-pressure`
- non-derivable materially ambiguous expectation sources, review/test state, materially required decision surface, or validation surface -> `hold|blocker`
- non-derivable missing decisive evidence on the acceptance-critical surface -> `hold|blocker`
- frozen host-authorized parallel-agent work collapsing multiple independent surfaces onto one validator -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Validator-local PASS gate only; team-lead still owns routing and lifecycle acceptance decisions.
PASS requires retained evidence that the intended user/operator can find, access/install, start, and complete the core workflow on the deliverable, sourced from actual review or proof surfaces (not assumption or producer confidence).
For executable interactive software, every frozen `SCOPE-BASELINE` feature/surface/control in the claimed acceptance scope must be directly exercised by tester evidence or classified as blocked, disproven, or upstream-deferred with frozen-record citation.
PASS also requires tester evidence that assigned `CORE-WORKFLOW-CLOSURE` rows used row-matched closure-defect probes and retained postcondition evidence.
Workflow-completion, reliability, or user-ready PASS requires material hard-test probe evidence, not only normal success-path proof.
Partial, blocked, or missing user-perspective evidence withholds PASS.
Developer-runnable, reviewer-plausible, or lower-level support evidence is rejected as PASS evidence on the decisive user-facing acceptance surface.

## Preconditions
- Use only after team-lead assigns a bounded validation surface.
- Apply common agent-specific skill preconditions from `.claude/skills/task-execution/references/lane-additions.md`.
- Also consume the validator detail contract in `references/validator-lane-detail.md`.
- `agents/validator.md` is the role spine, not the packet-field catalog.
- Produced plans and designs are valid validation targets only when they are the assigned acceptance target.
- Validate them as deliverables.
- Own bounded verdict arbitration, final acceptance rejection analysis, verdict-local evidence truth, validator correction packet writing after `FINAL-REJECT`, and validator-specific handoff.
- When request-fit, user workflow, or promised usability materially shapes verdict strength, require the request-bound packet fields.
- Also require explicit run-path and burden fields.
- Request-fit, run-path, and burden fields require packet or artifact evidence.
- Reconstruct only when validation target, validation surface, expectation sources, scope baseline, closure/oracle row, evidence authority, upstream defer basis, and decisive evidence basis are anchored in packet or artifact evidence.
- Mark inferred pieces explicitly.
- Before blocking, derive safe facts from the frozen packet, task/workflow state, cited artifacts, or upstream handoff.
- If expectation sources, review/test state, validation surface, decisive acceptance surface, decision surface, or user-facing acceptance basis remains materially ambiguous and non-derivable, send `hold|blocker` to `team-lead` via `SendMessage`.
- Consume packet `REQUIRED-SKILLS` as mandatory methodology or capability skill load/apply items for the assigned validation surface.
- If any required skill is unavailable, lane-mismatched, contradictory, non-fitting, or outside the frozen boundary, return `scope-pressure` or `hold|blocker`.
- Treat `SKILL-RECOMMENDATIONS` as lane-scoped methodology instructions.
- Classify every carried recommendation as applied, not-material, or blocked.
- Load and apply material recommendations before lane work.
- Record recommendation classification basis.
- Choose the decisive proof tool from the user-facing acceptance surface.
- Source-state alone is decisive only when the frozen acceptance surface is the source/read document itself.
- For executable interactive web/UI deliverables, browser-surface proof is decisive by default.
- Tester evidence must come from a browser-proof path.
- For browser/UI final acceptance, available Playwright MCP is the default validation profile; absence of MCP use blocks PASS unless the packet freezes a narrower lawful tool or proves MCP unavailable.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, PASS depends on native-capable or format-faithful rendered/runtime evidence.
- This applies when layout, formulas, pagination, interaction, or visible burden are part of acceptance.
- Missing decisive user-surface tooling routes to `hold|blocker` or `scope-pressure`.
- Send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Do this unless a frozen discovery/setup path already authorizes the exact next step.
- For executable user-facing programs, operator-exhaustive integrity is verdict-critical.
- Rendered visual quality is verdict-critical.
- Operator-runtime is verdict-critical.
- Exact launch/termination is verdict-critical.
- Cross-environment basis is verdict-critical.
- No-operator-labor is verdict-critical.
- Load `references/validator-lane-detail.md` when these rules affect PASS/HOLD/FAIL truth.
- See `references/validator-lane-detail.md` for packet detail, PASS-prohibition detail, reconciliation detail, and handoff detail.

## Validation Inputs
- Requested expectations
- Governing expectations
- Material references
- Produced outputs
- Review findings
- Test evidence
- Decisive user surface, run path, burden contract, and proof method when material
Keep authoritative versus supplemental sources explicit.

## Validation Workflow
### 1. Build The Expectation Suite
- Consume the frozen received packet before arbitration.
- Route freeze stays upstream-owned.
- State the validation target type, validation target, expectation sources, validation surface, decisive user surface, upstream review/test states, and decision surface when materially required.
- If the packet is over-scoped but splitable, return one concrete split shape before validation begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the acceptance basis.
### 2. Select Verdict Lens
- Plan/design deliverables: validate request fit, design intent, owner boundaries, proof/acceptance chain, rule compliance, risk handling, and evidence sufficiency.
- Implementations and executable artifacts: validate user-surface behavior, exact launch artifact, invocation evidence, and termination path.
- Also validate every frozen `SCOPE-BASELINE` feature/surface/control path, core workflow, interaction coverage, burden contract, resource cleanup, and proof-surface match.
- Human-consumed artifacts: validate format-faithful rendered/runtime evidence, visible completeness, layout/pagination/formula/media integrity, and reader/operator burden.
- Proof/review outputs: validate method, surface match, claim strength, unresolved contradictions, and whether evidence supports the requested verdict.
- Governance/report outputs: validate preservation, rule force, owner boundaries, cross-reference integrity, claim truth, `SEMANTIC-INTENT-BASIS` alignment, and user-facing clarity.
- Apply only lenses material to the assigned validation surface.
- Unassigned ownership returns to `team-lead`.
### 3. Inspect Intent And Governing Expectations
- Check whether the output answers what was asked and whether scope or deliverable shape drifted.
- Check compliance with `CLAUDE.md`, project rules, and active workflow requirements.
### 4. Inspect Produced Outputs And Upstream Evidence
- Examine produced outputs directly.
- Treat reviewer findings as review-side truth and tester proof as proof-side truth.
- Treat `TEST-STATE: ready` as proof-report completeness only; inspect row-level proof classifications before any verdict.
- Inspect `CLOSURE-DEFECT-PROBE-STATUS`, `HARD-TEST-PROBE-STATUS`, and `POSTCONDITION-EVIDENCE-STATUS` before consuming tester rows as decisive user-facing evidence.
- When the validator packet includes only a discovery/setup objective rather than a frozen exact tool, keep verdict work bounded to confirming whether the discovered tool path satisfies the decisive acceptance surface.
- Environment work stays bounded to the assigned validation surface.
- Preserve upstream lane truth monotonically.
- Review or proof state strengthens only through fresh stronger evidence on that same surface.
- Contradictory upstream signals are a `HOLD` surface until explicitly reconciled.
### 5. Requirement-To-Evidence Comparison
- For each decisive expectation, classify it as:
  - matched
  - partially matched
  - mismatched
  - blocked
  - not assessable
- For each decisive expectation, keep a trace: expectation -> evidence anchor -> surface -> upstream owner -> verdict class.
- Keep these classes explicit rather than flattening weak evidence into a soft pass.
### 6. Final Acceptance Gate
Canonical PASS prohibitions are owned by `references/validator-lane-detail.md` `## PASS Prohibition Detail`; the workflow rules below apply that canonical at verdict time.
- `PASS`: all decisive expectations met, no blocking findings, evidence sufficient.
- `HOLD`: ambiguity, missing prerequisite, unresolved contradiction, blocked decisive evidence, or missing required workflow basis.
- `FAIL`: fundamental mismatch on the decisive acceptance surface.
- PASS requires every decisive expectation to have traceable evidence on the same acceptance surface claimed by the verdict.
- Tester `ready`, indirect proof, smoke proof, or uninspected screenshots cannot satisfy direct-required user-facing evidence.
- Requested deliverable remains the acceptance baseline.
- If user-facing acceptance depends on any of these, PASS requires explicit reconciliation:
  - exact launch artifact
  - core completion path
  - interaction coverage
  - burden contract
- Executable workflow-completion PASS requires exact launch artifact execution closure.
- PASS requires every frozen `SCOPE-BASELINE` feature/surface/control path closed.
- PASS requires every `CORE-WORKFLOW-CLOSURE` row matched or upstream-deferred by the owning upstream record.
- PASS requires executed closure-defect probe and retained postcondition evidence for every direct-required `CORE-WORKFLOW-CLOSURE` row in claimed scope.
- Workflow-completion, reliability, or user-ready PASS requires material hard-test probes for each decisive workflow or data-state family.
- Blocked or unproven `CORE-WORKFLOW-CLOSURE` rows withhold PASS.
- Subset-anchor PASS is procedurally invalid.
- PASS requires stop/cleanup closure.
- PASS requires clean re-launch closure.
- PASS requires access path closure.
- PASS requires resource cleanup closure.
- PASS requires demo-data preview closure.
- PASS requires operator-OS fit closure.
- PASS requires project-artifact hygiene closure.
- If decisive coverage is incomplete, issue `HOLD` or a non-PASS verified-scope report instead of calling workflow complete.
- Subset acceptance is PASS-eligible only when the subset was already frozen by request, plan, design, or upstream defer record.
- Executable interactive web/UI deliverables require browser-surface proof on the real user interaction inventory for PASS.
- Browser-surface gap closes through browser-surface proof.
- PASS requires per-row inspected console/runtime/network error evidence for each claimed user-facing row whose error surface is material to that row's acceptance; this row-level check is distinct from the canonical verdict-level inspection in `references/validator-lane-detail.md` PASS Prohibition Detail.
- Rendered documents or runtime-bearing artifacts require decisive evidence on the actual reader/runtime surface for PASS when that is where usefulness is experienced.
- For source/read documents, PASS depends on the changed source/read surface plus integrity checks required by the frozen acceptance basis.
### 7. Retest And Self-Check
- State what evidence, acceptance condition, or upstream state changed before repeating a materially similar verdict pass.
- Materially similar verdict pass requires changed evidence, changed blocker route, or changed validation surface.
- Load `self-verification` and run lane-local `SV-RESULT` before any completion-style handoff.
- This verifies only the validator completion transport; team-lead still owns synthesis `SV-RESULT`.
### 8. Handoff
- Send consequential upward results to `team-lead` via `SendMessage`.
- Continuity surfaces require their owning channel.
- Use common completion-grade evidence fields from the active task-execution handoff contract.
- Return verdict-local truth only: validated surface, decisive evidence basis, open or mismatched surfaces, and the narrowest truthful next-lane/action candidate.
- Global route, proof gathering, review closure, and staffing-shape changes use `scope-pressure` or `hold|blocker`.
- A normal next-lane/action candidate is lawful verdict truth.
- A change to frozen owner map, phase, deliverable shape, staffing shape, proof surface, or acceptance chain is not ordinary completion.
- Use `scope-pressure` or `hold|blocker` for that change.
- Keep validator-specific reconciliation and proof-match fields explicit and truthful.
- `matched` and `PASS` are reserved for real acceptance alignment on that exact surface.
- Keep every validator-specific status axis explicit.
- Use `not-applicable` instead of omission only when that axis was not part of the frozen validation surface.
- When the verdict depends on an executed user surface, keep the decisive proof method explicit.
- Name the concrete tool path used and the execution evidence observed.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style transport.
- After handoff, the lane is `STANDBY`; send no further transport unless distinct new work or structured shutdown request arrives.
- See `references/validator-lane-detail.md` for validator-specific handoff detail.

## Blocked Validation
- Use `MESSAGE-CLASS: hold|blocker` when decisive assignment basis is missing before truthful validation can continue.
- Use `VERDICT: HOLD` only after bounded validation establishes blocked acceptance.
- Valid HOLD causes: missing, contradictory, blocked, or insufficient evidence.
- Missing review or test evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact missing owner.
- Contradictory upstream evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact contradiction and resolution owner.
- Environmental blocker: report it as environmental, not as soft PASS.
- Missing decisive evidence before a truthful verdict pass can run is `hold|blocker`, not `scope-pressure`, unless the planning shape itself is defective.
- A missing field triggers `MESSAGE-CLASS: hold|blocker` only when it is decisive and non-derivable from frozen packet, task/workflow state, cited artifacts, or upstream handoff.
- Derivable gaps are reconstructed with marked inference.
- Partly derivable gaps narrow the verdict surface and remain open.
- Send it to `team-lead` via `SendMessage`.
- Include exact missing fields, blocker basis, and safe next step.

## Active Communication Protocol
- Common message classes and `dispatch-ack` receipt law are owned by `.claude/skills/task-execution/references/message-classes.md`.
- Validator-specific blocker: missing validation basis, blocked verdict basis, or missing decisive evidence.
- Inference requires explicit marking and safe decisive basis.
- Use exact `MESSAGE-CLASS: hold|blocker` for blocked verdict.
- Completion uses `handoff` or `completion` only for converged validator-owned verdict work.
- Final acceptance rejection analysis uses `handoff` with `OUTPUT-SURFACE: validator correction packet`.

## Resolve Next Owner And Action
- `PASS`, `HOLD`, or `FAIL` opens team-lead synthesis, correction routing, closeout, or continuation by the frozen route.
- Missing decisive validation basis opens the named blocker owner/action before verdict work continues.

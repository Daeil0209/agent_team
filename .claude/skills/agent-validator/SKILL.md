---
name: agent-validator
description: Agent-specific validator lane skill for consequential validator-owned final evidence-based validation or PASS/HOLD/FAIL verdict assignments. Excludes receipt-only, narrow status, cleanup-only, phase-transition-only, and clarification-only messages.
user-invocable: false
PRIMARY-OWNER: validator
---
## Structural Contract
- Sharpens only its owned validation surface.
- Structural Contract internal gates: Scope & Quality Gate, PASS Gate
- Fixed top-level section order after Structural Contract: Preconditions, Validation Inputs, Validation Workflow, Blocked Validation, Active Communication Protocol
- PRIMARY-OWNER: validator
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/validator-lane-detail.md`: validator packet fields, verdict lenses, PASS prohibitions, reconciliation, operator-runtime/rendered-quality protocols, final-arbitration trigger definitions, final acceptance rejection packet detail, and completion detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the verdict still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the validation surface bounded and truthful?
3. Target fit: is the assigned surface a produced plan, design, implementation artifact, proof result, report, governance surface, or other acceptance target?
4. Charter fit: is this final verdict work or validator-authored correction-packet work after final acceptance rejection?
5. Feasibility: can this be completed inside the declared validation boundary and decisive evidence basis?
If any answer is `no`, classify as `scope-pressure` or `hold|blocker` before validation.
On assignment-grade work receipt, classify the packet per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake; validator-specific `reconstruct-with-inference` axes (beyond common owner/phase/proof/acceptance/deliverable) require unchanged validation target, validation surface, expectation sources, scope baseline, closure/oracle row, evidence authority, user-run path, tool basis, verdict burden, decision surface, user-facing acceptance basis, and upstream defer basis.
Assignment-grade validator correction packet after `FINAL-REJECT` executes bounded correction-basis analysis.
### PASS Gate
Validator-local PASS gate only.
Team-lead owns routing and cleanup decisions.
PASS requires retained evidence on the assigned target's decisive surface.
The decisive surface is the surface where the intended receiver runs, reads, operates, decides from, learns from, or presents the deliverable.
Validation target type selects the evidence profile:
- `executable-user-facing`: launch, access, interaction, completion, cleanup, relaunch, burden, `SCOPE-BASELINE`, and applicable `CORE-WORKFLOW-CLOSURE` evidence.
- `implementation`: runtime evidence when behavior is in scope; source/read evidence when the assigned target is source-read implementation quality.
- `plan` or `design`: request fit, design intent, owner/proof/acceptance chain, rule compliance, risk handling, and downstream executability evidence.
- `governance` or `report`: source/read integrity, rule force, owner boundary, cross-reference truth, claim truth, and reader clarity evidence.
- `human-consumed-artifact`: native-capable or format-faithful rendered evidence for layout, pagination, formulas, media, and reader burden when those are in scope.
- `proof-result` or `review-output`: method validity, surface match, claim strength, unresolved contradiction, and evidence-to-verdict support.
Per-target conditional PASS requirements live in `references/validator-lane-detail.md` `## PASS Prohibition Detail` and `### Operator-Exhaustive Integrity And Rendered Quality`.

## Preconditions
- Use only after team-lead assigns a bounded validation surface.
- Apply common agent-specific skill preconditions from `.claude/skills/task-execution/references/lane-additions.md`.
- Also consume the validator detail contract in `references/validator-lane-detail.md`.
- Produced plans and designs are valid validation targets only when they are the assigned acceptance target.
- Validate them as deliverables.
- Own bounded verdict arbitration, final acceptance rejection analysis, verdict-local evidence truth, validator correction packet writing after `FINAL-REJECT`, and validator-specific completion.
- When request-fit, user workflow, or promised usability materially shapes verdict strength, require the request-bound packet fields.
- Also require explicit run-path and burden fields.
- Request-fit, run-path, and burden fields require packet or artifact evidence.
- Reconstruct only when validation target, validation surface, expectation sources, scope baseline, closure/oracle row, evidence authority, upstream defer basis, and decisive evidence basis are anchored in packet or artifact evidence.
- Mark inferred pieces explicitly.
- Before blocking, derive safe facts from the frozen packet, task/workflow state, cited artifacts, or upstream completion.
- If expectation sources, review/test state, validation surface, decisive acceptance surface, decision surface, or user-facing acceptance basis remains materially ambiguous and non-derivable, send `hold|blocker` to `team-lead` via `SendMessage`.
- Choose the decisive proof tool from the assigned decisive acceptance surface.
- Source-state alone is decisive only when the frozen acceptance surface is the source/read document itself.
- For executable interactive web/UI deliverables, browser-surface proof is decisive by default.
- For those deliverables, tester evidence must come from a browser-proof path.
- For browser/UI final acceptance, available Playwright MCP is the default validation profile; absence of MCP use blocks PASS unless the packet freezes a narrower lawful tool or proves MCP unavailable.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, PASS depends on native-capable or format-faithful rendered/runtime evidence.
- This applies when layout, formulas, pagination, interaction, or visible burden are part of acceptance.
- Missing decisive-surface tooling routes to `hold|blocker` or `scope-pressure`.
- Send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Do this unless a frozen discovery/setup path already authorizes the exact next step.
- For executable user-facing programs, operator-exhaustive integrity is verdict-critical.
- Rendered visual quality is verdict-critical.
- Operator-runtime is verdict-critical.
- Exact launch/termination is verdict-critical.
- Cross-environment basis is verdict-critical.
- No-operator-labor is verdict-critical.
- Load `references/validator-lane-detail.md` when these rules affect PASS/HOLD/FAIL truth.
- See `references/validator-lane-detail.md` for packet detail, PASS-prohibition detail, reconciliation detail, and completion detail.

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
- Treat upstream defect labels only at their upstream claim strength; do not promote them locally.
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
Canonical PASS prohibitions, per-row inspection rules, decisive-surface evidence requirements, and subset-handling are owned by `references/validator-lane-detail.md` `## PASS Prohibition Detail`; consume that reference at verdict time.
Apply `Skill(review-verification)` before issuing PASS/HOLD/FAIL per the trigger below:
- Run full workflow (Steps 1-14) when the validation target is governance-asset change, multi-lane review synthesis, audit-grade verdict, defect classification, or patch-worthiness judgment. Cite the returned `review_verification_packet` fields `COHERENCE-RESULT`, `INTEGRITY-RESULT`, `NEGATIVE-RISK-RESULT`, and `PATCH-WORTHINESS` in the verdict.
- Run named lenses (`coherence-integrity-lens`, `negative-risk-lens`, `patch-worthiness-lens`) when the verdict materially depends on cross-surface coherence, negative risk, or patch fit. Cite each consumed lens result in the verdict.
- Skip lens application only when the validation target is single-surface direct evidence (e.g., a UI button click producing a captured screenshot) with no cross-surface, governance, or patch-worthiness dependency; record skip basis in the verdict.
Verdict labels:
- `PASS`: all decisive expectations met on the decisive surface, no blocking findings, evidence sufficient; when the trigger above fires, the `review_verification_packet` Step 5 Critical Review Gate defeaters are tested and disproven.
- `HOLD`: ambiguity, missing prerequisite, unresolved contradiction, blocked decisive evidence, missing required workflow basis, or triggered `review_verification_packet` material defeater confirmed or open.
- `FAIL`: fundamental mismatch on the decisive acceptance surface, or triggered `review_verification_packet` confirms unresolved cross-surface conflict, owner-boundary breach, protected-function loss, or patch-unworthiness on the validated target.
- Subset-anchor PASS is procedurally invalid; PASS only on frozen scope or upstream-deferred basis per the reference.
### 7. Retest And Self-Check
- Retry Guard rules live in `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions`.
- Validator-specific material change includes changed validation surface, changed acceptance condition, or changed upstream state.
### 8. Completion
- Apply the common completion contract from `.claude/skills/task-execution/references/completion-handoff.md` before validator-specific completion additions below.
- Return verdict-local truth only: validated surface, decisive evidence basis, open or mismatched surfaces, and the narrowest truthful next-lane/action candidate.
- Keep validator-specific reconciliation and proof-match fields explicit and truthful.
- `matched` and `PASS` are reserved for real acceptance alignment on that exact surface.
- Keep every validator-specific status axis explicit.
- Use `not-applicable:<basis>` instead of omission only when the validator reference allows that listed status axis to be outside the frozen validation surface.
- When the verdict depends on an executed user surface, keep the decisive proof method explicit.
- Name the concrete tool path used and the execution evidence observed.
- See `references/validator-lane-detail.md` for validator-specific completion detail.

## Blocked Validation
- Use `MESSAGE-CLASS: hold|blocker` when decisive assignment basis is missing before truthful validation can continue.
- Use `VERDICT: HOLD` only after bounded validation establishes blocked acceptance.
- Valid HOLD causes: missing, contradictory, blocked, or insufficient evidence.
- Missing review or test evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact missing owner.
- Contradictory upstream evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact contradiction and resolution owner.
- Environmental blocker: report it as environmental, not as soft PASS.
- Missing decisive evidence before a truthful verdict pass can run is `hold|blocker`, not `scope-pressure`, unless the planning shape itself is defective.
- A missing field triggers `MESSAGE-CLASS: hold|blocker` only when it is decisive and non-derivable from frozen packet, task/workflow state, cited artifacts, or upstream completion.
- Derivable gaps are reconstructed with marked inference.
- Partly derivable gaps narrow the verdict surface and remain open.
- Send it to `team-lead` via `SendMessage`.
- Include exact missing fields, blocker basis, and safe next step.

## Active Communication Protocol
- Validator-specific blocker: missing validation basis, blocked verdict basis, or missing decisive evidence.
- Inference requires explicit marking and safe decisive basis.
- Use exact `MESSAGE-CLASS: hold|blocker` for blocked verdict.
- Completion uses `completion` only for converged validator-owned verdict work.
- Final acceptance rejection analysis uses `completion` with `OUTPUT-SURFACE: validator correction packet`.

## Resolve Next Owner And Action
- `PASS`, `HOLD`, or `FAIL` opens team-lead synthesis, correction routing, closeout, or continuation by the frozen route.
- Missing decisive validation basis opens the named blocker owner/action before verdict work continues.

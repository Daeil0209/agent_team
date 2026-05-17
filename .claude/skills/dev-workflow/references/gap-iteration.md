# dev-workflow: Gap Detection And Iteration
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Use this reference for Phase 1 YAGNI review, Phase 4 design-implementation gap detection, Phase 5 iteration protocol, and rendered/user-surface gap feedback.

## Contents
- YAGNI Scope Review
- Gap Detection Dimensions
- Structural Check
- Functional Check
- Contract Check
- User-Readiness Principle
- Coverage Signals
- Gap Classification
- Iteration Protocol Detail
- Gap-State Packet
- Gap Detection Self-Growth
- Resolve Next Owner And Action

## YAGNI Scope Review
Runs in Phase 1 before CP2.

Procedure:
1. List proposed features, components, and scope items from the plan.
2. Judge from frozen purpose and evidence whether each item is essential for the core problem or nice-to-have.
3. Classify each item as:
   - MUST: blocks core value and remains in current scope
   - IMPROVE: improves the result while remaining outside core-blocking scope
   - DEFER: nice-to-have
   - OUT: out of current scope
4. Remove DEFER and OUT items from current plan scope.
5. Record removed items as future backlog.

Advance to CP2 only after scope inflation review is complete.
Treat unreviewed scope inflation as compounding risk across design, implementation, review, proof, and validation.

## Gap Detection Dimensions
Phase 4 gap detection separates:
- structural gaps
- functional gaps
- contract gaps
- delivery-experience gaps
- user-readiness gaps

Blocking gaps include missing components.
Missing proof on the required user surface is independently blocking.
Compare against the frozen `SCOPE-BASELINE`.
Treat implemented `ACTIVE-SLICE` as insufficient baseline evidence.
Treat missing, stubbed, placeholder-only, or unproven baseline items as blocking.
Honor explicit deferrals from the original frozen request, plan, or design.

## Structural Check
For each component in the design, verify:
1. Does the file or module exist?
2. Does the class, function, or namespace match the designed structure?
3. Are the parent component and all sub-components present?

Defect signal: design-defined component missing corresponding implementation artifact.

## Functional Check
For each component, verify:
1. Does implementation cover the primary use case described in design?
2. Are error paths and edge cases from design present in code?
3. Does observable behavior beyond source presence match designed behavior?

Defect signal: component exists structurally and fails its designed function.

## Contract Check
For each interface, format, or dependency boundary, verify:
1. Does the producing surface match designed inputs, outputs, and error states?
2. Does the consuming surface match the same contract?
3. Are shared meanings, field names, runtime data shapes, and generated or audited type sources consistent across the boundary?

Defect signal: contract mismatch between design and either producer or consumer.

## User-Readiness Principle
Verify:
- exact launch artifact plus invocation evidence, stop/cleanup, and clean re-launch path when executable
- core workflows and all frozen in-scope features/surfaces/controls
- persistence, restart, and error handling when in scope
- tester proof surface and validator acceptance surface aligned to the same resolved interaction/control inventory

## Coverage Signals
Scale implementation-completeness signals by deliverable type per `.claude/skills/dev-workflow/references/phase-surfaces.md`.
Use implementation-completeness signals as team-lead judgment inputs.
A single blocking defect blocks advancement regardless of completeness signal.
Full coverage still requires reviewer and tester sign-off on the acceptance chain.

## Gap Classification
Reviewer classifies each gap:

| Class | Definition | Iteration required |
|-------|------------|-------------------|
| Blocking | Missing component, broken contract, missing user-surface proof, or failure to implement primary use case | Reopen the correction loop until governing evidence reclassifies the gap |
| Non-blocking | Minor behavioral gap, cosmetic mismatch, or deviation without user-surface, acceptance, data, security, or workflow impact | Record in report |
| Deferred | Design decision intentionally outside this iteration | Record under follow-up |

When a gap is Blocking at P0 or P1 severity, escalate through `.claude/skills/dev-workflow/references/incident-response.md`.
Classify P0/P1 gaps as incident-response candidates.

## Iteration Protocol Detail
`dev-workflow` Phase 5 owns iteration structure and convergence truth.
Gap detection contributes Phase-2-derived acceptance-grade correction contract fields as contribution evidence.

Per-cycle gap detection contribution after authoritative corrected output and before tester re-verify:
1. Reviewer reruns structural, functional, contract, delivery-experience, and user-readiness checks scoped to affected components.
2. Reviewer reapplies the gap classification table to remaining or newly introduced gaps.
3. Coverage score, blocking-gap count, required return evidence, and acceptance-entry condition feed Phase 5 continue, root-cause escalation, or `HOLD` decision.

Reviewer quick-check stays blocking-only and delta-scoped.
Unclear delta raises `scope-pressure` and preserves delta scope.
Tester re-verifies affected surfaces before stale interaction rows.
Validator re-validates affected acceptance surfaces when final acceptance remains validator-required.
A prior validator `PASS` is stale for surfaces changed by correction until validator marks them current or issues a fresh `PASS`.
Same-class blocking gaps on different surfaces count as repeated same-class blocking gaps.
Repeated same-class blocking gaps escalate to root-cause classification.
Independent correction surfaces are split by correcting owner and run in parallel when owner, proof, acceptance, dependency, and merge boundaries remain unchanged.

## Gap-State Packet
Whenever blocking or significant gap findings move to `dev-workflow`, reviewer, tester, or team-lead, carry only decisive fields needed to route correction to acceptance:
- `GAP-STATE`
- `ROOT-CAUSE-CLASS`
- `FROZEN-DESIGN-EXPECTATION`
- `CHECKED-SURFACE`
- `DECISIVE-USER-SURFACE`
- `BLOCKING-GAPS`
- `NON-BLOCKING-GAPS`
- `DEFERRED-GAPS`
- `COVERAGE-SCORE-DISTRIBUTION`
- `EVIDENCE-BASIS`
- `CORRECTION-OWNER-SURFACE`
- `REQUIRED-RETURN-EVIDENCE`
- `REVERIFY-OWNER-ACTION`
- `ACCEPTANCE-ENTRY-CONDITION`
- `NEXT-OWNER-ACTION`
- `OPEN-SURFACES`

Preserve reviewer, tester, and validator state as the owning state.
Treat local gap-detection classification as contribution evidence.
Close a re-classified gap state only through the owning downstream agent.

## Gap Detection Self-Growth
Open workflow hardening when repeated missed gaps, repeated YAGNI failure, repeated phase drift, repeated bottlenecking after decomposition, or repeated source-only substitution appears.

## Resolve Next Owner And Action
- Blocking gap opens CP5 route classification.
- P0/P1 gap opens `incident-response`.
- Phase 5 gap contribution opens correction owner with required return evidence.
- Corrected output opens reviewer quick-check and tester re-verification.
- Cleared blocking gaps open validator ingress when final acceptance remains validator-required.
- Fresh or still-current validator `PASS` opens Final Acceptance Review by acceptance path.
- Repeated same-class blocking gap opens root-cause classification.
- Repeated missed-gap pattern opens `self-growth-sequence`.

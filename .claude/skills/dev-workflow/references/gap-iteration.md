# dev-workflow: Gap Detection And Iteration
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this reference for Phase 1 YAGNI review, Phase 4 design-implementation gap detection, Phase 5 iteration protocol, and rendered/user-surface gap feedback.

The former top-level `gap-detect` skill name is absorbed here. Do not keep a separate top-level skill folder for gap detection; consume gap detection through `dev-workflow` and this reference only.

## YAGNI Scope Review
Runs in Phase 1 before CP2.

Procedure:
1. List proposed features, components, and scope items from the plan.
2. For each item ask whether it is essential for the core problem or nice-to-have.
3. Classify each item as:
   - MUST: blocks core value and remains in current scope
   - SHOULD: improves the result but is not essential
   - COULD: nice-to-have
   - WON'T: out of current scope
4. Remove COULD and WON'T items from current plan scope.
5. Record removed items as future consideration.

Do not advance to CP2 with unreviewed scope inflation. Scope inflation in the plan compounds in design, implementation, review, proof, and validation.

## Gap Detection Dimensions
Phase 4 gap detection separates:
- structural gaps
- functional gaps
- contract gaps
- delivery-experience gaps
- user-readiness gaps

Blocking gaps are not only missing components. Missing proof on the required user surface is independently blocking.

## Structural Check
For each component in the design, verify:
1. Does the file or module exist?
2. Does the class, function, or namespace match the designed structure?
3. Are all sub-components present, not only the parent?

Defect signal: component defined in design has no corresponding implementation artifact.

## Functional Check
For each component, verify:
1. Does implementation cover the primary use case described in design?
2. Are error paths and edge cases from design present in code?
3. Does observable behavior match designed behavior, not just source presence?

Defect signal: component exists structurally but does not perform its designed function.

## Contract Check
For each interface or API point, verify:
1. Does server implementation match designed inputs, outputs, and error codes?
2. Does client consumption match the same contract?
3. Are data shapes, field names, and types consistent across the boundary?

Defect signal: contract mismatch between design and either producer or consumer.

## User-Readiness Principle
Verify:
- real launch/start path
- core workflows and all in-scope user-visible controls
- persistence, restart, and error handling when in scope
- tester proof surface and validator acceptance surface aligned to the same resolved interaction/control inventory

## Coverage Score Per File
Coverage scores are signals for team-lead judgment, not automatic thresholds.

| Score | Meaning |
|-------|---------|
| 0 | Not started or empty |
| 20 | Skeleton only: stubs, no logic |
| 40 | Basic structure: partial logic, key paths incomplete |
| 60 | Real logic present: key paths work, some requirements missing |
| 80 | Most requirements implemented: minor gaps only |
| 100 | Fully implements designed behavior |

A single blocking defect at score 90 still blocks advancement. Full coverage at score 100 still requires reviewer and tester sign-off on the acceptance chain.

## Gap Classification
Reviewer classifies each gap:

| Class | Definition | Iteration required |
|-------|------------|-------------------|
| Blocking | Missing component, broken contract, missing user-surface proof, or failure to implement primary use case | Yes, unless user accepts at CP5 |
| Non-blocking | Minor behavioral gap, cosmetic mismatch, or low-risk deviation | No, but record in report |
| Deferred | Design decision intentionally not implemented in this iteration | No, but document under follow-up |

When a gap is Blocking at T0 or T1 severity, escalate through `.claude/skills/dev-workflow/references/incident-response.md`. T0/T1 gaps are not normal iteration candidates.

## Iteration Protocol Detail
`dev-workflow` Phase 5 owns iteration cycle structure, cycle counter, and cycle limits. Gap detection contributes re-classification only.

Per-cycle gap detection contribution after developer fix and before tester re-verify:
1. Reviewer reruns structural, functional, contract, delivery-experience, and user-readiness checks scoped to affected components.
2. Reviewer reapplies the gap classification table to remaining or newly introduced gaps.
3. Coverage score and blocking-gap count feed Phase 5 continue-or-escalate decision.

Reviewer quick-check stays blocking-only. Tester re-verifies affected surfaces first, then stale interaction rows. The same unresolved blocking gap class after repeated cycles escalates instead of looping.

## Gap-State Packet
Whenever gap findings move to `dev-workflow`, reviewer, tester, or team-lead, carry only decisive fields:
- `GAP-STATE`
- `CHECKED-SURFACE`
- `BLOCKING-GAPS`
- `NON-BLOCKING-GAPS`
- `DEFERRED-GAPS`
- `COVERAGE-SCORE-DISTRIBUTION`
- `EVIDENCE-BASIS`
- `NEXT-OWNER`
- `OPEN-SURFACES`

Do not replace reviewer, tester, or validator state with local gap-detection classification. A re-classified gap state is not closed by the agent that produced it.

## Gap Detection Self-Growth
Open workflow hardening when repeated missed gaps, repeated YAGNI failure, repeated phase drift, repeated bottlenecking after decomposition, or repeated source-only substitution appears.

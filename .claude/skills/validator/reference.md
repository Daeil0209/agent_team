---
name: validator-reference
PRIMARY-OWNER: validator
auto-inject: false
---
# Validator Reference
## Auto-inject
false — load explicitly when packet detail, PASS-prohibition detail, reconciliation detail, or handoff detail is needed.

## Validator Packet Detail
- Consequential validator packets should keep these fields explicit:
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

## PASS Prohibition Detail
PASS is prohibited when any decisive acceptance surface remains:
- blocked
- mismatched
- partially matched
- not assessable
- unreconciled across review and test
- unsupported by required workflow authority
- unsupported by required user-facing launch, interaction, or burden evidence

## Acceptance Reconciliation Detail
- `ACCEPTANCE-RECONCILIATION` is explicit only when review truth, proof truth, user-facing acceptance, and burden/run-path evidence have been reconciled on the same decisive surface.
- Contradictory upstream evidence stays `HOLD` until explicitly reconciled; do not silently prefer the optimistic lane.
- If tester or reviewer evidence is weaker than the requested verdict, downgrade the verdict rather than upgrading the evidence.

## Validator Handoff Detail
- Keep these validator-specific fields explicit when applicable:
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `PROOF-SURFACE-MATCH`
  - `RUN-PATH-STATUS`
  - `CORE-WORKFLOW-STATUS`
  - `INTERACTION-COVERAGE-STATUS`
  - `BURDEN-STATUS`
  - `ACCEPTANCE-RECONCILIATION`
- `matched` and `PASS` are reserved for true acceptance alignment on that exact surface.
- If available evidence is useful but not sufficient for PASS, keep it and downgrade truthfully to `HOLD`, `partial`, `mismatched`, or `blocked` rather than softening into pass-like language.

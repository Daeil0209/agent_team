---
name: tester-reference
PRIMARY-OWNER: tester
auto-inject: false
---
# Tester Reference
## Auto-inject
false — load explicitly when packet detail, interaction-coverage detail, human-facing checklist detail, or handoff detail is needed.

## Tester Packet Detail
- Consequential tester packets should keep these fields explicit:
  - `PROOF-TARGET`
  - `PROOF-EXPECTATION`
  - `PROOF-SURFACE`
- Keep these runtime-context additions explicit when applicable:
  - `ENV-BASIS`
  - `SCENARIO-SCOPE`
- Keep one truthful tool path explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
- Keep these delivery-contract additions explicit when applicable:
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`

## Interaction Coverage
- For executable, user-facing software, keep an interaction-coverage matrix explicit.
- Each in-scope control must end in exactly one explicit state:
  - directly proven
  - disproven
  - blocked
  - out-of-scope by dispatch
- Navigation-only or indirect evidence does not justify `matched` interaction coverage when direct interaction remained required.

## Human-Facing Checklist
- Page image / visual layout captured when rendered usefulness matters
- First-glance comprehension assessed when reader-first usefulness matters
- Package validity and openability verified for office-format artifacts
- Per-page rendered evidence kept separate from text-level proof for page-read artifacts
- Rendered evidence kept distinct from wording, logic, and request-fit review

## Tester Handoff Detail
- Keep these tester-specific fields explicit when applicable:
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `PROOF-SURFACE-MATCH`
  - `RUN-PATH-STATUS`
  - `CORE-WORKFLOW-STATUS`
  - `INTERACTION-COVERAGE-STATUS`
  - `BURDEN-STATUS`
- `matched` is reserved for true contract alignment on that exact surface.
- If executed proof makes the frozen validator contract untruthful, keep `TEST-STATE: hold|blocked` and explain the contradiction in `OPEN-SURFACES` instead of silently mutating the validator basis.

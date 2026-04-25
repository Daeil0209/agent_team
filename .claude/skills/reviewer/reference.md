---
name: reviewer-reference
PRIMARY-OWNER: reviewer
auto-inject: false
---
# Reviewer Reference
## Auto-inject
false — load explicitly when packet detail, lens detail, severity mapping, or handoff detail is needed.

## Reviewer Packet Detail
- Consequential reviewer packets should keep these fields explicit:
  - `REVIEW-SCOPE`
  - `REVIEW-TARGET`
  - `PREREQ-STATE`
  - `EVIDENCE-BASIS`
  - `ACCEPTANCE-RISK`
  - `ACCEPTANCE-SURFACE`
  - `PRIOR-ANALYSIS`

## Domain Lenses
- Evidence quality
- Logical rigor
- Software quality
- Security
- Realizability
- Human-facing clarity
- Operational correctness
- Failure/risk
- UX
- Business logic
- Report/document quality
- Contextual consistency
Use only the lenses that materially affect the assigned surface.

## Severity Mapping
| Severity | Meaning |
|---|---|
| Critical | Must fix before further progress; escalate immediately when the defect implies system halt, data loss, credential exposure, destructive or irreversible damage, or unacceptable user harm risk |
| Major | Must fix before this stage passes |
| Minor | Should fix, does not block |
| Advisory | Observation only |

## Reviewer Handoff Detail
- If runnable proof is still required, keep `tester` explicit as the proof owner.
- If final validation is materially required, keep the validator ingress contract explicit:
  - `VALIDATION-TARGET`
  - `EXPECTATION-SOURCES`
  - `VALIDATION-SURFACE`
- Keep `DECISION-SURFACE` explicit when validator arbitration still needs a distinct decisive surface or multi-surface reconciliation.
- Keep these validator additions explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
- For request-bound acceptance, keep the request-fit contract explicit in the same handoff rather than rewriting it from memory.
- If review evidence makes the frozen contract untruthful, keep `REVIEW-STATE: hold|blocked` and explain the contradiction in `OPEN-SURFACES`.

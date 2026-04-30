---
name: reviewer-reference
PRIMARY-OWNER: reviewer
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Reviewer Reference
## Auto-inject
false — load explicitly when packet detail, lens detail, severity mapping, or handoff detail is needed.

## Role-Spine Handoff
`agents/reviewer.md` owns only the always-loaded reviewer charter, boundary, receipt trigger, stop rule, and review-local completion duty. This reference owns detailed reviewer packet fields, review lenses, severity mapping, specialist skill order, validator-ready handoff detail, and rendered/evidence gap detail.

When a reviewer role or skill says "reviewer additions" or "reviewer detail", consume this file directly. Do not re-expand `agents/reviewer.md` into a packet-field catalog. Missing decisive review detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless the review target and evidence basis are anchored in packet or artifact evidence.

Control packets, message classes, lifecycle truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the reviewer-specific payload and review discipline needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only. It does not replace an assignment-grade reviewer packet when new bounded review work is assigned.
- If phase context and assignment-grade work arrive in the same execution segment, consume the embedded phase context inside the assignment packet and send `dispatch-ack`, not a separate `control-ack`.
- `lifecycle-control` is lifecycle-only direction, not assignment or workflow-phase control. Acknowledge it with `control-ack` only when it materially affects active work, standby readiness, or shutdown path.

## Reviewer Packet Detail
- Consequential reviewer packets should keep these fields explicit:
  - `REVIEW-TARGET-TYPE` (`plan`, `design`, `implementation`, `proof-result`, `report`, `governance`, or another explicit artifact type)
  - `REVIEW-SCOPE`
  - `REVIEW-TARGET`
  - `PREREQ-STATE`
  - `EVIDENCE-BASIS`
  - `ACCEPTANCE-RISK`
  - `ACCEPTANCE-SURFACE`
  - `PRIOR-ANALYSIS`
- For plan review, also keep explicit when material:
  - `PLAN-CLAIM`
  - `ROUTE-BASIS`
  - `OWNER-MAP`
  - `PROOF-CHAIN`
  - `ACCEPTANCE-CHAIN`
  - `STOP-CONDITIONS`
- For design review, also keep explicit when material:
  - `DESIGN-INTENT`
  - `CONSTRAINTS`
  - `QUALITY-ATTRIBUTES`
  - `TRADEOFFS`
  - `INTERFACES`
  - `FAILURE-MODES`
  - `REGRESSION-RADIUS`

If these fields are missing and truthful review would require inventing them, use `MESSAGE-CLASS: hold|blocker` instead of guessing.

If truthful review needs a tool, rendered surface, or setup path unavailable to reviewer, the upward request to `team-lead` must include the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`. Do not replace a required rendered or executable review surface with source-only evidence.

## Domain Lenses
- Evidence quality
- Logical rigor
- Software quality
- Security
- Architecture/design tradeoff
- Plan feasibility and owner boundary
- Realizability
- Human-facing clarity
- Operational correctness
- Failure/risk
- UX
- Business logic
- Report/document quality
- Contextual consistency
Use only the lenses that materially affect the assigned surface.

## Applied Review Techniques
- Peer-inspection discipline: verify entry information, inspect the actual work product, record defects, require rework/follow-up evidence for blocking defects.
- Architecture/design tradeoff review: evaluate quality attributes, constraints, sensitivity points, tradeoffs, risks, and risk themes rather than only local correctness.
- Code/change review lens: check design, functionality, complexity, tests, naming, comments, documentation, every assigned line or declared reviewed subset, and system context.
- Security review lens: manual security judgment remains necessary for security-sensitive surfaces; scanners or source-only checks do not replace human review of trust boundaries, threat paths, unsafe defaults, secrets, injection, authz/authn, and data exposure.
- Negative-space review: look for required but missing constraints, evidence, edge cases, owner handoffs, user paths, rollback/cleanup paths, and acceptance/proof surfaces.
- Expert claim challenge: convert each major claim into `claim -> evidence -> impact -> owner -> required change`; do not accept unsupported confidence language.

## Severity Mapping
| Severity | Meaning |
|---|---|
| Critical | Must fix before further progress; escalate immediately when the defect implies system halt, data loss, credential exposure, destructive or irreversible damage, or unacceptable user harm risk |
| Major | Must fix before this stage passes |
| Minor | Should fix, does not block |
| Advisory | Observation only |

Specialist skill output is not automatically advisory. `security-review` and `code-quality-review` findings use this same severity mapping; remediation stays with the producing owner.

## Specialist Skill Loading
Specialist skills with `PRIMARY-OWNER: reviewer` load only via packet `REQUIRED-SKILLS`, `SKILL-AUTH`, or verified phase-local refinement:
- `code-quality-review` - SOLID checklist, duplication taxonomy, refactoring priority. SECONDARY-CONSUMER: developer.
- `security-review` - OWASP checklist, detection patterns, severity framework.

When both are active on one review surface, run `security-review` first because security findings can block acceptance regardless of code quality, then `code-quality-review`. They are review lenses; findings use normal severity and may be blocking. Remediation stays with the producing owner.

## Reviewer Handoff Detail
- Reviewer authoritative handoff blocks (`MESSAGE-CLASS: handoff`, `MESSAGE-CLASS: completion`, or exact `MESSAGE-CLASS: hold|blocker`) must include `REVIEW-STATE: ready|hold|blocked`.
- Use `ready` only when the assigned review scope is complete, decisive evidence supports the findings, and no blocking review defect remains.
- Use `hold` when review cannot truthfully complete because required basis, evidence, tool path, or upstream state is missing but resolvable.
- Use `blocked` when the assigned review surface cannot proceed under the frozen packet without replanning, rerouting, or upstream correction.
- If runnable proof is still required, keep `tester` explicit as the proof owner.
- If final validation is materially required, keep the validator ingress contract explicit:
  - `VALIDATION-TARGET-TYPE`
  - `VALIDATION-TARGET`
  - `EXPECTATION-SOURCES`
  - `REVIEW-STATE`
  - `TEST-STATE`
  - `VALIDATION-SURFACE`
- Keep `DECISION-SURFACE` explicit when validator arbitration still needs a distinct decisive surface or multi-surface reconciliation.
- Keep these validator additions explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
- For request-bound acceptance, keep the request-fit contract explicit in the same handoff rather than rewriting it from memory.
- If review evidence makes the frozen contract untruthful, set `REVIEW-STATE: hold` or `REVIEW-STATE: blocked` and explain the contradiction in `OPEN-SURFACES`.

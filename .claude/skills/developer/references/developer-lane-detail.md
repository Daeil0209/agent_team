---
name: developer-reference
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Developer Reference
## Auto-inject
false — load explicitly when packet detail, defect-fix detail, or handoff detail is needed.

## Role-Spine Handoff
`agents/developer.md` owns only the always-loaded developer charter, boundary, receipt trigger, stop rule, and lane-local completion duty. This reference owns the detailed developer packet fields, classification table, specialist matrix, defect-fix detail, and handoff detail.

When a developer role or skill says "developer additions" or "developer detail", consume this file directly. Do not re-expand `agents/developer.md` into a packet-field catalog. Missing decisive detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless the safe-inference rule below permits it.

Control packets, message classes, lifecycle truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the developer-specific payload needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only. It does not replace an assignment-grade developer packet when new bounded production work is assigned.
- If phase context and assignment-grade work arrive in the same execution segment, consume the embedded phase context inside the assignment packet and send `dispatch-ack`, not a separate `control-ack`.
- `lifecycle-control` is lifecycle-only direction, not assignment or workflow-phase control. Acknowledge it with `control-ack` only when it materially affects active work, standby readiness, or shutdown path.

## Required Dispatch Packet Fields
| Work Type | Required Fields |
|-----------|----------------|
| All developer-owned production | common base packet plus `PLAN-STATE`, `PLAN-STEP`, `CHANGE-SPEC`, `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`, `AGENT-FIT`, `SCOPE-MATCH`, `PRIOR-ANALYSIS`; `WRITE-SCOPE` when writes are path-bounded |
| Active `dev-workflow` plan/design artifact | `ACTIVE-WORKFLOW: dev-workflow`, `CURRENT-PHASE`, `WORK-SURFACE`, `PLAN-STATE`, `PLAN-STEP`, `CHANGE-SPEC`, `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`, `AGENT-FIT`, `SCOPE-MATCH`, `PRIOR-ANALYSIS` |
| Implementation edit | `PLAN-STATE`, `PLAN-STEP`, `CHANGE-SPEC`, `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`, `AGENT-FIT`, `SCOPE-MATCH`, `PRIOR-ANALYSIS`; `WRITE-SCOPE` when writes are path-bounded |
| Meaningful/high/critical risk | explicit acceptance pipeline: `REVIEW-OWNER: reviewer`, `PROOF-OWNER: tester`, `ACCEPTANCE-OWNER: validator` |
| Request-bound documents | `CHANGE-BOUNDARY` must declare first-draft, integration, merge-compress, or bounded correction surface |
| Manifest-sync | `TASK-CLASS`, `MANIFEST-UNIQUE`, `OVERLAP-REVIEW`, `PRE-EXEC-REVIEW`, `WRITE-SCOPE` |
| Governance-patch | `TASK-CLASS`, `CHANGE-BOUNDARY`, `WRITE-SCOPE` |

## Handoff Completeness Challenge
Developer must challenge decisive production basis before production. This is not a demand for all possible information; it is a hard gate against starting from an implied, incomplete, contradictory, wrong-owner, or overbroad packet.

Production discovery and edits are forbidden until the packet is classified as `execute` or `reconstruct-with-inference`. Developer must use the first lawful executable path that can satisfy the user instruction. `scope-pressure` and `hold|blocker` stop only the unsafe current path; they open the team-lead resolution loop, not task abandonment.

Minimum decisive production basis:
- `PLAN-STATE`
- `PLAN-STEP`
- `CHANGE-SPEC`
- `CHANGE-BOUNDARY`
- `DONE-CONDITION`
- `WRITE-SCOPE` when any file mutation is path-bounded
- `REQUIRED-SKILLS`
- `ACCEPTANCE-RISK`
- `REVIEW-OWNER`
- `PROOF-OWNER`
- `ACCEPTANCE-OWNER`
- `AGENT-FIT`
- `SCOPE-MATCH`
- `PRIOR-ANALYSIS`
- user-facing surface when it materially affects production
- first lane action
- stop condition

Decision table:
| State | Condition | Action |
|---|---|---|
| `execute` | Decisive basis is explicit, bounded, and owner-consistent | Proceed through workflow |
| `reconstruct-with-inference` | Missing detail is safely inferable without changing owner, phase, proof burden, acceptance burden, deliverable shape, or write scope | Reconstruct explicitly, mark inference, then proceed |
| `scope-pressure` | Packet is too wide, mixed-phase, wrong-owner, shardable, hides a prerequisite, or smuggles review/proof/validation into production | Stop the unsafe path; send pressure to `team-lead` via `SendMessage` with smallest truthful production boundary and next executable step |
| `hold|blocker` | Write scope, authority, acceptance contract, production-phase basis, decisive production basis, or smallest truthful implementation boundary is materially ambiguous | Stop the unsafe path; send `MESSAGE-CLASS: hold|blocker` to `team-lead` via `SendMessage` with exact invalid or missing basis and what is needed to resume |

Upward assertion must name:
- exact constraint or missing decisive basis
- attempted or available execution path
- why current execution cannot continue truthfully
- smallest truthful production boundary
- safe next packet correction, research/setup need, or next owner

Tool/setup gap assertion must also name the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md` when production needs a tool, dependency setup, runtime bridge, or evidence surface outside the frozen packet boundary.

Resolution loop:
- Developer reports constraints immediately instead of waiting, guessing, or abandoning the task.
- `team-lead` consumes the report, routes researcher/tool/setup/packet correction as needed, and returns a corrected executable path.
- Developer resumes execution from the corrected path and repeats the loop until the user instruction is completed or a genuine impossible/unsafe condition is proven.

Insufficient handoff examples:
- "Update the docs" without `CHANGE-BOUNDARY`, `DONE-CONDITION`, or excluded scope.
- "Fix the bug" without observed failure, write scope, proof owner, or retest expectation.
- "Implement the design" without artifact boundary, user-facing surface, or acceptance-risk basis.
- "Use the right skill" without `REQUIRED-SKILLS`, `SKILL-AUTH`, or safe phase-local refinement basis.

## Specialist Skill Loading
- Specialist capabilities live under the active skill root as a `skill-id` directory with its own `SKILL.md`; they do not live as active agent role files under `.claude/agents/`.
- `SKILL-AUTH` packets bind `skill-id` to the target lane plus blocked surface; developer resolves that against the active project skill root.
- `team-lead` may route developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- Use `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>` when governance-sensitive specialist skill routing basis must stay explicit.
- `SKILL-AUTH` is for explicit routing/traceability. `SKILL-RECOMMENDATIONS` is for methodology guidance inside an already bounded development production surface.
- Load specialist skills only via packet `REQUIRED-SKILLS`, `SKILL-AUTH`, or verified phase-local refinement. Do not load by habit, by general expertise, or because a skill exists.

Specialist skills with `PRIMARY-OWNER: developer`:
- business and operations: `business-workflow`
- architecture: `software-architecture`, `enterprise-architecture`
- domain grounding: `instructional-design`, `engineering-grounding`, `mathematical-correctness`
- document and visual production: `document-automation`, `visual-composition`
- UI implementation: `mockup-to-component`, `design-system-tokens`
- support overlays: `benchmark-simulation`, `external-tool-bridge`

When multiple specialists are active on one blocked surface, the controlling order is: `business-workflow` -> `software-architecture` -> domain specialists (`instructional-design`, `engineering-grounding`, `mathematical-correctness`) -> `enterprise-architecture` -> `document-automation` -> `visual-composition` -> UI implementation specialists (`mockup-to-component`, `design-system-tokens`). `benchmark-simulation` and `external-tool-bridge` are support overlays without controlling-chain position; they may evaluate or integrate without overriding earlier controlling contracts.

## Durability Gate
| Fix type | Definition | Action |
|---|---|---|
| root-cause | Addresses a verified origin | Proceed |
| symptom-relief | Reduces impact without proving origin | Proceed and disclose |
| hypothesis-based | Plausible but unconfirmed cause | Proceed and keep verification basis explicit |
| open | Cause unknown | internal `HOLD`; if reporting upward, emit `MESSAGE-CLASS: hold|blocker` with the missing root-cause basis and safe next step |

## Regression Guard
- Trigger when `TASK-CLASS: defect-fix` or the assignment is clearly an observed defect correction.
- Default: build a failing guard before the target correction, confirm fail, correct, confirm pass, keep the guard.
- Fallback: if guard creation is impossible or disproportionate, record `FALLBACK-BASIS` and keep the retest surface explicit.
- Non-skip: no silent correction-only path.

## Developer Handoff Detail
- Keep applied changes, executed checks, unrun or blocked checks, and unresolved assumptions separated so downstream lanes do not reconstruct implementation truth from the diff alone.
- Include `PREREQ-STATE: complete|partial|missing` in consequential upward handoff so downstream lanes do not infer prerequisite truth.
- For request-bound artifacts, state whether the applied change preserved the answer surface, deliverable shape, and excluded-scope boundary expected by the packet.

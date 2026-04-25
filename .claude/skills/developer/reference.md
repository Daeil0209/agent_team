---
name: developer-reference
PRIMARY-OWNER: developer
auto-inject: false
---
# Developer Reference
## Auto-inject
false — load explicitly when packet detail, defect-fix detail, or handoff detail is needed.

## Required Dispatch Packet Fields
| Work Type | Required Fields |
|-----------|----------------|
| All developer-owned production | common base packet plus `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`; `WRITE-SCOPE` when writes are path-bounded |
| Active `dev-workflow` plan/design artifact | `ACTIVE-WORKFLOW: dev-workflow`, `CURRENT-PHASE`, `WORK-SURFACE`, `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER` |
| Implementation edit | `CHANGE-BOUNDARY`, `DONE-CONDITION`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`; `WRITE-SCOPE` when writes are path-bounded |
| Meaningful/high/critical risk | explicit acceptance pipeline: `REVIEW-OWNER: reviewer`, `PROOF-OWNER: tester`, `ACCEPTANCE-OWNER: validator` |
| Request-bound documents | `CHANGE-BOUNDARY` must declare first-draft, integration, merge-compress, or bounded correction surface |
| Manifest-sync | `TASK-CLASS`, `MANIFEST-UNIQUE`, `OVERLAP-REVIEW`, `PRE-EXEC-REVIEW`, `WRITE-SCOPE` |
| Governance-patch | `TASK-CLASS`, `CHANGE-BOUNDARY`, `WRITE-SCOPE` |

## Specialist Skill Loading
- Specialist capabilities live as skills under `.claude/skills/{skill-id}/SKILL.md`, not as active subagents under `.claude/agents/`.
- `SKILL-AUTH` packets bind `skill-id` to the target lane plus blocked surface; developer resolves that against the active project skill root.
- `team-lead` may route developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- Use `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>` when governance-sensitive specialist skill routing basis must stay explicit.
- `SKILL-AUTH` is for explicit routing/traceability. `SKILL-RECOMMENDATIONS` is for methodology guidance inside an already bounded development production surface.

## Durability Gate
| Fix type | Definition | Action |
|---|---|---|
| root-cause | Addresses a verified origin | Proceed |
| symptom-relief | Reduces impact without proving origin | Proceed and disclose |
| hypothesis-based | Plausible but unconfirmed cause | Proceed and keep verification basis explicit |
| open | Cause unknown | `HOLD` |

## Regression Guard
- Trigger when `TASK-CLASS: defect-fix` or the assignment is clearly an observed defect correction.
- Default: build a failing guard before the target correction, confirm fail, correct, confirm pass, keep the guard.
- Fallback: if guard creation is impossible or disproportionate, record `FALLBACK-BASIS` and keep the retest surface explicit.
- Non-skip: no silent correction-only path.

## Developer Handoff Detail
- Keep applied changes, executed checks, unrun or blocked checks, and unresolved assumptions separated so downstream lanes do not reconstruct implementation truth from the diff alone.
- For request-bound artifacts, state whether the applied change preserved the answer surface, deliverable shape, and excluded-scope boundary expected by the packet.

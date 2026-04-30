# dev-workflow: Incident Response
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this reference when T0/T1 severity, implementation regression, unexpected failure, launch-path failure, or incident-related phase transition appears inside `dev-workflow`.

The former top-level `incident-response` skill name is absorbed here. Do not keep a separate top-level skill folder for incident response; consume incident response through `dev-workflow` and this reference only.

## Activation Boundary
Load incident detail when:
- an error, regression, or unexpected failure is detected during or after implementation
- user-reported first-view or launch-path failure appears
- incident context changes a dev-workflow phase state and requires phase transition notification

General dev-workflow phase transitions without incident context use `dev-workflow` plus `.claude/skills/task-execution/references/phase-transition-control.md`; they do not load incident-response by ceremony.

## Incident Response Workflow
1. Detection and classification
- Identify the failed surface: error log, test failure, user report, monitoring alert, launch failure, or rendered/user-facing failure.
- Classify severity:
  - T0: system halt, production down, data loss risk, or equivalent stop condition
  - T1: governance block, core feature broken, launch-path failure, or work that must be fixed before continuation
  - T2: quality gate defect that can be fixed in the current iteration cycle
  - T3: advisory issue to record and schedule

2. Impact analysis
- Name affected components, services, workflows, users, downstream work, and regression risk.
- User-reported first-view or launch-path failure is blocking until reproduced or disproven on the intended user surface.

3. Fix proposal
- Developer proposes root cause, bounded file/surface change, fix risk, and verification plan.
- Team-lead reviews the proposal before routing execution.
- User-facing escalation is required for T0/T1 severity.
- Explicit user approval before modification is required only when the proposed action is destructive, security-sensitive, externally committed, or a policy choice.

4. Apply and verify
- Developer applies the reviewed bounded fix.
- Tester verifies the fix resolves the incident on the decisive proof surface.
- Reviewer confirms no regression was introduced.
- If the fix fails, return to fix proposal. After three failed attempts, escalate instead of looping.

5. Post-incident record
- Record what happened, root cause, fix applied, time or cycles to resolution, and whether a recurrence barrier is needed.
- If prevention was possible and the missed check is recurring or material, open `Self-Growth Sequence` on the narrowest owner surface.

## Phase Transition Notification
Phase transitions during incident response use the canonical `phase-transition-control` packet defined in `.claude/skills/task-execution/references/phase-transition-control.md`. Do not author a parallel notification format here.

Incident response contributes only incident-context fields:
- severity tier T0-T3
- blast-radius summary
- root-cause status: proposed, approved, applied, or verified
- carried-forward blocking issues from the prior phase

Broadcasting, agent acknowledgment, and structured-vs-freeform discipline live with the canonical packet contract.

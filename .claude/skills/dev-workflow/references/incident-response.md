# dev-workflow: Incident Response
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use this reference when P0/P1 severity, implementation regression, unexpected failure, launch-path failure, or incident-related phase transition appears inside `dev-workflow`.

## Activation Boundary
Load incident detail when:
- an error, regression, or unexpected failure is detected during or after implementation
- user-reported first-view or launch-path failure appears
- incident context changes a dev-workflow phase state and requires incident phase-cursor context

General dev-workflow phase transitions without incident context use `dev-workflow` plus `.claude/skills/task-execution/references/phase-transition-control.md`; they do not load incident-response by ceremony.

## Incident Response Workflow
1. Detection and classification
- Identify the failed surface: error log, test failure, user report, monitoring alert, launch failure, or rendered/user-facing failure.
- Classify severity:
  - P0: system halt, production down, data loss risk, or equivalent stop condition
  - P1: governance block, core feature broken, launch-path failure, or work that must be fixed before continuation
  - P2: quality gate defect that can be fixed in the current iteration cycle
  - P3: issue to record and schedule
- T-labels at adjacent surfaces (checkpoints, dev-workflow trigger-bound references, monitoring-lifecycle-detail) map to P-labels: T0 = P0, T1 = P1, T2 = P2; the same severity definitions apply.

2. Impact analysis
- Name affected components, services, workflows, users, downstream work, and regression risk.
- User-reported first-view or launch-path failure is blocking until reproduced or disproven on the intended user surface.

3. Fix proposal
- Developer proposes root cause, bounded file/surface change, fix risk, and verification plan.
- Team-lead reviews the proposal before routing execution.
- P0/P1 severity reports a user-facing blocker or incident surface while non-destructive fix routing continues through the owning path.
- User-escalation triggers are owned by `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.

4. Apply and verify
- Developer applies the reviewed bounded fix.
- Tester verifies the fix resolves the incident on the decisive proof surface.
- Reviewer confirms no regression was introduced.
- If the fix fails, return to fix proposal. After three failed attempts, escalate instead of looping.

5. Post-incident record
- Record what happened, root cause, fix applied, time or cycles to resolution, and whether a recurrence barrier is needed.
- If prevention was possible and the missed check is recurring or material, open `Skill(governance-modification)` recurrence-hardening mode on the narrowest owner surface.

## Incident Phase Cursor Context
Phase transitions during incident response use the canonical `phase-transition-control` packet defined in `.claude/skills/task-execution/references/phase-transition-control.md`. Do not author a parallel notification format here.

Incident response contributes only incident-context fields:
- severity tier P0-P3
- blast-radius summary
- root-cause status: proposed, approved, applied, or verified
- carried-forward blocking issues from the prior phase

Broadcasting, agent acknowledgment, and structured-vs-freeform discipline live with the canonical packet contract.

## Resolve Next Owner And Action
- P0/P1 detection opens incident classification and user-facing blocker truth.
- Approved bounded fix opens developer correction.
- Applied fix opens tester proof on the decisive proof surface.
- Verified fix opens reviewer regression check.
- Failed fix returns to fix proposal.
- Three failed attempts open escalation instead of iteration.
- Recurring or material missed prevention opens `Skill(governance-modification)`.
- Verified incident resolution returns to the active dev-workflow phase cursor.

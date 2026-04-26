---
name: incident-response
description: Incident classification, fix proposal workflow, and phase transition notification for error and regression handling in the dev-workflow.
user-invocable: false
---

## Structural Contract

- PRIMARY-OWNER: team-lead
- Fixed section order:
  1. `Activation Criteria`
  2. `Incident Response Workflow`
  3. `Phase Transition Notification`
- Do not add new sections without explicit governance review.
- Keep section names stable when referenced by dev-workflow dispatch packets.
- Structural connectivity is immutable: new procedural content must remain attached to an owning section rather than appearing as free-floating doctrine.

# Incident Response Skill

This skill provides the incident response workflow and phase transition notification protocol for the dev-workflow. It governs how errors and regressions are detected, classified, and resolved, and how phase advances are broadcast to active workers.

## Activation Criteria

This skill is loaded alongside `dev-workflow` when:
- An error, regression, or unexpected failure is detected during or after implementation
- A phase transition broadcast is required (any phase advance in the dev-workflow)

team-lead may also direct loading via SKILL-AUTH.

Backup authorization (team-lead directed):
```
SKILL-AUTH: lane=team-lead; surface=incident-response|phase-transition-notification; skill=incident-response
```

---

## Incident Response Workflow

When an error or regression is detected during or after implementation:

**Step 1: Detection and Classification**
- Identify: What failed? (error log, test failure, user report, monitoring alert)
- Classify severity using team T0-T3 framework:
  - T0 (system halt): Production down, data loss risk → immediate escalation to user
  - T1 (governance block): Core feature broken → block further work, fix first
  - T2 (quality gate): Non-critical defect → fix in current iteration cycle
  - T3 (advisory): Minor issue → record and schedule

**Step 2: Impact Analysis**
- Scope: Which components/services are affected?
- Blast radius: How many users/features impacted?
- Dependencies: What downstream work is blocked?
- Regression check: Did this break something that previously worked?

**Step 3: Fix Proposal (NOT automatic)**
- Developer proposes fix with:
  - Root cause analysis
  - Proposed change (bounded, specific files)
  - Risk assessment of the fix itself
  - Verification plan
- Team-lead reviews proposal
- User approves if T0/T1 severity

**Step 4: Apply and Verify**
- Developer applies approved fix
- Tester verifies fix resolves the issue
- Reviewer confirms no regression introduced
- If fix fails, return to Step 3 (max 3 attempts, then escalate)

**Step 5: Post-Incident Record**
- Document: what happened, root cause, fix applied, time to resolution
- Identify: Could this have been prevented? If yes, what check/gate was missing?
- Update: Add prevention rule to relevant checklist if pattern is recurring

---

## Phase Transition Notification

Phase transitions during incident-response use the canonical `phase-transition-control` packet defined in `.claude/skills/task-execution/reference.md` § Downward Phase-Transition Control Packet. Do not author a parallel notification format here.

incident-response contributes incident-context fields into the canonical packet:
- severity tier (T0-T3 per `Incident Response Workflow`)
- blast-radius summary (affected components/services and downstream blocks)
- root-cause status (proposed / approved / applied / verified)
- carried-forward blocking issues from the prior phase

Broadcasting, worker acknowledgment, and structured-vs-freeform discipline all live with the canonical packet contract. Operators consume that contract for the wire format and use this skill only for the incident-context payload it specifies above.

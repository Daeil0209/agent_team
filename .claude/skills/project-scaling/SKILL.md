---
name: project-scaling
description: Project complexity classification and governance parameter scaling for calibrating governance depth at project start or when project complexity changes.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed section order: Activation, Project Complexity Classification, Governance Parameters Per Tier, Operational Guardrails, Task Classification Heuristic, Quality Metrics Integration, Deliverable Quality Philosophy Application, Role-Scoped Self-Growth Loop, Structural Feedback To Upstream, References
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Activation

Load this skill when starting work on a new project, when project scope expands materially, or when governance depth seems mismatched to actual complexity. Do NOT load this skill to replace the Primary Operating Loop, auto-apply governance gates without team-lead judgment, or override explicit user-confirmed tier decisions.

This skill is a **team-lead** common skill. It supplements `task-execution` Step 2: DETERMINE TIER — it does NOT replace the Primary Operating Loop. Per-request tier defaults to the project-level tier. It may adjust UP when the specific request has higher complexity or risk than the project baseline. It may adjust DOWN for explicitly bounded low-risk work (e.g., single-file clerical edits, isolated config changes) with explicit justification; in such cases the lower tier governs only the specific request. Detection heuristics are SUGGESTIONS — team-lead presents the suggestion; user confirms or overrides before governance parameters are applied. All quality metrics defined here are INPUT SIGNALS to team-lead judgment, not automatic gates. They do not replace the separated acceptance chain (`reviewer` → `tester` → `validator`).

## Project Complexity Classification

### Three-Tier Model

| Tier | Description | Typical Examples |
|---|---|---|
| **Lightweight** | Single feature, few files, no infrastructure, simple UI | Quick fixes, minor features, prototypes, config changes |
| **Standard** | Multi-file feature, API integration, moderate complexity | Typical feature development, BaaS integration, structured workflows |
| **Precision** | Microservices, infrastructure, security-sensitive, enterprise scale | Enterprise systems, multi-service architectures, compliance-critical work |

### Detection Heuristics (Suggestions Only)

> For Detection Heuristics table, see reference.md

### Classification Procedure

1. Inspect the active project root for structural signals above.
2. Form a suggested tier with rationale (1–2 sentences).
3. Present the suggestion to the user: "Based on [signal], I'd classify this as [tier]. Does that match your intent, or should I adjust?"
4. Record the user-confirmed tier as the active project tier before applying any governance parameters.
5. If tier changes mid-project, re-present and re-confirm before adjusting governance depth.

### Local-App Fast Path

For a single-user local app, prototype, dashboard, or operator tool with bounded scope, local data, no authentication/security boundary, no multi-tenant infrastructure, and no destructive external side effects, start from `Lightweight` unless concrete signals require `Standard`. Use `Precision` only when the actual request introduces enterprise architecture, security/compliance risk, infrastructure orchestration, or hard-to-reverse data consequences.

This fast path reduces ceremony and staffing only. It does not weaken request fit, burden reduction, real launch-path proof, user-view evidence, or blocker honesty.

## Governance Parameters Per Tier

Apply these parameters only after user-confirmed tier is established.

> For Governance Parameters Per Tier table and Checkpoint Semantics, see reference.md

## Operational Guardrails

Concrete thresholds to prevent runaway execution. Thresholds are defaults; note when a project overrides them.

| Guardrail | Default Threshold | Behavior on Breach |
|---|---|---|
| **Blast radius limiter** | Max 10 files changed per single developer dispatch | Pause, confirm with user before continuing |
| **Loop breaker** | Max 5 retry/iteration cycles on the same task | Escalate to user with current state and recommended action. When dev-workflow Phase 5 is active, its cycle limit and escalation path (return to Phase 4, then escalate after 2 re-entries) takes precedence. |
| **Stale work signal** | No meaningful progress after 3 consecutive turns on the same task | Flag to team-lead; team-lead decides retry, reassign, or scope reduction |
| **Concurrent write lock** | Before every dispatch, verify no active worker writes to the same file paths | Block new dispatch until write conflict is resolved |
| **Scope creep detection** | Implementation grows beyond 2× the originally scoped file count | Pause and confirm with user before continuing |

- Guardrail thresholds are configurable per project. Record any project-local overrides at session start.
- Breach behavior is team-lead action, not automatic halt. Team-lead decides the appropriate response based on context.

## Task Classification Heuristic

Quick classification to supplement team-lead's tier determination in the Primary Operating Loop `DETERMINE TIER` step. This maps task signals to Primary Operating Loop tier, not project tier.

| Task Signal | Primary Loop Tier | Team-Lead Action |
|---|---|---|
| Quick fix, typo, config change | Lightweight | Direct dispatch, minimal oversight |
| Bounded first-view/run-path blocker with narrow reversible fix | Lightweight | Stabilize or dispatch smallest owner, then re-verify affected user surface |
| Feature with clear spec, bounded scope | Standard | Scope check → dispatch → verify |
| Open-ended feature, architectural change | Precision | Full analysis → plan → confirm → dispatch → review → verify |
| Security-sensitive or destructive change | Precision + `sec-review` | Full pipeline with security specialist skill authorization |

- Project tier sets the floor. A Lightweight project with a security-sensitive request still requires Precision + `sec-review` handling.
- When task signals conflict, defer to the higher tier.

## Quality Metrics Integration

These are INPUT SIGNALS to team-lead judgment. They do not replace or substitute for the separated acceptance chain.

> For Quality Metrics table, see reference.md

- A high match score does not waive `reviewer`, `tester`, or `validator` steps.
- A low coverage indicator signals incomplete implementation — do not route to acceptance chain until addressed or explicitly scoped out.
- Team-lead records these values in the dispatch context so downstream lanes can confirm or challenge the assessment.

> For Governance Trust Score, see reference.md

## Deliverable Quality Philosophy Application

Role-specific application of CLAUDE.md Deliverable Quality Philosophy principles:

- P4 Context: Tier classification must adapt to the actual project environment, team capacity, and deployment context — not a generic template. Governance parameters that ignore actual project constraints = P4 violation.
- P8 Burden: Governance overhead must be proportional to actual project risk. Over-governed light projects and under-governed full projects both create unnecessary burden; calibration is the primary quality signal.

## Role-Scoped Self-Growth Loop

- Track repeated scaling miscalibration signals (over-governed simple tasks, under-governed high-risk changes, tier suggestions rejected by users) across sessions.
- When the same miscalibration class recurs, escalate to team-lead as a capability-gap signal for heuristic or threshold hardening.

## Structural Feedback To Upstream

- Signal to team-lead when governance depth mismatches (tier suggestions consistently overridden, guardrail thresholds consistently breached) suggest upstream project classification or policy gaps.

## References

- Complexity classification is a team-lead judgment; user-confirmed tier is binding. Tier changes follow the same confirm-before-apply rule.
- Governance parameters map to role separation and acceptance standards in `CLAUDE.md`. Specialist skills load through their owning lane per `CLAUDE.md` §Operating Model, not as additional agent teammates.
- Guardrail thresholds align with Preflight Responsibility, Recurrence Prevention, and Bottleneck Prevention in `CLAUDE.md`. Team-lead records project-local overrides in the workspace-local procedure state.
- Task heuristic supplements `agents/team-lead.md` §Primary Operating Loop and `task-execution` Step 2; it does not replace that step or override request-fit and deliverable-fit as leading interpretation priority.
- Quality metrics are input signals only; acceptance authority belongs to `reviewer`, `tester`, `validator` per role separation in `CLAUDE.md`.

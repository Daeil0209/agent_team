---
name: project-scaling
description: Project complexity classification and governance parameter scaling for calibrating governance depth at project start or when project complexity changes.
user-invocable: false
---

## Structural Contract

- Fixed top-level order:
  1. `Priority 1: Immutable Purpose`
  2. `Priority 2: Required Procedures And Rules`
  3. `Priority 3: Reference Notes`
- `Priority 2` content must be grouped by the directly related `Priority 1` purpose surface.
- `Priority 3` content must be grouped by the directly related `Priority 2` procedure.
- Lower-priority content must remain traceable from the immediately higher priority while keeping repeated mapping text minimal.
- Within each priority section, ID numbers follow descending importance: `*-1` is the most foundational item in that section, and later numbers must not outrank earlier ones.
- Do not add new top-level sections without explicit governance review.
- During self-growth or update work, preserve this hierarchy and its mapping chains as protected meaning rather than optional formatting.

## Priority 1: Immutable Purpose(IP)

### IP-1. Skill Identity

- This skill belongs to the **team-lead** lane and is a **common skill** with `PRIMARY-OWNER: team-lead`.
- Purpose: provide project-level complexity classification and governance parameter scaling so team-lead can calibrate oversight depth, acceptance chain, staffing shape, and specialist authorization to match actual project risk.
- This skill supplements the Primary Operating Loop's `DETERMINE TIER` step (RPA-1, Step 2 in `agents/team-lead.md`). It does NOT replace that loop.
- Per-request tier (`Lightweight / Standard / Precision`) adjusts UP from the project-level tier determined here; it never adjusts down. A Light project can still require a Precision request.
- Detection heuristics are SUGGESTIONS to team-lead — not automatic classification. Team-lead presents the suggestion; user confirms or overrides before governance parameters are applied.

### IP-2. Usage Contract

- Load this skill when: starting work on a new project, when project scope expands materially, or when governance depth seems mismatched to actual complexity.
- Do NOT load this skill to: replace the Primary Operating Loop, auto-apply governance gates without team-lead judgment, or override explicit user-confirmed tier decisions.
- All quality metrics defined here are INPUT SIGNALS to team-lead judgment, not automatic gates. They do not replace the separated acceptance chain (`reviewer` → `tester` → `validator`).

## Priority 2: Required Procedures And Rules(RPA)

### RPA-1. Project Complexity Classification. For IP-1

#### Three-Tier Model

| Tier | Description | Typical Examples |
|---|---|---|
| **Light** | Single feature, few files, no infrastructure, simple UI | Quick fixes, minor features, prototypes, config changes |
| **Standard** | Multi-file feature, API integration, moderate complexity | Typical feature development, BaaS integration, structured workflows |
| **Full** | Microservices, infrastructure, security-sensitive, enterprise scale | Enterprise systems, multi-service architectures, compliance-critical work |

#### Detection Heuristics (Suggestions Only)

These signals indicate a likely tier, but team-lead presents the suggestion and waits for user confirmation or override before applying governance parameters.

| Signal | Likely Tier |
|---|---|
| `terraform/`, `k8s/`, `docker-compose.yml` present in repo | Full |
| Security-sensitive changes, auth systems, secrets management | Full |
| API integration, third-party service wiring, multi-file feature | Standard |
| Structured development project with spec or design doc | Standard |
| Single page, simple script, isolated config change, typo fix | Light |

#### Classification Procedure

1. Inspect the active project root for structural signals above.
2. Form a suggested tier with rationale (1–2 sentences).
3. Present the suggestion to the user: "Based on [signal], I'd classify this as [tier]. Does that match your intent, or should I adjust?"
4. Record the user-confirmed tier as the active project tier before applying any governance parameters.
5. If tier changes mid-project, re-present and re-confirm before adjusting governance depth.

### RPA-2. Governance Parameters Per Tier. For IP-1

Apply these parameters only after user-confirmed tier is established.

| Parameter | Light | Standard | Full |
|---|---|---|---|
| **Acceptance chain depth** | `reviewer` only | `reviewer` + `tester` | `reviewer` + `tester` + `validator` |
| **Review scope** | Code quality | + architecture consistency | + security (`sec-review`) + infrastructure |
| **Testing requirements** | Basic verification | Structured testing | E2E + security + performance |
| **Documentation required** | Minimal (inline) | Feature-specific docs | Architecture + design + API docs |
| **Recommended team size** | 1–2 workers | 2–3 workers | Full 5-lane deployment |
| **Design options** | Optional | Recommended | Required (3 architecture options) |
| **Interactive checkpoints** | CP4 only (implementation approval) | CP1, CP3, CP4 | All 5 checkpoints (CP1–CP5) |
| **Gap analysis** | Optional | Recommended | Required before acceptance |
| **Specialist skills** | None by default | `dev-workflow` | `dev-workflow` + `sec-review` + `enterprise-arch` |

#### Checkpoint Definitions

- **CP1**: Requirements and scope confirmation (before planning begins)
- **CP2**: Architecture or design option selection (before implementation starts)
- **CP3**: Mid-implementation scope check (after significant partial completion)
- **CP4**: Implementation approval (before final acceptance chain)
- **CP5**: Post-acceptance sign-off (before closeout)

> **Note**: These checkpoint descriptions provide governance-level guidance for project-tier calibration. When dev-workflow is active, dev-workflow owns the authoritative phase-specific checkpoint semantics (CP1: Requirements Confirmation, CP2: Ambiguity Resolution, CP3: Architecture Selection, CP4: Implementation Approval, CP5: Issue Resolution). Refer to dev-workflow for phase-bound checkpoint definitions.

### RPA-3. Operational Guardrails. For IP-1

Concrete thresholds to prevent runaway execution. Thresholds are defaults; note when a project overrides them.

| Guardrail | Default Threshold | Behavior on Breach |
|---|---|---|
| **Blast radius limiter** | Max 10 files changed per single developer dispatch | Pause, confirm with user before continuing |
| **Loop breaker** | Max 5 retry/iteration cycles on the same task | Escalate to user with current state and recommended action |
| **Stale work signal** | No meaningful progress after 3 consecutive turns on the same task | Flag to team-lead; team-lead decides retry, reassign, or scope reduction |
| **Concurrent write lock** | Before every dispatch, verify no active worker writes to the same file paths | Block new dispatch until write conflict is resolved |
| **Scope creep detection** | Implementation grows beyond 2× the originally scoped file count | Pause and confirm with user before continuing |

- Guardrail thresholds are configurable per project. Record any project-local overrides at session start.
- Breach behavior is team-lead action, not automatic halt. Team-lead decides the appropriate response based on context.

### RPA-4. Task Classification Heuristic. For IP-1

Quick classification to supplement team-lead's tier determination in the Primary Operating Loop `DETERMINE TIER` step. This maps task signals to Primary Operating Loop tier, not project tier.

| Task Signal | Primary Loop Tier | Team-Lead Action |
|---|---|---|
| Quick fix, typo, config change | Lightweight | Direct dispatch, minimal oversight |
| Feature with clear spec, bounded scope | Standard | Scope check → dispatch → verify |
| Open-ended feature, architectural change | Precision | Full analysis → plan → confirm → dispatch → review → verify |
| Security-sensitive or destructive change | Precision + `sec-review` | Full pipeline with security specialist skill authorization |

- Project tier sets the floor. A Light project with a security-sensitive request still requires Precision + `sec-review` handling.
- When task signals conflict, defer to the higher tier.

### RPA-5. Quality Metrics Integration. For IP-2

These are INPUT SIGNALS to team-lead judgment. They do not replace or substitute for the separated acceptance chain.

| Metric | Description | Use |
|---|---|---|
| **Design-implementation match score** | How well does the code match the design doc? (0–100 per file or component) | Feed into team-lead's decision to iterate, escalate, or proceed to acceptance |
| **Coverage indicator** | Percentage of design requirements with corresponding implementation | Identify unimplemented surfaces before routing to acceptance chain |

- A high match score does not waive `reviewer`, `tester`, or `validator` steps.
- A low coverage indicator signals incomplete implementation — do not route to acceptance chain until addressed or explicitly scoped out.
- Team-lead records these values in the dispatch context so downstream lanes can confirm or challenge the assessment.

#### Governance Trust Score (Input Signal)

A composite score that gives team-lead a quantitative view of project quality trends. This is an INPUT SIGNAL for judgment — it does NOT automatically change governance tier or approval gates.

**5 Components (100-point scale):**

| Component | Weight | Measures |
|---|---|---|
| Phase completion rate | 25 pts | How often do development phases complete without rollback? |
| Quality check pass rate | 25 pts | What percentage of reviews/tests pass on first attempt? |
| Error recovery rate | 20 pts | When issues occur, how quickly and cleanly are they resolved? |
| Iteration efficiency | 15 pts | How many iteration cycles needed before acceptance? (fewer = better) |
| Scope stability | 15 pts | How often does scope change after plan approval? (less change = better) |

**Score Interpretation (advisory only):**

| Range | Signal | Team-Lead Action |
|---|---|---|
| 86-100 | Strong execution | Consider lighter oversight for routine work |
| 71-85 | Healthy | Standard governance appropriate |
| 51-70 | Needs attention | Increase checkpoint frequency, review depth |
| 31-50 | Concerning | Full governance pipeline for all work, root cause analysis |
| 0-30 | Critical | Pause and reassess project approach with user |

**Rules:**
- Score is NEVER used to auto-promote or auto-demote governance tier
- Score changes are reported to team-lead as trend signals, not commands
- Team-lead uses score alongside direct evidence and user feedback
- Score calculation happens at phase transitions, not continuously
- If score and direct evidence disagree, direct evidence wins

### RPA-6. Skill Routing Guide. For IP-1

When team-lead determines project tier, use this guide to decide which skills to load. Agents load skills autonomously based on task triggers; team-lead may also direct loading via SKILL-AUTH.

| Situation | Recommended Skill Loading |
|---|---|
| Enterprise architecture work | Load `enterprise-arch`; or team-lead directs via `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=enterprise-arch` |
| Security-sensitive changes | Load `sec-review`; or team-lead directs via `SKILL-AUTH: lane=reviewer:<lane-id>; surface=<blocked-surface>; skill=sec-review` |
| Structured development project (Standard or Full) | Load `dev-workflow`; or team-lead directs via `SKILL-AUTH: lane=team-lead; surface=<blocked-surface>; skill=dev-workflow` |
| Light tier | No additional skills required by default |
| Code quality deep review needed | Load `code-quality`; or team-lead directs via `SKILL-AUTH: lane=reviewer:<lane-id>; surface=<blocked-surface>; skill=code-quality` — Recommended for Standard and Full tiers during review phase. Reviewer-owned. |
| Design-implementation gap detection or YAGNI review | Load `gap-detect` alongside dev-workflow at Phases 1, 4, 5. Or team-lead directs via `SKILL-AUTH: lane=team-lead; surface=gap-detection|iteration-protocol|yagni-review; skill=gap-detect` — Team-lead-owned. |
| Error or regression detected, or at any phase transition | Load `incident-response`; event-driven, activated on error/regression detection or phase transitions. Or team-lead directs via `SKILL-AUTH: lane=team-lead; surface=<blocked-surface>; skill=incident-response` — Team-lead-owned. |
| Test scripts absent and Docker-based testing available | Load `log-qa`; activated when test scripts are absent and Docker-based testing is available. Or team-lead directs via `SKILL-AUTH: lane=tester:<lane-id>; surface=<blocked-surface>; skill=log-qa` — Tester-owned. |
| Design system standardization needed | Load `design-token`; activated when design system standardization is needed. Or team-lead directs via `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=design-token` — Developer-owned. |
| UI mockup exists and component conversion is needed | Load `ui-mockup`; activated when UI mockup exists and component conversion is needed. Or team-lead directs via `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=ui-mockup` — Developer-owned. |

- Authorization packets follow the format defined in `agents/team-lead.md` IR-4.
- Authorizing a specialist skill does not expand the worker's charter beyond its owning lane boundary.
- Issue authorization before dispatching the lane that will load the skill, not after.

## Priority 3: Reference Notes(RN)

### RN-1. Classification References. For RPA-1

- Project complexity classification is a team-lead judgment, not an automated filter. Detection heuristics surface signals; team-lead synthesizes them with project context and user confirmation.
- The user-confirmed tier is the binding governance basis. Heuristic suggestions are discarded if the user overrides.
- Tier changes mid-project follow the same confirm-before-apply rule as initial classification.

### RN-2. Governance Parameter References. For RPA-2

- Full tier governance parameters (security review, infrastructure review, 3 architecture options, all 5 CPs, gap analysis) reflect the acceptance standards in `CLAUDE.md` for high-risk, multi-system, or compliance-sensitive work.
- Specialist skills referenced here (`dev-workflow`, `sec-review`, `enterprise-arch`) are loaded through their owning lane per `CLAUDE.md` Active Runtime Model. They are not spawned as additional agent teammates.
- Acceptance chain depth maps to role separation doctrine in `CLAUDE.md` Role Separation And Decision Ownership.

### RN-3. Guardrail References. For RPA-3

- Blast radius limiter and concurrent write lock align with Preflight Responsibility and the manifest-sync packet in `agents/team-lead.md` RPA-2.
- Loop breaker aligns with Retry And Defect Classification in `CLAUDE.md`.
- Scope creep detection aligns with Bottleneck Prevention in `CLAUDE.md`.
- Project-local threshold overrides should be recorded in session continuity state (`session-state.md`) so they survive session resumption.

### RN-4. Task Heuristic References. For RPA-4

- This heuristic supplements the Primary Operating Loop `DETERMINE TIER` step in `agents/team-lead.md` RPA-1, Step 2.
- It does not replace that step's governing table or override request-fit and deliverable-fit as the leading interpretation priority.
- When task signals are ambiguous, team-lead may run a bounded scout dispatch before committing to a full Precision pipeline.

### RN-5. Quality Metric References. For RPA-5

- These metrics are not canonical acceptance criteria. Acceptance authority belongs to `reviewer`, `tester`, and `validator` per role separation in `CLAUDE.md`.
- Design-implementation match and coverage indicator are most useful during active development to decide whether to continue or pause for a mid-implementation scope check (CP3).
- Downstream skills may add role-specific consequences for these metrics but must not redefine their input-signal-only status.

### RN-6. Skill Authorization References. For RPA-6

- Agents autonomously load skills based on professional judgment and task triggers; `team-lead` may also direct loading via `SKILL-AUTH` packets as backup (format defined in `agents/team-lead.md` IR-4 and RPA-4).
- When team-lead directs via SKILL-AUTH, the target lane (`developer`, `reviewer`) performs direct specialist skill loading.
- Common skills (`dev-workflow`) and specialist skills (`sec-review`, `enterprise-arch`) remain distinct. Common skills require a single `PRIMARY-OWNER`; specialist skills are direct patch surfaces for their owning lane.

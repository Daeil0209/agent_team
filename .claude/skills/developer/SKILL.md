---
name: developer
description: Implementation procedure for bounded approved edits.
user-invocable: false
PRIMARY-OWNER: developer
---

## Structural Contract

- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Escalation Triggers, Implementation Workflow, Changeset Separation, Technical Standards, Active Communication Protocol
- PRIMARY-OWNER: developer
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.

### Scope & Quality Gate
Before ANY work:
1. **Request fit**: Does instruction match user's original request?
2. **Scope proportionality**: Is work scope proportional to request?
3. **Charter fit**: Does this work belong inside the developer lane, or is it actually orchestration, research, review, proof, or final acceptance work?
4. **Feasibility**: Can this be completed within capabilities and turn budget?

If ANY fails → return scope feedback. Do NOT execute over-scoped instructions.

### User-Perspective Gate

Apply this gate when the output is user/operator-facing or acceptance depends on real start/use. This is a developer-local completion gate, not review, proof, or final acceptance authority.

1. Can the intended user or operator find the entry path without developer-only knowledge?
2. Can they install, open, or start the deliverable using the stated procedure rather than hidden setup knowledge?
3. Can they complete the core task without developer assistance or implementation knowledge?

If any answer is `no` or `unverified`, the work is not ready to present as done. Keep the exact user-perspective gap explicit in the handoff. "Developer can run it" is not enough.

## Preconditions

- Use only after team-lead assigns bounded scope.

### Required Dispatch Packet Fields

| Work Type | Required Fields |
|-----------|----------------|
| All implementation | PLAN-STATE, PLAN-STEP, ACCEPTANCE-RISK, REVIEW-OWNER, PROOF-OWNER, ACCEPTANCE-OWNER, CHANGE-SPEC |
| Meaningful/high/critical risk | + explicit acceptance pipeline (REVIEW-OWNER: reviewer, PROOF-OWNER: tester, ACCEPTANCE-OWNER: validator) |
| Consequential dispatch | + WORKER-FIT, SCOPE-MATCH, PRIOR-ANALYSIS: included |
| Request-bound artifacts | + REQUEST-INTENT, CORE-QUESTION, REQUIRED-DELIVERABLE, PRIMARY-AUDIENCE, EXCLUDED-SCOPE |
| Request-bound documents | PLAN-STEP: draft or merge-compress. CHANGE-SPEC explicit about first-draft vs integration |
| Office-format artifacts | + rendered review chain: developer/doc-auto → tester → reviewer → validator |
| Manifest-sync | + TASK-CLASS, MANIFEST-UNIQUE, OVERLAP-REVIEW, PRE-EXEC-REVIEW, WRITE-SCOPE |
| Governance-patch | + TASK-CLASS, OWNER-SURFACE, CHANGE-BOUNDARY, WRITE-SCOPE, VERIFY-BASIS |
| Optimization/compression | + OPTIMIZATION-ORDER: post-change-only, OPTIMIZATION-GUARD: zero-loss, PROTECTED-MEANING: checked |

- In the current target design, specialist capabilities live as skills under the path pattern .claude/skills/{skill-id}/SKILL.md, not as active subagents under `.claude/agents/`.
- Authorization packets should name `skill-id`, bind it to the target lane plus blocked surface, and let `developer` resolve it against the active project skill root/subpath.
- If packet fields create material ambiguity in write scope, authority, or acceptance risk, stop and escalate. If the developer lane, user intent, and safe change boundary are inferable from context, reconstruct the working packet explicitly and mark inferred pieces as inference before execution.
- For workflow-governed work, confirm explicit implementation-phase authority before any code, scaffold, schema, business-logic, or executable structure work begins. Research findings, workbook analysis, internal lead reasoning, or scope scaffolds alone do not constitute implementation authority. If implementation entry basis is missing, return `HOLD`. [Rule-Class: mandatory]

> **Dispatch-side SKILL-AUTH governance** (context, not developer execution steps):
- `team-lead` may authorize developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- When the blocked capability is a developer-exclusive specialist skill, `developer` is the default skill-up owner.
- When approving developer-side specialist skill use, send `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>`. Default mode is `SPECIALIST_SKILL_ENFORCEMENT_MODE=autonomous` — this packet is an authorization and traceability contract.
- Scope boundary: SKILL-AUTH is for security-sensitive or governance-sensitive specialist skills requiring explicit team-lead authorization before loading. SKILL-RECOMMENDATIONS is for methodology and workflow skills that guide the execution approach within the dispatched scope. When a skill appears in both systems, SKILL-AUTH authorization takes precedence.
- Specialist skill ids such as `sw-spec`, `biz-sys`, `ui-ux`, or `design-token` must not be treated as `Agent` targets. They are loaded inside the assigned worker lane after the dispatch packet establishes the owning lane, surface, and authorization basis.

## Escalation Triggers

- Change touches 3+ files across modules
  (Exception: when the dispatch packet explicitly covers the multi-file scope in `CHANGE-BOUNDARY` or `WRITE-SCOPE`, the scope was pre-authorized. No escalation needed unless actual changes exceed declared scope.)
- New inter-module dependency introduced
- Shared interface contract modified
- Pattern reused in 5+ places affected

## Implementation Workflow

### 1. Confirm Assigned Scope
- Restate scope before editing. Confirm mode: proposal-only, diff-only, or apply.
- If scope exceeded, stop and escalate.
- For workflow-governed work, also confirm phase legitimacy: "Am I being asked to implement during an authorized implementation phase?" If the expected output includes runtime code, scaffolding, schema creation, business-rule modules, or executable app structure, and implementation-phase authority is not explicit in the dispatch, stop and escalate. [Rule-Class: mandatory]
- See §Escalation Triggers for scope conditions that require stopping before any edits begin.

### 2. Pre-Implementation Discovery
1. **Existence**: Grep for names/synonyms before creating new items.
2. **Convention**: Glob + adjacent files for naming/placement patterns.
3. **Consumer**: Grep reference count and impact radius.
4. **Test coverage**: Glob for covering tests.
5. **Config keys**: Search existing definitions before adding new ones.
6. **Runtime hygiene** (governance surfaces only): verify stale residue cleared.
7. **Repo-aware verification path**: before using `git diff`, `git status`, branch history, or similar repository-only evidence, confirm the current root is actually inside a git repository. If not, use direct file inspection, explicit touched-file review, or other file-based evidence instead of emitting raw git failure as if it were a substantive blocker.

### 2A. Skill Recommendation Evaluation
- This loop evaluates situational skills only. Baseline MWEC loads remain mandatory per `CLAUDE.md` `§Skill Loading Philosophy`.
- If the dispatch packet includes `SKILL-RECOMMENDATIONS`, evaluate each recommended skill against the developer's role:
  - **Evaluation baseline**: Cross-reference the user's original instructions with the dispatch packet's `REQUEST-INTENT`, `CORE-QUESTION`, and `REQUIRED-DELIVERABLE`. Skill evaluation must serve both the user's stated intent and the role-based criteria below — technical fit alone is insufficient if the skill does not advance the user's actual goal.
  1. **Implementation fit**: Will this skill's approach improve the implementation quality for the assigned scope?
  2. **Proportionality**: Does the task complexity warrant this methodology's overhead, or would standard implementation workflow be more effective?
  3. **Architecture alignment**: Does this skill's patterns align with the existing codebase conventions and the approved design?
- **Applicable and beneficial** → load the skill to guide implementation (e.g., `enterprise-arch` for architecture patterns, `ui-mockup` for UI conversion, `design-token` for design systems).
- **Applicable but disproportionate** → note the skill's availability without loading; proceed with standard implementation workflow.
- **No recommendation fits** → independently search available skill descriptions for a better alternative. If found, report upward via SendMessage before loading.
- **No recommendations provided** → independently scan available skills for technique, architecture, or methodology skills applicable to this work.
- Record which skill was selected or rejected (with rationale) in the handoff.
- Governance rules for methodology skill loading:
  - Load at most one governing methodology skill per work phase. When multiple candidates are applicable, select the highest-fit skill based on the evaluation criteria above.
  - When SKILL-RECOMMENDATIONS is explicitly "none", the team-lead searched and found no applicable skills to recommend. The worker may still independently search if the work context suggests a methodology skill would be beneficial, but is not obligated to. Independent search is expected when the SKILL-RECOMMENDATIONS field is absent from the dispatch.
  - Self-verification Critical Challenge takes precedence over methodology skill quality criteria. Methodology skills provide additional checks, not replacement for convergence verification.
  - On reuse with new SKILL-RECOMMENDATIONS, treat previously loaded methodology skills as inactive reference. New evaluation based on the fresh dispatch takes precedence.

### 3. Pre-Edit Analysis Gate
1. Read target section completely, not just lines you plan to touch.
2. Check semantic duplication against target file and doctrine.
3. Loss-risk analysis: would edit overwrite or displace valuable content?
4. Local-context balance: check adjacent owner surfaces stay aligned.
5. Gate: both pass -> continue; either fails -> stop and report.

### 3A. Durability Gate (for fixes/corrections)

| Fix type | Definition | Action |
|---|---|---|
| root-cause | Addresses verified origin | Proceed |
| symptom-relief | Reduces impact, not origin | Proceed + disclose |
| hypothesis-based | Plausible unconfirmed cause | Proceed + HOLD on verification |
| open | Cause unknown | HOLD - escalate |

Apply 5 Whys when fix type is hypothesis-based or open.

### 4. Proposal-Only Branch
- If mode is proposal/diff-only: produce bounded proposal, no file edits, wait for apply authorization.

### 4A. Retry Governance
- Max 3 retries before mandatory escalation.
- Escalate to team-lead via SendMessage with message-class: hold and the specific retry exhaustion context.

### 4B. Plan Verification
Load the `self-verification` skill and execute Critical Challenge on the plan before proceeding to execution. This is the operational execution point for SV Activation Trigger 3. The plan is an unverified candidate until it survives Critical Challenge.

### 5. Execute Bounded Change
- Preserve existing architecture and conventions.
- Follow §Technical Standards for naming, control flow, and SOLID compliance during implementation.

### 6. Pre-Handoff Integrity
_This section is the authoritative implementation checklist. `agents/developer.md §Pre-Handoff Integrity` states the governing principles; this skill section provides the executable steps._
1. No broken imports or missing references
2. No contradictory logic or unreachable branches
3. Functions remain callable from expected call sites
4. No syntax fragments or partial edits
5. No dead references to renamed/removed symbols
6. Load the `self-verification` skill and execute the full procedure including Critical Challenge. Include the verification output format in the handoff block.

### 7. Handoff
Build the full handoff block in the message body and deliver to team-lead via SendMessage. Do not write to `./.claude/session-state.md` or `$HOME/.claude/session-state.md` directly — team-lead owns all continuity surfaces.
- Report: mode, what changed, why, files touched, risks, blockers, recommended next lane.
- When a task mixes multiple change types, apply §Changeset Separation to keep edit units separable in this handoff.
- For consequential upward `SendMessage` reports with `MESSAGE-CLASS: handoff|completion|hold`, keep one completion-grade evidence block explicit:
  - `TASK-ID: <assigned-id|none>`
  - `PREREQ-STATE: complete|partial|missing`
  - `OUTPUT-SURFACE: <changed artifact, file set, or produced output>`
  - `EVIDENCE-BASIS: <applied change basis plus executed, unrun, or blocked checks>`
  - `OPEN-SURFACES: <remaining blockers, assumptions, or none-material>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `SKILL-RECOMMENDATIONS: <skill and rationale or none>`
  - `PLANNING-BASIS: loaded`
  - `SV-PLAN-VERIFY: done`
  - `SELF-VERIFICATION: converged`
  - `CONVERGENCE-PASS: 1|2|3`
  - `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`
  - If any of those procedure states is not true yet, use `MESSAGE-CLASS: hold` and explain the blocked surface in `OPEN-SURFACES` instead of formatting the report as completion-ready.
- `PREREQ-STATE`: `missing` = prerequisite or integrity basis not explicit; `partial` = some acceptance-critical basis still open; `complete` = downstream review can start without reconstructing the implementation basis.
- Use the task id from the runtime assignment packet whenever one exists. Do not substitute a worker name, inferred chronology, or remembered topic label.
- Default to `REQUESTED-LIFECYCLE: standby` when preserved implementation context may still matter; request `shutdown` only when near-term reuse should not be preserved. This is a request, not authority.
- This block is only for consequential `handoff|completion|hold`. Ordinary continuity or status notes may stay free-form.
- Wait for reuse/standby/shutdown direction.
- Separate applied changes, executed checks, unrun or blocked checks, and unresolved assumptions so downstream lanes inherit a truthful implementation state without reconstructing it from the diff alone.
- For request-bound artifacts, state whether the applied change preserved the answer surface, deliverable shape, and excluded-scope boundary expected by the packet.

## Changeset Separation
- When a task mixes multiple change types, keep edit units separable.
- In handoff, separate change types when distinction matters for review.

## Technical Standards
- Prefer explicit over implicit: named constants, descriptive names, clear control flow.
- One function = one responsibility. Handle errors explicitly.
- Verify dependencies exist before importing. Check test coverage impact.
- SOLID principles: violations in new code are pre-handoff findings; in existing code, record as observation.

## Active Communication Protocol

- Consequential `handoff|completion|hold` must use the completion-grade evidence block above, including `REQUESTED-LIFECYCLE`.

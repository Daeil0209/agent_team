---
name: agent-team-lead
description: Team-lead-specific procedure skill for lead-owned orchestration, route bridging, communication objections, synthesis, reporting staging, and interrupt/autonomy.
user-invocable: false
PRIMARY-OWNER: team-lead
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
## Structural Contract
- Sharpens only team-lead-owned procedure detail.
- `.claude/agents/team-lead.md` remains the always-loaded team-lead role spine.
- This skill owns detailed team-lead procedure references under `references/`.
- Skill name is `agent-team-lead`.
- `team-lead` remains a role name, not a skill name.
- Fixed section order: Structural Contract, Activation, Reference Map, Lead Procedure Routing, Resolve Next Owner And Action.

## Activation
- Load when `.claude/agents/team-lead.md` opens a team-lead procedure trigger that names a reference in this skill.
- Load before consuming any reference under `.claude/skills/agent-team-lead/references/`.
- Do not load for lane-owned assignment work unless team-lead procedure control is the active owner path.
- This skill does not replace `work-planning`, `task-execution`, `session-boot`, `session-closeout`, `self-verification`, or `Skill(governance-modification)`.

## Reference Map
- Pre-action gate: `references/pre-action-gate.md`
- Owner trigger order: `references/owner-trigger-order.md`
- Session and route bridge: `references/session-route-bridge.md`
- Planning fields: `references/planning-field-consume.md`
- Final Acceptance Review (FAR) rejection routing: `references/far-reject-routing.md`
- Configured-review output lead own-review: `references/codex-output-lead-own-review.md`
- Lead-local guarded law: `references/lead-local-guarded-law.md`
- Communication objections: `references/communication-objections.md`
- Synthesis consume: `references/synthesis-consume.md`
- Output surface law: `references/output-surface-law.md`
- Reporting surface rules: `references/reporting-surface-rules.md`
- Routine continuation: `references/routine-gate-continuation.md`
- Interrupt/autonomy: `references/interrupt-autonomy.md`

## Lead Procedure Routing
- Active team-lead triggers consume the exact reference named by `.claude/agents/team-lead.md`.
- Reference consumption requires applied-rule mapping before action, synthesis, report, redispatch, mutation, or completion claim.
- `.claude/agents/team-lead.md` keeps always-loaded role identity, authority, trigger skeleton, mandatory reference links, decisive stops, and next-owner routing.
- Situation-specific lead procedure detail stays in this skill's trigger-bound references.
- A missing, stale, or unconsumed required reference stops the action and opens the missing reference consumption path.

## Resolve Next Owner And Action
- Satisfied reference consumption returns to the active team-lead procedure action.
- Missing `agent-team-lead` skill load opens `Skill(agent-team-lead)`.
- Missing reference consumption opens the exact required reference.
- Boundary changes route to the owning skill or sequence named by `.claude/agents/team-lead.md`.

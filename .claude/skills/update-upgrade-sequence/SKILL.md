---
name: update-upgrade-sequence
description: Update and upgrade sequence for doctrine, agents, skills, settings, hooks, and team-system assets.
user-invocable: false
PRIMARY-OWNER: team-lead
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

## Structural Contract
- Sharpens only its owned sequence surface.
- Fixed section order: Purpose, Activation, Reference Map, Update/Upgrade Sequence, Skill And Specialist Changes, Constraints, Resolve Next Owner And Action
- PRIMARY-OWNER: team-lead
- Owns team-system asset update routing.
- Consumes `self-growth-sequence` `Change Sequence` for patch mechanics.
- Consumes owner references for specialist matrices.

## Purpose
Open `Update/Upgrade Sequence` when team-system assets change.
Route directly from `work-planning` as `ACTIVE-SEQUENCE: update-upgrade-sequence`.
Governance patch placement, generalization, and patch-ready record consume `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.

Adjacent owners:
- confirmed recurrence defects -> `self-growth-sequence`
- patch mechanics -> `self-growth-sequence` `Change Sequence`
- lane-owned specialist execution -> lane role files or agent-specific skills
- agent dispatch or packet truth -> `task-execution`

## Activation
Load when doctrine, agents, skills, settings, hooks, or project-root `.mcp.json` enabled by `.claude/settings.json` need modification.
Load when live-surface mirrors need modification.
Load when other team-system assets need modification.
Also load for introduction, upgrade, migration, compression, or ownership/routing correction of those assets.

If the trigger is a confirmed behavioral or procedural defect, open `self-growth-sequence` as the primary sequence.
Use this sequence only for the required asset-update surface.
If the trigger is ordinary non-defect asset maintenance, this sequence is primary.
It consumes `Change Sequence` for execution mechanics.

## Reference Map
Load only the reference whose trigger is active.
- `references/update-checks.md`: update-specific structural, owner, hierarchy, mapping, and configurable-value checks.
- `references/skill-introduction.md`: new skill approval, common-vs-specialist ownership, category gate, reject criteria, and approval packet.
- `references/specialist-routing.md`: specialist skill routing, `SKILL-AUTH`, benchmark-first routing, and owner-matrix source of truth.

If a triggered reference cannot be loaded, freeze `HOLD`.
Alternatively blocker-clear or reopen the owner.
Approval requires triggered reference basis or owner reopening.

## Update/Upgrade Sequence
Every update/upgrade path first:
1. Name the target asset and owning surface.
   For governance patches, name the consumed execution path that makes the target surface effective.
2. Classify the change type.
   Use these change types:
   - `ordinary asset maintenance` for routine asset updates
   - `recurrence hardening` for confirmed recurrence barriers
   - `capability introduction` for new capability surfaces
   - `external-tool/MCP integration` for external tool integration
   - `compression` for context or document reduction
   - `migration` for source-to-destination moves
   - `settings/hook change` for settings or hook edits
   - `runtime enforcement expansion` for broader runtime blocking or enforcement
   - `specialist-routing change` for specialist routing changes
   Live-surface synchronization is migration.
   Classify these hook edits as `runtime enforcement expansion`:
   - add deny behavior
   - broaden deny behavior
   - broaden matcher scope
   - broaden permission-deny scope
   - broaden blocking path
   - broaden runtime enforcement tier
   Classify these settings edits as `runtime enforcement expansion`:
   - add deny behavior
   - broaden deny behavior
   - broaden permission-deny scope
   - broaden runtime enforcement tier
3. Classify the update tier.
   Tiering selects update-local verification depth only.
   Update tiers are not self-growth hardening tiers; confirmed behavioral or procedural defects use `self-growth-sequence` as primary and this sequence only covers the required asset-update surface.
   Tiering does not waive `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`, triggered reference consumption, `self-growth-sequence` `Change Sequence` execution gate, Hook-Last approval, destructive/security approval, or `SV-RESULT` closure.
   Use the smallest tier that preserves the target asset's owner boundary, live consumption path, and protected procedure force.
   - `quick update`: same-owner typo, dead-text deletion, duplicate trim, pointer correction, terminology normalization, or wording clarification that preserves rule force, owner, trigger, stop, evidence, acceptance, runtime effect, live references, and consumed path.
   - `standard update`: ordinary governance, role, skill, or reference edits that change consumed procedure detail inside the same owner family without moving ownership, expanding runtime enforcement, changing acceptance authority, or migrating meaning across owner surfaces.
   - `structural update`: owner re-home, migration, compression with destination-owner change, skill introduction, skill split or merge, specialist-routing change, external-tool/MCP integration, settings/hook change, runtime enforcement expansion, acceptance/validation authority change, or cross-surface structural impact.
   Unknown, mixed, or disputed tier upgrades to the highest material tier before mutation.
4. Use only the `self-growth-sequence` `Change Sequence` patch mechanics required by the change type and tier.
   Full self-growth opens only for confirmed behavioral or procedural defects.
   Governance patch mechanics include consumed-layer placement, generalization basis, and patch-ready record from `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.
5. Apply the tier checks.

Quick update checks:
- Preserve structural contracts, owner boundaries, live references, protected local restatements, source meaning, and the current consumed path.
- Preserve current rule force, trigger, stop, evidence, acceptance, runtime, and design-intent behavior.
- Post-verify the resulting diff and the touched owner surface before reporting the change as verified.
- Upgrade to `standard update` when preservation is not obvious from the touched owner surface.

Standard update checks:
- Complete all quick update checks.
- Inspect material adjacent consumed owner surfaces before mutation when the change can affect them.
- Post-verify references, owner semantics, information preservation, and affected consumed surfaces before reporting the change as verified.
- Check in-flight outputs or prior verdict impact only when the change touches active route, dispatch, proof, validation, acceptance, reporting, or user-facing closure.

Structural update checks:
- Complete all standard update checks.
- Record source-to-destination trace when meaning moves, compresses, replaces, or redistributes across owner surfaces.
- Consume `references/update-checks.md`, `references/skill-introduction.md`, or `references/specialist-routing.md` when their trigger is active.
- Verify current trigger, owner, stop, evidence, runtime, and design-intent behavior for moved or structurally affected surfaces.
- Verify hook/settings/runtime side effects when enforcement, tooling, permissions, or runtime behavior changes.
- Post-verify in-flight outputs and prior verdict impact before reporting the change as verified.

Use `references/update-checks.md` for update-specific checks not already owned by `Change Sequence` and for triggered structural checks.

## Skill And Specialist Changes
Before adding, removing, splitting, merging, or re-homing a skill, classify whether the surface is:
- independent top-level skill
- parent-owned reference/detail
- agent-specific skill
- specialist skill
- common team-operation skill

Use `references/skill-introduction.md` for new skill approval and ownership.
Use `references/specialist-routing.md` when `REQUIRED-SKILLS`, `SKILL-AUTH`, specialist order, or owner-matrix routing is material.

Independently routable workflow, sequence, agent-specific, or dispatch owners stay top-level.
Parent-detail skills re-home under the parent.
Skill names remain only when a packet, route, or activation path needs them.

## Constraints
- No new operational rule without a clear owner.
- Governance patches must satisfy `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate` before update closure.
- Do not restate patch-selection rules here when that gate controls the same action.
- Shared doctrine weakening requires explicit owner approval.
- Duplicate ownership requires intentional protected restatement or hierarchy consistency basis.
- Treat rule, skill, settings, and hook changes as governance-sensitive by default.
- Runtime enforcement expansion requires `references/update-checks.md` Hook-Last preflight plus explicit operator approval before execution.
- Destructive, security-sensitive, externally committed, or operator-policy-choice actions require operator approval before modification.
- Reviewed non-destructive governance changes proceed through `Skill(self-growth-sequence)` `Change Sequence` Step 5b `Execution Gate`.
- Sandbox filesystem approval is technical permission, not governance approval.

## Resolve Next Owner And Action
- Ordinary asset maintenance opens `Update/Upgrade Sequence`.
- Confirmed recurrence defects open `self-growth-sequence`.
- Patch mechanics open `self-growth-sequence` `Change Sequence`.
- Missing triggered reference basis opens blocker-clear, owner reopening, or `HOLD`.
- Failed post-verify opens the smallest owner correction.
- Verified asset update opens `SV-RESULT` before consequential reporting.

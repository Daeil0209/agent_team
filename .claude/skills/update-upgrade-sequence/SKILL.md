---
name: update-upgrade-sequence
description: Update and upgrade sequence for doctrine, agents, skills, settings, hooks, and team-system assets.
user-invocable: false
PRIMARY-OWNER: team-lead
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

Adjacent owners:
- confirmed recurrence defects -> `self-growth-sequence`
- patch mechanics -> `self-growth-sequence` `Change Sequence`
- lane-owned specialist execution -> lane role files or lane-core skills
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
Every update/upgrade path must:
1. Name the target asset and owning surface.
2. Classify the change type.
   Use `ordinary asset maintenance` for routine asset updates.
   Use `recurrence hardening` for confirmed recurrence barriers.
   Use `capability introduction` for new capability surfaces.
   Use `external-tool/MCP integration` for external tool integration.
   Use `compression` for context or document reduction.
   Use `migration` for source-to-destination moves.
   Use `settings/hook change` for settings or hook edits.
   Use `runtime enforcement expansion` for broader runtime blocking or enforcement.
   Use `specialist-routing change` for specialist routing changes.
   Live-surface synchronization is migration.
   Hook edits that add deny behavior are `runtime enforcement expansion`.
   Hook edits that broaden deny behavior are `runtime enforcement expansion`.
   Hook edits that broaden matcher scope are `runtime enforcement expansion`.
   Hook edits that broaden permission-deny scope are `runtime enforcement expansion`.
   Hook edits that broaden blocking path are `runtime enforcement expansion`.
   Hook edits that broaden runtime enforcement tier are `runtime enforcement expansion`.
   Settings edits that add deny behavior are `runtime enforcement expansion`.
   Settings edits that broaden deny behavior are `runtime enforcement expansion`.
   Settings edits that broaden permission-deny scope are `runtime enforcement expansion`.
   Settings edits that broaden runtime enforcement tier are `runtime enforcement expansion`.
3. Use only the `self-growth-sequence` `Change Sequence` patch mechanics required by the change class.
   Full self-growth opens only for confirmed behavioral or procedural defects.
4. Preserve structural contracts.
5. Preserve owner boundaries.
6. Preserve live references.
7. Preserve protected local restatements.
8. Preserve source-to-destination meaning.
9. Preserve current trigger behavior for live-surface synchronization.
10. Preserve current owner behavior for live-surface synchronization.
11. Preserve current stop behavior for live-surface synchronization.
12. Preserve current evidence behavior for live-surface synchronization.
13. Preserve current design-intent behavior for live-surface synchronization.
14. Post-verify the diff before reporting the change as verified.
15. Post-verify references before reporting the change as verified.
16. Post-verify owner semantics before reporting the change as verified.
17. Post-verify information preservation before reporting the change as verified.
18. Post-verify affected surfaces before reporting the change as verified.
19. Post-verify in-flight outputs before reporting the change as verified.
20. Post-verify prior verdict impact before reporting the change as verified.

Use `references/update-checks.md` for the update-specific checks that are not already owned by `Change Sequence`.

## Skill And Specialist Changes
Before adding, removing, splitting, merging, or re-homing a skill, classify whether the surface is:
- independent top-level skill
- parent-owned reference/detail
- lane-core skill
- specialist skill
- common team-operation skill

Use `references/skill-introduction.md` for new skill approval and ownership.
Use `references/specialist-routing.md` when `REQUIRED-SKILLS`, `SKILL-AUTH`, specialist order, or owner-matrix routing is material.

Independently routable workflow, sequence, lane-core, or dispatch owners stay top-level.
Parent-detail skills re-home under the parent.
Skill names remain only when a packet, route, or activation path needs them.

## Constraints
- No new operational rule without a clear owner.
- Before adding governance text, test tighter owner-local alternatives first.
- Apply tightening, replacing, trimming, merging, or re-homing when they preserve force.
- Any expansion requires proof that no shorter owner-local edit carries the same force; otherwise replace, trim, merge, or re-home.
- Shared doctrine weakening requires explicit owner approval.
- Duplicate ownership requires intentional protected restatement or hierarchy consistency basis.
- Treat rule, skill, settings, and hook changes as governance-sensitive by default.
- Runtime enforcement expansion requires `references/update-checks.md` Hook-Last preflight plus explicit operator approval before execution.
- Destructive, security-sensitive, externally committed, or operator-policy-choice actions require operator approval before modification.
- Reviewed non-destructive governance changes proceed through `.claude/skills/self-growth-sequence/SKILL.md` `Change Sequence` Step 5b `Execution Gate`.
- Sandbox filesystem approval is technical permission, not governance approval.

## Resolve Next Owner And Action
- Ordinary asset maintenance opens `Update/Upgrade Sequence`.
- Confirmed recurrence defects open `self-growth-sequence`.
- Patch mechanics open `self-growth-sequence` `Change Sequence`.
- Missing triggered reference basis opens blocker-clear, owner reopening, or `HOLD`.
- Failed post-verify opens the smallest owner correction.
- Verified asset update opens `SV-RESULT` before consequential reporting.

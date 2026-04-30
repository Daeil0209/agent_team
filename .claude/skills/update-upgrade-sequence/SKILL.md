---
name: update-upgrade-sequence
description: Update and upgrade sequence for doctrine, agents, skills, settings, hooks, and team-system assets; use for .claude asset modifications, skill introduction, and specialist routing changes.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned sequence surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: Purpose, Activation, Reference Map, Update/Upgrade Sequence, Skill And Specialist Changes, Constraints
- PRIMARY-OWNER: team-lead
- This skill owns team-system asset update routing. It consumes `self-growth-sequence` `Change Sequence` for patch mechanics and owner references for specialist matrices.
- Structural changes require governance review.

## Purpose
Open the `Update/Upgrade Sequence` when team-system assets change. This is a top-level team-lead sequence skill, not a `team-lead` edge-case reference, because `.claude` asset modification must be directly routable from `work-planning` as `ACTIVE-SEQUENCE: update-upgrade-sequence`.

This skill does not replace:
- `self-growth-sequence` for confirmed recurrence defects
- `self-growth-sequence` `Change Sequence` for patch mechanics
- lane role files or lane-core skills for lane-owned specialist execution
- `task-execution` for agent dispatch or packet truth

## Activation
Load when doctrine, agents, skills, settings, hooks, or other `.claude` team-system assets need modification, introduction, upgrade, migration, compression, or ownership/routing correction.

If the trigger is a confirmed behavioral or procedural defect, open `self-growth-sequence` as the primary sequence and use this sequence only for the asset-update surface it requires. If the trigger is ordinary non-defect asset maintenance, this sequence is primary and consumes `Change Sequence` for execution mechanics.

## Reference Map
Load only the reference whose trigger is active.
- `references/update-checks.md`: update-specific structural, owner, hierarchy, mapping, and configurable-value checks.
- `references/skill-introduction.md`: new skill approval, common-vs-specialist ownership, category gate, reject criteria, and approval packet.
- `references/specialist-routing.md`: specialist skill routing, `SKILL-AUTH`, benchmark-first routing, and owner-matrix source of truth.

If a triggered reference cannot be loaded, freeze `HOLD`, blocker-clear, or reopened owner instead of approving from the compact sequence spine.

## Update/Upgrade Sequence
Every update/upgrade path must:
1. Name the target asset and owning surface.
2. Classify whether the change is ordinary asset maintenance, recurrence hardening, capability introduction, compression, migration, settings/hook change, or specialist-routing change.
3. Run `self-growth-sequence` `Change Sequence` for patch mechanics before execution.
4. Preserve structural contracts, owner boundaries, live references, protected local restatements, and source-to-destination meaning.
5. Post-verify the diff, references, owner semantics, and information preservation before reporting the change as verified.

Use `references/update-checks.md` for the update-specific checks that are not already owned by `Change Sequence`.

## Skill And Specialist Changes
Before adding, removing, splitting, merging, or re-homing a skill, classify whether the surface is:
- independent top-level skill
- parent-owned reference/detail
- lane-core skill
- specialist skill
- common team-operation skill

Use `references/skill-introduction.md` for new skill approval and ownership. Use `references/specialist-routing.md` when `REQUIRED-SKILLS`, `SKILL-AUTH`, specialist order, or owner-matrix routing is material.

Do not hide an independently routable workflow, sequence, lane-core, or dispatch owner inside `team-lead/references/`. Do not keep a top-level skill when it is only a parent skill's detail and no packet, route, or activation path needs the skill name.

## Constraints
- No new operational rule without a clear owner.
- Do not weaken shared doctrine silently in lower-level documents.
- Do not leave the same rule half-owned by multiple documents unless duplication is intentional and justified for hierarchy consistency.
- Treat rule, skill, settings, and hook changes as governance-sensitive by default.
- Destructive, security-sensitive, externally committed, or operator-policy-choice actions require operator approval before modification.
- Reviewed non-destructive governance changes proceed through `.claude/skills/self-growth-sequence/SKILL.md` `Change Sequence` Step 5b `Execution Gate`; sandbox filesystem approval is technical permission, not governance approval.

---
name: update-upgrade-sequence
description: Update and upgrade procedures for doctrine, agents, skills, settings, hooks, and team-system assets.
user-invocable: false
---

## Activation

Load this skill when doctrine, agents, skills, settings, hooks, or other team-system assets need modification. This includes skill introduction, specialist skill routing, and skill category gates.

Changes executed through this sequence use the normal `Change Sequence` which remains in the always-loaded `team-governance-sequences` skill.

## Update/Upgrade Sequence

The `Update/Upgrade Sequence` applies when doctrine, agents, skills, settings, hooks, or other team-system assets are modified.

### Required checks

1. Confirm the target artifact owner.
2. Perform semantic overlap review before adding new rules or procedures.
3. Prefer `replace`, `trim`, or `re-home` over append-only accumulation.
4. Preserve migration traceability.
   The source meaning, destination owner, and verification basis must remain inspectable.
5. Perform zero-information-loss confirmation for moved, merged, compressed, or re-homed operational meaning.
   The before/after comparison must show where each unique rule meaning now lives.
6. Where a runtime setting or threshold must remain configurable, keep one owner for the value and make all other documents or prompts reference that owner instead of duplicating the literal value.
7. When a hook still enforces a contract, keep that contract understandable through owner-document prose and human-readable deny reasons rather than requiring a large central code table.
8. Treat intentional local restatements of role boundaries, lane contracts, and acceptance gates as protected meaning, not cosmetic duplication.
   If a rule is repeated so a file remains safe to read in isolation, do not remove it unless an equivalent owner-local contract still exists after the change.
9. When optimization, compression, rewrite, or self-evolution is the stated reason for the change, explicitly classify each repeated governance sentence as either protected common contract or safely removable duplication before trimming it.
10. Preserve approved structural hierarchies and connection mappings when the target document already uses them.
   Role documents must preserve their declared role/procedure/reference hierarchy and keep required mapping lines intact. Skill documents must preserve their fixed structural contract and keep reference detail attached to an owning workflow or sequence block.
11. New top-level sections, orphaned procedure blocks, orphaned reference blocks, or broken mapping chains require explicit governance review before execution.
12. Run the full `Change Sequence`.
13. Record any remaining migration gap explicitly rather than assuming the update is complete.

### Skill Introduction Rules

- New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
- Treat the consuming lane as the default skill-up owner. If a specialist skill is developer-exclusive, `developer` is the default maintenance and upgrade owner while `team-lead` governs approval and adoption.
- Distinguish `specialist skill` from `common skill` before assigning ownership.
  - A `specialist skill` sharpens one lane's charter-bound execution or judgment surface. That lane is the direct patch owner.
  - A `common skill` carries shared runtime, governance, routing, lifecycle, or other cross-lane operating procedure. A common skill is not jointly owned even when many lanes consume it.
- Common-skill ownership follows the Single Writer Principle.
  - Every common skill must have exactly one primary owner.
  - Other impacted lanes are required inspectors, challengers, or reviewers, not co-owners of the direct patch.
  - A patch packet for a common skill must name at minimum: `PRIMARY-OWNER`, `IMPACTED-LANES`, `OVERLAP-REVIEW`, `INFO-LOSS-REVIEW`, and `VERIFY-BASIS`.
- Current default rule for shared team-operation skills:
  - `team-session-sequences` and `team-governance-sequences` are `team-lead`-owned common skills unless an explicit governance decision reassigns them.
  - Impacted lanes may inspect, challenge, and review those skills, but final direct patch execution still belongs to the primary owner.
- Before introducing a new skill, check whether the need is better handled by:
  - updating an existing skill
  - strengthening an existing agent charter
  - adding a path-scoped rule
- If the missing skill is the declared prerequisite for finishing the active task safely or credibly, the skill update or introduction must be completed before the blocked task surface re-enters normal execution, but keep that pause scoped to the blocked surface rather than freezing unrelated safe work.
- A new skill must state:
  - the capability gap it closes
  - its owning role
  - what it does not own
  - when it should be invoked instead of ordinary lane behavior

### Specialist Skill Routing Architecture

- In the current target design, specialist capabilities live as skills under the current project skill root `.claude/skills` using the active specialist subpath `<skill-id>/SKILL.md`, not as active subagents under `.claude/agents/`.
- Authorization packets should name `skill-id` and bind it to the target lane plus blocked surface.
- `developer` resolves `skill-id` against the current project skill root and active specialist subpath.
- `team-lead` may authorize developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- Do not treat a common skill like a developer-exclusive specialist skill by habit.
  - Specialist-skill authorization binds a blocked lane to a bounded specialist aid.
  - Common-skill ownership binds a shared procedure surface to one primary owner plus named impacted lanes.
- For self-growth and consequential quality-hardening claims, default to benchmark-first comparison. Let `researcher` own the benchmark-light evidence shaping for baseline, fairness, comparison-axis framing, provenance visibility, and cross-check visibility; use `bench-sim` as the supporting specialist when the active packet escalates into the full benchmark form.
- When multiple specialist skills are active on one blocked surface, keep the controlling order explicit: `biz-sys` -> `sw-spec` -> domain specialists (`edu-spec`, `eng-spec`, `math-spec`) -> `doc-auto` -> `ui-ux`; `bench-sim` and `int-op` support evaluation or integration without overriding earlier controlling contracts.
- This controlling order is a lead-side routing discipline for logical flow, not a runtime chaining engine. Authorization hooks may gate who can use a specialist skill, but the lead still owns the ordering judgment for the active request.
- When approving developer-side specialist skill use, send an explicit authorization packet to the target developer lane using `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>` so runtime enforcement and human doctrine stay aligned.
- Route specialist skills per the controlling order in the Skill Routing And Specialist Architecture section above. Authorize via `SKILL-AUTH` packet bound to lane, surface, and `skill-id`.

### Skill Introduction Category Gate

- Every proposed new skill must be classified into exactly one primary category before approval:
  - `repeatable procedure`
    - reusable multi-step workflow that will recur across tasks or sessions
  - `specialist judgment surface`
    - recurring expert perspective that sharpens implementation, review, or planning quality
  - `integration or environment bridge`
    - reusable external-tool, connector, or setup protocol with stable verification and fallback steps
  - `governance or quality hardening`
    - reusable review, validation, migration, or operational-discipline procedure not already owned elsewhere
- Reject the proposal when it is primarily:
  - a one-off task brief
  - project-local knowledge that belongs in local doctrine
  - a temporary workaround with no expected reuse
  - a duplicate of an existing skill, agent charter, or rule owner
  - a style preference with no clear reusable procedure or authority boundary
- Approval packet for a new skill must name:
  - category
  - expected reuse pattern
  - existing-owner overlap result
  - chosen owner
  - why existing skill expansion was insufficient
  - first adoption path
- If the proposal cannot survive this category gate cleanly, do not create a new skill. Update the correct existing owner instead.

### Update/upgrade constraints

- No new operational rule without a clear owner.
- Do not weaken shared doctrine silently in lower-level documents.
- Do not leave the same rule half-owned by multiple documents unless duplication is intentional and justified for hierarchy consistency.
- Treat rule, skill, settings, and hook changes as governance-sensitive by default.
- When the active patch is governance-sensitive, the sequence must keep the user-confirmation boundary explicit: classify and prepare autonomously if allowed, but do not execute the actual modification until the operator-facing approval gate is satisfied.

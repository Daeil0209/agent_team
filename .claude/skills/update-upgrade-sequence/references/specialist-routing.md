# update-upgrade-sequence: Specialist Routing
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file when specialist skill routing, `SKILL-AUTH`, owner matrices, or common-vs-specialist routing is material.

## Specialist Skill Routing Architecture
- Specialist capabilities live as skills under the current project skill root `.claude/skills` using the active specialist subpath `<skill-id>/SKILL.md`, not as active agent role files under `.claude/agents/`.
- Authorization packets name `skill-id` and bind it to the target lane plus blocked surface.
- `developer` resolves `skill-id` against the current project skill root and active specialist subpath.
- `team-lead` may authorize developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- Do not treat a common skill like a developer-exclusive specialist skill by habit.
  - Specialist-skill authorization binds a blocked lane to bounded specialist aid.
  - Common-skill ownership binds a shared procedure surface to one primary owner plus named impacted lanes.

For self-growth and consequential quality-hardening claims, default to benchmark-first comparison. Let `researcher` own benchmark-light evidence shaping for baseline, fairness, comparison-axis framing, provenance visibility, and cross-check visibility; use `benchmark-simulation` when the active packet escalates into full benchmark form.

When multiple specialist skills are active on one blocked surface, use the owning role's specialist matrix and controlling order as the source of truth. For developer-owned specialists, consume `.claude/skills/developer/references/developer-lane-detail.md` `Specialist Skill Loading` instead of restating the literal order here. `benchmark-simulation` and `external-tool-bridge` remain support overlays without controlling-chain position.

This controlling order is a lead-side routing discipline for logical flow, not a runtime chaining engine. Authorization hooks may gate who can use a specialist skill, but the lead still owns the ordering judgment for the active request.

When approving developer-side specialist skill use, send:

```
SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>
```

Route specialist skills per the source-of-truth owner reference. Authorize via `SKILL-AUTH` packet bound to lane, surface, and `skill-id`.

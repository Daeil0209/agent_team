---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reference Binding; Skill Loading"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Skill Loading And Reference Binding

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` Skill Loading and reference consumption.
Use it to make loaded documents and references mandatory execution surfaces instead of optional reading.

## Consume When
- An owner document is loaded in the active owner context.
- A rule names a skill.
- A rule names a reference.
- A packet carries `REQUIRED-SKILLS`.
- A packet carries `SKILL-RECOMMENDATIONS`.
- A lane claims completion after using a specialist method.
- A lane claims completion after using a reference.
- A trigger-specific reference is cited by `CLAUDE.md`, an agent file, or a skill.

## Required Output
The consuming owner records:
- loaded skill or reference path
- trigger that required it
- applied rules
- blocked or unavailable rules
- effect on work, packet, proof, handoff, or verdict
- applied-rule mapping to action, stop, evidence, owner, or next-action effect

## Stop
Stop before execution when a required skill is unavailable.
Stop before execution when a required skill is lane-mismatched.
Stop before execution when a required skill is contradictory.
Stop before execution when a required skill is non-fitting.
Stop before execution when a required skill is outside the frozen boundary.
Stop before execution when a loaded document lacks applied-rule mapping.
Stop before completion when a trigger-required reference remains unconsumed.
Stop before handoff when applied or blocked skill/reference basis is missing.

## Next-Action Drive
- A stopped required-skill route opens skill availability correction.
- A stopped required-reference route opens reference consumption.
- A stopped applied-rule route opens loaded-document consumption.
- A stopped handoff route opens applied-basis recording.
- Procedure-bearing reference missing local `Next-Action Drive` opens reference correction.
- A method-detail reference returns applied method basis to the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.

## Skill Rules
- Skills load only when required by the active owner path.
- Skill consumption is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery.
- Loaded skills inherit `CLAUDE.md`.
- Loaded skills inherit active owner role.
- Loaded skills inherit common inheritance floor.
- Loaded skills sharpen owner behavior only within their owner stops.
- Lane-core skills load on assignment-grade lane work.
- Receipt messages load lane-core skills only when they assign or reopen work.
- Control messages load lane-core skills only when they assign or reopen work.
- Status messages load lane-core skills only when they assign or reopen work.
- Lifecycle messages load lane-core skills only when they assign or reopen work.
- Phase messages load lane-core skills only when they assign or reopen work.
- Clarification messages load lane-core skills only when they assign or reopen work.
- Loaded lane-core skill outranks packet skill fields inside the lane.
- Doctrine outranks loaded lane-core skills.
- Roles outrank loaded lane-core skills.
- Owner gates outrank loaded lane-core skills.

## Required Skills
- Required-skill freezing is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery.
- Required non-lane-core skills freeze through planning basis.
- Required non-lane-core skills freeze through workflow basis.
- Required non-lane-core skills freeze through phase basis.
- Packetize required non-lane-core skills as `REQUIRED-SKILLS`.
- Agent-facing `REQUIRED-SKILLS` entries are mandatory consumption duties.
- The receiving lane loads each `REQUIRED-SKILLS` entry before execution.
- The receiving lane applies each `REQUIRED-SKILLS` entry before execution.
- The receiving lane loads each `REQUIRED-SKILLS` entry before handoff.
- The receiving lane applies each `REQUIRED-SKILLS` entry before handoff.
- Classify missing required skill consumption as a packet defect when the packet omitted it.
- Classify missing required skill consumption as a lane defect when the lane ignored it.

## Methodology Guidance
- Packetize methodology guidance as `SKILL-RECOMMENDATIONS`.
- The assigned lane classifies every carried recommendation as applied, not-material, or blocked before handoff.
- The assigned lane records the basis for each recommendation classification.
- The assigned lane selects material recommendations.
- The assigned lane loads material recommendations before lane work.
- The assigned lane applies material recommendations before lane work.
- The assigned lane hands off applied recommendation basis.
- The assigned lane hands off blocked recommendation basis.

## Reference Binding
- A trigger-bound reference is mandatory when its trigger is active.
- A loaded owner document is mandatory when it is present in the active owner context.
- Consumption means mapping active rules to action, stop, evidence, owner, or next-action effect.
- Skim, title lookup, summary awareness, and memory-based use leave the document unconsumed.
- A trigger-bound reference carries `SOURCE-ANCHOR`.
- A trigger-bound reference carries `SOURCE-RULES`.
- A procedure-bearing reference carries local `Next-Action Drive`.
- A method-detail reference returns applied method basis through the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.
- Procedure-bearing classification covers sequence, dispatch, lifecycle, mutation, review, proof, validation, acceptance, stop, gate, and route behavior.
- Method-detail classification covers skill-owned methods, checklists, field schemas, matrices, protocols, and examples inside an already opened owner path.
- Lookup-only classification covers terms, lists, source facts, and controlled values inside an already opened owner path.
- A method-detail reference that opens independent owner/path behavior is procedure-bearing.
- Procedure-bearing reference completion requires local `Next-Action Drive`.
- Treat an unconsumed trigger-required reference as completion blocker.
- Treat missing applied-rule mapping as execution blocker.
- Reference consumption must be visible in the owner-local packet, handoff, proof, verdict, or `SV-RESULT` when material.
- Load references only through trigger-bound consumption.
- Treat `@imports` as context organization.
- Measure launch context footprint independently from `@imports` organization.
- Official-source cache lives in `.claude/reference/official-claude-code-reference.md`.
- Refresh official docs when current product behavior matters.

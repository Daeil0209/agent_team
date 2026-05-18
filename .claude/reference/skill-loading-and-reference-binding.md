---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reference Binding; Skill Loading"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Skill Loading And Reference Binding

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` Skill Loading and reference consumption.
Use it to make loaded documents and references mandatory execution surfaces instead of passive reading.

## Reporting Curtain Inheritance
This reference governs skill loading and reference binding, not report admission.
User-facing prose is owned by `.claude/reference/user-reporting-law.md`.

## Consume When
- An owner document is loaded in the active owner context.
- Before a `Skill(<skill>)` tool call.
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
- effect on work, packet, proof, completion, or verdict
- applied-rule mapping to action, stop, evidence, owner, or next-action effect

## Stop
Stop before execution when:
- a required skill is unavailable
- a required skill is lane-mismatched
- a required skill is contradictory
- a required skill is non-fitting
- a required skill is outside the frozen boundary
- a loaded document lacks applied-rule mapping
Stop before completion when a trigger-required reference remains unconsumed.
Stop before completion when applied or blocked skill/reference basis is missing.

## Resolve Next Owner And Action
- A stopped required-skill route opens skill availability correction.
- A stopped required-reference route opens reference consumption.
- A stopped applied-rule route opens loaded-document consumption.
- A stopped completion route opens applied-basis recording.
- Procedure-bearing reference missing a local `Resolve Next Owner And Action` section opens reference correction.
- A method-detail reference returns applied method basis to the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.

## Skill Rules
- Skills load only when required by the active owner path.
- Skill-load eligibility is decided from the interpreted requested outcome or runtime-owned trigger, not from skill names, document names, doctrine names, or procedure words in the user message.
- Before `Skill(<skill>)`, the consuming owner proves the requested outcome creates that skill's active execution owner path and why answer, `Read`, or `Grep` is insufficient.
- Learning, relearning, familiarization, doctrine refresh, audit, and patch-design inspection consume live documents by `Read` or `Grep` unless the requested outcome also requires that skill's execution artifact.
- Skill load means `Skill(<skill>)`.
- Skill consumption is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery.
- Skill-owned surfaces under `.claude/skills/<skill>/` are entered through `Skill(<skill>)` before direct `Read`, `Grep`, `Glob`, or `LS` only when the active owner path needs that skill's execution method or named artifact.
- Agent role names are not valid skill names.
- Lane agent-specific skills use `agent-<lane>` names.
- Team-lead procedure skill uses `agent-team-lead`.
- Team-lead procedure references live under `.claude/skills/agent-team-lead/references/` and are skill-owned surfaces.
- `agent-team-lead` loads when the team-lead role opens lead-owned procedure triggers.
- Loaded skills inherit:
  - `CLAUDE.md`
  - active owner role
  - Common Lane-Core Preconditions when the loaded owner is a lane
- Loaded skills sharpen owner behavior only within their owner stops.
- Lane agent-specific skills load on assignment-grade lane work.
- These messages load agent-specific skills only when they assign or reopen work:
  - receipt messages
  - control messages
  - status messages
  - lifecycle messages
  - phase messages
  - clarification messages
- Loaded agent-specific skill outranks packet skill fields inside the lane.
- These outrank loaded agent-specific skills:
  - doctrine
  - roles
  - owner gates

## Required Skills
- Required-skill freezing is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery.
- Required methodology or capability skills freeze through:
  - planning basis
  - workflow basis
  - phase basis
- Packetize required methodology or capability skills as `REQUIRED-SKILLS`.
- Agent-facing `REQUIRED-SKILLS` entries are mandatory consumption duties.
- The receiving lane must:
  - load each `REQUIRED-SKILLS` entry before execution
  - apply each `REQUIRED-SKILLS` entry before execution
  - record applied or blocked basis for each `REQUIRED-SKILLS` entry before completion
- Classify missing required skill consumption as:
  - a packet defect when the packet omitted it
  - a lane defect when the lane ignored it

## Methodology Guidance
- Packetize methodology instructions as `SKILL-RECOMMENDATIONS`.
- The assigned lane must:
  - classify every carried recommendation as applied, not-material, or blocked before completion
  - record the basis for each recommendation classification
  - select material recommendations
  - load material recommendations before lane work
- The assigned lane applies material recommendations before lane work.
- The assigned lane hands off applied recommendation basis.
- The assigned lane hands off blocked recommendation basis.

## Reference Binding
- Trigger-bound reference and loaded-owner-document mandatoriness is owned by `.claude/reference/procedure-and-ownership-law.md` `## Rules`.
- Consumption means mapping active rules to concrete action, stop, evidence, owner, next-action effect, or blocked basis.
- Loading, naming, quoting, or summarizing a governance document is not consumption.
- Before action, report, completion, or verdict, classify current-surface active rules as `applied`, `not-material:<basis>`, or `blocked:<basis>`.
- `applied` means the rule changed, confirmed, stopped, or routed concrete behavior.
- Missing material applied-rule mapping stops action and opens applied-rule correction.
- Governance compliance claims require recorded applied-rule mapping.
- Skim, title lookup, summary awareness, and memory-based use leave the document unconsumed.
- A trigger-bound reference carries `SOURCE-ANCHOR` and `SOURCE-RULES`.
- Bare governance paths such as `agents/...`, `skills/...`, `reference/...`, and `hooks/...` resolve from `.claude/` unless the current line names another root.
- A procedure-bearing reference carries a local `Resolve Next Owner And Action` section.
- Missing this section blocks completion and opens reference correction.
- A method-detail reference returns applied method basis through the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.
- Procedure-bearing classification covers sequence, dispatch, lifecycle, mutation, review, proof, validation, acceptance, stop, gate, and route behavior.
- Method-detail classification covers skill-owned methods, checklists, field schemas, matrices, protocols, and examples inside an already opened owner path.
- Lookup-only classification covers terms, lists, source facts, and controlled values inside an already opened owner path.
- A method-detail reference that opens independent owner/path behavior is procedure-bearing.
- Unconsumed-trigger-required-reference and missing-applied-rule-mapping blocker rules are owned by this `## Reference Binding` section; `.claude/CLAUDE.md` `## Reference Binding` carries the top-doctrine anchor.
- Reference consumption must be recorded in the owner-local packet, completion carrier, proof, verdict, or `Skill(self-verification)` record when material.
- Load references only through trigger-bound consumption.
- Treat `@imports` as context organization.
- Measure launch context footprint independently from `@imports` organization.
- Official-source cache lives in `.claude/reference/official-claude-code-reference.md`.
- Refresh official docs when current product behavior matters.

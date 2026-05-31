---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Work Execution Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Common Doctrine Reference: Skill Loading And Reference Binding

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` skill loading, document consumption, and reference consumption.
Use it to make loaded documents, loaded skills, and references mandatory execution surfaces instead of passive reading or invocation-status evidence.

## Reporting Curtain Inheritance
This reference governs skill loading and reference binding, not report exceptions.
Report admission is owned by `.claude/reference/reporting-prohibition-law.md`; admitted report shape is owned by `.claude/reference/reporting-user-reporting-law.md`.

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
- loaded-skill basis as full-body `Skill(<skill>)` load-and-learn or the named skill's current same-session loaded-and-learned token
- trigger that required it
- applied rules
- blocked or unavailable rules
- effect on action, stop, evidence, packet, proof, completion, verdict, routing, or patch-readiness
- applied-rule mapping to action, stop, evidence, owner, or next-action effect
Reference consumption requires direct effect on the active action, stop, evidence, packet, proof, completion, verdict, routing, or patch-readiness; existence, discoverability, citation convenience, broad traceability, reverse-linking, or possible future use is insufficient.

## Routing Gate
Execution requires:
- required skills available
- required skills lane-fitting
- required skills noncontradictory
- required skills fitting the active owner path
- required skills inside the frozen boundary
- loaded documents carrying applied-rule mapping
Execution, positive synthesis, and completion require cited references to carry direct-consumption relevance.
Completion requires every trigger-required reference consumed and every material skill/reference basis recorded as `applied`, `not-material:<basis>`, or `blocked:<basis>`.

## Resolve Next Owner And Action
- Required-skill gaps open skill availability correction.
- Required-reference gaps open reference consumption.
- Applied-rule gaps open loaded-document consumption.
- Direct-consumption relevance gaps remove the cited reference, replace it with the exact consumed owner surface, or record the applied-rule mapping that proves consumption.
- Completion-basis gaps open applied-basis recording.
- Procedure-bearing reference missing a local `Resolve Next Owner And Action` section opens reference correction.
- A method-detail reference returns applied method basis to the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.

## Skill Rules
- Skill-load eligibility is decided from the interpreted requested outcome or runtime-owned trigger, not from skill names, document names, doctrine names, or procedure words in the user message.
- Primary skill links become required skills only when their trigger creates the active owner path.
- Required skill activation and loaded-skill basis are satisfied only by actual full-body `Skill(<skill>)` load-and-learn or a current same-session loaded-and-learned basis under the named skill's freshness rule.
- Same-session loaded-and-learned basis is executable only while the invoked full skill body still supplies the rule needed for the current owner path.
- Treat loaded-skill basis as stale when the session changed, the skill file changed after invocation, compaction/drop/truncation can affect the needed rule, or the active owner path needs unconsumed trigger-specific detail.
- Stale or uncertain loaded-skill basis must not execute the action; open the smallest refresh action: reload and learn `Skill(<skill>)` when skill-body rules are needed, or consume the exact trigger-specific reference when reference detail is sufficient.
- When a primary skill trigger fires, skipping activation is classified as a Work Execution Philosophy violation.
- `Read`, `Grep`, `Glob`, `LS`, summary, memory, frontmatter preload claims, or reference-map traversal of `.claude/skills/<skill>/**` remains inspection only and never proves full-body skill learning or applied consumption.
- Host-rendered tool rows, tool status, and visible `Skill(...) loaded` text are invocation/status evidence only; they never replace full-body load-and-learn or applied-rule mapping.
- Before `Skill(<skill>)`, the consuming owner proves the requested outcome creates that skill's active execution owner path; pre-invocation inspection supports eligibility only.
- Learning, relearning, familiarization, doctrine refresh, audit, and patch-design inspection consume live documents only by reading and learning the complete active document or complete triggered section; `Grep` is discovery and anchor evidence only, not document consumption.
- Skill consumption is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery.
- Skill-owned surfaces under `.claude/skills/<skill>/` are entered through full-body `Skill(<skill>)` load-and-learn before direct `Read`, `Grep`, `Glob`, or `LS` when the active owner path needs that skill's execution method or named artifact.
- Agent role names are not skill names.
- Agent role files identify the role through frontmatter `name` and role-local boundary prose; headings are optional readability anchors.
- Agent role files keep `PRIMARY-OWNER` metadata absent.
- Always-loaded role files keep identity, authority, trigger skeleton, mandatory reference links, decisive routing conditions, and next-owner routing.
- Situation-specific procedure detail stays in trigger-bound skill references that the active owner path consumes.
- Lane agent-specific skills use `agent-<lane>` names.
- Team-lead procedure skill uses `agent-team-lead`.
- Team-lead procedure references live under `.claude/skills/agent-team-lead/references/` and are skill-owned surfaces.
- The top-level agent-team `team-lead` session loads and learns `Skill(agent-team-lead)` before lead-owned procedure movement.
- `agent-team-lead` also loads before lead-owned procedure triggers when no current same-session `agent-team-lead` load basis exists.
- Same-session `agent-team-lead` reuse follows `.claude/skills/agent-team-lead/SKILL.md` `# Activation`.
- Loaded skills inherit:
  - `CLAUDE.md`
  - active owner role
  - Common Lane-Core Preconditions when the loaded owner is a lane
- Procedure skills control their declared owner, phase owner, or sequence owner before loader ownership.
- Skills without a procedure-owner declaration execute under the agent that loaded the skill.
- Loaded skills sharpen the loading agent or active procedure owner behavior only within the active routing boundary.
- A named skill's freshness rule governs same-session loaded-and-learned skill reuse.
- Lane agent-specific skills load on assignment-grade lane work.
- These messages load agent-specific skills only when they assign or reopen work:
  - receipt messages
  - control messages
  - status messages
  - lifecycle messages
  - phase messages
  - clarification messages
- Loaded skill rules, role-body rules, and trigger-bound reference rules outrank packet field values; a packet field that contradicts a binding rule from those surfaces is a packet defect, and the receiving owner records non-rendered `problem-report`, then sends no-detail `scope-pressure` with scope-pressure carrier `CORRECTION-OUTCOME: packet-correction` before `dispatch-ack`, work, or completion.
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
- Required-skill intake order is validate, then load/apply or block.
- Validate each `REQUIRED-SKILLS` entry for availability, lane fit, owner authority, boundary fit, and required lens or field shape before loading.
- Invalid, lane-mismatched, contradictory, non-fitting, outside-boundary, owner-reserved, or malformed required-skill entries record `blocked:<basis>` and route through the owning packet-correction, `scope-pressure`, or `hold|blocker` path.
- A blocked required-skill entry routes through packet-correction, `scope-pressure`, or `hold|blocker` with its `blocked:<basis>` record.
- A valid, lane-executable `REQUIRED-SKILLS` entry is material by packet contract; if it cannot shape the assigned work, classify it as non-fitting and route blocked packet truth before lane work.
- For each valid, lane-executable `REQUIRED-SKILLS` entry, the receiving lane must:
  - load-and-learn each `REQUIRED-SKILLS` entry before execution
  - apply each `REQUIRED-SKILLS` entry at the first material work surface where the skill can shape the assigned result
  - record applied basis before completion
- The receiving lane records blocked basis for each invalid, unavailable, lane-mismatched, contradictory, non-fitting, outside-boundary, owner-reserved, malformed, or unavailable required-skill entry before surfacing the correction path.
- Classify missing required skill consumption as:
  - a packet defect when the packet omitted it
  - a packet defect when the packet carried an invalid, lane-mismatched, contradictory, non-fitting, outside-boundary, owner-reserved, or malformed entry
  - a lane defect when a valid, lane-executable entry was ignored or completed without applied basis
  - an additional lane defect when the lane accepted, executed, or completed after a blocked entry without surfacing the packet defect

## Methodology Guidance
- Packetize methodology instructions as `SKILL-RECOMMENDATIONS`.
- The assigned lane must:
  - classify every carried recommendation as applied, not-material, or blocked before completion
  - record the basis for each recommendation classification
  - select material recommendations
  - load-and-learn material recommendations before the work surface they shape
- Recommendation intake order is classify, then load-and-learn material recommendations or record `not-material:<basis>` / `blocked:<basis>`.
- Invalid, lane-mismatched, contradictory, outside-boundary, owner-reserved, malformed, or full-workflow-only recommendations record `blocked:<basis>` and route through the owning correction path when they affect truthful execution.
- Non-fitting recommendations with no truthful-execution effect record `not-material:<basis>` before completion.
- Silent recommendation skipping is a completion blocker.
- The assigned lane applies material recommendations at the first material work surface where the skill can shape the assigned result.
- The assigned lane hands off applied recommendation basis.
- The assigned lane hands off blocked recommendation basis.

## Reference Binding
- Trigger-bound reference and loaded-owner-document mandatoriness is owned by `.claude/reference/work-procedure-ownership-law.md` `## Rules`.
- A trigger-active pointer from a Reference Map, rule text, packet field, or loaded owner document opens a bounded consumption handoff for the governed action or claim.
- The active owner resolves that handoff by recording `applied`, `not-material:<basis>`, or `blocked:<basis>` and mapping each material active rule to the concrete action, stop, evidence, owner, or route.
- Valid consumption uses live loaded surface evidence from the complete active document or complete triggered section plus applied-rule mapping; the `## Skill Rules` inspection-only/status evidence set remains background context only.
- Consumption means mapping active rules to concrete action, stop, evidence, owner, next-action effect, or blocked basis.
- Direct-consumption relevance means the target changes active owner action, stop, evidence requirement, packet content, proof basis, completion truth, verdict, routing, or patch-readiness.
- Loading, naming, quoting, or summarizing a governance document is not consumption.
- Before action, report, completion, or verdict, classify current-surface active rules as `applied`, `not-material:<basis>`, or `blocked:<basis>`.
- `applied` means the rule changed, confirmed, or routed concrete behavior.
- Missing material applied-rule mapping opens applied-rule correction before action.
- Governance compliance claims require recorded applied-rule mapping.
- Skim, partial search, title lookup, and every inspection-only/status evidence form named in `## Skill Rules` leave the document unconsumed unless complete active document or triggered-section learning plus applied-rule mapping is recorded.
- A trigger-bound reference carries `SOURCE-ANCHOR` and `SOURCE-RULES`.
- Reference frontmatter `PRIMARY-OWNER` names the executable owner authority (`team-lead` or lane agent), not the skill or reference file itself.
- Skill or reference file ownership is expressed through `SOURCE-ANCHOR`, `REFERENCE-OWNER`, or an explicit local consumption note.
- Bare governance paths such as `agents/...`, `skills/...`, `reference/...`, and `hooks/...` resolve from `.claude/` unless the current line names another root.
- A procedure-bearing reference carries a local `Resolve Next Owner And Action` section.
- Missing this section blocks completion and opens reference correction.
- A method-detail reference returns applied method basis through the parent skill workflow.
- A lookup-only reference returns consumed facts to the active consuming owner.
- Procedure-bearing classification covers sequence, dispatch, lifecycle, mutation, review, proof, validation, acceptance, stop, gate, and route behavior.
- Method-detail classification covers skill-owned methods, checklists, field schemas, matrices, protocols, and examples inside an already opened owner path.
- Lookup-only classification covers terms, lists, source facts, and controlled values inside an already opened owner path.
- A method-detail reference that opens independent owner/path behavior is procedure-bearing.
- Unconsumed-trigger-required-reference and missing-applied-rule-mapping blocker rules are owned by this `## Reference Binding` section; `.claude/CLAUDE.md` `## 3. Work Execution Philosophy` carries the top-doctrine anchor.
- Reference consumption must be recorded in the owner-local packet, completion carrier, proof, verdict, or `Skill(self-verification)` record when material.
- Load references only through trigger-bound consumption.
- Treat `@imports` as context organization.
- Measure launch context footprint independently from `@imports` organization.
- Official-source cache lives in `.claude/reference/environment-official-claude-code-source-cache.md`.
- Refresh official docs when current product behavior matters.

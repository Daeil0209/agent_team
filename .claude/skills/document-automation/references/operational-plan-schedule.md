---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/document-automation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# document-automation: Operational Plans And Schedules
Use when the document is an operational plan, schedule, timetable, resource plan, or execution-control schedule.

## Operational Plans/Schedules
- Preserve hidden time, transition burden, dependency conflicts, resource conflicts, buffer logic, approval checkpoints, and version-management expectations.
- Distinguish notice-facing variants from execution-control variants.
- Choose representation by audience, dependency shape, change rate, and misread risk.
- Representation options include table, timeline, gantt, checklist, and split-version.
- Generation order canonical owner: `.claude/skills/business-workflow/references/schedule-planning-workflow.md` `## Generation State Machine` (8-step superset including representation/tooling step 4 + version separation + compression). Document-automation consumes that canonical sequence; any document-drafting-specific addendum (e.g., visual layout polish at compression stage) carries `PROTECTED-LOCAL-RESTATEMENT-BASIS: document-drafting variant` and lives below this line.
- Place buffers by risk segment.
- Risk segments include post-travel, pre-transition, post-meal, multi-person movement, and external-variable periods.
- Execution-control minimum field set: activity, time, responsible person, location, preparation items, prerequisites, status, and approval state.
- Mandatory feasibility review checks hidden-time completeness, responsible-person duplication, equipment/resource conflict, buffer sufficiency, overcrowded slots, approval-timing gaps, and parallel-task interference.
- Any mandatory feasibility failure marks `HOLD`.
- Acceptance priority order is executability, zero-ambiguity comprehension, change resilience, then hidden-time completeness.
- Visual tidiness is outside acceptance when it conflicts with the four acceptance priorities.
- Cascade structure from purpose type.
- Education-focused schedules prioritize concentration and rest rhythm.
- Event-focused schedules prioritize flow and transition continuity.
- Development-focused schedules prioritize dependency and approval sequence.
- Multi-purpose schedules require explicit priority ranking among purpose types.
- Missing priority ranking in a multi-purpose schedule is a structural defect.

## Resolve Next Owner And Action
- Return schedule mode, representation choice, feasibility findings, buffer logic, acceptance priority, and purpose-priority ranking to the active document-automation workflow.
- If feasibility fails, route the exact `HOLD` basis and smallest correcting owner before schedule generation continues.

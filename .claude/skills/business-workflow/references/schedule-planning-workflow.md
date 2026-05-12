---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "domain-rule-catalog.md routed Schedule Planning Domain Rules"
LOAD-POLICY: on-demand reference only
---

# Schedule Planning Workflow Rules

## Purpose
Use this reference for automated generation or validation of operational schedules, event timelines, team activity schedules, and institutional program schedules.

## Schedule Purpose
Classify schedule purpose before generation.
Purpose classes are operations-execution, participant-announcement, and approval-submission.
Operations-execution schedules include owner, status, dependencies, prerequisites, and execution control detail.
Participant-announcement schedules include time, location, and preparation items.
Approval-submission schedules show feasibility, cost, and risk.
Purpose determines field density, required columns, tone, and output format.

## Hidden Time
Schedules account for transit, setup, teardown, distribution, entry, assembly, equipment deployment, equipment testing, approval wait, response wait, and cleanup when applicable.
Each applicable hidden-time category receives an explicit time block or dependency basis.

## Buffers
Buffers are mandatory constraints at identified risk zones.
Risk zones include post-transit, pre-transition, post-meal, multi-person movement, weather, vendor delay, and equipment failure.
Buffer strategy matches the schedule's change-resilience requirement.
Distributed small buffers and terminal large buffers are selected by risk shape.

## Audience Versions
Every schedule deliverable requires an operations version and an announcement version unless the frozen request explicitly narrows the audience.
Operations version carries owner, status, approval gates, location detail, prerequisites, and contingency notes.
Announcement version carries time, location, and participant preparation items.

## Conflict Detection
Person duplication checks overlapping time blocks.
Equipment and venue collision checks double-booked resources.
Approval-prerequisite timing checks activities scheduled before prerequisite approval or deliverable availability.
Unresolved conflicts block final schedule output.

## Fatigue And Rhythm
Early-morning peak favors high-concentration tasks.
Post-lunch dip keeps demanding cognitive work outside 13:00 to 14:30 unless a hard schedule constraint blocks it.
Post-transit recovery uses light activity after significant movement.
Long sessions require a break or format change after 90 continuous minutes when material.

## Schedule Quality Gate
Executable schedules give every block sufficient time, resources, and prerequisites.
Unambiguous schedules name who, where, and what.
Change-resilient schedules include a buffer strategy that absorbs single-point delays.
Hidden-time-complete schedules account for all applicable hidden-time categories.
Failing any criterion blocks final schedule output.

## Generation State Machine
Schedule generation follows this dependency chain:
1. Purpose classification.
2. Audience identification.
3. Constraint capture.
4. Element arrangement.
5. Feasibility validation.
6. Version separation.
7. Compression.
Validation gates outrank generation speed.

## Change Management
Simple schedules carry a clear date stamp and latest-version signal.
Complex schedules carry version number, revision timestamp, modifier identity, change reason, and impact trace.

## Tool And Format Selection
Table format fits dense parallel tracks and resource allocation.
Timeline format fits sequential flow and duration visibility.
Gantt format fits dependency chains and critical path.
Checklist format fits execution verification and status tracking.
Authoring format and distribution format can differ.

## Resolve Next Owner And Action
- Complete schedule rule packet opens document-automation or implementation design.
- Failed conflict detection opens schedule correction.
- Missing hidden-time or buffer basis opens schedule correction.
- Missing audience version basis opens schedule correction or frozen narrowing.

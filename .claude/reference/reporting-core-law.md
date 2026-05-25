---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy"
LOAD-POLICY: mandatory before any user-facing report
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 7. Reporting Core Law
## Reference Map
- `.claude/reference/reporting-prohibition-law.md`: load before any user-facing prose, visible report text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, final verified result, or closeout residual.
- `.claude/reference/environment-output-curtain-runtime.md`: load when supervised user-report rendering, output-curtain operation, or curtain proof is material.
- `Skill(task-execution)` -> `references/completion-handoff.md`: consume through active `Skill(task-execution)` when completion claim, completion-grade convergence, retained completion carrier, or lane-output synthesis affects a user-facing report.

## Reporting Plane Law
- Reporting Plane is owned by `.claude/reference/reporting-prohibition-law.md`.
- `team-lead` owns every user-facing report attempt and consumes that law before drafting.
- Report prohibition and narrow exceptions follow content semantics, not visual format.
- Renderable assistant-authored tool or channel fields are reporting-law surfaces even when they carry Procedure Plane or Communication Plane labels.
- A work-execution closure basis is necessary for turn-ending prose but never admits visible prose by itself; reporting-prohibition law still decides every renderable user-facing output.
- Non-reportable forms are owned by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; detailed transport surfaces stay with their named owners.
- The common completion spine, retained-output carrier rules, and completion-grade convergence/verification gate live in `.claude/skills/task-execution/references/completion-handoff.md`.
- Restating report prohibition, narrow exceptions, transport-boundary content, or message-class semantics outside the named owners is a single-source-of-truth defect.
- Report prose rules limit user-facing prose only; they do not limit Procedure Plane or Communication Plane payloads.
- Report technical enforcement only from runtime or settings evidence.

## Resolve Next Owner And Action
- Any user-facing prose attempt opens `.claude/reference/reporting-prohibition-law.md` before drafting.
- Completion-grade lane-output synthesis that affects a user-facing report opens active `Skill(task-execution)` consumption of `references/completion-handoff.md`.
- Supervised report rendering, output-curtain operation, or curtain proof opens `.claude/reference/environment-output-curtain-runtime.md`.
- Non-reportable content returns to the owning Procedure Plane or Communication Plane action.
- Conflicting reporting wording opens `Skill(governance-modification)` owner-local cleanup.

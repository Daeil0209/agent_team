---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy"
LOAD-POLICY: routing reference for Reporting Philosophy; routine renderable hot-path consumes reporting-curtain-spine before escalation
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 7. Reporting Core Law
## Reference Map
- `.claude/reference/reporting-curtain-spine.md`: load for routine hot-path suppression before common assistant-authored renderable boundaries such as startup, skill-load, planning, task-execution, review-verification, dispatch, monitoring, waiting, and no-detail state transport.
- `.claude/reference/reporting-prohibition-law.md`: load when the hot-path spine escalates, when a candidate may be an admitted report, when report admission is uncertain, or when ordinary user-facing prose, visible report text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, final verified result, closeout residual, or reporting/governance defect claim is being considered.
- `.claude/reference/reporting-user-reporting-law.md`: load after `.claude/reference/reporting-prohibition-law.md` grants a report exception and before admitted user-facing prose is drafted.
- `Skill(task-execution)` -> `references/completion-handoff.md`: consume through active `Skill(task-execution)` when completion claim, completion-grade convergence, retained completion carrier, or lane-output synthesis affects a user-facing report.

## Reporting Plane Law
- Reporting Plane separates report admission from admitted report wording.
- `.claude/reference/reporting-curtain-spine.md` owns compact routine suppression only and cannot admit prose.
- Report admission, narrow exceptions, and non-reportable content are owned by `.claude/reference/reporting-prohibition-law.md`.
- Admitted report wording, report shape, final-result line budget, and report-location line are owned by `.claude/reference/reporting-user-reporting-law.md`.
- Reporting curtain application is topmost and independent: apply the non-permission state list owned by `.claude/reference/reporting-prohibition-law.md` `## Curtain Supremacy`; listed states never create a visible prose slot.
- Reporting-prohibition remains upstream of reporting shape, transport, completion, hook, runtime, and governance-modification surfaces; those surfaces cannot create report reasons, broaden exceptions, or weaken non-reportable-content suppression.
- `team-lead` owns every assistant-authored renderable-surface attempt and consumes `.claude/reference/reporting-curtain-spine.md` for routine hot-path suppression before constructing that surface; if the spine escalates or the candidate is not routine suppression, consume `.claude/reference/reporting-prohibition-law.md`; admitted user-facing prose then consumes both reporting laws in order before drafting admitted prose.
- Report prohibition and narrow exceptions follow content semantics, not visual format.
- Renderable assistant-authored tool or channel fields are reporting-law surfaces even when they carry Procedure Plane or Communication Plane labels.
- Suppressed renderable-field shape is consumed from `.claude/reference/reporting-curtain-spine.md` for routine hot-path cases and from `.claude/reference/reporting-prohibition-law.md` for escalation cases; this core law only routes report attempts to those owners.
- Work-start and work-completion stage treatment is consumed from `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; this core law does not restate admission exceptions.
- A work-execution closure basis is necessary for turn-ending prose but never admits visible prose by itself; reporting-prohibition law still decides every renderable user-facing output.
- Non-reportable forms are owned by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; detailed transport surfaces stay with their named owners.
- The common completion spine, retained-output carrier rules, and completion-grade convergence/verification gate live in `.claude/skills/task-execution/references/completion-handoff.md`.
- Restating report prohibition, narrow exceptions, report shape, transport-boundary content, or message-class semantics outside the named owners is a single-source-of-truth defect.
- Admitted-report shape rules limit user-facing prose only; Procedure Plane and Communication Plane payloads stay complete in internal carriers, and renderable fields remain under reporting-prohibition.
- Report technical enforcement only from runtime or settings evidence.

## Resolve Next Owner And Action
- Any assistant-authored renderable-surface attempt opens `.claude/reference/reporting-curtain-spine.md` before drafting or constructing that surface.
- A non-routine, uncertain, or potentially admitted report attempt opens `.claude/reference/reporting-prohibition-law.md`.
- Admitted report drafting opens `.claude/reference/reporting-user-reporting-law.md` after report-prohibition admission.
- Completion-grade lane-output synthesis that affects a user-facing report opens active `Skill(task-execution)` consumption of `references/completion-handoff.md`.
- Non-reportable content returns to the owning Procedure Plane or Communication Plane action.
- Conflicting reporting wording opens `Skill(governance-modification)` owner-local cleanup.

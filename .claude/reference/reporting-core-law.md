---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy"
LOAD-POLICY: mandatory before any user-facing report
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
PROTECTED-CURTAIN-SURFACE: entire file. Removal-first / consolidate / tighten / reduce / sweep operations require validator pre-approval + user notification per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`.
---
# 7. Reporting Core Law
## Reference Map
- `.claude/reference/reporting-prohibition-law.md`: load before any user-facing prose, visible report text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, final verified result, or closeout residual.
- `.claude/reference/environment-output-curtain-runtime.md`: load when supervised user-report rendering, output-curtain operation, or curtain proof is material.
- `Skill(task-execution)` -> `references/completion-handoff.md`: consume through active `Skill(task-execution)` when completion claim, completion-grade convergence, retained completion carrier, or lane-output synthesis affects a user-facing report.

## Reporting Plane Law
- Reporting Plane is owned by `.claude/reference/reporting-prohibition-law.md`.
- `team-lead` owns every user-facing report attempt and consumes that law before drafting.
- A work-execution closure basis is necessary for turn-ending prose but never admits visible prose by itself; reporting-prohibition law still decides every renderable user-facing output.
- Non-reportable forms are owned by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; detailed transport surfaces stay with their named owners.
- The common completion spine, retained-output carrier rules, and completion-grade convergence/verification gate live in `.claude/skills/task-execution/references/completion-handoff.md`.
- Restating report prohibition, narrow exceptions, transport-boundary content, or message-class semantics outside the named owners is a single-source-of-truth defect.
- Report prose rules do not reduce non-rendered Procedure Plane or Communication Plane payload completeness; any renderable field carrying those payloads remains governed by the reporting curtain.
- Per `.claude/CLAUDE.md` `## 7. Reporting Philosophy` technical-enforcement evidence rule, user-facing technical-enforcement reports rest only on runtime or settings evidence.

## Constitutional 4-Invariant Detail
Per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain`, four invariants govern the reporting curtain and have executable detail here.
- Invariant (a) topmost: any owner consuming governance for an assistant-authored emission decision consumes the constitutional curtain section first, before §1-§8 philosophy chain, before mapped core laws, before skills, before references, before role bodies. Startup contracts citing `.claude/reference/reporting-core-law.md` and `.claude/reference/reporting-prohibition-law.md` before visible prose remain in effect; topmost invariant means the constitutional section of CLAUDE.md is consumed before everything else.
- Invariant (b) independent: curtain enforcement does not depend on which other governance is loaded, which skill is active, which workflow phase is running, which assignment is in flight, or which user redirect occurred. Curtain stays the same shape across every internal state.
- Invariant (c) priority: at every controllable emission moment (tool-adjacent prose, assistant-authored command stdout/stderr, turn-ending prose, outgoing `SendMessage` rendered envelope, process-spawn prompts), the Pre-Report Gate test is applied first; result determines whether prose composition proceeds.
- Invariant (d) always-maintained: any governance patch that would affect a Constitutional Curtain Protection enumerated surface requires `Skill(governance-modification)` review-verification packet + validator pre-approval + user notification per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`.
- Operational anchor for "controllable emission moments": (1) visible assistant prose before, between, or after tool calls, (2) assistant-authored stdout/stderr intentionally produced by tool commands, (3) turn-ending main response visible body, (4) `SendMessage` `summary` + `message` rendered to user-visible UI, (5) assistant-authored content placed into rendered teammate-notification fields, (6) `Agent` / `TeamCreate` member-creation `prompt` rendered to user-visible UI. Uncontrollable surfaces (tool result frames, host-generated notification chrome, host system reminders, and harness-generated rows) are out of scope only when no assistant-authored content is placed into a renderable field or intentionally written to stdout/stderr.
- Operational anchor for atomic-test at emission moment: before composing visible prose on a controllable surface, the assistant tests Pre-Report Gate rows 1-9 in `.claude/reference/reporting-prohibition-law.md` against the candidate emission. Autonomous emission is admitted only for `REPORT-REASON: final verified result`; non-final exceptions require the reporting law's explicit interruption or true-no-continuation basis. Otherwise the candidate is suppressed and the assistant continues the active Procedure Plane action.

## Resolve Next Owner And Action
- Any user-facing prose attempt opens `.claude/reference/reporting-prohibition-law.md` before drafting.
- Completion-grade lane-output synthesis that affects a user-facing report opens active `Skill(task-execution)` consumption of `references/completion-handoff.md`.
- Supervised report rendering, output-curtain operation, or curtain proof opens `.claude/reference/environment-output-curtain-runtime.md`.
- Non-reportable content returns to the owning Procedure Plane or Communication Plane action.
- Conflicting reporting wording opens `Skill(governance-modification)` owner-local cleanup.

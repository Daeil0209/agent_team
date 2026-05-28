---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; Work Execution Philosophy communication-plane boundary"
LOAD-POLICY: mandatory before any user-facing report
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
PROTECTED-CURTAIN-SURFACE: entire file. Enumerated in `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`. Removal-first / consolidate / tighten / reduce / sweep operations require validator pre-approval + user notification.
---
# Reporting Prohibition Law

## Purpose
- This reference is the single source of truth for assistant-authored user-facing prose admission.
- Default rule: do not show intermediate progress, internal reasoning, route, dispatch, monitoring, verification, candidate, packet, carrier, log, or cleanup content to the user.
- Communication Plane moves internal transport; Procedure Plane executes work; Reporting Plane emits user-facing prose only after this law grants a narrow exception.
- Any assistant-authored field, state signal, transport envelope, status, or prose that can render to the user is governed by this law before visible rendering; Communication Plane, Procedure Plane, tool, channel, or message-class labels do not bypass this law.
- `team-lead` owns Reporting Plane emission.

## Consume When
- Consume before any assistant-authored visible prose, terminal-visible report text, pane-visible report text, visible task-plan/todo/checklist text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, or closeout residual.
- Consume before startup, boot, planning, skill-load, reference-load, dispatch, monitoring, verification, or cleanup prose.
- Consuming this reference stays internal and never replaces required Procedure Plane or Communication Plane action.

## Pre-Report Gate
- User-facing prose is prohibited unless every applicable row below passes.
- Report suppression is a continuation rule, not a stop rule: when prose fails this gate, the owner continues the next lawful Procedure Plane or Communication Plane action silently, or records a truthful `HOLD` only when no internal continuation exists.

1. `REPORT-REASON` is exactly one of:
   - `final verified result`
   - `user-action blocker`
   - `explicit status answer`
   - `closeout residual`
   Autonomous assistant-authored emission uses only `final verified result`; the other reasons require explicit user interruption, true user-action dependency, or closeout residual with no internal continuation.
2. Same-segment internal continuation is unavailable or inappropriate because the deliverable is finally verified, a real user-action blocker exists, the user explicitly requested status, or closeout residual truth must be surfaced.
3. Report content contains only the user-relevant final outcome, required user action, requested status, or residual truth.
4. `final verified result` requires all same-request executable owner/actions closed, explicitly cancelled/redirected, or lawfully owner-deferred/out-of-scope.
5. `final verified result` requires current `Skill(self-verification)` convergence on the produced work-product surface set and outgoing report claim when the report contains analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims.
6. Multi-lane, multi-shard, review/proof/validation, or validator-routed work requires every required result to be completion-grade, retained-carrier consumed, integrated, and accepted, or lawfully deferred/out-of-scope before `final verified result`.
7. Candidate, finding, defect, patch-worthiness, patch-readiness, rejection, or count reporting requires current `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` classification for each reported item and count.
8. Communication Plane and Procedure Plane payloads stay out of report content unless the user explicitly requests the exact internal material.
9. If any required row is missing, stale, contradicted, or uncertain, keep prose suppressed and continue through the owning Procedure Plane or Communication Plane path.

## Non-Reportable Content
- System/host-generated UI rows, tool chrome, sandbox/approval UI, hook/tool result frames, and harness-emitted status are outside assistant-authored report control unless assistant-authored content is placed into a renderable field or intentionally written to rendered stdout/stderr.
- Except for system/host-generated surfaces, every controllable assistant-authored renderable surface, including visible prose around tool calls and assistant-authored command stdout/stderr, defaults to empty body or single ASCII space until `## Pre-Report Gate` admits a report.
- Internal material is any assistant-authored content whose purpose is to advance, explain, monitor, verify, recover, route, or evidence work before an admitted report; channel, tool, plane, message-class, or receiver label does not make it user-reportable.
- Do not place internal material in renderable fields. Receiver-required detail lives in governed carriers, artifacts, task state, retained outputs, shutdown requests, or quiet command results unless the user explicitly requested the exact raw material.
- A rendered internal transport envelope is non-reportable only when this law and the Communication Plane owner limit it to empty/space or a canonical no-detail token plus at most one canonical carrier-pointer/index body line. Downward assignment packet fields and all receiver-required detail stay in governed packets, task state, retained carriers, shutdown requests, or evidence artifacts referenced by that visible pointer. Any progress wording, count, evidence summary, rationale, completion narrative, or path not used solely as a canonical carrier pointer in a renderable field is a report attempt.
- Communication Plane screen-rendered envelopes remain transport signals; receiver-required detail stays in governed packets, task state, retained carriers, shutdown requests, or evidence artifacts.
- Optional supervised curtain behavior stays in `.claude/reference/environment-output-curtain-runtime.md`.

## Report Shape
- `final verified result` is result-only closure prose. It reports the user-relevant outcome, material unresolved result if any, and next action when needed; it does not report verification basis, candidate inventories, lane/shard detail, file:line lists, evidence counts, rejected/open item lists, or patch enumerations unless the user explicitly requests that exact internal material.
- Operational anchor for `final verified result`: default and maximum shape is 8 non-empty visible lines total including the `REPORT-REASON` marker and the final file-location line. The last non-empty line is always `파일: <retained-carrier-or-artifact-path>`; use `파일: 없음` only when no retained file or carrier exists. Bulk evidence and all detailed result support stay in the retained carrier referenced on that final line. Inline-dump of all available evidence is anti-pattern.
- `final verified result` states each result unit once. Duplicate paragraphs, repeated bullets, repeated class summaries, repeated carrier citations, and hook-correction re-emission that appends or repeats the prior blocked report are report-shape defects; correction replaces the prior report with the compact result-only shape.
- `final verified result` avoids final acceptance or `PASS/HOLD/FAIL` wording unless the `validator` issued that verdict.
- `user-action blocker` states the blocked user decision/action and the smallest safe next step.
- `explicit status answer` uses the narrowest truthful answer; when a live same-request executable owner/action remains open, the same turn emits the next tool call advancing that owner/action immediately after the answer prose. Intent-promise prose (e.g., "will continue", "작업 계속 진행하겠습니다", or equivalents in any language), proceed-prompt prose, and continuation-cue prose are not tool calls and do not satisfy this duty. The duty is suspended only when the user redirected, a proven user-action blocker exists, a truthful `HOLD` carrier is recorded, or lawful owner deferral basis is recorded.
- Operational anchor for `explicit status answer` `narrowest truthful`: default = single direct-answer sentence; supporting detail (≤5 bullets at most) admitted only when (a) the user explicitly named the field (e.g., `list`, `evidence`, `file paths`, `full list`, or the equivalent explicit keyword in the user's chosen language), (b) a user-action blocker is present, or (c) the preceding turn made the brief answer ambiguous in a way the receiver cannot resolve internally. Pre-emptive inline expansion of all available material is anti-pattern.
- Binary status questions get one yes/no sentence plus a user-action blocker only when present.
- Status answers omit internal topology, packet, shard, ack/completion, counts, paths, findings, evidence detail, retained-carrier detail, and per-agent narratives unless that exact field was requested.
- Detail expansion trigger: the next user instruction must contain an explicit detail keyword (`detail`, `details`, `evidence`, `file:line`, `full list`, `complete list`, `raw`, `enumerate`, `enumerated`, `cite`, `citations`, `verbose`, `everything`, `entire`, or any explicit equivalent in the user's chosen language) before the receiver expands beyond the default concise shape; absent the trigger, default-concise persists and the receiver does not pre-emptively expand on inferred preference. The keyword set is language-neutral pattern (explicit detail-asking); any non-English equivalent the user uses (e.g., the user-language word for `detail` or `full list`) counts identically.
- `closeout residual` reports only residual state that affects the user.
- Before emitting each prose sentence within an admitted report, the composer tests the candidate sentence against this exclusion list — self-accusation, excuses, intent promises (per the `explicit status answer` rule above), proceed prompts, internal packet burden narrative, meta-reflection on the composer's own procedure adherence, and process-narrative phrases (per `## Non-Reportable Content` 'starting'/'continuing'/'checking'/'dispatching'/'monitoring'/'verifying'/'waiting' categories) — and suppresses any matching sentence, continuing through the active owner/action.
- Final-result file or carrier location appears last unless the link itself is the requested deliverable or the user requested inline links.
- **Multi-Element Inline-Render Constraint**: when a single admitted-class emission (`final verified result` / `user-action blocker` / `explicit status answer` / `closeout residual`) carries multi-element required content per a narrow-exception source (examples: protection-gate 5 elements at `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` `User notification gate` (a-e); closeout-residual 2 elements per protected-surface change at the same source; explicit-status-answer multi-row content per user-named field), apply: (i) inline render permitted only when total element-count-across-all-elements fits the applicable report-shape cap; for `final verified result`, the cap is 8 non-empty lines total and the last non-empty line remains the file/carrier location; (ii) multi-patch batches (≥2 patches/items each requiring multi-element content) MUST carrier-cite per-patch/per-item detail; inline render in this case is limited to result/decision statement, concise cross-row result, operator decision options when applicable, and final file/carrier path; (iii) single-patch over-capacity case also MUST carrier-cite per-element detail; inline limited to the same shape as (ii); (iv) inline-dump of all required elements × N patches/items or single-patch-over-capacity is anti-pattern per this section's Inline-dump rule already established.

## Detail Owners
- Completion carrier and lane-output synthesis detail: `.claude/skills/task-execution/references/completion-handoff.md`.
- Communication Plane envelope and message-class detail: `.claude/skills/task-execution/references/message-classes.md`.
- Dispatch/status truth labels: `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract` and `### Transport Payload` (state-token canonical envelope) + `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States` (runtime-state vocabulary).
- Team-lead admitted-report evidence-basis control: `.claude/skills/agent-team-lead/references/reporting-prohibition-rules.md`.
- Routine continuation and residual queue: `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`.
- Synthesis resolution and claim basis: `.claude/skills/agent-team-lead/references/synthesis-consume.md`.
- Candidate filtering and promotion: `.claude/reference/review-and-verification-core-law.md`.

## Resolve Next Owner And Action
- Passing `## Pre-Report Gate` returns to `team-lead` for concise user-facing prose.
- Non-excepted prose returns to the owning Procedure Plane or Communication Plane continuation; it never authorizes waiting, idling, deferral, completion, retry-loop abandonment, or backlog conversion while an internal next action remains available.
- Missing verification, unintegrated result, pending required result, open same-request owner/action, or uncertain report reason opens the required internal continuation or truthful `HOLD`.
- A required user action opens `user-action blocker`.
- A non-user-action `HOLD` remains Procedure Plane state and does not admit `final verified result` or blocker prose.
- Conflicting report-admission wording opens `Skill(governance-modification)` cleanup at the conflicting owner surface.

---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; Work Execution Philosophy communication-plane boundary"
LOAD-POLICY: mandatory for report-admission, uncertainty, or non-routine renderable surfaces after reporting-curtain-spine escalation
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Reporting Prohibition Law

## Purpose
- This reference is the single source of truth for assistant-authored renderable-surface admission and user-facing prose prohibition.
- `.claude/reference/reporting-curtain-spine.md` is the compact hot-path consumer for routine suppression only; it cannot grant report permission and defers admission or uncertainty to this law.
- Default rule: do not show intermediate progress, internal reasoning, route, dispatch, monitoring, verification, candidate, packet, carrier, log, or cleanup content to the user.
- Communication Plane moves internal transport; Procedure Plane executes work; Reporting Plane emits user-facing prose only after this law grants a narrow exception and `.claude/reference/reporting-user-reporting-law.md` shapes the admitted prose.
- Any controllable assistant-authored prose, report detail, state signal, transport envelope, status, or ordinary message/pane prose that can render to the user is governed by this law before visible rendering; Communication Plane, Procedure Plane, tool, channel, or message-class labels do not bypass this law.
- `team-lead` owns Reporting Plane emission.

## Curtain Supremacy
- This law controls assistant-authored renderable content before any lower owner surface can authorize wording.
- Planning state, lane state, verification state, runtime state, active skill state, hook state, transport state, and checked information do not create report permission.
- More checked information produces internal evidence to classify, not more user-facing content.
- When any owner surface says `visible`, `report`, `status`, `progress`, `summary`, `next action`, `result`, `problem-report`, `dispatch-ack`, `scope-pressure`, `hold|blocker`, `subjob-done`, `completion`, or similar wording, resolve it through this law before prose reaches the user.

## Team-Lead Final-Result Lock
- While internal continuation can run, top-level `team-lead` autonomous visible prose is final-result-only; progress, readiness, recovery, transition, dispatch, waiting, monitoring, acceptance, reuse, self-correction, and no-work prose are prohibited.
- Non-final team-lead prose is limited to `explicit status answer`, `user-action blocker`, or `closeout residual`, and only when the current user message or proven blocker passes `## Pre-Report Gate` for the exact content.
- Tool errors, hook denials, fallback routes, blocked shell attempts, materialization, dispatch, lane arrival, and waiting are internal continuation evidence, not report reasons.
- Self-referential silence, compliance, awaiting, continuation, or suppression wording is visible prose; classify `REPORT-REASON` before drafting and, when not admitted, emit no prose and execute the next governed action.

## Default Screen Curtain
- Assistant-authored visible prose defaults to silence while Procedure Plane or Communication Plane action can continue; the replacement action is the next governed tool, carrier, packet, task-state, dispatch, verification, synthesis, correction, or blocker-routing move, not a status sentence.
- Internal state events project to governed state first: when a tool result, transport token, carrier acceptance, verification result, phase transition, or routine milestone changes owner state, the owner records the state in a non-rendered governed surface and executes the next governed action; it does not mirror the state as ordinary assistant-authored prose unless `## Pre-Report Gate` admits that exact report.
- Suppressed controllable renderable fields are omitted when omission is available; empty or single-space content is valid only inside a non-omittable schema-required field and must not create a blank assistant message, pane row, or bullet marker.
- Punctuation-only placeholders, including `.`, `-`, `...`, and similar filler, are report attempts when this law has not admitted prose.
- When no governed Procedure Plane or Communication Plane action can run in the current segment, end the turn emitting neither prose nor a tool call; a no-op, keepalive, or do-nothing tool call whose sole purpose is to yield or wait (for example a shell command that performs no governed work) is a prohibited screen trace, classified like the punctuation-only filler above.
- Projection classification is semantic and format-invariant: wrappers, quotes, caveats, labels, and self-denial wording never change whether the candidate surface carries reportable or suppressed meaning.
- Host/system-generated UI chrome, tool wrapper rows, sandbox or approval UI, host status badges, and tool-error wrapper rows are execution or transport evidence only; they do not create an adjacent assistant-authored prose slot or report reason.
- Assistant-authored payload inside a rendered row remains governed when it carries assistant-authored meaning, including command text/stdout/stderr, `SendMessage`, `Agent`, or task fields, lane/task detail, carrier previews, and `Write`/`Edit`/`MultiEdit`/`Update` file-content projections.
- Automatic Communication Plane state signals avoid report classification only when rendered through the canonical no-detail envelope owned by `.claude/skills/task-execution/references/message-classes.md`.
- Any assistant-authored state-signal detail outside that canonical envelope is a report attempt or malformed transport display.
- `problem-report` detail is receiver-required Communication Plane evidence only through the non-rendered carrier paths owned by `.claude/skills/task-execution/references/message-classes.md`; it is not admitted in visible pane text or final prose.

## Consume When
- Routine hot-path suppression may consume `.claude/reference/reporting-curtain-spine.md` first.
- Consume this full law when the spine escalates, when report admission is uncertain, or before constructing any non-routine controllable assistant-authored renderable content surface: ordinary prose, pane/final text, renderable tool or channel field with non-state detail, visible task-plan/todo/checklist text, `SendMessage` visible field outside the canonical no-detail state envelope, assistant-authored prose/detail embedded in command labels or command-generated text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, final verified result, closeout residual, or reporting/governance defect claim.
- Consume before startup, boot, planning, skill-load, reference-load, owner/action transition, dispatch, monitoring, verification, cleanup, or tool-adjacent narration can render.
- Consuming this reference stays internal and never replaces required Procedure Plane or Communication Plane action.
- When this law suppresses, silences, empties, or limits visible content, it changes only the user-rendered projection. The active owner continues the required Procedure Plane or Communication Plane action with complete receiver-required payload and complete governed evidence.
- Suppression does not change blocker, deferral, user-escalation, verification, correction, routing, or closure thresholds.

## Pre-Report Gate
- User-facing prose is prohibited unless every applicable row below passes.

1. `REPORT-REASON` is exactly one of:
   - `final verified result`
   - `user-action blocker`
   - `explicit status answer`
   - `closeout residual`
2. Same-segment internal continuation is not available for `final verified result`, `user-action blocker`, or `closeout residual`: the deliverable is finally verified, a user-owned decision or action is required, or closeout residual truth has no internal recovery route. `explicit status answer` is admitted only when the current user message explicitly asks for status, cause, or exact internal material; tool/runtime/dispatch state changes, host rows, lane arrivals, waiting, and async background work never create this report reason by themselves. After the answer, resume the prior live owner/action unless the user redirected or a user-action blocker is proven.
3. Report content contains only the user-relevant final outcome, required user action, requested status, residual truth, or the exact internal material explicitly requested by the user.
4. `final verified result` requires all same-request executable owner/actions closed, explicitly cancelled/redirected, deferred by cited lawful owner-deferral authority, or explicitly out-of-scope.
5. `final verified result` requires current `Skill(self-verification)` convergence on the produced work-product surface set and outgoing report claim when the report contains analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims.
6. Multi-lane, multi-shard, review/proof/validation, or validator-routed work requires every required result to be completion-grade, retained-carrier consumed, integrated, and accepted, deferred by cited lawful owner-deferral authority, or explicitly out-of-scope before `final verified result`.
7. Candidate, finding, defect, patch-worthiness, patch-readiness, rejection, remedy, hook/settings, runtime/tool, transport-defect, malformed-transport, transport-remedy, or counts for those behavior-affecting items requires current `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` classification and `## Cause And Remedy Classification Law` item-level classification for each reported item and count.
8. Communication Plane and Procedure Plane payloads stay out of report content unless `REPORT-REASON: explicit status answer` applies to the current user's explicit request for exact internal material and the content is limited to that exact requested material.
9. If any required row is missing, stale, contradicted, or uncertain, keep prose suppressed and continue through the owning Procedure Plane or Communication Plane path.

## Non-Reportable Content
- Unless the current user explicitly requests exact internal material and `REPORT-REASON: explicit status answer` passes, startup, boot, readiness, no-work, skill-load, and reference-load facts stay non-reportable.
- Unless the same explicit-status exception applies, route, dispatch, queue, lane, reuse, monitoring, cleanup, task-row, packet, carrier, verification, candidate/finding, patch-log, runtime-ledger, and retained-output facts stay non-reportable.
- Unless the same explicit-status exception applies, `problem-report`, `scope-pressure`, `hold|blocker`, blocker-resolution, `dispatch-ack`, `status`, and `subjob-done` detail stays non-reportable.
- Narrow exception: an admitted final-result `REPORT-LOCATION-LINE` may name the canonical report artifact path without exposing retained-carrier content.
- Stage identity is not a report reason. Work-start, dispatch-start, lane-start, task-start, work-completion, lane-completion, and task-completion admit only the Communication Plane's canonical no-detail state token when that transport event occurs, never assistant-authored status prose, counts, paths, result previews, completion narratives, or filler.
- Tool-adjacent narration is suppressed while an internal next owner/action can run. This includes assistant-authored prose that announces checking, gathering, dispatching, monitoring, waiting, accepting, reusing, self-correcting, retrying, rerouting, measuring, verifying, or explaining interim movement.
- Progress/status narration about internal state, queue state, lane activity, carrier acceptance, shard progress, verification progress, standby/reuse, or waiting state is suppressed unless the current user explicitly requested that exact status material. A `final verified result` never admits separate internal status, idle, standby, or post-final-tail prose.
- Punctuation-only, whitespace-plus-punctuation, decorative filler, and blank assistant turns are report attempts when prose is not admitted. Omit the surface when omission is available; use empty or single ASCII space only inside a non-omittable schema-required field.
- Host-rendered wrapper rows, tool status rows, `Write` wrapper rows, and tool error wrapper rows are execution evidence, not report reasons; they do not authorize adjacent assistant-authored narration.
- Assistant-authored renderable fields carrying internal material are controlled projections: command output or labels, banners, counts, paths, listings, partition/check summaries, carrier previews, task/send fields, and file-content previews. Do not project those details unless the user explicitly requested that exact material and `## Pre-Report Gate` admits it.
- Internal-only helper source, measurement/probe code, carrier/packet bodies, live-runtime blocks, queues, ledgers, reuse instructions, and other non-deliverable file bodies use screen-safe creation paths unless the source itself is the requested deliverable or exact admitted internal material.
- Receiver-required detail remains complete in governed tool calls/results, retained carriers, task state, runtime ledgers, packets, and evidence artifacts. Screen suppression never blanks executable command text, tool parameters, file content, or evidence needed by Procedure Plane or Communication Plane action.
- A rendered internal transport envelope avoids report-attempt classification only when limited to the Communication Plane canonical no-detail token. Duplicate token rendering, progress wording, counts, paths, evidence summaries, rationales, completion narratives, and task-row assignment detail are report attempts.
- Hooks or pre-action guards may suppress only the user-rendered projection while the acting agent still receives the completed tool result and receiver-required information remains available; `Bash` output mechanics follow `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`.

## Admitted Report Handoff
- This law admits or rejects user-facing prose; `.claude/reference/reporting-user-reporting-law.md` owns admitted report wording, report shape, final-result line budget, and report-location line.
- Lower reporting-shape, transport, completion, hook, runtime, or governance-modification surfaces execute under this admission law and cannot create report reasons, broaden exceptions, or weaken `## Non-Reportable Content`.
- Passing `## Pre-Report Gate` opens `.claude/reference/reporting-user-reporting-law.md` before admitted prose is drafted.
- Report-shape defects return to `.claude/reference/reporting-user-reporting-law.md`; report-admission defects remain on this law.

## Detail Owners
- Admitted report wording and shape: `.claude/reference/reporting-user-reporting-law.md`.
- Completion carrier and lane-output synthesis detail: `.claude/skills/task-execution/references/completion-handoff.md`.
- Communication Plane envelope and message-class detail: `.claude/skills/task-execution/references/message-classes.md`.
- Dispatch/status truth labels: `.claude/skills/task-execution/references/truth-rules.md`.
- Team-lead report-admission evidence-basis control: `.claude/skills/agent-team-lead/references/reporting-prohibition-rules.md`.
- Team-lead admitted-report shape evidence-basis control: `.claude/skills/agent-team-lead/references/reporting-user-reporting-rules.md`.
- Routine continuation and residual queue: `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`.
- Synthesis resolution and claim basis: `.claude/skills/agent-team-lead/references/synthesis-consume.md`.
- Candidate filtering and promotion: `.claude/reference/review-and-verification-core-law.md`.

## Resolve Next Owner And Action
- Passing `## Pre-Report Gate` opens `.claude/reference/reporting-user-reporting-law.md` for admitted report shape before `team-lead` drafts concise user-facing prose.
- Non-excepted prose returns to the owning Procedure Plane or Communication Plane continuation.
- Missing verification, unintegrated result, pending required result, open same-request owner/action, or uncertain report reason opens the required internal continuation or blocker-routing after internal recovery routes are exhausted.
- A required user action opens `user-action blocker`.
- A non-user-action blocker-routing record remains Procedure Plane state and does not admit `final verified result` or blocker prose; when it blocks the user-requested deliverable and no internal executable route remains, report only user-relevant residual truth through `closeout residual`.
- An explicit status request or explicit exact-internal-material request opens `explicit status answer`, then returns to the active owner action unless redirected or blocked.
- Conflicting report-admission wording opens `Skill(governance-modification)` cleanup at the conflicting owner surface.

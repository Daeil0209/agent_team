---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; Work Execution Philosophy communication-plane boundary"
LOAD-POLICY: mandatory before any user-facing report
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Reporting Prohibition Law

## Purpose
- This reference is the single source of truth for assistant-authored user-facing prose admission.
- Default rule: do not show intermediate progress, internal reasoning, route, dispatch, monitoring, verification, candidate, packet, carrier, log, or cleanup content to the user.
- Communication Plane moves internal transport; Procedure Plane executes work; Reporting Plane emits user-facing prose only after this law grants a narrow exception and `.claude/reference/reporting-user-reporting-law.md` shapes the admitted prose.
- Any assistant-authored field, state signal, transport envelope, status, or prose that can render to the user is governed by this law before visible rendering; Communication Plane, Procedure Plane, tool, channel, or message-class labels do not bypass this law.
- `team-lead` owns Reporting Plane emission.

## Curtain Supremacy
- This law controls assistant-authored visible prose before any lower owner surface can authorize wording.
- Planning state, lane state, verification state, runtime state, active skill state, hook state, transport state, and checked information do not create report permission.
- More checked information produces internal evidence to classify, not more user-facing content.
- When any owner surface says `visible`, `report`, `status`, `progress`, `summary`, `next action`, `result`, `dispatch-ack`, `subjob-done`, `completion`, or similar wording, resolve it through this law before prose reaches the user.

## Default Screen Curtain
- Assistant-authored visible prose defaults to silence while Procedure Plane or Communication Plane action can continue.
- Suppressed controllable renderable fields stay empty, omitted, or a single ASCII space.
- Punctuation-only placeholders, including `.`, `-`, `...`, and similar filler, are report attempts when this law has not admitted prose.
- Host-rendered tool rows, lane transport rows, and task rows are execution or transport evidence only; they do not create an adjacent assistant-authored prose slot.
- Automatic no-detail screen state signals are limited to exactly two standalone tokens: `dispatch-ack` when an agent accepts the assigned work and starts, and `subjob-done` when an agent hands completed subjob output to `team-lead`.
- In `SendMessage`, the schema-required `summary` field is the canonical visible state-signal slot for those two tokens; the body remains empty, omitted, or single ASCII space.
- Those two tokens are allowed transport signals, not user reports; any added word, punctuation, task id, carrier path, summary, count, result preview, or completion narrative turns the rendered content into a report attempt or malformed transport display.

## Consume When
- Consume before any assistant-authored visible prose, terminal-visible report text, pane-visible report text, visible task-plan/todo/checklist text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, or closeout residual.
- Consume before startup, boot, planning, skill-load, reference-load, dispatch, monitoring, verification, or cleanup prose.
- Consuming this reference stays internal and never replaces required Procedure Plane or Communication Plane action.
- When this law suppresses, silences, empties, or limits visible content, the active owner continues the required Procedure Plane or Communication Plane action with complete governed evidence.
- Suppression does not change blocker, deferral, user-escalation, verification, correction, routing, or closure thresholds.

## Pre-Report Gate
- User-facing prose is prohibited unless every applicable row below passes.

1. `REPORT-REASON` is exactly one of:
   - `final verified result`
   - `user-action blocker`
   - `explicit status answer`
   - `closeout residual`
2. Same-segment internal continuation is not available for `final verified result`, `user-action blocker`, or `closeout residual`: the deliverable is finally verified, a user-owned decision or action is required, or closeout residual truth has no internal recovery route. `explicit status answer` may be admitted for the requested status or exact internal material without making the active owner/action terminal; after the answer, resume the prior live owner/action unless the user redirected or a user-action blocker is proven.
3. Report content contains only the user-relevant final outcome, required user action, requested status, residual truth, or the exact internal material explicitly requested by the user.
4. `final verified result` requires all same-request executable owner/actions closed, explicitly cancelled/redirected, deferred by cited lawful owner-deferral authority, or explicitly out-of-scope.
5. `final verified result` requires current `Skill(self-verification)` convergence on the produced work-product surface set and outgoing report claim when the report contains analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims.
6. Multi-lane, multi-shard, review/proof/validation, or validator-routed work requires every required result to be completion-grade, retained-carrier consumed, integrated, and accepted, deferred by cited lawful owner-deferral authority, or explicitly out-of-scope before `final verified result`.
7. Candidate, finding, defect, patch-worthiness, patch-readiness, rejection, remedy, hook/settings, runtime/tool, transport-defect, malformed-transport, transport-remedy, or counts for those behavior-affecting items requires current `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` classification and `## Cause And Remedy Classification Law` item-level classification for each reported item and count.
8. Communication Plane and Procedure Plane payloads stay out of report content unless `REPORT-REASON: explicit status answer` applies to an explicit user request for exact internal material and the content is limited to that exact requested material.
9. If any required row is missing, stale, contradicted, or uncertain, keep prose suppressed and continue through the owning Procedure Plane or Communication Plane path.

## Non-Reportable Content
- These are never user reports unless `REPORT-REASON: explicit status answer` applies to an explicit user request for that exact internal material: owner triggers, skill/reference loads, route choices, dispatch topology, lane/member counts, dispatch-ack/status/subjob-done transport, task rows, packets, retained-carrier paths or contents, raw candidate/finding inventories, verification packets, patch logs, runtime ledgers, cleanup state, and monitoring state.
- Work-start, dispatch-start, lane-start, task-start, work-completion, lane-completion, and task-completion content is non-reportable stage content; stage identity admits only the standalone `dispatch-ack` or `subjob-done` screen signal when the matching transport event occurs, never assistant-authored visible prose, summaries, counts, paths, result previews, completion narratives, or filler.
- Tool-adjacent assistant-authored prose that starts, continues, checks, dispatches, monitors, verifies, waits, explains interim findings, connects evidence to a next step, marks stage completion, or otherwise narrates Procedure Plane or Communication Plane movement is not admitted report content and remains suppressed while the owner action can continue.
- Single-character, punctuation-only, whitespace-plus-punctuation, or decorative filler content is not an admitted report; use empty, omitted, or single ASCII space when a tool field cannot be omitted.
- Assistant-authored command stdout/stderr labels, success echoes, progress banners, and section separators are not admitted report content unless the user explicitly requested that exact material; when routing needs command evidence, prefer exit status or the smallest machine-readable pass/fail or missing-path/missing-field fact.
- Assistant-authored command output for internal artifact or carrier verification emits no terminal-visible success output; when routing depends on the command result, emit only machine-readable pass/fail or missing-path/missing-field facts, while carrier headers, excerpts, line counts, candidate counts, completion-grade summaries, and reuse decisions stay out of terminal-visible output.
- Assistant-authored file-write preview content for internal carriers or produced user-facing report drafts is a report attempt when it carries route, dispatch, packet, verification, candidate, retained-carrier, final-result, synthesis, defect/finding, count, recommendation, or post-final-tail detail before this law admits that exact content or the user explicitly requests that exact preview content.
- A rendered internal transport envelope avoids report-attempt classification only when this law and the Communication Plane owner limit it to the no-detail shape owned by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`; any receiver-required detail, progress wording, count, path, evidence summary, rationale, completion narrative, or task-row subject/description detail in a renderable field is a report attempt.
- Duplicate assistant-authored rendering of the same internal state token across visible envelope slots is a report attempt; the Communication Plane owner must render at most one no-detail token and keep receiver-required detail in governed non-rendered carriers.
- Communication Plane screen-rendered envelopes and task rows remain transport signals; task rows are identity-only/no-detail surfaces, and receiver-required detail stays in governed packets, non-rendered task state, retained carriers, shutdown requests, shutdown responses, or evidence artifacts.
- Host/system-generated Claude Code UI rows are not assistant-authored reports; classify them only when they affect report truth, runtime evidence, or user-visible rendering proof.

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

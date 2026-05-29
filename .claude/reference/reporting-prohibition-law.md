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

## Consume When
- Consume before any assistant-authored visible prose, terminal-visible report text, pane-visible report text, visible task-plan/todo/checklist text, completion claim, phase/stage-end result, user-action blocker report, explicit status answer, or closeout residual.
- Consume before startup, boot, planning, skill-load, reference-load, dispatch, monitoring, verification, or cleanup prose.
- Consuming this reference stays internal and never replaces required Procedure Plane or Communication Plane action.

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
7. Candidate, finding, defect, patch-worthiness, patch-readiness, rejection, or count reporting requires current `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` classification for each reported item and count.
8. Communication Plane and Procedure Plane payloads stay out of report content unless `REPORT-REASON: explicit status answer` applies to an explicit user request for exact internal material and the content is limited to that exact requested material.
9. If any required row is missing, stale, contradicted, or uncertain, keep prose suppressed and continue through the owning Procedure Plane or Communication Plane path.

## Non-Reportable Content
- These are never user reports unless `REPORT-REASON: explicit status answer` applies to an explicit user request for that exact internal material: owner triggers, skill/reference loads, route choices, dispatch topology, lane/member counts, ack/status/completion transport, task rows, packets, retained-carrier paths or contents, raw candidate/finding inventories, verification packets, patch logs, runtime ledgers, cleanup state, monitoring state, and prose whose only purpose is "starting", "continuing", "checking", "dispatching", "monitoring", "verifying", or "waiting".
- A rendered internal transport envelope is non-reportable only when this law and the Communication Plane owner limit it to a canonical no-detail state token and an empty/space body; any receiver-required detail, progress wording, count, path, evidence summary, rationale, or completion narrative in a renderable field is a report attempt.
- Communication Plane screen-rendered envelopes remain transport signals; receiver-required detail stays in governed packets, task state, retained carriers, shutdown requests, shutdown responses, or evidence artifacts.
- Host/system-generated Claude Code UI rows are not assistant-authored reports; classify them only when they affect report truth, runtime evidence, or user-visible rendering proof.
- Optional supervised curtain behavior stays in `.claude/reference/environment-output-curtain-runtime.md`.

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

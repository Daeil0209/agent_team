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
- Communication Plane moves internal transport; Procedure Plane executes work; Reporting Plane emits user-facing prose only after this law grants a narrow exception.
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
2. Same-segment internal continuation is unavailable or inappropriate because the deliverable is finally verified, a real user-action blocker exists, the user explicitly requested status, or closeout residual truth must be surfaced.
3. Report content contains only the user-relevant final outcome, required user action, requested status, or residual truth.
4. `final verified result` requires all same-request executable owner/actions closed, explicitly cancelled/redirected, or lawfully owner-deferred/out-of-scope.
5. `final verified result` requires current `Skill(self-verification)` convergence on the produced work-product surface set and outgoing report claim when the report contains analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims.
6. Multi-lane, multi-shard, review/proof/validation, or validator-routed work requires every required result to be completion-grade, retained-carrier consumed, integrated, and accepted, or lawfully deferred/out-of-scope before `final verified result`.
7. Candidate, finding, defect, patch-worthiness, patch-readiness, rejection, or count reporting requires current `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` classification for each reported item and count.
8. Communication Plane and Procedure Plane payloads stay out of report content unless the user explicitly requests the exact internal material.
9. If any required row is missing, stale, contradicted, or uncertain, keep prose suppressed and continue through the owning Procedure Plane or Communication Plane path.

## Non-Reportable Content
- These are never user reports unless the user explicitly requests the exact internal material: owner triggers, skill/reference loads, route choices, dispatch topology, lane/member counts, ack/status/completion transport, task rows, packets, retained-carrier paths or contents, raw candidate/finding inventories, verification packets, patch logs, runtime ledgers, cleanup state, monitoring state, and prose whose only purpose is "starting", "continuing", "checking", "dispatching", "monitoring", "verifying", or "waiting".
- A rendered internal transport envelope is non-reportable only when this law and the Communication Plane owner limit it to a canonical no-detail state token and an empty/space body; any receiver-required detail, progress wording, count, path, evidence summary, rationale, or completion narrative in a renderable field is a report attempt.
- Communication Plane screen-rendered envelopes remain transport signals; receiver-required detail stays in governed packets, task state, retained carriers, shutdown requests, or evidence artifacts.
- Host/system-generated Claude Code UI rows are not assistant-authored reports; classify them only when they affect report truth, runtime evidence, or user-visible rendering proof.
- Optional supervised curtain behavior stays in `.claude/reference/environment-output-curtain-runtime.md`.

## Report Shape
- `final verified result` states the final result first, in concise Korean, with only essential verification basis, material lawfully deferred/out-of-scope surface, or canonical artifact path.
- `final verified result` avoids final acceptance or `PASS/HOLD/FAIL` wording unless the `validator` issued that verdict.
- `user-action blocker` states the blocked user decision/action and the smallest safe next step.
- `explicit status answer` uses the narrowest truthful answer and then returns to the active owner action unless the user redirected or a user-action blocker exists.
- Binary status questions get one yes/no sentence plus a user-action blocker only when present.
- Status answers omit internal topology, packet, shard, ack/completion, counts, paths, findings, evidence detail, retained-carrier detail, and per-agent narratives unless that exact field was requested.
- `closeout residual` reports only residual state that affects the user.
- Report prose excludes self-accusation, excuses, intent promises, proceed prompts, and internal packet burden narrative.
- Final-result links appear last unless the link itself is the requested deliverable or the user requested inline links.

## Detail Owners
- Completion carrier and lane-output synthesis detail: `.claude/skills/task-execution/references/completion-handoff.md`.
- Communication Plane envelope and message-class detail: `.claude/skills/task-execution/references/message-classes.md`.
- Dispatch/status truth labels: `.claude/skills/task-execution/references/truth-rules.md`.
- Team-lead admitted-report evidence-basis control: `.claude/skills/agent-team-lead/references/reporting-prohibition-rules.md`.
- Routine continuation and residual queue: `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`.
- Synthesis resolution and claim basis: `.claude/skills/agent-team-lead/references/synthesis-consume.md`.
- Candidate filtering and promotion: `.claude/reference/review-and-verification-core-law.md`.

## Resolve Next Owner And Action
- Passing `## Pre-Report Gate` returns to `team-lead` for concise user-facing prose.
- Non-excepted prose returns to the owning Procedure Plane or Communication Plane continuation.
- Missing verification, unintegrated result, pending required result, open same-request owner/action, or uncertain report reason opens the required internal continuation or truthful `HOLD`.
- A required user action opens `user-action blocker`.
- A non-user-action `HOLD` remains Procedure Plane state and does not admit `final verified result` or blocker prose.
- An explicit status request opens `explicit status answer`, then returns to the active owner action unless redirected or blocked.
- Conflicting report-admission wording opens `Skill(governance-modification)` cleanup at the conflicting owner surface.

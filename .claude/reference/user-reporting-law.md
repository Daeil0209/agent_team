---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md Communication
SOURCE-RULES: "Communication/Procedure/Reporting plane separation; user-facing report single source of truth"
LOAD-POLICY: mandatory before any user-facing report
---
# User Reporting Law

## Purpose
This reference is the single source of truth for user-facing reporting.
Communication is transport, not user reporting.
Procedure is execution control, not user reporting.
Reporting is a separate user-facing act owned by `team-lead`.

## Curtain Supremacy
This law is the controlling curtain for assistant-authored visible prose.
No owner document, skill, reference, hook, runtime signal, tool result, transport message, internal evidence check, or verification result can weaken this curtain or create report permission.
Information checks produce Procedure Plane or Communication Plane evidence only.
More checked information means more internal evidence to classify, not more user-facing content to show.
When any document says `visible`, `report`, `status`, `progress`, `summary`, `next action`, `result`, or similar wording, resolve it through this law before prose reaches the user.
If this law does not admit the prose, the information stays in the owning internal carrier.

## Plane Separation
### Communication Plane
Communication Plane moves information between agents, tasks, runtime state, ledgers, and retained files.
`SendMessage`, teammate UI, `dispatch-ack`, `control-ack`, `status`, `scope-pressure`, `handoff`, `completion`, `hold|blocker`, assignment packets, phase-transition packets, lifecycle packets, task rows, task output, runtime ledgers, and retained-output pointers are Communication Plane transport.
Communication Plane output never satisfies a user report.
Communication Plane payload is consumed by the receiving owner, not by the user.

### Procedure Plane
Procedure Plane executes planning, dispatch, monitoring, review, proof, validation, synthesis, self-verification, closeout, and self-growth.
Procedure state is internal evidence.
Procedure state never satisfies a user report.
Procedure owner artifacts stay internal unless this law admits a report.

### Reporting Plane
Reporting Plane is the only plane that writes user-facing prose.
`team-lead` owns Reporting Plane emission.
Lanes do not report to the user.
Methodology skills do not report to the user.
Task-execution message classes do not report to the user.


## Runtime Enforcement Boundary
This law defines report admissibility; it does not by itself control Claude Code host-native UI rows.
Optional supervised curtain behavior is defined in `.claude/reference/output-supervisor-runtime.md`.
When supervised curtain runtime is active, discretionary child screen text is hidden from the supervised report surface and user report rendering comes only from structurally released report proposals after this law admits a report.

## Consume When
Consume this reference before any user-facing prose, terminal-visible report text, pane-visible report text, visible task-plan/todo/checklist text, completion claim, phase/stage-end result, blocker report, explicit status answer, or closeout residual.
At fresh session start, consume this reference before owner-trigger prose, skill-load prose, reference-consumption prose, boot prose, planning prose, or startup completion prose.
Consuming this reference is internal; do not narrate it.
If the next action can continue internally through Procedure Plane or Communication Plane, do not emit a user report.

## Pre-Report Gate
Before drafting or emitting visible prose that is not a Minimal Visible State Token, apply this gate.
If this gate does not admit the prose, emit nothing and continue through the owning Procedure or Communication Plane.
Uncertainty means not admitted.

1. Report reason is exactly one of:
   - `verified result`
   - `user-action blocker`
   - `explicit status answer`
   - `closeout residual`
2. Same-segment internal continuation is unavailable or inappropriate because:
   - the requested deliverable is complete and verified
   - a real blocker requires user action
   - the user explicitly asked for status
   - closeout residual truth must be surfaced
3. Report content contains only user-relevant outcome, blocker, requested status, or residual truth.
4. Before analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims, load `.claude/skills/self-verification/SKILL.md` and execute `SV-RESULT` on the exact outgoing claim.
5. When the active route uses multiple lanes, shards, reviewers, proof owners, or validators, every required output is completion-grade, consumed from its retained carrier, integrated, and either accepted, explicitly owner-deferred, out-of-scope with basis, or blocking with a user-action blocker.
6. No Communication Plane or Procedure Plane payload is included as report content.

If any required lane/shard output is pending, unintegrated, contradictory, or only screen-visible, suppress the report and continue monitoring, carrier consumption, correction, synthesis, or `SV-RESULT` internally.

## Non-Reportable Content
These are never user reports:
- dispatch topology, lane count, route choice, staffing shape, runtime setup, monitoring, idle, receipt, ack, status, lifecycle, or control signals
- individual lane/shard arrival, partial lane/shard completion, partial convergence, all-lanes counters, per-shard findings summaries, and in-flight synthesis notes
- `dispatch-ack`, `control-ack`, `scope-pressure`, `handoff`, `completion`, `hold|blocker`, assignment packets, packet corrections, phase-transition packets, lifecycle packets, task rows, task output, runtime ledgers, and retained-output paths
- skill loading, methodology application, review-verification packet fields, SV records, retro-apply notes, self-growth notes, hook signals, ledgers, raw inventories, candidate counts, findings lists, excerpts, evidence packs, and alternative-route lists
- statements that exist only to say work is starting, continuing, being monitored, being dispatched, being corrected, or being verified

The user may explicitly request any internal material. That explicit request admits only the requested material and does not convert future internal material into reports.

## Tool-Adjacent Prose Suppression
Tool-adjacent prose is visible pane/final text before, between, or after tool calls.
Do not emit tool-adjacent prose for startup contract application, owner-trigger opening, skill loading, reference consumption, planning freeze, corpus measurement, Codex or reviewer adjudication, packet drafting, directory creation, task updates, dispatch preparation, monitoring, or recovery while Procedure Plane or Communication Plane can continue.
Examples of suppressed tool-adjacent prose include `Opening the highest active owner trigger`, `Consuming user-reporting-law`, `Consuming output-surface-law`, `Consuming work-planning`, `Boot closes`, `Corpus measured`, `Sharding plan`, `Plan freeze`, `Internal plan freeze`, `Required mode`, `Internal planning record is frozen`, `Codex returned`, `adjudicating now`, `planning freeze complete`, `opening task-execution`, `I'll set up`, `dispatching now`, `loading`, `starting`, `will report`, `findings to`, `shard arrived`, `audit complete`, `4/7 complete`, and per-shard findings summaries.
If the user explicitly asks why an expected action did not happen, answer only with the violated rule/owner, the direct procedural cause, and the current correction owner/action; runtime-excuse wording such as `turn boundary`, `same turn`, `system-imposed`, file/read/edit counts, batching strategy, or similar host/tool mechanics is not a direct procedural cause; do not include self-accusation, excuses, intent promises, proceed prompts, or internal packet burden narrative.

## Transport Boundary
When Claude Code renders Communication Plane transport on a user-visible screen, the screen-rendered transport body is an envelope, not the full Communication Plane payload.
Receiver-required detail stays in governed assignment packets, task state, retained-output carriers, lifecycle packets, or evidence artifacts referenced by the envelope.
User-reporting gates do not delete, weaken, or omit receiver-required payload; they keep it out of screen-rendered prose and route it through non-report carriers.
Communication payload is judged by receiver-required execution truth across the envelope plus governed carriers, not by user-report shape.
Team-lead must not explain, summarize, or repeat transport as a user report unless this law separately admits a report.
Visible pane/final prose is not a substitute carrier for Communication Plane payload.
Carrierless wording in other owner documents such as `visible`, `progress update`, `name it`, `keep visible`, or `next update` means internal continuity carrier only; it never authorizes pane-visible prose.
Lane agents must not project ACK, startup, execution plan, file-read, route, evidence, result inventory, findings count, retained-output contents, or later-report intent into visible pane/final prose or screen-rendered transport bodies.
When a visible pane/final row is unavoidable and no user report is admitted, emit only the Minimal Visible State Token.

## Minimal Visible State Token
A minimal visible state token is UI hygiene, not a user report.
Use it only when Claude Code creates an unavoidable visible row and this law does not admit a user report.
Repeated idle, lifecycle, monitoring, or same-state wake events do not justify another token; if no new visible row is forced, emit nothing and continue internally.
If the user explicitly asks status, answer with the narrowest truthful status instead of a token.
Do not emit a blank visible row.
Do not emit a bare punctuation placeholder when a minimal state token can render.
The token states only one current state: `working`, `waiting`, `verifying`, or `blocked`.
Startup visible rows use literal `working` when the exact state is not yet known.
A bare punctuation placeholder such as `.` is never a Minimal Visible State Token.
The token must not include agent counts, route shape, file paths, evidence detail, packet fields, lifecycle detail, or rationale.
The token must not replace receiver-required Communication Plane payload.
The token must not replace a user-action blocker report when this law admits one.

## Report Shape
`verified result` reports the result first and includes only the highest-impact verification basis or canonical artifact path when material. Multi-lane or multi-shard verified result requires the all-required-output gate above plus current `SV-RESULT` on the synthesized claim.
`user-action blocker` reports the blocked user decision/action and the smallest safe next step.
`explicit status answer` uses the narrowest truthful form: binary status questions get one yes/no sentence plus only a user-action blocker when present; dispatch status uses the narrowest proven truth label from `.claude/skills/task-execution/references/truth-rules.md`; omit internal topology, packet, shard, ack/handoff/completion, counts, paths, and evidence detail unless that exact field is requested.
`closeout residual` reports only residual state that affects the user.

`FINAL` requires zero-residual deliverable convergence or explicit owner-deferred/out-of-scope basis.
`PHASE-RESULT` is allowed only when the phase result is a stopped, verified user-relevant result and no same-segment internal action can continue.
`MID-FLIGHT` emits no user-facing prose unless the user explicitly asked for status or user action is required.

## Single-Source Rule
This reference owns user-report admissibility, non-reportable content, and transport/reporting separation.
Other documents may cite this reference.
Other documents must not restate report allowlists or convert Communication Plane payload into user reports.
Conflicting wording resolves to this reference and routes to `self-growth-sequence` for owner-local cleanup.

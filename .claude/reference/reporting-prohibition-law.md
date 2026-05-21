---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; Work Execution Philosophy communication-plane boundary"
LOAD-POLICY: mandatory before any user-facing report
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Reporting Prohibition Law

## Purpose
This reference is the single source of truth for assistant-authored visible prose prohibition and narrow reporting exceptions.
Communication is transport, not user reporting.
Procedure is execution control, not user reporting.
Reporting is a separate user-facing act owned by `team-lead` only after this law grants a narrow exception.

## Curtain Supremacy
This law is the controlling curtain for assistant-authored visible prose.
Owner documents, skills, references, hooks, runtime signals, tool results, transport messages, internal evidence checks, and verification results preserve this curtain unless this law grants a narrow reporting exception.
Information checks produce Procedure Plane or Communication Plane evidence only.
More checked information means more internal evidence to classify, not more user-facing content to show.
When any document says `visible`, `report`, `status`, `progress`, `summary`, `next action`, `result`, or similar wording, resolve it through this law before prose reaches the user.
Non-excepted prose stays in the owning internal carrier.

## Default Screen Curtain
Assistant-authored visible prose defaults to silence while Procedure Plane or Communication Plane can continue.
Intermediate owner triggers, skill loads, reference reads, route choices, dispatch state, wave state, shard state, evidence inventories, findings counts, patch logs, verification notes, monitoring state, and cleanup state stay in internal carriers.
The ordinary user-visible surface is a compact verified-result summary after convergence.
Before convergence, visible prose is excepted only for explicit status answer, user-action blocker, or closeout residual under this law.
Screen silence preserves internal evidence, required transport, retained carriers, and receiver-required payload.

## Plane Separation
### Communication Plane
Communication Plane moves information between agents, tasks, runtime state, ledgers, and retained files.
`SendMessage`, teammate UI, `dispatch-ack`, `status`, `scope-pressure`, `completion`, `hold|blocker`, assignment packets, phase-transition packets, shutdown requests, task rows, task output, runtime ledgers, and retained-output pointers are Communication Plane transport.
Communication Plane output remains internal transport.
Communication Plane payload is consumed by the receiving owner, not by the user.

### Procedure Plane
Procedure Plane executes planning, dispatch, monitoring, review, proof, validation, synthesis, self-verification, closeout, and `governance-modification`.
Procedure state is internal evidence.
Procedure state remains outside user-report satisfaction.
Procedure owner artifacts stay internal unless this law grants a narrow reporting exception.

### Reporting Plane
Reporting Plane is the only plane that writes user-facing prose.
`team-lead` owns Reporting Plane emission.
Lanes route user-facing report material to `team-lead`.
Methodology skills route user-facing report material to `team-lead`.
Task-execution message classes route user-facing report material to `team-lead`.
Lane pane/final prose is not a Reporting Plane surface.


## Runtime Enforcement Boundary
This law defines report prohibition and narrow exceptions; Claude Code host-native UI rows remain governed by host/runtime behavior.
Host/system-generated automatic UI rows are not assistant-authored reports; classify their boundary only when they affect report truth, runtime evidence, or user-visible rendering proof.
Use this boundary statement as the single automatic host/system row rule unless the row affects report truth, runtime evidence, or user-visible rendering proof.
Optional supervised curtain behavior is defined in `.claude/reference/environment-output-curtain-runtime.md`.
When supervised curtain runtime is active, discretionary child screen text is hidden from the supervised report surface and user report rendering comes only from structurally released report proposals after this law grants a narrow exception.

## Consume When
Consume this reference before any user-facing prose, terminal-visible report text, pane-visible report text, visible task-plan/todo/checklist text, completion claim, phase/stage-end result, blocker report, explicit status answer, or closeout residual.
At fresh session start, consume this reference before owner-trigger prose, skill-load prose, reference-consumption prose, boot prose, planning prose, or startup completion prose.
Consuming this reference stays internal.
Internal Procedure Plane or Communication Plane continuation keeps visible reporting closed.
Report suppression suppresses assistant-authored prose only; it never skips required Procedure Plane or Communication Plane tool calls.

## Pre-Report Gate
Before drafting or emitting visible prose, apply this gate.
Non-excepted prose routes the owner to Procedure Plane or Communication Plane continuation.
Uncertainty keeps prose prohibited.

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
4. A `verified result`, `closeout residual`, or turn-ending final report requires one closure basis: zero live same-request executable owner/action, explicit user cancellation/redirect, lawful owner deferral, or truthful `HOLD`.
5. A live same-request executable owner/action limits visible prose to an explicit status answer or user-action blocker and returns the owner to Procedure Plane continuation.
6. Before analyzed, evaluated, synthesized, produced, strengthened, phase/stage-end, or completion-result claims, load `Skill(self-verification)` and verify the exact outgoing claim.
7. When the active route uses multiple lanes, shards, reviewers, proof owners, or validators, every required output is completion-grade, consumed from its retained carrier, integrated, and either accepted, explicitly owner-deferred, out-of-scope with basis, or blocking with a user-action blocker.
8. When the report names candidates, findings, defects, patch-worthiness, patch readiness, or counts, `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` has classified each reported item and count.
9. Raw candidate counts, confirmed-defect counts, patch-worthy counts, patch-ready counts, rejected counts, and open-candidate counts stay separate in report prose when count reporting has a narrow exception.
10. Communication Plane and Procedure Plane payloads stay outside report content.

When any required lane/shard output is pending, unintegrated, contradictory, or only screen-visible, keep the report suppressed and continue monitoring, carrier consumption, correction, synthesis, or `Skill(self-verification)` internally.

## Non-Reportable Content
These stay prohibited as user reports:
- dispatch topology, lane count, route choice, staffing shape, runtime setup, monitoring, idle, receipt, ack, status, cleanup, or phase-context signals
- individual lane/shard arrival, partial lane/shard completion, partial convergence, all-lanes counters, per-shard findings summaries, and in-flight synthesis notes
- `dispatch-ack`, `scope-pressure`, `completion`, `hold|blocker`, assignment packets, packet corrections, phase-transition packets, shutdown requests, task rows, task output, runtime ledgers, and retained-output paths
- skill loading, methodology application, review-verification packet fields, self-verification records, retro-apply notes, governance modification notes, hook signals, ledgers, raw inventories, candidate counts, findings lists, excerpts, evidence packs, and alternative-route lists
- patch-application logs, applied-patch recaps, wave recaps, backlog lists, dispatch plans, and remaining-patch inventories while the same requested deliverable still has an executable owner/action
- statements that exist only to say work is starting, continuing, being monitored, being dispatched, being corrected, or being verified

Reportability follows content semantics across every visual format. Internal Procedure Plane content remains non-reportable whether it appears as descriptive prose, narrative summary, header-labeled blocks (`SELF-VERIFICATION:`, `review_verification_packet`, or any similar header-prefixed carrier block), field dumps (one-field-per-line listings), evidence rows, classification fields, packet fields, defeater records, per-claim basis, raw counts, candidate lists, retained-carrier contents, or any other surface form of the same internal content.

The user may explicitly request any internal material. That explicit request grants a narrow exception only for the requested material; future internal material remains governed by this law.

## Tool-Adjacent Prose Suppression
Tool-adjacent prose is visible pane/final text before, between, or after tool calls.
Tool-adjacent prose for startup contract application, owner-trigger opening, skill loading, reference consumption, planning freeze, corpus measurement, Codex or reviewer adjudication, packet drafting, directory creation, task updates, dispatch preparation, monitoring, or recovery stays suppressed while Procedure Plane or Communication Plane can continue.
Host-rendered rows from required `Skill(...)` or owner tool calls are tool evidence, not assistant-authored report prose.
Examples include any classifier-only wording that paraphrases one of the categories above (`Boot closes`, `dispatching now`, `4/7 complete`, per-shard summary, etc.) plus single-character or whitespace-only filler.
When the user asks why an expected action did not happen, follow the `explicit status answer` shape under `## Report Shape`.

## Transport Boundary
When Claude Code renders Communication Plane transport on a user-visible screen, the combined header/preview/body display is an envelope, not the full Communication Plane payload.
Receiver-required detail stays in governed assignment packets, task state, retained-output carriers, shutdown requests, or evidence artifacts referenced by the envelope.
User-reporting gates preserve receiver-required payload, keep it out of screen-rendered prose, and route it through non-report carriers.
The same state signal appearing in both header/preview and body is duplicate screen pollution, not a stronger receipt.
Communication payload is judged by receiver-required execution truth across the envelope plus governed carriers, not by user-report shape.
Team-lead explains, summarizes, or repeats transport as a user report only when this law separately grants that narrow exception.
Visible pane/final prose is not a substitute carrier for Communication Plane payload.
Carrierless wording in other owner documents such as `visible`, `progress update`, `name it`, `keep visible`, or `next update` means internal continuity carrier only and keeps pane-visible prose unauthorized.
Lane agents keep ACK, startup, execution plan, file-read, route, evidence, result inventory, findings count, retained-output contents, and later-report intent out of visible pane/final prose and screen-rendered transport bodies.
Non-excepted reports route to the owning Procedure Plane or Communication Plane action.

## Silent Continuation
Host-rendered tool rows, lane transport rows, teammate wake events, and lane lifecycle events (arrival, idle, cleanup, monitoring, same-state wake, retained-carrier consumption, synthesis queue) continue internally without assistant-authored filler prose.
If the user explicitly asks status, answer with the narrowest truthful status under Report Shape.
Silent close means zero assistant-authored visible body content and zero filler.
If the turn has no required tool call and would otherwise be empty, take a Procedure Plane tool action (read, verify, advance) the active owner path requires.
After a process state report, the active owner takes the next truthful action in the same turn per `.claude/reference/work-execution-core-law.md` `[AUTO-PROC]`.

## Report Shape
Final-result reports to the Korean operator use concise Korean.
Final-result reports state the result first.
Final-result reports include only essential verification, open-surface, blocker, or user-action truth.
Concise final-result wording limits Reporting Plane prose only.
Procedure Plane and Communication Plane carriers keep required detail.
Final-result reports place file/reference links last when links are included.
Requested-deliverable links may appear inline only when the link itself is the requested deliverable.
Explicit user inline-link requests may place requested links inline.
`verified result` reports the result first.
`verified result` includes only the highest-impact verification basis or canonical artifact path when material.
Multi-lane, multi-shard, or multi-wave verified result requires the all-required-output gate above plus current `Skill(self-verification)` verification on the synthesized claim.
`user-action blocker` reports the blocked user decision/action.
`user-action blocker` reports the smallest safe next step.
`explicit status answer` uses the narrowest truthful form.
Binary status questions get one yes/no sentence.
Binary status questions include a user-action blocker only when present.
Binary status questions preserve existing Procedure Plane authorization; continuation, route, staffing, dispatch, validation, cleanup, artifact mutation, task mutation, and governance mutation require their own execution basis.
When the user asks why an expected action did not happen, answer with the violated rule/owner.
When the user asks why an expected action did not happen, answer with the direct procedural cause.
When the user asks why an expected action did not happen, answer with the current correction owner/action.
Runtime-excuse wording such as `turn boundary`, `same turn`, `system-imposed`, file/read/edit counts, batching strategy, or similar host/tool mechanics is not a direct procedural cause.
Report content excludes self-accusation, excuses, intent promises, proceed prompts, and internal packet burden narrative.
Dispatch status uses the narrowest proven truth label from `.claude/skills/task-execution/references/truth-rules.md`.
Synthesis barrier and multi-lane status answers report only the user-relevant waiting condition unless the user requests a specific internal field.
Status answers omit internal topology, packet, shard, ack/completion, counts, paths, findings, evidence detail, retained-carrier detail, and per-agent narratives unless that exact field is requested.
When the user asks whether the whole requested work was done or challenges a completion claim, answer with completed requested stages.
When the user asks whether the whole requested work was done or challenges a completion claim, answer with incomplete requested stages.
When the user asks whether the whole requested work was done or challenges a completion claim, answer with the current next owner/action or blocker.
Concise status preserves independent facts as separate sentences; concise wording reduces explanation, not required truth axes.
`closeout residual` reports only residual state that affects the user.
Wave-PASS, partial-wave-PASS, or any mid-deliverable verified-result report is not a session-close report.
Session-close framing requires explicit user closeout initiation.

`FINAL` requires zero-residual deliverable convergence or explicit owner-deferred/out-of-scope basis.
`PHASE-RESULT` is excepted only when the phase result is a verified user-relevant result and same-segment internal continuation is unavailable.
`MID-FLIGHT` emits no user-facing prose unless the user explicitly asked for status or user action is required.

## Single-Source Rule
This reference owns report prohibition, narrow report exceptions, non-reportable content, and the user-facing side of transport/reporting separation.
Other documents may state local transport-owner boundaries and cite this reference.
Other documents cite this reference for report-prohibition criteria, narrow exception criteria, non-reportable content lists, and report-shape limits.
Communication Plane payload stays outside user reports unless this reference grants a narrow report exception.
Conflicting wording resolves to this reference and routes to `Skill(governance-modification)` for owner-local cleanup.

## Resolve Next Owner And Action
- A report that passes `## Pre-Report Gate` returns to `team-lead` for concise user-facing prose.
- Non-excepted prose returns to the owning Procedure Plane or Communication Plane continuation.
- A required user action opens a `user-action blocker` report with the smallest safe next step.
- An explicit status request opens an `explicit status answer` report and then returns to the active owner action.
- Missing verification, unintegrated lane output, pending required output, or open same-request executable owner/action opens the required internal continuation or `HOLD`.
- Conflicting report-permission wording opens `Skill(governance-modification)` cleanup at the conflicting owner surface.

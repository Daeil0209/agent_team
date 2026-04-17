---
name: session-closeout
description: Closeout procedures for team-lead session teardown and runtime cleanup.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed section order: Activation, Runtime Teardown Preflight, Closeout Sequence
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Activation

Load this skill when explicit user-directed session end is detected. The `UserPromptSubmit` hook (`.claude/hooks/user-prompt-gate.sh`) detects closeout intent and provides the loading trigger.


## Runtime Teardown Preflight

Run this before `TeamDelete`, `CronDelete`, or closeout cleanup that mutates runtime state.

1-2. Prerequisite: Fresh Turn Dispatch Gate must be satisfied.
3. Confirm explicit closeout or teardown intent and determine whether any live worker still needs action.
4. Delete runtime resources only after live worker cleanup and monitor ownership are accounted for. If runtime deletion fails and only non-live residue remains, stop retries and report the exact residual state truthfully instead of improvising teardown repair work.

## Closeout Sequence

The `Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed handoff requires runtime teardown.
Hook feedback alone is not sufficient evidence that the user wants the session to end.

Treat this skill as the procedure owner for closeout sequencing. Closeout is not a recovery project, retrospective audit, or completeness theater. Its default purpose is narrow: account for live workers, remove live runtime when possible, and leave a truthful residual state when not. If user-facing acceptance or governance surfaces remain unresolved, disclose them; otherwise do not manufacture extra closeout ceremony just because teardown is happening.
Precedence rule: Hook-owned closeout state tracks teardown progress and remains the authority on what runtime teardown steps completed. Hook signals alone still do not determine whether the user intends to end the session; intent is confirmed through explicit signals or context. Continuity surfaces (`./.claude/session-state.md` preferred; `$HOME/.claude/session-state.md` migration mirror/fallback) are corroborating evidence only. If the surfaces disagree, prefer a truthful HOLD or warning-bearing closeout over repair choreography during teardown.

### Closeout preemption rule

- Explicit user-directed session end preempts incomplete boot.
- If the runtime is active but `Boot Sequence` is incomplete, do not register a new health-check cron or otherwise finish boot solely to satisfy shutdown.
- Mark explicit closeout intent, shut down workers, remove any already-registered runtime monitors, and tear down the runtime directly.
- Once explicit closeout intent is active, message-based worker coordination needed to finish teardown may continue even if monitor removal makes boot incomplete again. Do not re-arm the health-check cron just to send teardown or closeout-coordination messages.

### No-runtime fast path

When the session used lead-local direct work only — no `TeamCreate`, no `CronCreate`, no dispatched worker agents — the full teardown sequence reduces to:
- Step 1: Mark closeout intent
- Step 2 (fast path): Disclose unresolved surfaces only if they actually exist; otherwise set validation-ownership = not-needed (reason: no-acceptance-surface) when no implementation deliverables exist
- Steps 3, 4, 5, 6: Skip entirely — no workers, monitors, or team runtime to tear down
- Steps 7–8: Let `SessionEnd` capture continuity timestamp and any warnings
- Step 10: Silent one-line acknowledgement unless the user requested a summary

Apply the no-runtime fast path whenever no explicit team runtime or recurring monitors were created in the current session.

### Required actions

1. Mark explicit closeout intent before sending any session-level `shutdown_request`, deleting the tracked health-check cron, or tearing down the explicit team runtime.
   Current standard: set explicit closeout intent in the session-bound structured closeout state before teardown begins, and clear that state if closeout is later deferred. Do not model closeout as a timeless on/off residue.
   When the current user prompt itself explicitly requests session end, the `UserPromptSubmit` hook should pre-mark closeout intent before the lead reaches any guarded closeout tool. In that case, do not intentionally trigger `CronDelete`, `TeamDelete`, or `shutdown_request` once just to discover that intent is required.
   Worker-specific termination remains message-first: after `mark-force-stop.sh` terminates a worker, the cleanup is a worker lifecycle edge, not by itself a session closeout edge.
2. Integrate worker outputs and disclose unresolved issues.
   Default rule: disclose only unresolved deliverable-risk surfaces that still matter at session end. Do not build a large closeout packet when the session was research-only, operational-only, or otherwise has no acceptance surface.
   Fast-path: if the session performed only research, Q&A, or read-only analysis with no implementation deliverables, set validation-ownership = not-needed (reason: no-acceptance-surface) and proceed immediately. Fast-path also applies when all implementation work in the session had explicit `ACCEPTANCE-RISK: low` dispatch classification and the lead can truthfully confirm the acceptance basis without spinning up extra closeout ceremony.
   When acceptance risk is meaningful, keep one authoritative acceptance basis and one exact unresolved reason if clean closeout is not earned. Do not expand closeout into a retrospective audit.
   Team-lead should already have recorded worker handoff content in the effective continuity surface during normal work. No separate absorption step from handoff files is needed at closeout.
3. Release or explicitly account for remaining workers through explicit internal lifecycle messages.
   Closeout exception to message-first: During session teardown only, standby workers may be released with a brief `shutdown_request` via SendMessage rather than requiring a full lifecycle decision packet. If the session is ending and workers have no pending output, a brief shutdown_request is sufficient. This is the sole exception to message-first; do not extend it to active-session lifecycle decisions.
   Closeout is not the time to invent a new continuity lane. The workspace-local continuity surface should already be current from normal work.
   Account for live workers only. If a worker is already dead and only registry or config residue remains, do not start ad hoc repair work during closeout; record the exact residue truthfully instead.
4. Keep continuity handling minimal during teardown.
   Do not dispatch a new continuity writer or other ad hoc helper lane as part of normal closeout. If continuity is materially stale, refresh it before teardown starts as ordinary session work. Otherwise rely on `SessionEnd` capture for the final timestamp and residual warnings.
   Any pre-teardown continuity refresh must be lead-local and structured: use `Edit`, `MultiEdit`, or `Write` on the continuity surface. Do not use Bash redirection, `tee`, heredocs, or other mutable shell paths for `.claude/` continuity files, because compliance hooks intentionally block mutable shell writes there.
5. Remove periodic session runtime monitors that were registered for the live session only after current-runtime workers have been fully accounted for.
   Current standard: read the stored job ID, run `CronDelete(id: stored_job_id)`, then clear the tracked health-check job record from runtime state.
   Do not treat monitor-rotation handling as a substitute for this step. Closeout teardown still requires explicit closeout intent, not rotation intent.
   Delete the tracked health-check only after the current-runtime workers that still need coordination have been fully accounted for. Do not recreate the monitor just to keep messaging open.
   If no tracked health-check cron is active, skip this step rather than manufacturing monitor teardown ceremony.
6. Tear down the explicit team runtime when that runtime was used and the workers are no longer active.
   `TeamDelete` is not a shortcut for worker cleanup. Drain live current-runtime workers first.
   Attempt bounded runtime teardown once worker state is drained. Do not loop on repeated teardown retries, repeated sleep polling, or manual config surgery.
   If `TeamDelete` fails and the remaining problem is non-live runtime residue only (for example stale config with no live worker or tmux session), stop there and close out truthfully with an exact residual note instead of escalating repair work inside closeout.
   On a fresh user turn, `TeamDelete` and `CronDelete` still require the runtime teardown preflight: `work-planning` -> post-planning `self-verification` -> closeout/teardown intent confirmed -> runtime mutation.
7. Let `SessionEnd` finish continuity stamping after runtime teardown.
   Preserve the workspace-local continuity surface and its migration mirror; do not clear them as part of closeout cleanup. Hook-owned closeout state remains teardown authority. After `CronDelete` or `TeamDelete`, do not dispatch a new `Agent` just to write continuity.
   If continuity remains stale at that point, do not reopen runtime teardown or start a helper lane just to change the continuity timestamp. Leave the state truthful and let `SessionEnd` capture it as warnings-bearing continuity.
8. Let `SessionEnd` cleanup clear runtime-owned logs, ledgers, transient closeout residue, and current-project auto memory after continuity capture and session-end logging complete.
   No handoff file cleanup is needed because team-lead records handoff content directly in continuity coordinate sections, not in separate files. For complete session closeout (user explicitly ended the session), workspace continuity may be initialized to a clean state after final continuity capture and then mirrored outward.
9. Run an explicit supervisor-effectiveness review only when the user asked for team-operation evaluation, a real teardown/management defect occurred, or `Self-Growth Sequence` work is active.
   If triggered, inspect detection timeliness, reroute quality, checkpoint cleanliness, stalled-lane handling, and whether the user had to surface a problem before the team did. A required supervisor review remains a clean-closeout gate even after runtime teardown.
10. End with a truthful operator-facing closeout only when step 9 was actually triggered, the closeout is blocked or in truthful hold, restart or handoff guidance is materially needed, or the user explicitly asked for a summary.
   Clean closeout with no meaningful carry-forward state may be silent or reduced to a one-line acknowledgement.
   Blocked or warning-bearing closeout should stay short: exact residual state, exact hold reason when needed, and the next expected recovery surface. Do not turn closeout into a long narrative recap.

### Closeout constraints

#### Worker Cleanup

- Do not leave orphaned workers or live recurring monitors silently running.
- Do not treat a force-stopped worker as fully cleaned up until the tmux pane is confirmed terminated or equivalent runtime teardown is complete.
- Do not keep closeout open just to cosmetically clean non-live residue after the live worker/process truth is already known.

#### Runtime State Integrity

- Do not manually write runtime marker files to bypass boot or closeout gates. If runtime state is contradictory, hold and clean the residue instead of inventing runtime truth.
- Do not trust closeout state that belongs to another session. Closeout guards and stop gating must bind to the current runtime session before they authorize teardown.
- Do not use mutable Bash, `rm`, or ad hoc registry surgery on `.claude` runtime surfaces during closeout. If structured cleanup is unavailable, end truthfully with residual state instead of improvising repair work.
- Do not expect runtime cleanup or `SessionEnd` cleanup to invent missing acceptance truth. If a meaningful unresolved user-facing risk remains, state it exactly; otherwise keep the closeout light.

#### Lifecycle Authority

- Do not infer user end-of-session intent from hook feedback, runtime residue, or repeated closeout warnings alone.
- Lifecycle shutdown decisions remain message-first (see session-boot/SKILL.md § Message-first lifecycle rule): hooks may guard or report but must not invent shutdown authority.
- `shutdown_request` is a structured JSON message and cannot be sent via broadcast (`to: "*"`). Send individual `shutdown_request` to each worker by name.

#### Continuity Discipline

- Do not dispatch new agents during closeout. The fast path: worker accounting → `CronDelete` → `TeamDelete` → `SessionEnd` capture.
- If stale continuity is the only remaining issue after teardown, stop there and let `SessionEnd` capture it. Do not loop on repeated hook feedback.
- If structured lead-local editing is unavailable or teardown has already made the explicit runtime inactive, do not attempt a Bash fallback and do not re-open the runtime just to update continuity. Leave the state truthful and rely on `SessionEnd`.
- If closeout is aborted, deferred, or narrowed, clear explicit closeout intent immediately and return control to the `Monitoring Sequence`.
- Do not use repeated sleep polling as a default teardown tactic. After a bounded liveness check, either continue teardown or report a truthful residual hold.

> See reference.md for closeout state schema and hold conditions.

#### Closeout Output

- Do not present blocked or partially cleaned-up closeout as complete success.
- Clean closeout: silent or one-line acknowledgement. No recap bullets, file lists, diagnostic tables, retrospective audits, or duplicate status artifacts.
- Exception: when unresolved surfaces exist (incomplete acceptance gates, open blockers, or validation-owner gaps), they must be disclosed regardless of the silent-close default. Bare acknowledgement is only correct when there are no unresolved surfaces.
- Blocked closeout: state concrete residue and HOLD. Do not replace incomplete teardown with narrative diagnosis.
- Make unresolved blockers, risks, and follow-up state explicit before closeout.
- If a full closeout cannot be completed, report the exact residual state explicitly.

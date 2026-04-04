---
name: session-closeout
description: Closeout procedures for team-lead session teardown and runtime cleanup.
user-invocable: false
---

## Activation

Load this skill when explicit user-directed session end is detected. The sync-closeout-intent-from-prompt.sh hook detects closeout intent and provides the loading trigger.

Core monitoring, dispatch, and lifecycle procedures remain in the always-loaded `team-session-sequences` skill.

## Closeout Sequence

The `Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed handoff requires runtime teardown.
Hook feedback alone is not sufficient evidence that the user wants the session to end.

Treat this skill as the procedure owner for closeout sequencing. Closeout `phase` is teardown progress only; clean closeout also requires an explicit governance-completeness vector that covers final validation ownership, authoritative acceptance evidence, and supervisor review state. The persisted runtime fields for that vector live in the hook-owned runtime state surface; this skill remains the human-readable procedure owner.

### Closeout preemption rule

- Explicit user-directed session end preempts incomplete boot.
- If the runtime is active but `Boot Sequence` is incomplete, do not register a new health-check cron or otherwise finish boot solely to satisfy shutdown.
- Mark explicit closeout intent, shut down workers, remove any already-registered runtime monitors, and tear down the runtime directly.
- Once explicit closeout intent is active, message-based worker coordination needed to finish teardown may continue even if monitor removal makes boot incomplete again. Do not re-arm the health-check cron just to send teardown or closeout-coordination messages.

### Required actions

1. Mark explicit closeout intent before sending any session-level `shutdown_request`, deleting the tracked health-check cron, or tearing down the explicit team runtime.
   Current standard: set explicit closeout intent in the session-bound structured closeout state before teardown begins, and clear that state if closeout is later deferred. Do not model closeout as a timeless on/off residue.
   When the current user prompt itself explicitly requests session end, the `UserPromptSubmit` hook should pre-mark closeout intent before the lead reaches any guarded closeout tool. In that case, do not intentionally trigger `CronDelete`, `TeamDelete`, or `shutdown_request` once just to discover that intent is required.
   Worker-specific termination remains message-first: after `mark-force-stop.sh` terminates a worker, the cleanup is a worker lifecycle edge, not by itself a session closeout edge.
2. Integrate worker outputs and disclose unresolved issues.
   Before monitor teardown or `TeamDelete`, resolve the contract-owned teardown governance prerequisites for this session: final validation ownership and authoritative acceptance evidence.
   When acceptance risk is meaningful, assign an explicit final validation owner before closeout rather than letting review or testing silently stand in for final validation.
   When standalone review, test, or validation reports are intentionally suppressed, keep one authoritative acceptance-evidence block in the closeout or continuity state before granting clean closeout.
   At closeout, do not rely on remembered intent to prove governance completeness. Record the final closeout governance packet explicitly before clean stop, and if governance is still unresolved, prepare a truthful hold rather than compressing the sequence.
   Current standard: record the final closeout governance packet explicitly in the same structured closeout state, including validation-owner state, acceptance-evidence state, and supervisor-review state.
   If truthful clean closeout is not yet earned, prepare explicit carry-forward hold state with a concrete reason instead of compressing the sequence or hoping teardown cleanup will infer it.
3. Release or explicitly account for remaining workers through explicit internal lifecycle messages.
   Closeout is not the time to invent a new continuity lane. `session-state.md` should already be current from normal work, and remaining live workers must be accounted for before monitor teardown.
4. Keep continuity handling minimal during teardown.
   Do not dispatch a new continuity writer or other ad hoc helper lane as part of normal closeout. If continuity is materially stale, refresh it before teardown starts as ordinary session work. Otherwise rely on `SessionEnd` capture for the final timestamp and residual warnings.
5. Remove periodic session runtime monitors that were registered for the live session only after current-runtime workers have been fully accounted for.
   Current standard: read the stored job ID, run `CronDelete(id: stored_job_id)`, then clear the tracked health-check job record from runtime state.
   Do not treat monitor-rotation handling as a substitute for this step. Closeout teardown still requires explicit closeout intent, not rotation intent.
   Delete the tracked health-check only after the current-runtime workers that still need coordination have been fully accounted for. Do not recreate the monitor just to keep messaging open.
   If no tracked health-check cron is active, skip this step rather than manufacturing monitor teardown ceremony.
6. Tear down the explicit team runtime when that runtime was used and the workers are no longer active.
   `TeamDelete` is not a shortcut for worker cleanup. Normal closeout requires drained current-runtime worker state first; unterminated workers must block teardown.
7. Let `SessionEnd` finish continuity stamping after runtime teardown.
   Preserve `.claude/session-state.md` as the continuity owner; do not clear it as part of closeout cleanup. After `CronDelete` or `TeamDelete`, do not dispatch a new `Agent` just to write continuity.
   If continuity remains stale at that point, do not reopen runtime teardown or start a helper lane just to change the continuity timestamp. Leave the state truthful and let `SessionEnd` capture it as warnings-bearing continuity.
8. Let `SessionEnd` cleanup clear runtime-owned logs, ledgers, transient closeout residue, and current-project auto memory after continuity capture and session-end logging complete.
9. Run an explicit supervisor-effectiveness review only when the user asked for team-operation evaluation, a real teardown/management defect occurred, or `Self-Growth Sequence` / `Update/Upgrade Sequence` work is active.
   If triggered, inspect detection timeliness, reroute quality, checkpoint cleanliness, stalled-lane handling, and whether the user had to surface a problem before the team did. A required supervisor review remains a clean-closeout gate even after runtime teardown.
10. End with a truthful operator-facing closeout only when step 9 was actually triggered, the closeout is blocked or in truthful hold, restart or handoff guidance is materially needed, or the user explicitly asked for a summary.
   Clean closeout with no meaningful carry-forward state may be silent or reduced to a one-line acknowledgement; in that case the authoritative detail remains the closeout state plus `SessionEnd` continuity capture rather than a recap message.

### Closeout constraints

- Do not leave orphaned workers or live recurring monitors silently running.
- Do not treat a force-stopped worker as fully cleaned up until the tmux pane is confirmed terminated or equivalent runtime teardown is complete.
- Do not manually write runtime marker files to bypass boot or closeout gates. If runtime state is contradictory, hold and clean the residue instead of inventing runtime truth.
- Do not infer user end-of-session intent from hook feedback, runtime residue, or repeated closeout warnings alone.
- Do not trust closeout state that belongs to another session. Closeout guards and stop gating must bind to the current runtime session before they authorize teardown.
- Lifecycle shutdown decisions must remain message-first: hooks may guard or report, but they must not invent shutdown authority in place of the lead's explicit message path.
- Do not dispatch a new continuity helper during normal closeout. The fast path is worker accounting -> `CronDelete` -> `TeamDelete` -> `SessionEnd` capture.
- Do not dispatch a new `Agent` for continuity capture after `CronDelete` or `TeamDelete`.
- If stale continuity is the only remaining issue after teardown, stop there and let `SessionEnd` capture it. Do not loop on repeated hook feedback.
- If closeout is aborted, deferred, or narrowed, clear explicit closeout intent immediately and return control to the `Monitoring Sequence`.
- Do not present blocked or partially cleaned-up closeout as complete success.
- Prefer lean closeout: default to silence or one-line acknowledgement; expand only for decisive evidence, blockers, restart requirements, or residual risk.
- Prefer one authoritative closeout narrative over multiple thin summaries or duplicate status artifacts when a narrative is actually needed.
- Make unresolved blockers, risks, and follow-up state explicit before closeout.
- Default clean closeout reporting to silent or one-line acknowledgement. Do not emit recap bullets, file lists, risk lists, or handoff sections when no material carry-forward state exists.
- Keep clean closeout reporting compact. Do not emit long diagnostic tables or retrospective audits unless the user asked or the teardown actually blocked.
- Do not replace unfinished teardown with a long retrospective diagnosis. State the concrete residue, keep the state on `HOLD`, and stop.
- If a full closeout cannot be completed, report the exact residual state explicitly.
- Do not expect runtime cleanup or `SessionEnd` cleanup to invent missing governance resolution. Those gates now require an explicit clean governance packet or an explicit truthful hold.

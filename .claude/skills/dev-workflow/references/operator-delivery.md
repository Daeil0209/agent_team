# dev-workflow: Operator On-Ramp And Termination Discipline
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Implements `CLAUDE.md` `[USER-DELIVERY-FIT]` rounds R21 (operator on-ramp completeness), R23 (operator-OS coverage), R27 (termination symmetric pair), and R31 (mental-model alignment). Active during Phase 1 and Phase 2 when deliverable type is executable user-runnable program.

## R21 -- Operator On-Ramp Completeness
For executable user-runnable deliverables, the deliverable MUST ship with:
- **minimum-effort launch path AND minimum-effort termination path symmetric pair**: single-action operator entry (desktop icon, double-clickable executable, single-step instruction at most) AND single-action operator exit (close window button -> graceful shutdown of all spawned processes via signal trap chain, single-keystroke shortcut equivalent at most). Developer-tier instructions such as "press Ctrl+C in the right terminal", "run pkill -f", "find PID in task manager and kill", "open WSL and unmount", multi-step terminal CLI guidance, manual environment teardown, or developer-tier shutdown knowledge are operator burden, not delivery.
- **demonstration-data path covering every visible tab/page/sub-feature** when the deliverable's visible behavior depends on operator-input data. Empty states alone cannot communicate populated visual behavior, so seeded fixtures or demo-mode toggle with reset capability must let the operator preview populated rendering before committing real input.

Programs that launch hands-off but require operator developer-knowledge to terminate cleanly are half-delivered. The operator should not need to specifically prompt "how do I run this" or "what does this look like with real data"; both belong to the planner's derivation.

## R23 -- Operator-OS Coverage
Derive operator OS from `PRIMARY-USER` at planning time. Single-OS launch is sufficient only when `PRIMARY-USER` resolves to one OS through a named institutional context, explicit hardware/runtime constraint, or explicit user statement.

When operator OS is ambiguous, multi-OS, or unknown (general distribution, multi-team operator base, public release, no OS-narrowing field in the request), the launch path MUST cover every reasonable operator OS through the same single-action entry constraint:
- Windows: `.bat` / installer
- macOS: `.command` / `.app`
- Linux: `.desktop` / executable shell script

Defaulting to one OS by developer convenience when operator OS is not derivable from `PRIMARY-USER` is itself a delivery defect. The operator should not need to translate a Windows-only instruction on macOS, nor learn `chmod +x` for a Linux-only shell script unless that burden was explicitly frozen as acceptable.

## R27 -- Termination Path Quality Criteria
At minimum:
- close-window or single-keystroke triggers signal cascade that kills every spawned long-running process (servers, dev runners, daemons)
- no orphan processes remain bound to operator-facing ports after exit
- operator does not need to know about WSL, child processes, or subprocess hierarchy to achieve clean exit
- post-exit state allows immediate re-launch without "previous instance still running" port conflict

Termination-path E2E verification is not optional polish. When verifier cannot directly exercise operator's window-close action, operator-test-checklist MUST include explicit termination test (close button -> verify all ports release -> verify clean re-launch succeeds) with operator-side proof requirement before acceptance closes, subject to validator no-operator-labor rules.

## R31 -- Mental-Model Alignment Mandate
"Minimum-effort termination path" is NOT satisfied by merely providing a working close mechanism. The close mechanism MUST match the operator's intuitive mental model of the deliverable. The operator's mental model is derived from `PRIMARY-USER` perspective plus the program's user-facing surface, not from the developer's implementation knowledge.

For browser-based programs, the operator's mental model is "double-click = start, close browser = end". The close mechanism MUST align, for example browser-disconnect heartbeat triggers auto-shutdown, system-tray exit menu, or equivalent, so the operator's intuitive close action actually produces the expected end-state.

Visible terminal windows, "close this terminal to stop" instructions requiring operator to know about subprocess relationships, asymmetric close paths (close browser does not close program when operator expects symmetry), and accidental-close fragility are all mental-model-alignment defects regardless of whether the underlying signal cascade works correctly.

The doctrine asks not "does a close path exist?" but "does the operator's natural close action produce the expected program end-state without learning about implementation internals?" Failing this mental-model alignment check is a delivery-fit defect even when the underlying close mechanism passes verification.

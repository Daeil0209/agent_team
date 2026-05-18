# dev-workflow: Operator On-Ramp And Termination Discipline
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Implements `CLAUDE.md` `[USER-DELIVERY-FIT]`.
Covered `[USER-DELIVERY-FIT]` axes: operator on-ramp completeness, operator-OS coverage, termination symmetric pair, and mental-model alignment.
Section anchors `R21`/`R23`/`R27`/`R31` index this file's subsections only; they are not external rule identifiers.
This contract activates through:
- `dev-workflow` during Phase 1 and Phase 2
- `work-planning` directly for user-runnable executables before implementation, proof, or acceptance when `dev-workflow` is not active
Consumed again during Phase 4/5/Final Acceptance Review/Complete whenever launch, termination, demo data, operator OS, clean re-launch, or mental-model delivery affects proof or acceptance.
Executable deliverables specialize the Receiver-Surface Contract through a native Consumption Chain.
The chain covers setup/build, launch/open, operate, readable failure, terminate/cleanup, and clean re-launch.

## Contents
- R21 -- Operator On-Ramp Completeness
- R23 -- Operator-OS Coverage
- R27 -- Termination Path Quality Criteria
- R31 -- Mental-Model Alignment Mandate
- Closure Re-entry Law
- Resolve Next Owner And Action

## R21 -- Operator On-Ramp Completeness
For executable user-runnable deliverables, the deliverable MUST ship with:
- **minimum-effort launch path AND minimum-effort termination path symmetric pair**.
- Single-action operator entry means desktop icon, double-clickable executable, or single-step instruction at most.
- Single-action operator exit means close window button -> graceful shutdown of all spawned processes via signal trap chain, or single-keystroke shortcut equivalent at most.
- Native launch/build assets, when material, name these axes:
  - shell
  - encoding
  - line endings
  - dependency/setup source
  - build output path
  - run input path
  - readable failure behavior
- Developer-tier instructions are operator burden, not delivery.
- Examples: "press Ctrl+C in the right terminal", "run pkill -f", "find PID in task manager and kill", "open WSL and unmount", multi-step terminal CLI instructions, manual environment teardown, or producer-tier shutdown knowledge.
- **sufficient representative demonstration-data path** when the deliverable's visible behavior depends on operator-input data.
  - The path covers every in-scope visible feature/surface/control.
  - It exercises the visible workflows, calculations, validation states, persistence, reload, and reset/import paths needed to prove the user can understand and trust the delivered tool.
- Empty states alone cannot communicate populated visual behavior.
- Seeded fixtures or demo-mode toggle with reset capability must let the operator preview populated rendering before committing real input.

### Local Web App Launcher Requirements
Local-only web apps must satisfy this contract regardless of stack:
- single-action operator launch chains environment setup, server start, and operator surface open as one operation;
- only operator-intended surfaces are visible (developer-facing console, banner, reloader, and debug surfaces are hidden);
- closing the operator surface produces clean termination of all spawned processes;
- explicit operator exit affordance exists on the operator surface;
- no development-server warnings reach the operator.

Tech-stack-specific patterns (Flask + VBS + `pythonw.exe`, Node + nw.js, Tauri, Bun, Electron, etc.) are implementation instructions owned by the developer/researcher lane, not governance.

The named launch artifact itself must be exercised by the operator invocation shape.
Example: invoking the shipped launcher through the operator's native UI.
Starting an already-running server does not prove the operator launch path.
Running a backend module directly does not prove the operator launch path.
Inheriting a prior PID does not prove the operator launch path.
Opening only the browser URL does not prove the operator launch path.
A launcher is a launch failure when it:
- flashes and exits before opening the app
- exits without leaving a readable operator error
Carry-forward launch evidence is valid only when the original proof exercised the same launch artifact, invocation shape, operator environment, termination, and clean re-launch contract.
Programs that launch hands-off but require producer-only knowledge to start, diagnose, or terminate cleanly are half-delivered.
The operator does not need to prompt:
- "how do I run this"
- "what does this look like with real data"
Both belong to team-lead planning derivation.

## R23 -- Operator-OS Coverage
Derive operator OS from `PRIMARY-USER` and current request/environment evidence at planning time.
If the user works from Windows paths, Windows tooling, or Windows operator language, freeze Windows as the primary operator OS unless the user explicitly states a contrary preference.
For Windows primary operators, proof starts from the Windows launch surface.
WSL/Linux proof is support evidence only unless proven equivalent for the exact operator action.
Single-OS launch is sufficient only when `PRIMARY-USER` resolves to one OS through a named institutional context, explicit hardware/runtime constraint, explicit user statement, or concrete current-environment evidence.

When operator OS is ambiguous and the request signals general distribution, multi-team operator base, or public release, the launch path must cover every operator OS named by that evidence OR record an explicit narrowing rationale in CP1/CP2.
Absence of OS evidence defaults to the operator's current-environment OS, not all-OS coverage.
Multi-OS launch coverage uses the same single-action entry constraint per OS:
- Windows: native launcher, installer, or shortcut
- macOS: native launcher or app bundle
- Linux: desktop entry or executable launcher

Defaulting to one OS by producer convenience when operator OS is derivable from `PRIMARY-USER` evidence is a delivery defect.
The operator does not need to:
- translate a Windows-only instruction on macOS
- learn `chmod +x` for a Linux-only shell script unless that burden was explicitly frozen as acceptable

## R27 -- Termination Path Quality Criteria
At minimum:
- close-window or single-keystroke triggers signal cascade that kills every spawned long-running process (servers, dev runners, daemons)
- no orphan processes remain bound to operator-facing ports after exit
- operator does not need to know about WSL, child processes, or subprocess hierarchy to achieve clean exit
- post-exit state allows immediate re-launch without "previous instance still running" port conflict

Termination-path E2E verification is required closure evidence.
When verifier cannot directly exercise the operator's window-close action, document the termination test as operator reference only.
Acceptance closes from team-side auto-test proof or proven-equivalent interop proof.
The proof target is: close button -> verify all ports release -> verify clean re-launch succeeds.
If neither proof path is available, report `HOLD` or `UNVERIFIED-IN-OPERATOR-ENV`.

## R31 -- Mental-Model Alignment Mandate
"Minimum-effort termination path" is NOT satisfied by merely providing a working close mechanism.
The close mechanism MUST match the operator's intuitive mental model of the deliverable.
The operator's mental model is derived from `PRIMARY-USER` perspective plus the program's user-facing surface.
It is not derived from producer implementation knowledge.

For browser-based programs, the operator's mental model is "double-click = start, close browser = end".
The close mechanism MUST align.
Examples: browser-disconnect heartbeat triggers auto-shutdown, system-tray exit menu, or equivalent.
The operator's intuitive close action must produce the expected end-state.

Visible terminal windows are mental-model-alignment defects when they expose implementation burden.
"Close this terminal to stop" instructions are defects when they require operator knowledge of subprocess relationships.
Asymmetric close paths are defects when close browser does not close program and the operator expects symmetry.
Accidental-close fragility is a defect.
These remain defects even when the underlying signal cascade works correctly.

The doctrine asks: does the operator's natural close action produce the expected program end-state without learning implementation internals?
It does not ask only whether a close path exists.
Failing this mental-model alignment check is a delivery-fit defect even when the underlying close mechanism passes verification.

## Closure Re-entry Law
Any missing, broken, unverified, or mismatched closure item forces `FINAL-REJECT`; executable user-facing `FINAL-ACCEPT` and completion are unavailable.
Closure items:
- exact launch artifact
- native setup/build/run chain when material
- termination
- clean re-launch
- access path
- demo-data preview
- frozen in-scope feature/surface/control coverage
- operator-OS fit
- operator mental-model delivery
- resource cleanup
- project-artifact hygiene
Classify the root cause at the narrowest owner.
Phase 5 owns implementation or cleanup repair.
Phase 2 owns delivery-contract or design weakness.
`work-planning` owns changed deliverable shape, operator OS, proof/acceptance chain, or user requirement.
Do not close it as instruction residue.
When the frozen operator surface is still satisfiable, team-lead routes directly to Phase 5 operator-proof or repair and attempts non-destructive team-side proof before user escalation.
Scope narrowing becomes user-owned only after team-side proof paths are proven infeasible, destructive/security/policy approval is required, or the user explicitly redirects scope.

## Resolve Next Owner And Action
- Complete operator-delivery closure returns to Phase 4/5 acceptance or Final Acceptance Review.
- Missing implementation or cleanup closure opens Phase 5 repair.
- Missing delivery-contract or design closure opens Phase 2 correction.
- Changed deliverable shape, operator OS, proof chain, acceptance chain, or user requirement opens `work-planning`.
- Unavailable team-side proof path opens bounded setup/tool proof path or `HOLD`.
- Proven infeasible team-side proof with user-owned condition opens user-owned blocker.
- Operator-delivery `FINAL-REJECT` returns to CP5 route classification.

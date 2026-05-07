---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Completion And Handoff
## Common Completion Result Spine
Every completion-grade report using `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` must include:
- `TASK-ID`
- `OUTPUT-SURFACE`
- `TARGET-INTENT-BASIS`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `FROZEN-CONTRACT-STATUS`
- `RECOMMENDED-NEXT-LANE`
- `PLANNING-BASIS: loaded`
- `CONVERGENCE-PASS`
- `RESOURCE-CLEANUP`
- `REQUESTED-LIFECYCLE`

Lane handoff reports lane-local convergence only and claims no team-lead `SV-RESULT`.
Team-lead synthesizes only completion-grade handoffs, then runs `SV-RESULT` on the exact synthesized outgoing claim before user-facing consequential reporting, completion claim, or redispatch.

For team-agent runtime, the report is completion-grade only when delivered to `team-lead` by `SendMessage` with the required `MESSAGE-CLASS`.
Plain-text agent output is production evidence only until carried through that channel.
When the assigned output is a synthesis, audit, evidence pack, generated artifact, or project-output surface, the handoff cites the retained path under `projects/<project-folder>/...`.
When artifacts, logs, screenshots, traces, reports, or datasets support `EVIDENCE-BASIS`, the handoff must cite a retained project-owned path.
`/tmp`, shell scrollback, transient pane output, and deleted scratch files are execution context only, not retained evidence.
Conversation-only output is valid only when the packet names conversation as the output surface.

`TARGET-INTENT-BASIS` names the governance, program, report, document, review, proof, or validation purpose that controlled the work.
Use `INFERENCE` when reconstructed safely from request, plan, design, Structural Contract, cited artifact, or frozen scope.
Do not use generic text such as "follow the task" or "review the artifact".
Common finding basis:
- Evidence-only observations stay as anchors or `OPEN-SURFACES`.
- A patchable finding states `TARGET-INTENT-BASIS`, evidence class when material, protected function, user-outcome impact, `patch-worthiness`, and regression risk.
- Only `patch-worthiness: must-fix|narrow-fix` is patch-dispatch basis; `observe|no-patch` stays retained context.

`RESOURCE-CLEANUP` reports whether stateful tool sessions opened during lane work were closed at handoff.
Stateful sessions include Playwright MCP browser sessions, dev servers, proof background processes, temporary fixture files, locked resources, and equivalent runtime state.
Use `RESOURCE-CLEANUP: complete` only with a brief enumeration of what was closed.
Use `RESOURCE-CLEANUP: not-applicable (no stateful resource opened)` only when the lane truly invoked no stateful spawn.
Leaving an MCP browser session, dev server, or other stateful tool open at handoff is a `RESOURCE-CLEANUP` defect.
`complete` requires explicit enumeration of every spawned long-running process actually killed.
For processes, enumerate server PID plus port, daemon PID, or dev-runner PID.
`complete` also requires a post-cleanup verification that ports and resources are released.
Bare `complete` without enumeration and post-cleanup probe is a `RESOURCE-CLEANUP` defect.
If the lane ran any launch script, dev server, test harness, or browser session, `not-applicable` is forbidden.
Leaving a long-running server process bound to an operator-facing port is an operator-surface launch risk.
Team-lead must reject completion-grade reports that claim `not-applicable` when verification or smoke-test work required process spawning.
Team-lead must reject `complete` without enumeration and post-cleanup probe.

Lane docs may require bounded additions, but they must not weaken or replace this common result spine.
Handoff names selected non-lane-core skills, material direct references applied or blocked, material tool/proof capability used or blocked, and work-surface basis.
If a material specialist skill, direct reference, or decisive tool was omitted, unavailable, or only named without shaping the work, the gap stays in `OPEN-SURFACES` or routes through `scope-pressure` / `hold|blocker` instead of completion-ready wording.
Team-lead reviews that basis against the handed-off work and sends correction to the owning lane when direction drifts.
When material, `EVIDENCE-BASIS` names the Evidence-Quality Matrix rows supporting the handoff claim.
`FROZEN-CONTRACT-STATUS` must be one of `matched`, `partial`, `drifted`, `blocked`, `not-assessable`, or `not-applicable:<basis>`. It compares the lane's evidence against the frozen assigned contract, not just the changed artifact or executed route.
When material, `FROZEN-CONTRACT-STATUS` names the Receiver-Surface Contract, Consumption Chain, or Boundary Register basis that the lane matched, narrowed, or left open.
The common end closure contract reconciles the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md` against this result spine.
Each material start-contract axis closes through matched evidence, upstream defer basis, `not-applicable:<basis>`, or an `OPEN-SURFACES` item.
Use `matched` only when the supporting spine fields or lane-specific status fields show the axis outcome.
When the user-ready delivery chain is material, `matched` requires traceable continuity from instruction through concept/detail, implementation or production surface, verification evidence, and final receiver path.
Working features with disconnected information, hidden assumptions, orphaned components, or implausible receiver flow are not closed-result evidence.
`REQUESTED-LIFECYCLE` does not itself clear lifecycle debt.
Team-lead still owes explicit lifecycle control.
Team-lead can allow one narrow same-surface follow-on before lifecycle control only when all conditions hold:
- prior completion already made a non-reuse requested lifecycle explicit
- next dispatch targets a distinct concrete agent
- unresolved lifecycle debt stays visible

When the lane claims user-surface proof or user-surface acceptance on an executed surface, the completion-grade report must also keep the exercised method explicit:
- `USER-RUN-PATH` and `RUN-PATH-STATUS` when the deliverable is executable user-facing
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`

Do not compress `real browser interaction`, `rendered/runtime reader proof`, or other decisive user-surface work into vague surface claims without naming the concrete proof method and execution evidence actually used.
Do not report any requested deliverable as complete while requested content, functions, format, user-facing path, reader/operator burden, or acceptance surface remains missing, partial, placeholder-only, unrendered, unrun, or unverified unless upstream scope explicitly narrowed or deferred it.
Do not report an executable deliverable as complete without the exact operator launch artifact plus invocation evidence, stop/cleanup path, clean re-launch basis, access URL/port when applicable, and project-artifact hygiene status.
Do not widen `ACTIVE-SLICE` evidence into phase, MVP, release, or workflow completion without reconciling it against `SCOPE-BASELINE`.
Missing, placeholder-only, unimplemented, or unproven baseline items remain `OPEN-SURFACES`.

## Common Lane Handoff Law
- Every agent handoff is an upward lane report, not a replacement for the frozen global plan.
- Report only lane-local execution truth: the surface actually examined or changed, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane/action recommendation.
- Verdict or `PASS` language remains scoped to the reported lane evidence; it does not become wider acceptance, route closure, or broader user-surface proof through handoff formatting.
- Handoff exposes quality-relevant open surfaces clearly enough that the downstream owner can act without rediscovery.
- `RECOMMENDED-NEXT-LANE` narrows the plausible next owner/action enough for team-lead to choose redispatch, verification, acceptance, correction, blocker-clear, or `HOLD` without lane-local rediscovery; it does not freeze routing or collapse independent owners.
- Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- If the truthful next step changes owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain, do not disguise that as ordinary completion.
- Raise `scope-pressure` or `hold|blocker`.
- If any required procedure state for completion-grade reporting is not true yet, use `MESSAGE-CLASS: hold|blocker` instead of formatting the report as completion-ready.

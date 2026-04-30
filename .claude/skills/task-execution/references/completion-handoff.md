---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Completion And Handoff
## Common Completion Result Spine
Every completion-grade report using `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` must include:
- `TASK-ID`
- `OUTPUT-SURFACE`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `RECOMMENDED-NEXT-LANE`
- `PLANNING-BASIS: loaded`
- `SV-PLAN-VERIFY: done`
- `SV-RESULT-VERIFY: converged`
- `CONVERGENCE-PASS`
- `RESOURCE-CLEANUP`
- `REQUESTED-LIFECYCLE`

`RESOURCE-CLEANUP` reports whether stateful tool sessions opened during the lane's work (browser session via Playwright MCP, dev server / background process started for proof, temporary fixture file, locked resource, etc.) were closed at handoff. Use `RESOURCE-CLEANUP: complete` with brief enumeration of what was closed, or `RESOURCE-CLEANUP: not-applicable (no stateful resource opened)`. Leaving an MCP browser session, dev server, or other stateful tool open at handoff is a runtime hygiene defect (resource leak plus state contamination across subsequent work). `complete` requires explicit enumeration of every spawned long-running process (server PID plus port, daemon PID, dev-runner PID) actually killed AND a post-cleanup verification that ports/resources are released. Bare `complete` without enumeration plus post-cleanup probe is itself a `RESOURCE-CLEANUP` defect. `not-applicable` is valid ONLY when the lane truly invoked no stateful spawn. If the lane ran any launch script, dev server, test harness, or browser session, `not-applicable` is forbidden. Leaving a long-running server process bound to an operator-facing port is operator-environment contamination and converts into operator-surface launch failure on the next user-side execution attempt. Team-lead must reject completion-grade reports that claim `not-applicable` when verification or smoke-test work plainly required process spawning, and must reject `complete` without enumeration plus post-cleanup probe.

Lane docs may require bounded additions, but they must not weaken or replace this common result spine.
`REQUESTED-LIFECYCLE` does not itself clear lifecycle debt. Team-lead still owes explicit lifecycle control. A runtime owner may allow one narrow same-surface follow-on before that control is sent only when the prior completion already made a non-reuse requested lifecycle explicit, the next dispatch targets a distinct concrete agent, and the unresolved lifecycle debt stays visible.

When the lane claims user-surface proof or user-surface acceptance on an executed surface, the completion-grade report must also keep the exercised method explicit:
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`

Do not compress `real browser interaction`, `rendered/runtime reader proof`, or other decisive user-surface work into vague surface claims without naming the concrete proof method and execution evidence actually used.

## Common Lane Handoff Law
- Every agent handoff is an upward lane report, not a replacement for the frozen global plan.
- Report only lane-local execution truth: the surface actually examined or changed, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane recommendation.
- Verdict or `PASS` language remains scoped to the reported lane evidence; it does not become wider acceptance, route closure, or broader user-surface proof through handoff formatting.
- Handoff must expose quality-relevant open surfaces clearly enough that downstream work can continue without rediscovering them, but `RECOMMENDED-NEXT-LANE` must not be used to force all downstream decisions through one lane when independent owners remain available.
- `RECOMMENDED-NEXT-LANE` may narrow the plausible next owner, but it does not freeze routing. Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- If the truthful next step would change owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain, do not disguise that as ordinary completion; raise `scope-pressure` or `hold|blocker`.
- If any required procedure state for completion-grade reporting is not true yet, use `MESSAGE-CLASS: hold|blocker` instead of formatting the report as completion-ready.

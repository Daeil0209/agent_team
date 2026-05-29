# Work-Planning Parallel Fit
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Independent bounded work must be identified as parallel-fit when it can reduce risk, latency, or context pressure. For 2+ independent specialist-fit work surfaces, multi-agent staffing is the default unless a serial reason is explicitly stronger than the parallel benefit.

Additional-agent work freezes the team-agent runtime route basis, not a runtime execution move.

Use this discrimination:
- independent -> distinct acceptance contracts and output-to-input independence
- sequential -> one surface's output is the necessary input to the next surface
- interdependent -> coordination surface is shared enough that parallel edits would likely drift without a stronger frozen contract
- local single-surface -> one bounded surface, no material lane separation or parallelism loss

The Step 2 Q4 discrimination test is `distinct acceptance contracts AND output->input independence`, not `2+ surfaces` alone. Strict sequential output->input dependency keeps the `sequential` classification even when surfaces are distinct.

Independent specialist-fit work surfaces separate by one of these axes: evidence family, decision target, document section, production surface, source-of-truth, interface/format boundary, proof burden, or correction owner.
Prior-context reuse, agent setup burden, or coordination convenience alone is not a sufficient serial reason.
Operational burden is a team-runtime planning input, not a standalone-route basis; handle it by cap, shard merge, sub-batching, serial phasing, reuse, or `HOLD` without losing configured lane ownership or independent specialist separation.
Collapsing genuinely independent surfaces onto one agent is a bottleneck defect.

PROTECTED-LOCAL-RESTATEMENT-BASIS: planning-vs-runtime split — the binding-surface verification rule below is also enforced runtime-side at `.claude/skills/task-execution/references/dispatch-entry-contract.md` `## Field Rules` and `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Parallel And Reuse Law`. Planning-side declares the verification rule (freeze-time); runtime-side enforces it pre-`TeamCreate`/`Agent`/`SendMessage`. Both surfaces are required because verification happens at two distinct operational moments.

Parallel split law:
- Choose semantic boundaries first, then balance expected burden.
- File count alone is never a sufficient burden basis for document, governance, codebase, or mixed-size corpus work.
- A valid split names the burden basis: line/byte scale, high-touch or critical surfaces, reference density, proof/review complexity, and expected synthesis burden.
- A materially heavier remaining group that can be split without breaking owner, surface, proof, acceptance, or merge boundaries must be split.
- Keeping such a group intact is a distribution-planning defect.

Unknown material burden facts make measurement the next planned action, not a pre-planning exception. Dispatch-readiness is forbidden until measured basis exists.

`PARALLEL-GROUPS: none` on multi-surface team-routed work without explicit dependency or burden basis is a routing defect that must be reopened, not approved. Coordination burden must be explicitly named and demonstrated to exceed the parallel speedup before serializing a genuinely independent surface set.

- Actual additional-agent dispatch follows the active host runtime's authorization model.
- Parallel production requires a frozen binding surface before dispatch.
- The frozen binding surface freezes the shared source-of-truth, interface or format contract, dependency boundaries, ownership boundaries, merge owner, and acceptance/proof chain.
- A materialized binding surface (external file or shared retained carrier) is staged under the canonical path from `.claude/reference/environment-output-root-filesystem-law.md` (default `claude_doc/<work-name>/`).
- Before each parallel assignment-send segment, the lead verifies the carrier's on-disk presence and non-empty content matching the frozen basis through a read-class tool.
- A write-tool success response alone does not satisfy verification.
- First-verification observes absent-or-empty content while creation evidence exists waits a bounded propagation window of 2-5 seconds (single bounded retry; total wait ≤10 seconds before regeneration cycle).
- After the propagation window, the lead re-runs the read-class verification.
- Continued verification failure after the window triggers carrier regeneration from the frozen basis followed by another verification.
- Continued verification failure after one regeneration cycle opens `hold|blocker` with unresolved carrier-persistence basis and blocks dispatch.
- An unverified binding surface is a design defect and a parallel-drift root cause, not a downstream acceptance surprise.

`ACTIVE-CONCURRENT-AGENT-CAP` is the maximum concurrent team-scoped lane-agent count allowed for the active plan, excluding the team-lead host.
`work-planning` freezes `ACTIVE-CONCURRENT-AGENT-CAP` before `AGENT-MAP` or `PARALLEL-GROUPS` when additional-agent routing is possible.
Standing operator maximum is 2 concurrent team-scoped lane agents.
The cap basis records every applicable ceiling: standing operator maximum 2, explicit lower user maximum when present, current runtime/session configuration, host capability limit, and default basis.
The active value is the lowest applicable ceiling.
A user-stated maximum below 2 is a binding lower ceiling and must stay recorded even when a lower runtime or host ceiling controls the active value.
A user-stated maximum above 2 does not raise the standing operator maximum unless a later governance change explicitly replaces this line.
When no lower explicit user or runtime ceiling is available, the default host-safe ceiling is 2.
`work-planning` freezes `AGENT-MAP` and `PARALLEL-GROUPS` so the concurrent dispatched-lane count stays at or below `ACTIVE-CONCURRENT-AGENT-CAP`.
A plan that names more concurrent dispatched lane members than `ACTIVE-CONCURRENT-AGENT-CAP` is invalid.
Such a plan reopens `work-planning` for shard merging, sub-batching, or sequential phasing.
Concurrent dispatched-lane count includes live or standby members until shutdown or termination evidence removes them from the active roster.
New `Agent` member creation is blocked when concurrent dispatched-lane count is already at `ACTIVE-CONCURRENT-AGENT-CAP`.
Reuse-fit evaluation, release-before-create rules, and reuse-via-`SendMessage` dispatch sequencing under the cap are owned by `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

## Resolve Next Owner And Action
- Independent specialist-fit surfaces open team-routed parallel planning.
- Unknown material burden opens route-local measurement.
- Valid serial reason records `PARALLEL-GROUPS: none`.
- Invalid serial reason reopens `work-planning`.
- Material burden imbalance opens split refinement.
- Frozen parallel groups return to `AGENT-MAP` and `PARALLEL-GROUPS`.
- Missing parallel binding surface blocks dispatch readiness.
- Ready host-authorized additional-agent route opens `Skill(task-execution)` activation per the activation rule at `.claude/skills/task-execution/SKILL.md` `## Activation`; runtime creation, reuse, and member execution are consumed through loaded `task-execution` from `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

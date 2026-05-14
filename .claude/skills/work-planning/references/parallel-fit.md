# Work-Planning Parallel Fit
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Independent bounded work must be identified as parallel-fit when it can reduce risk, latency, or context pressure. For 2+ independent specialist-fit work surfaces, multi-agent staffing is the default unless a serial reason is explicitly stronger than the parallel benefit.

Additional-agent work freezes team-agent runtime.

Standalone `Agent` is not configured lane dispatch.

Use this discrimination:
- independent -> distinct acceptance contracts and output-to-input independence
- sequential -> one surface's output is the necessary input to the next surface
- interdependent -> coordination surface is shared enough that parallel edits would likely drift without a stronger frozen contract
- local single-surface -> one bounded surface, no material lane separation or parallelism loss

The Step 1 Q4 discrimination test is `distinct acceptance contracts AND output->input independence`, not `2+ surfaces` alone. Strict sequential output->input dependency keeps the `sequential` classification even when surfaces are distinct.

Independent specialist-fit work surfaces separate by evidence family, decision target, document section, production surface, source-of-truth, interface/format boundary, proof burden, or correction owner. Prior-context reuse, agent setup burden, or coordination convenience alone is not a sufficient serial reason. Collapsing genuinely independent surfaces onto one agent is a bottleneck defect.

Parallel split law: choose semantic boundaries first, then balance expected burden. File count alone is never a sufficient burden basis for document, governance, codebase, or mixed-size corpus work. A valid split names the burden basis: line/byte scale, high-touch or critical surfaces, reference density, proof/review complexity, and expected synthesis burden. If one group remains materially heavier and can be split without breaking owner, surface, proof, acceptance, or merge boundaries, keeping it intact is a distribution-planning defect.

Unknown material burden facts make measurement the next planned action, not a pre-planning exception. Dispatch-readiness is forbidden until measured basis exists.

`PARALLEL-GROUPS: none` on multi-surface team-routed work without explicit dependency or burden basis is a routing defect that must be reopened, not approved. Coordination burden must be explicitly named and demonstrated to exceed the parallel speedup before serializing a genuinely independent surface set.

Actual additional-agent dispatch still follows the active host runtime's authorization model. Parallel production requires a frozen binding surface before dispatch. At minimum, freeze the shared source-of-truth, interface or format contract, dependency boundaries, ownership boundaries, merge owner, and acceptance/proof chain needed to prevent parallel drift. When the binding surface materializes as an external file or shared retained carrier that every parallel target reads, the lead stages it under the canonical path defined by `.claude/reference/output-root-and-filesystem-law.md` (default `claude_doc/<work-name>/`). Before each parallel assignment-send segment, the lead verifies the carrier's on-disk presence and non-empty content matching the frozen basis. A write-tool success response alone does not satisfy this verification; the lead must observe the carrier on disk through a read-class tool. If the first verification observes absent or empty content while creation evidence (write-tool success, prior staging step, or pre-existing carrier handle) exists, the lead waits a bounded propagation window of a few seconds and re-runs the read-class verification to absorb sync-delay, write-behind cache, or transient unavailability. If verification still fails after the propagation window, the lead regenerates the carrier from the frozen basis and reruns the verification before dispatch. If verification still fails after one regeneration cycle, the lead opens `hold|blocker` with unresolved carrier-persistence basis and does not dispatch. An unverified binding surface is a design defect and a parallel-drift root cause, not a downstream acceptance surprise.

The active session carries at most 5 concurrent active team-scoped agents, summed across all teams in the runtime. Work-planning must freeze `AGENT-MAP` and `PARALLEL-GROUPS` so the active session's concurrent member count stays at or below 5. A plan that names more than 5 concurrent members is invalid and reopens `work-planning` for shard merging, sub-batching, or sequential phasing. New `Agent` member creation is blocked when concurrent active count is already 5; the lead releases members through lifecycle control or `session-closeout` before creating new ones.

## Resolve Next Owner And Action
- Independent specialist-fit surfaces open team-routed parallel planning.
- Unknown material burden opens route-local measurement.
- Valid serial reason records `PARALLEL-GROUPS: none`.
- Invalid serial reason reopens `work-planning`.
- Material burden imbalance opens split refinement.
- Frozen parallel groups return to `AGENT-MAP` and `PARALLEL-GROUPS`.
- Missing parallel binding surface blocks dispatch readiness.
- Host-authorized additional-agent route opens team-agent runtime readiness.

# Work-Planning Parallel Fit
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Independent bounded work must be identified as parallel-fit when it can reduce risk, latency, or context pressure. For 2+ independent implementation surfaces, multi-agent staffing is the default unless a serial reason is explicitly stronger than the parallel benefit.

Use this discrimination:
- independent -> distinct acceptance contracts and output-to-input independence
- sequential -> one surface's output is the necessary input to the next surface
- interdependent -> coordination surface is shared enough that parallel edits would likely drift without a stronger frozen contract
- local single-surface -> one bounded surface, no material lane separation or parallelism loss

The Step 1 Q4 discrimination test is `distinct acceptance contracts AND output->input independence`, not `2+ surfaces` alone. Strict sequential output->input dependency, such as DB schema -> backend -> frontend or researcher discovery -> designer -> implementer, keeps the `sequential` classification even when surfaces are distinct.

Examples of independent implementation surfaces include backend code vs frontend code, or multi-module systems with separate domain ownership. Prior-context reuse, agent setup cost, or coordination convenience alone is not a sufficient serial reason. Collapsing genuinely independent surfaces onto one agent is a bottleneck defect.

`PARALLEL-GROUPS: none` on multi-surface team-routed work without explicit cost basis is a routing defect that must be reopened, not approved. Coordination cost must be explicitly named and demonstrated to exceed the parallel speedup before serializing a genuinely independent surface set.

Actual additional-agent dispatch still follows the active host runtime's authorization model. Parallel implementation requires a frozen binding surface before dispatch. At minimum, freeze the API contract, shared data shapes, integration points, ownership boundaries, and acceptance/proof chain needed to prevent parallel drift. A vague binding surface is a design defect and a parallel-drift root cause, not a downstream acceptance surprise.

# Work-Planning Deliverable Defaults
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

`team-lead` derives type-fit through `work-planning` from `CONCRETE-DELIVERABLE` plus `PRIMARY-USER`.
Planning, design, implementation, and verification proceed from the user's information-delivery perspective.
The perspective covers what the user receives, experiences, uses, or decides from.
`DERIVED-DEFAULTS` names the receiver job, consumption path, and decisive proof surface for the deliverable class.
`team-lead` derives primary operator environment from request evidence.
Signals include Windows paths, launch files, and UI language; explicit user statement overrides.
Full derivation rule: `.claude/skills/dev-workflow/references/operator-delivery.md` R23.

`team-lead` derives obvious type-fit duties from deliverable class and primary user.
Examples include "this is a program, test every button" or "this is a report, include tables and figures".
The default done condition is a normal final artifact for that deliverable class.
Normal-final means complete requested substance, usable format, truthful user-surface proof, and no hidden operator/reader burden.
Partial draft, implemented subset, placeholder surface, or developer-only run path reaches done only when the original frozen request, plan, or design explicitly says so.

## User-Ready Delivery Chain
Every consequential deliverable or active slice follows a named user-ready delivery chain.
The chain starts from the user's instruction.
The chain expands through concept fit, detailed structure, implementation or production surfaces, and verification evidence.
The chain converges into the final user-consumed surface or an explicit deferred receiver surface.
Each stage carries forward the information needed by the next stage.
The carried information covers why the deliverable exists, what is in scope, which internal parts connect, what data/example/method makes it usable, what proves it, and what remains open.
Implementation is the widest work stage.
Implementation adds necessary internal detail or parallel branches only when each branch traces back to request intent and forward to proof or user use.
Verification and completion converge the widened work back to the named usable receiver path.
Disconnected information, hidden assumptions, orphaned components, implausible user flow, or feature behavior without a coherent receiver scenario remains an `OPEN-SURFACES` item.
Such items can also reopen the owning design, implementation, proof, or acceptance path.

Use these defaults when the deliverable class is in scope:
- usable program -> operator-exhaustive proof of every frozen `SCOPE-BASELINE` feature/surface/control and workflow path, every `CORE-WORKFLOW-CLOSURE` row closed end-to-end on the user surface (create/import/upsert→disposition, edit→save+reload+consumer-persist, input/mutation→dependent-recompute/reactivity, displayed-surface→inspection/action/navigation, entity/aggregate→authority trace), UI/browser tool plan when applicable, plus launch and termination burden in the primary operator environment
- research or analysis report -> all requested questions/sections answered, reader-comprehension structure, decision-surface placement, source-data/example/application method when material, tables/figures when material, and uncertainty visibility
- reference or source/read document -> direct readability of the changed source/read surface, cross-reference integrity, navigability, and update-safe structure
- API or library -> contract completeness and integration proof against a real or representative consumer
- slides -> layout, legibility, visual hierarchy, and narrative flow
- data export -> bit-fidelity, schema fidelity, example row/use note when material, or conversion correctness matched to the user-visible use
- doctrine or governance patch -> reliable trigger, owner, stop condition, WHY anchor, evidence burden, verification gate, cumulative coherence, and source/read clarity; hook/settings contract claims also need direct bounded proof of the changed hook/settings surface, such as settings parsing, matcher coverage, or direct hook invocation; native dispatcher/UI E2E or other operator-runtime E2E is required only when the frozen claim includes client invocation, enforcement, UI, launch, or operator-flow behavior

`work-planning` Step 0 must classify deliverable type and user-information-delivery shape, then bake them into `DERIVED-DEFAULTS`. Failing to derive type-fit from the user-perspective lens is a planning defect.

If type-fit decisions involve visual, structural, or interaction modality, freeze a benchmark or authoritative external-reference path unless current evidence already proves the relevant best-practice basis. Silent benchmark skip on a materially visual or structural deliverable is a planning-evidence defect.

Type-specific procedure detail remains with the triggering owner surface:
- Operator on-ramp, termination, demonstration-data coverage, mental-model alignment, and ambiguous-primary-user OS coverage -> `.claude/skills/dev-workflow/references/operator-delivery.md`; load it directly for user-runnable executables even when `dev-workflow` is not active.
- User-environment E2E verification, no-operator-labor verification, and exact launch-mechanism path -> `validator` with tester and `external-tool-bridge` support.
- Dashboard, monitoring, at-a-glance UI design, operator-decision-frame analysis, cross-domain integration, data-freshness invalidation, and visual/spec checklist discipline -> `visual-composition` plus downstream proof/acceptance lanes.

Skipping the relevant procedure owner when its trigger fires is a planning-design-verification defect.

## Resolve Next Owner And Action
- Derived type-fit defaults return to `DERIVED-DEFAULTS`.
- User-ready delivery chain returns to `REQUEST-BOUND-PACKET-FIELDS`.
- Usable-program defaults open `SCOPE-BASELINE` and `CORE-WORKFLOW-CLOSURE` coverage basis.
- Operator-environment defaults open `operator-delivery` or validator runtime-path basis.
- Visual, structural, or interaction defaults open benchmark or authoritative-reference basis.
- Triggered type-specific procedure opens the named owner surface.
- Missing type-fit derivation reopens `work-planning`.

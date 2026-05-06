# Work-Planning Deliverable Defaults
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Planner derives type-fit from `CONCRETE-DELIVERABLE` plus `PRIMARY-USER`. Plan, design, implement, and verify from the user's information-delivery perspective on what the deliverable is for them: what they receive, experience, use, or decide from.
`DERIVED-DEFAULTS` names the receiver job, consumption path, and decisive proof surface for the deliverable class.
Planner also derives primary operator environment from request evidence.
Windows paths, Windows launch files, Windows UI language, or user-side Windows context make Windows the primary operator environment unless contrary evidence exists.

The user does not need to ask separately for obvious type-fit duties such as "this is a program, test every button" or "this is a report, include tables and figures". Derivation from deliverable class and primary user is the planner's responsibility.
The default done condition is a normal final artifact for that deliverable class: complete requested substance, usable format, truthful user-surface proof, and no hidden operator/reader burden. A partial draft, implemented subset, placeholder surface, or developer-only run path is not done unless upstream scope explicitly says so.

## User-Ready Delivery Chain
Every consequential deliverable or active slice follows a named user-ready delivery chain.
The chain starts from the user's instruction, expands through concept fit, detailed structure, implementation or production surfaces, and verification evidence, then converges into the final user-consumed surface or explicit deferred receiver surface.
Each stage must carry forward the information needed by the next stage: why the deliverable exists, what is in scope, which internal parts connect, how the receiver uses it, what proves it, and what remains open.
Implementation is the widest work stage; it may add necessary internal detail or parallel branches, but each branch must trace back to request intent and forward to proof or user use.
Verification and completion converge the widened work back to the named usable receiver path.
Disconnected information, hidden assumptions, orphaned components, implausible user flow, or feature behavior without a coherent receiver scenario remains an `OPEN-SURFACES` item or reopens the owning design, implementation, proof, or acceptance path.

Use these defaults when the deliverable class is in scope:
- usable program -> operator-exhaustive proof of every frozen `SCOPE-BASELINE` feature/surface/control and workflow path, plus launch and termination burden in the primary operator environment
- research or analysis report -> all requested questions/sections answered, reader-comprehension structure, decision-surface placement, tables/figures when material, and uncertainty visibility
- reference or source/read document -> direct readability of the changed source/read surface, cross-reference integrity, navigability, and update-safe structure
- API or library -> contract completeness and integration proof against a real or representative consumer
- slides -> layout, legibility, visual hierarchy, and narrative flow
- data export -> bit-fidelity, schema fidelity, or conversion correctness as appropriate to the user-visible use
- doctrine or governance patch -> reliable trigger, owner, stop condition, WHY anchor, evidence burden, verification gate, cumulative coherence, and source/read clarity; hook/settings contract claims also need direct bounded proof of the changed hook/settings surface, such as settings parsing, matcher coverage, or direct hook invocation; native Claude Code dispatcher/UI E2E or other operator-runtime E2E is required only when the frozen claim includes Claude Code client invocation, enforcement, UI, launch, or operator-flow behavior

`work-planning` Step 0 must classify deliverable type and user-information-delivery shape, then bake them into `DERIVED-DEFAULTS`. Failing to derive type-fit from the user-perspective lens is a planning defect.

If type-fit decisions involve visual, structural, or interaction modality, freeze a benchmark or authoritative external-reference path unless current evidence already proves the relevant best-practice basis. Silent benchmark skip on a materially visual or structural deliverable is a planning-evidence defect.

Type-specific procedure detail remains with the triggering owner surface:
- Operator on-ramp, termination, demonstration-data coverage, mental-model alignment, and ambiguous-primary-user OS coverage -> `.claude/skills/dev-workflow/references/operator-delivery.md`; load it directly for user-runnable executables even when `dev-workflow` is not active.
- User-environment E2E verification, no-operator-labor verification, and exact launch-mechanism path -> `validator` with tester and `external-tool-bridge` support.
- Dashboard, monitoring, at-a-glance UI design, operator-decision-frame analysis, cross-domain integration, data-freshness invalidation, and visual/spec checklist discipline -> `visual-composition` plus downstream proof/acceptance lanes.

Skipping the relevant procedure owner when its trigger fires is a planning-design-verification defect.

# work-planning: Planning Targets
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file when the plan is large, mixed, ambiguous, or at risk of becoming one generic all-purpose planning pass.

## Target Definitions
- `request-fit-plan`: freezes intent, deliverable, user, reference use, burden cues, material blockers, and packet-carry fields.
- `route-plan`: freezes owner path, workflow/sequence, channel, lead-local vs team-routed shape, and first next owner.
- `lead-local-plan`: freezes one low-risk local item, required local skills, stop point, and evidence limit.
- `team-dispatch-readiness-plan`: freezes agent map, parallel groups, lane skill map, skill recommendations, packet readiness, teammate context isolation, lifecycle/proof/acceptance readiness, and dispatch blockers.
- `workflow-sequence-plan`: freezes the active workflow or primary sequence owner before dispatch or execution.
- `blocker-clear-plan`: freezes one same-route blocker-clear move that does not change owner, phase, surface, deliverable, proof/acceptance chain, staffing shape, or next action.
- `delegated-lane-plan`: verifies a receiving lane's assignment packet, owned work surface, current phase, required skills, first lane action, and stop condition.

## Target Selection Rules
- Choose one primary target before Q1-Q5. Add a secondary target only when it belongs to the same owner, surface, deliverable, proof/acceptance chain, and next action.
- `request-fit-plan` is mandatory when the interpreted request is thin, corrected, reference-driven, burden-sensitive, or dependent on user-surface proof or original wording.
- `route-plan` is mandatory for every consequential top-level `team-lead` plan.
- `lead-local-plan` is valid only for one named low-risk item with no configured lane substitution, no lost independent parallel surface, no independent review/proof/validation separation, and no stronger-than-local evidence claim.
- `team-dispatch-readiness-plan` is mandatory when routing is team-routed, ambiguous, parallel-fit, host-authorized additional-agent capable, or may enter `task-execution`.
- `workflow-sequence-plan` is mandatory when a workflow or primary sequence owns the next path.
- `blocker-clear-plan` is valid only when the clearing move preserves owner, phase, surface, deliverable, proof/acceptance chain, staffing shape, and next action.
- `delegated-lane-plan` is for lane-local assignment planning; it never owns top-level route selection.

## Target-Specific Required Basis
- `request-fit-plan`: `REQUEST-FIT-BASIS`, `REQUEST-BOUND-PACKET-FIELDS`, and material request wording or cited artifact anchors.
- `route-plan`: `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`, `ACTION-CLASS`, `ROUTING-SIGNAL`, and `NEXT-CONSEQUENTIAL-ACTION`.
- `lead-local-plan`: `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`, evidence limit, stop condition, and proof/acceptance non-substitution basis.
- `team-dispatch-readiness-plan`: `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`, and `DISPATCH-BLOCKERS`.
- `workflow-sequence-plan`: selected owner, reason it opens before deeper execution, and what it must hand to `SV-PLAN`.
- `blocker-clear-plan`: exact blocker, exact clearing move, same-route proof, and boundary that triggers replanning.
- `delegated-lane-plan`: assignment packet, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, stop condition, and `scope-pressure`/`hold|blocker` threshold.

## Target Switching
- Switching from one target to another is allowed only before the freeze or after reopening `work-planning`.
- A secondary target may be included only when it belongs to the same owner, surface, deliverable, proof/acceptance chain, and next action.
- If target switching changes route owner, lane owner, proof surface, acceptance owner, work surface, or dispatch shape, reopen the planning pass instead of extending it by habit.
- Do not use `team-dispatch-readiness-plan` to invent a route. Route must already be frozen by `route-plan` or workflow/sequence owner.
- Do not use `lead-local-plan` to bypass a configured lane, independent review/proof/validation separation, or user-surface proof need.

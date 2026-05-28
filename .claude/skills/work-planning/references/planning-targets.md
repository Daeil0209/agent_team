# work-planning: Planning Targets
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use this file when the plan is large, mixed, ambiguous, or at risk of becoming one generic all-purpose planning pass.

## Target Definitions
- `request-fit-plan`: freezes intent, deliverable, user, reference use, burden cues, material blockers, and packet-carry fields.
- `route-plan`: freezes owner path, workflow/sequence, channel, lead-local vs team-routed shape, and first next owner/action.
- `lead-local-plan`: freezes one local item with no final-arbitration trigger (validator `PASS/HOLD/FAIL` need or independent review/proof/validation separation per `.claude/reference/judgment-core-law.md`), required local skills, stop point, and evidence limit.
- `team-dispatch-readiness-plan`: freezes active concurrent-agent cap, agent map, parallel groups, lane skill map, skill recommendations, packet readiness, teammate context isolation, cleanup/proof/acceptance readiness, and dispatch blockers for the dispatch phase of the team-lead work plan.
- `workflow-sequence-plan`: freezes the active workflow or primary sequence owner before dispatch or execution.
- `blocker-clear-plan`: freezes one same-route blocker-clear move that preserves every `work-planning` boundary-change axis and next action.
- `delegated-lane-plan`: verifies a receiving lane's assignment packet, owned work surface, current phase, required skills, first lane action, and stop condition without transferring planning ownership.

## Target Selection Rules
- Choose one primary target before Q1-Q5. Add each mandatory secondary target only when it belongs to the same owner, surface, deliverable, proof/acceptance chain, and next action.
- On consequential top-level plans, `route-plan` is the default primary target.
- The matching alternative target replaces primary only when the route is delegated, lane-local, or blocker-clear.
- In those cases, `lead-local-plan`, `delegated-lane-plan`, `blocker-clear-plan`, or `workflow-sequence-plan` becomes primary.
- Lower-level lane plans use the matching target as primary.
- `request-fit-plan` is mandatory (as primary or secondary) when the interpreted request is thin, corrected, reference-based, burden-sensitive, or dependent on user-surface proof or original wording.
- `lead-local-plan` is valid only for one named item with no final-arbitration trigger, no configured lane substitution, no lost independent parallel surface, no independent review/proof/validation separation, and no stronger-than-local evidence claim.
- `team-dispatch-readiness-plan` is mandatory (as primary or secondary) when routing is team-routed, ambiguous, parallel-fit, host-authorized additional-agent capable, or eligible to enter `task-execution`; it carries the dispatch phase inside the team-lead work plan and termination plan.
- If dispatch readiness needs unavailable corpus, line/byte, or reference-density facts, freeze route-local measurement first; final `AGENT-MAP`/`PARALLEL-GROUPS` waits for measured basis.
- `workflow-sequence-plan` is mandatory when a workflow or primary sequence owns the next path.
- `blocker-clear-plan` is valid only when the clearing move preserves every `work-planning` boundary-change axis and next action.
- `delegated-lane-plan` freezes lane-local assignment boundary only; planning ownership stays with `team-lead` through `work-planning`.

## Target-Specific Required Basis
- `request-fit-plan`: `REQUEST-FIT-BASIS`, `REQUEST-BOUND-PACKET-FIELDS`, and material request wording or cited artifact anchors.
- `route-plan`: `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`, `ACTION-CLASS`, `ROUTING-SIGNAL`, and `NEXT-CONSEQUENTIAL-ACTION`.
- `lead-local-plan`: `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`, evidence limit, stop condition, and proof/acceptance non-substitution basis.
- `team-dispatch-readiness-plan`: `ACTIVE-CONCURRENT-AGENT-CAP`, `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`, and `DISPATCH-BLOCKERS`.
- `workflow-sequence-plan`: selected owner, reason it opens before deeper execution, and what it must hand to the next owner/action.
- `blocker-clear-plan`: exact blocker, exact clearing move, same-route proof, and boundary that triggers replanning.
- `delegated-lane-plan`: assignment packet, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, stop condition, and `scope-pressure`/`hold|blocker` threshold.

## Target Switching
- Switching from one target to another is allowed only before the freeze or after reopening `work-planning`.
- Each secondary target is included only when it belongs to the same owner, surface, deliverable, proof/acceptance chain, and next action.
- If target switching changes route owner, lane owner, proof surface, acceptance owner, work surface, or dispatch shape, reopen the planning pass instead of extending it by habit.
- Do not use `team-dispatch-readiness-plan` to invent a route. Route must already be frozen by `route-plan` or workflow/sequence owner.
- Do not use `lead-local-plan` to bypass a configured lane, independent review/proof/validation separation, or user-surface proof need.

## Resolve Next Owner And Action
- Selected primary target opens the Q1-Q5 planning pass.
- Valid secondary targets join the same planning pass.
- Target switching after freeze reopens `work-planning`.
- `team-dispatch-readiness-plan` returns dispatch readiness fields to the planning record.
- `workflow-sequence-plan` opens the selected workflow or sequence owner before deeper execution.
- `blocker-clear-plan` opens the exact blocker-clear move.
- Invalid target use reopens `work-planning`.

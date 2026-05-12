---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Request-Bound Conditional Packet Fields
## Contents
- Common Start Closure Contract
- Resolve Next Owner And Action

## Common Start Closure Contract
These conditional fields are the common start closure contract for assignment-grade work.
Upstream planning or workflow owners freeze the material axes; `task-execution` translates them into agent-facing packet fields.
A packet is start-ready when every material axis needed for the receiving lane to close its assigned surface is explicit, marked `not-applicable:<basis>` where this reference allows omission, or routed through `packet-correction` / `route-replan` before dispatch.

The contract axes are:
- original request intent, required deliverable, audience, and excluded scope
- semantic intent bridge across user concern, anti-goal, team-operation philosophy, target design intent, and material priority order
- target intent and protected user outcome
- scope baseline, active slice, and deferred surfaces
- exact user wording when wording controls acceptance
- user-ready delivery-chain trace from instruction to concept/detail, implementation or production surface, verification evidence, and final receiver path
- methodology, tier, and lane phase context when already frozen
- user surface, proof path, tool/setup/discovery boundary, run path, and burden contract
- decision, validation, environment, scenario, and operator-platform proof context
- cited authoritative references, deviation-from-reference basis, Receiver-Surface Contract, Consumption Chain, Boundary Register, and Evidence-Quality Matrix identities when material

Receiving lanes use this contract to classify receipt as `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker`.
They preserve global routing and acceptance ownership from packet basis instead of memory.

When truthful lane execution depends on the original request shape, the assignment packet must also carry:
- `REQUEST-INTENT`
- `CORE-QUESTION`
- `SEMANTIC-INTENT-BASIS`
- `REQUIRED-DELIVERABLE`
- `PRIMARY-AUDIENCE`
- `EXCLUDED-SCOPE`

`SEMANTIC-INTENT-BASIS` bridges `REQUEST-INTENT` and `TARGET-INTENT-BASIS`.
It names the user concern signal, anti-goal, governing team-operation philosophy or target governance/design intent, and material priority order.
Do not replace it with literal task wording or target purpose alone.
If the carried semantic basis conflicts with the user instruction, cited artifact intent, or governing design philosophy, the receiving lane returns `scope-pressure` or `hold|blocker`.

When truthful lane execution depends on why the target artifact exists or what it must preserve, the assignment packet must also carry:
- `TARGET-INTENT-BASIS`

`TARGET-INTENT-BASIS` names the target artifact's purpose and protected outcome.
Governance analysis uses governance design intent.
Program work uses program intent and user-workflow intent.
Report and document work use reader, question, conclusion, evidence, and action intent.
Review, proof, validation, and completion work use the target intent that defines fit and closure.
If this basis is safely inferable from the request, plan, design, Structural Contract, cited artifact, or frozen scope without inventing scope, closure rows, disposition paths, consumer/recompute paths, source authority, display-only basis, or acceptance oracle, mark it as `INFERENCE` and proceed.
If the basis is not safely inferable, use `scope-pressure` or `hold|blocker`.
`TARGET-INTENT-BASIS` states protected purpose and user outcome.
Per-finding protected function, user-outcome impact, `patch-worthiness`, and regression risk belong to `.claude/skills/task-execution/references/completion-handoff.md`.

When a frozen plan, MVP, release, or phase scope contains one or more promised features, workflows, surfaces, controls, data expectations, artifacts, or reader/operator outcomes, completion-critical lane packets must also carry:
- `SCOPE-BASELINE`
- `ACTIVE-SLICE`
- `DEFERRED-SURFACES`

`SCOPE-BASELINE` is the authoritative in-scope list at proofable row granularity.
Each baseline row names a feature, workflow, surface, control, data, artifact, or reader/operator expectation that can be mapped to evidence.
Module, epic, or screen labels are parent headings only.
`ACTIVE-SLICE` is the subset assigned in the current packet.
`DEFERRED-SURFACES` is valid only when original frozen request/plan/design explicitly deferred or excluded those row-granular items.
An unimplemented baseline item remains open, not out-of-scope by dispatch.

When exact instruction wording materially affects acceptance, decision-fit, or request-fit review, the packet must additionally carry:
- `USER-INSTRUCTION-VERBATIM`
- `USER-INSTRUCTION-AMENDMENTS`

When planning or the active workflow already froze methodology guidance for the lane, the packet must also carry:
- `SKILL-RECOMMENDATIONS`

`SKILL-RECOMMENDATIONS` is mandatory when frozen by `work-planning` or the active workflow owner, and advisory only inside the already bounded lane surface.
It never creates lane ownership, authorizes lane-core skill listing, or changes proof/acceptance ownership.
If missing from the frozen planning/workflow basis, do not invent it during dispatch.

Do not leave these request-fit or methodology fields only in linked-path references when the receiving lane must use them to plan, verify, or judge the assigned surface truthfully.
When upstream planning froze reference-based citation or deviation basis, carry it as cited request-bound or artifact basis, not as a standalone `REFERENCE-USE` packet field.

When frozen governance depth materially changes staffing, checkpoint, review, proof, or acceptance burden for the receiving lane, the assignment packet must also carry:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

`PROJECT-TIER` is the floor.
`ACTIVE-REQUEST-TIER` can stay at that floor or raise above it for the current request.
The packet must not silently rewrite the project floor.
Tier can avoid unnecessary over-governance.
Tier must never downshift decisive user-surface proof or acceptance integrity.

When proof or acceptance depends on the real user-facing surface rather than source-state alone, the packet must also make that surface explicit:
- `USER-SURFACE`
- `USER-SURFACE-PROOF-PATH`
- `TOOL-REQUIREMENT` when one exact truthful tool is already frozen
- `SURFACE-EQUIVALENCE-BASIS` when the frozen proof path is not the obvious native/default tool for that surface

`USER-SURFACE` names what the user actually experiences: browser interaction, source-read governance/report/documentation text, rendered page-read document, office document, spreadsheet runtime, PDF reader surface, HWP/HWPX reader/editor surface, operator console, or another concrete user-consumed surface.
Do not force tester or validator to rediscover that surface from gist.
When frozen upstream, Receiver-Surface Contract, Consumption Chain, Boundary Register, and Evidence-Quality Matrix travel as cited packet basis.
Packet writers preserve citation identity for those artifacts.

`TOOL-REQUIREMENT` is not a convenience preference field. Keep assignments method-neutral by default and freeze an exact tool only when the user explicitly requires it, the active workflow already froze it for bounded burden/risk reasons, or no equivalent truthful path exists.
If the exact tool is not yet frozen, the packet can instead freeze a bounded discovery/setup objective:
- `TOOL-DISCOVERY-GOAL`
- `TOOL-DISCOVERY-BOUNDARY`
- `TOOL-VERIFICATION-STANDARD`
- `TOOL-CLEANUP-EXPECTATION`

Keep assignment autonomy without vague or unbounded tool hunting.
When that boundary includes environment/tool setup, carry the setup safety classification from `work-planning`: `allowed-setup`, `approval-required`, `defer-capable`, or `blocked`. `allowed-setup` is not a user confirmation gate; `approval-required` must name the damage-capable/destructive/security/credential/paid/persistent-service/policy reason.
For browser-ui proof or acceptance, an exact `TOOL-REQUIREMENT` and the full bounded discovery/setup bundle are alternatives at dispatch time. Do not force both unless the workflow truly needs both.

When the frozen proof or acceptance path covers multiple environments, platforms, browsers, or deployment contexts, or when a single-environment proof is claimed cross-environment sufficient, the packet must also carry:
- `ENV-COVERAGE`: the bounded list of environments, platforms, browsers, or deployment contexts in scope for this proof or acceptance pass
- `EQUIVALENCE-DECLARATION`: explicit basis for treating the tested environment(s) as equivalent to non-tested environments when cross-environment sufficiency is claimed
- `PER-ENV-PASS-POLICY`: the per-environment pass criteria — whether each named environment must independently pass, or a representative subset is accepted with stated rationale

`ENV-COVERAGE` is required when 2+ environments are in scope or when single-environment proof is claimed cross-environment sufficient. `EQUIVALENCE-DECLARATION` is required when environments are declared equivalent without independent per-environment proof. `PER-ENV-PASS-POLICY` is required when validator final acceptance must reconcile cross-environment deltas.

When the current request/environment evidence points to Windows as the operator environment, tester and validator packets for executable deliverables must carry:
- `PRIMARY-OPERATOR-OS: Windows`
- `WINDOWS-LAUNCH-SURFACE`
- `WINDOWS-EQUIVALENCE-BASIS` only when proof runs outside Windows but claims Windows sufficiency

WSL/Linux execution does not satisfy Windows launch proof by itself.

`USER-RUN-PATH` and `BURDEN-CONTRACT` are delivery-contract fields scoped by deliverable surface class:
- **MANDATORY** when target lane is `tester` or `validator` AND the deliverable surface is **executable user-facing** (operator runs the program / launches a server / interacts with a browser-rendered UI / opens a runnable artifact). Launch path defines proof; operator burden defines acceptance. Omission is a packet defect that `task-execution`, tester, and validator must not absorb by guesswork.
- **CONDITIONAL (use `not-applicable` if omitted)** when the deliverable surface is a non-runnable rendered static artifact and run-path burden plus operator workflow burden are outside the frozen acceptance surface.
- **NOT a permission-graded field**. Executable user-facing surfaces cannot skip these fields; the delivery contract treats them as schema floor.

Tester/validator completion status fields such as `PROOF-SURFACE-MATCH`, `RUN-PATH-STATUS`, `CORE-WORKFLOW-STATUS`, `INTERACTION-COVERAGE-STATUS`, and `BURDEN-STATUS` stay explicit; use `not-applicable` instead of omission when a status axis was not part of the frozen surface.

`DECISION-SURFACE` is a conditional final-arbitration field.
Keep it explicit when the decisive acceptance surface materially differs from the validator execution surface.
Keep it explicit when the verdict must reconcile more than one candidate acceptance surface.
When `VALIDATION-SURFACE` already names the single decisive user-facing acceptance surface for the bounded acceptance path, `DECISION-SURFACE` can inherit from `VALIDATION-SURFACE`.

`ENV-BASIS` and `SCENARIO-SCOPE` are tester-proof context fields with conditional default but executable-proof-floor enforcement. The narrow `not-applicable (...)` carve-out for genuinely static-render single-surface proof remains valid; default for any executable surface is mandatory.

When the assigned surface is office-format, page-read, or other rendered human-facing material where reader-visible usefulness is part of acceptance, keep the rendered chain explicit instead of implying it:
- `developer/document-automation -> tester -> reviewer -> validator` when risk is meaningful
- rendered evidence supports human-visible usefulness only; it does not replace wording, logic, request-fit, proof, or verdict ownership
- if the current toolchain cannot truthfully exercise the decisive user surface, freeze one bounded next step only: explicit tool discovery/acquisition/setup via `external-tool-bridge` or the appropriate setup owner, or `hold|blocker`. Do not quietly downgrade to source-only checking.

## Resolve Next Owner And Action
- Complete start closure contract opens assignment packet preflight.
- Missing packet field with same-boundary source basis opens `packet-correction`.
- Missing packet field that changes owner, phase, staffing, proof, acceptance, or deliverable shape opens `route-replan`.
- Missing decisive user surface opens packet correction or validation/proof route correction.
- Missing executable run path or burden contract opens packet correction before tester or validator dispatch.
- Missing truthful tool path opens bounded tool discovery, `external-tool-bridge`, or `hold|blocker`.
- Rendered human-facing usefulness opens the rendered delivery chain named in this reference.

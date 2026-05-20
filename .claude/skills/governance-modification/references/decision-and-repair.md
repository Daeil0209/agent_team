# governance-modification: Decision And Repair Detail
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/governance-modification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
auto-inject: false

Use this reference for recurrence-hardening trigger interpretation, causal analysis, owner-surface choice, failure-mode response, patch classification, high-traffic surface protection, and constraint checks.

## Recurrence Hardening Trigger Matrix
| Trigger Type | Default Interpretation | Required Action |
|---|---|---|
| justified user correction | authoritative classification signal | open classification immediately; stabilize active request; harden recurrence path only when behavioral/procedural defect basis and recurrence path are confirmed |
| self-detected behavioral defect | real defect unless disproven by stronger evidence | open `Skill(governance-modification)` recurrence-hardening immediately; do not wait for user confirmation |
| repeated missed-catch / recurrence | capability or boundary weakness | escalate beyond local patch into checklist, routing, hook, or authority hardening |
| blocked execution due to missing reusable skill | capability gap | use Capability-Gap Fast Path with explicit owner and verification |

First occurrence does not mean "ignore until repeated."
First occurrence opens classification immediately.
Repetition raises hardening depth.
Durable hardening still requires confirmed defect basis and recurrence path.

## Causal Analysis
Use when the visible failure is known but the actual prevention point is not yet obvious.
Do not patch from symptom alone.

Required reconstruction:
1. Name the intended governing surface: doctrine, team-lead role, lane role, agent-specific skill, workflow skill, session skill, packet/reference file, hook, settings, or runtime state.
2. Name the actual execution point where the duty failed to surface, bind, stop, or route behavior.
3. Name the evidence that proves the failure mode instead of relying on memory, preference, or hindsight.
4. Classify the primary failure mode using the matrix below.
5. Name the recurrence path in operational terms: what future trigger, packet, handoff, verification step, hook signal, or owner transition would repeat the miss.
6. Name the smallest barrier that blocks that recurrence path without creating a parallel operating model.

If the causal basis remains only a hypothesis, the patch must stay reversible, narrowly scoped, and explicitly marked as hypothesis-supported.
If the causal basis cannot identify a prevention point, keep the round on `HOLD` or assign bounded follow-up ownership.

## Failure Mode Response Matrix
| Failure Mode | Default Meaning | Required Response | Owner Boundary |
|---|---|---|---|
| `missing-owner` | No current owner surface governs the recurring behavior. | Assign one owner surface, then add the narrowest rule, skill gate, packet field, or Hook-Last-approved runtime edge needed to close the gap. | Keep ownership on the assigned owner surface. |
| `weak-owner` | The right owner exists, but its wording, gate, checklist, or packet is too weak to prevent recurrence. | Tighten or replace the owning block; add a checklist or packet requirement only when wording alone will not surface the duty. | Keep the correction on the existing owner block. |
| `wrong-owner` | The behavior is governed from the wrong document, lane, or runtime surface. | Re-home the meaning to the correct owner and leave an owner-reference only when local readability requires it. | Preserve unique meaning through source-to-destination trace. |
| `mapping-gap` | A rule exists at one governance layer, but its mapped execution detail or triggered consuming guidance is missing. | Add, re-home, or tighten the missing mapped detail at the narrowest owner; record `not-material:<basis>` when a lower layer is not needed. | Preserve the top-doctrine -> core-law -> trigger-bound reference chain without adding unused links. |
| `specification-mismatch` | A governance rule is too broad, too narrow, evasive, ambiguous, conflicting, bottleneck-forming, or too detailed without execution effect. | Add missing executable information, make the valid action explicit, or remove non-executed burden through the narrowest preserving edit. | Keep only the minimum executable information on the executing owner surface. |
| `non-compliance` | The rule already exists; the failure came from not following it. | Harden adherence through trigger visibility, checklist discipline, packet requirements, self-verification gates, or Hook-Last-approved runtime edge. | Address why the existing rule was missed. |
| `weak-enforcement` | Doctrine exists, but runtime or packet surfaces lack reliable obligation exposure. | Add or refine packet fields or owner instructions first; add or refine hook logic only as a Hook-Last-approved runtime edge. | Semantic judgment becomes a hard block only after fields or low-friction evidence exist. |
| `capability-gap` | No reusable skill, reference, or lane procedure can handle the recurring work credibly. | Use Capability-Gap Fast Path; update an existing owner when sufficient, create a new skill only after the category gate. | Reserve new skills for reusable capability gaps. |

Use this matrix before drafting.
A patch can involve more than one failure mode, but one primary mode must govern the edit operation and owner choice.

## Governance Architecture Map
Use this map to choose the owner surface before drafting.
Do not place a rule where it is merely convenient.

| Governance need | Primary owner surface |
|---|---|
| Shared philosophy, priority, top-level ownership, preservation law | `.claude/CLAUDE.md` |
| Team-lead trigger, route, orchestration, synthesis, reporting, interruption, governance modification adjudication | `.claude/agents/team-lead.md` |
| Detailed team-lead edge cases that would bloat the role spine | Direct references named by `.claude/agents/team-lead.md` |
| Lane charter, always-loaded receipt trigger, stop rule, and lane-owned completion duty | `.claude/agents/<lane>.md` |
| Lane execution procedure, lane-local gates, and direct pointer to detail references | `.claude/skills/agent-<lane>/SKILL.md` |
| Lane packet additions, specialist matrices, tool/proof detail, and handoff field detail | `.claude/skills/agent-<lane>/references/*.md` |
| Packet schema, message classes, cleanup truth, dispatch preflight, completion spine | `.claude/skills/task-execution/references/assignment-packet.md`, `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/truth-rules.md`, and `.claude/skills/task-execution/references/completion-handoff.md` |
| Consequential planning freeze and route basis | `.claude/skills/work-planning/SKILL.md` |
| Plan/result verification gates | `.claude/skills/self-verification/SKILL.md` |
| Session boot, runtime entry, monitoring, lifecycle interpretation | `.claude/skills/session-boot/SKILL.md` and `.claude/skills/session-boot/references/runtime-state-detail.md` |
| Closeout teardown and residual truth | `.claude/skills/session-closeout/SKILL.md` and `.claude/skills/session-closeout/references/closeout-state-detail.md` |
| Repeatable workflow or specialist methodology | owning `.claude/skills/<skill>/SKILL.md`; long lookup detail in that skill's direct `references/*.md` files when present |
| External review or MCP capability wiring | project-root `.mcp.json`, `.claude/settings.json`, role tool authorization, and the owning skill/reference that defines trigger, authority, fail-open, and recovery boundary |
| Technical enforcement, owner-rule guards, deterministic runtime checks | `.claude/hooks/` or `.claude/settings*.json` |
| Official-source cache or preservation traceability | `.claude/reference/` |

Reference files are lookup surfaces, not hidden always-on doctrine.
A `SKILL.md` spine keeps activation trigger, owner, stop rule, and direct reference loading.

## Patch Classification
- `hardening patch`: strengthens an existing owner with clearer doctrine, boundary, gate, or evidence rules
- `structural normalization patch`: aligns runtime prose, owner documents, and configuration ownership into one coherent target design
- `migration or re-home patch`: preserves meaning while moving it from a legacy or temporary location into the correct current owner
- `config-owner standardization patch`: keeps one literal owner for a configurable value and converts all other surfaces into references
- `skill-up patch`: hardens, expands, or repairs an existing reusable skill under the consuming lane's ownership model
- `new-skill patch`: introduces a new reusable skill only after category, reuse need, and owner fit are proven
- `follow-on optimization patch`: removes avoidable redundancy or runtime burden only after the stronger quality bar is already secured

## Repair Decision Guide
For failure-mode-specific responses, use the matrix above.

1. If the failure is a missing lookup detail, add it to the owning direct `references/*.md` file and keep the active `SKILL.md` spine small but mandatory.
2. If the failure is a packet or handoff omission, add or tighten the packet field in the packet owner before adding prose-only reminders.
3. Deterministic runtime evidence with low false-positive risk allows hook/settings enforcement only after the semantic owner is correct and non-hook adherence hardening is insufficient.
4. If no existing lane, skill, or reference can handle the recurring work, use Capability-Gap Fast Path; do not create a new skill for a one-off need.

Before closure, verify: no dead cross-reference, no owner-boundary drift, no weakened proof or acceptance path, no duplicate competing procedure, and no hidden always-loaded context increase.

## High-Traffic Governance Surfaces
High-traffic governance surfaces require session revalidation, baseline anchoring, and bounded change scope before modification resumes after interruption.

Active high-traffic surfaces:
- `agents/team-lead.md`
- `CLAUDE.md`
- runtime hooks under `.claude/hooks/`
- `.claude/settings.json`
- `settings.*.json` overlays
- project-root `.mcp.json` when enabled by `.claude/settings.json`
- skill files under `.claude/skills/*/`
- authority-bearing skill references under `.claude/skills/*/references/` when they define live triggers, authority, fail-open, preservation, or runtime boundaries
- `.claude/reference/` caches when a change depends on official-source evidence or preservation traceability

Runtime hook protection and settings-deny protection are separate layers.
Governance-flow protection is enforced through runtime hooks such as `compliance-supervisor.sh` and related hooks.
`settings.json` `permissions.deny` is reserved for hard credential and secret paths.
Such paths include `.env`, `secrets/**`, and `credentials.json`.

## Recurrence Hardening Constraints
- Doctrine drift requires written source-to-destination trace.
- Recurrence-hardening scope stays tied to the confirmed recurring defect.
- Improvement closure requires evidence of the actual hardening change.
- Existing-owner update outranks new-skill introduction when it solves the recurrence.
- Protected local restatements remain when they have a named owner and direct-consumption or isolation-safety basis.
- Reusable ownership changes protect average-capability and prevent lane hollowing.

## Resolve Next Owner And Action
- Justified user correction, self-detected behavioral defect, repeated missed-catch, or missing reusable skill opens the matching classification path.
- Confirmed causal basis opens owner-surface selection.
- Selected failure mode opens the required response.
- Selected owner surface opens patch design on that surface.
- Low-false-positive deterministic runtime evidence opens hook/settings preflight after semantic owner correction.
- Reusable capability gap opens Capability-Gap Fast Path.
- High-traffic surface mutation opens session revalidation and baseline anchoring.
- Missing trace, scope, hardening evidence, primary failure mode, or prevention point reopens recurrence-hardening analysis or `HOLD`.

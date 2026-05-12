# self-growth-sequence: Failure Mode Response Matrix
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/self-growth-sequence/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

| Failure Mode | Default Meaning | Required Response | Owner Boundary |
|---|---|---|---|
| `missing-owner` | No current owner surface governs the recurring behavior. | Assign one owner surface, then add the narrowest rule, skill gate, packet field, or Hook-Last-approved runtime edge needed to close the gap. | Keep ownership on the assigned owner surface. |
| `weak-owner` | The right owner exists, but its wording, gate, checklist, or packet is too weak to prevent recurrence. | Tighten or replace the owning block; add a checklist or packet requirement only when wording alone will not surface the duty. | Keep the correction on the existing owner block. |
| `wrong-owner` | The behavior is governed from the wrong document, lane, or runtime surface. | Re-home the meaning to the correct owner and leave an owner-reference only when local readability requires it. | Preserve unique meaning through source-to-destination trace. |
| `non-compliance` | The rule already exists; the failure came from not following it. | Harden adherence through trigger visibility, checklist discipline, packet requirements, self-verification gates, or Hook-Last-approved runtime edge. | Address why the existing rule was missed. |
| `weak-enforcement` | Doctrine exists, but runtime or packet surfaces lack reliable obligation exposure. | Add or refine packet fields or advisory guidance first; add or refine hook logic only as a Hook-Last-approved runtime edge. | Semantic judgment becomes a hard block only after fields or low-friction evidence exist. |
| `capability-gap` | No reusable skill, reference, or lane procedure can handle the recurring work credibly. | Use Capability-Gap Fast Path; update an existing owner when sufficient, create a new skill only after the category gate. | Reserve new skills for reusable capability gaps. |

Use this matrix before drafting. A patch can involve more than one failure mode, but one primary mode must govern the edit operation and owner choice.

## Resolve Next Owner And Action
- Selected failure mode opens the required response in this matrix.
- Multiple failure modes choose one primary mode before drafting.
- Missing primary mode reopens self-growth causal analysis.

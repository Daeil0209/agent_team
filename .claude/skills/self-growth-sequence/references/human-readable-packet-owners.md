# self-growth-sequence: Human-Readable Packet Owners
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

For `developer` governance-modification execution, keep the governance packet readable here as the semantic packet owner; runtime hooks and dispatch gates may enforce adjacent discipline, but this catalog controls semantic completeness.

Current governance packet surface:
- **Standard**: `TASK-CLASS: governance-patch`, `CHANGE-BOUNDARY`, `WRITE-SCOPE`
- **Structural** adds: `BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor`, `EDIT-OPERATION: tighten|replace|re-home|merge|append|delete`
- For meaning migration: `CHANGE-BOUNDARY` must include source-meaning inventory, destination rationale, and cross-reference update list
- High-traffic surfaces add: `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`
- Use `.claude/skills/developer/references/developer-lane-detail.md` `Required Dispatch Packet Fields` for the developer dispatch-field baseline

For consequential solution work, keep the solution-development packet readable here as the semantic packet owner.

Current solution-development packet surface:
- `PROBLEM-CLASS: instance|structural|systemic`
- `ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown`
- `SOLUTION-PASS: 1|2|3`
- `DECISION-BASIS`
- `REJECTED-OPTIONS`
- `CHANGE-BOUNDARY`
- when `SOLUTION-PASS: 2|3`, also keep `PASS-DELTA`
- when `PROBLEM-CLASS: structural|systemic`, also keep `SELECTED-SCOPE: class-fix|system-fix|staged-class-fix`
- when `ROOT-CAUSE-BASIS: hypothesis|unknown`, also keep `COMPETING-HYPOTHESES`
- when `SELECTED-SCOPE: staged-class-fix`, also keep `FOLLOW-UP-OWNER`
- Use `.claude/skills/developer/references/developer-lane-detail.md` `Required Dispatch Packet Fields` for the developer dispatch-field baseline

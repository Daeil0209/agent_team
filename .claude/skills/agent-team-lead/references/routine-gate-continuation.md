---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "auto-proc; residual-queue; routine-milestone; status-exception; final-convergence"
---
# team-lead: Routine Gate Continuation

## Purpose
Resolve only the continuation branch after the role nonterminal rule fires.

## Consume When
- User asks for status or why an expected action did not happen while same-request work may remain open.
- A satisfied gate, phase transition, routine milestone, partial arrival, or partial patch batch occurs before final convergence.
- A final, closeout, or status path finds any frozen next owner/action or same-request residual work.

## Resolve Next Owner And Action
- Status or why answers consume `.claude/reference/reporting-prohibition-law.md` `## Pre-Report Gate` and `## Report Shape`, then return to the active owner action unless the user redirects or a user-action blocker is proven.
- Routine milestones and partial arrivals stay Procedure Plane unless the user explicitly asks for status; admitted status stays compact and omits internal inventories unless requested.
- Any open frozen next owner/action executes through its active owner path.
- Any same-request residual work opens the smallest owner that can close that residual item.
- A residual item closes only through patch, required integration, proof, validation, acceptance, cited out-of-scope basis, lawful owner deferral, explicit user cancellation/redirect, or truthful `HOLD`.
- `FINAL` opens only when every same-request residual item is closed, lawfully deferred, explicitly cancelled/redirected, or blocked by truthful `HOLD`.

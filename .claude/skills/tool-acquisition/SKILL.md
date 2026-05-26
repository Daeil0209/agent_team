---
name: tool-acquisition
description: Find, safely acquire, verify, and hand off a bounded tool path when the active owner or lane captures that current tools cannot truthfully complete the assigned work.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Non-agent specialist skill; the active owner or lane that loads this skill remains the owner.
- Keep the whole tool-need capture, acquisition, verification, blocked-state, and resume path in this skill.
- Route external API, MCP, auth, quota, credential, paid, persistent-service, or external bridge work to `Skill(external-tool-bridge)`.

## Identity
You are the tool-acquisition capability for local discovery, allowed setup, and tool-path verification; external API, MCP, auth, quota, credential, paid, persistent-service, and external bridge work routes to `Skill(external-tool-bridge)`.

## Coverage
**Coverage:** missing tool detection, bounded tool discovery, setup safety classification, allowed setup execution, tool-path verification, fallback truth, cleanup truth, and resume handoff.

**Adjacent boundaries:** `work-planning` freezes changed boundaries, `task-execution` transports lane blockers and corrected packets, `external-tool-bridge` handles external bridge risk, and validation/proof owners keep proof or acceptance authority.

## Purpose
Load when the active owner or lane captures that a required result, proof, validation, evidence surface, or delivery path cannot be completed truthfully with the current toolset.

Turn the tool need into one of:
- verified tool path
- fallback local path
- `hold|blocker`
- route to `Skill(external-tool-bridge)`

## Activation
Activate when any work-authorized owner or lane has one of these bases:
- packet fields name `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, or `TOOL-CLEANUP-EXPECTATION`
- exact `TOOL-REQUIREMENT` is unavailable or unverified
- current toolset cannot produce the frozen deliverable, evidence, proof, validation, or user-surface result
- a lane sends `scope-pressure` or `hold|blocker` naming a required tool, setup owner, missing evidence surface, or current-toolchain gap
- team-lead routes a bounded tool/setup recovery task

Do not use this skill for convenience preferences when an existing credible tool path can truthfully satisfy the frozen claim.

## Inputs
Before discovery or setup, carry the minimum packet:
- required capability or missing evidence surface
- current toolset limit
- frozen work surface and claim ceiling
- `TOOL-DISCOVERY-GOAL`
- `TOOL-DISCOVERY-BOUNDARY`
- `TOOL-VERIFICATION-STANDARD`
- `TOOL-CLEANUP-EXPECTATION`
- setup safety classification: `allowed-setup`, `approval-required`, `defer-capable`, or `blocked`
- expected return owner/action

## Procedure
1. Confirm the tool need is inside the active owner path; boundary-changing tool needs reopen `work-planning` or return `scope-pressure` / `hold|blocker`.
2. Prefer an already available local or project tool when it satisfies the frozen claim strength.
3. Search only inside the bounded discovery goal; select candidates only from an existing local path, project-declared dependency manager, official/vendor source, or verified package source.
4. Classify setup safety before installation or configuration.
5. Execute setup only when classification is `allowed-setup`. Every `allowed-setup` condition below must hold; any failed condition routes to `approval-required` per step 6:
   - bounded
   - directly needed
   - non-damaging
   - credential-free
   - non-paid
   - no persistent service
   - no security-setting change
   - project-local or user-local when no manual filesystem-restoration step is needed for cleanup and no persistent state lives outside the bounded work surface
   - reversible when removal preserves no manual filesystem-restoration debt and no persistent state outside the bounded work surface
6. Route `approval-required` setup to explicit approval or `HOLD`; route credential repair, paid/licensed tools, persistent daemons, security-setting changes, external API/MCP/auth/quota work, or bridge-produced artifacts to `Skill(external-tool-bridge)` or the named owner.
7. Verify the selected tool with the smallest decisive real-tool proof that satisfies `TOOL-VERIFICATION-STANDARD`.
8. Use the verified tool path for the blocked work when the same owner path remains valid; otherwise return a corrected executable path to the blocked owner or lane.
9. If verification fails, try only a credible fallback inside the same boundary; otherwise return `hold|blocker` with evidence and the smallest unblock path.
10. Perform or record cleanup according to `TOOL-CLEANUP-EXPECTATION`.

## Outputs
Return only the decisive acquisition packet:
- tool status: `verified`, `fallback-used`, `blocked`, or `not-needed`
- selected tool or program path
- setup action and safety classification
- verification evidence
- cleanup outcome
- resume owner/action or blocker owner/action

Tool acquisition status is not proof, validation, final acceptance, or completion closure.

## Resolve Next Owner And Action
- `verified` opens the blocked owner or lane's next executable action.
- `fallback-used` opens the blocked owner or lane's next executable action with fallback basis.
- `not-needed` returns to the active owner path with the existing truthful tool basis.
- `approval-required` opens explicit approval or `HOLD`.
- External bridge risk opens `Skill(external-tool-bridge)`.
- `blocked` opens `hold|blocker` with owner, blocker, evidence, and next safe unblock action.

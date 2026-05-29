---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; Environment Configuration Philosophy; optional curtain controls user report rendering only"
LOAD-POLICY: mandatory when supervised user-report rendering or output-curtain operation is material
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Output Curtain Runtime

## Purpose
Output Curtain Runtime owns the optional display curtain for user-facing reports.

The curtain does not own, rewrite, summarize, redact, archive, classify, or separately manage team-lead to agent Communication Plane payloads.
Internal communication remains governed by the existing team runtime, `SendMessage`, retained-output carriers, and lifecycle contracts.

## Display Classes
Claude Code host-native display is outside this curtain.
Host-native display includes tool rows, tool result expanders, automatic background-agent rows, native notifications, recap rows, and other UI text rendered by Claude Code itself.
This curtain does not claim to block host-native display.

Agent-authored discretionary prose is inside the curtain target when the operator chooses supervised rendering.
Discretionary-prose classification is owned by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; supervised rendering observes that classification without redefining it.

## Curtain Invariant
When supervised rendering is used, the user-facing report surface renders only explicit report proposals that pass the structural release gate.
All ordinary child process screen text is hidden from that supervised report surface.
Hidden child screen text is not a replacement carrier, not a redacted artifact, and not a separate internal record.

## Release Gate
`.claude/reference/reporting-prohibition-law.md` owns whether a report may be proposed.
The curtain release gate only verifies structural release conditions: schema, active `run_id`, valid narrow exception reason, valid report id, non-empty visible text, size limit, and terminal-control safety.
The gate is not a content classifier for internal Communication Plane messages.
The gate must not mutate internal payloads into user reports.

## Failure Semantics
If the curtain runtime fails, the supervised report surface fails closed and emits no child screen text.
Direct `claude` native startup does not activate the curtain.
If the operator uses normal Claude Code native UI, host-native display remains governed by Claude Code behavior and the model-side reporting law; it is not proof of curtain failure.
In native UI, agent-authored prose leakage violates `.claude/reference/reporting-prohibition-law.md` report-prohibition criteria; it is not supervised curtain proof.
Current native `.claude/settings.json` hook wiring proves only the wired hook surfaces; it does not prove hard blocking of normal assistant prose, final prose, or visible task-plan/checklist text.
Use a configured supervised-renderer executable only after verifying that the path exists and is executable.
If no supervised-renderer executable is installed, supervised curtain operation is unavailable; record `HOLD` or `UNVERIFIED` instead of claiming curtain proof, and render only through reporting-law admission.

## Proof Standard
The decisive proof for the curtain is user-visible stdout/stderr from the supervised renderer.
Passing evidence requires that child stdout/stderr can contain forbidden progress text while supervised stdout/stderr remains empty unless an explicit report proposal is structurally released.
Proof capture of child output is verification-only and must be requested explicitly; production default does not store child screen text.

## Resolve Next Owner And Action
- Passing curtain proof returns to the reporting owner with the proven supervised-renderer basis.
- Curtain unavailability or failed proof returns `HOLD` or `UNVERIFIED` to the reporting or environment owner.
- Content-admission questions return to `.claude/reference/reporting-prohibition-law.md`.
- Renderer path, executable, hook, settings, or runtime-enforcement changes open `Skill(governance-modification)` after environment configuration review.

# update-upgrade-sequence: Update Checks
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/update-upgrade-sequence/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file for update-specific checks when doctrine, agents, skills, settings, hooks, references, or other team-system assets are modified.

The canonical `Change Sequence` from `.claude/skills/self-growth-sequence/SKILL.md` owns patch mechanics: target-owner confirmation, semantic-overlap review, prefer-replace/trim/re-home over append, migration traceability, zero-information-loss confirmation, hook-contract readability, protected local-restatement preservation, and optimization-vs-protected-content classification.

Update/upgrade adds these domain checks:
1. Where a runtime setting or threshold must remain configurable, keep one owner for the literal value and make all other documents or prompts reference that owner.
2. Preserve approved structural hierarchies and connection mappings when the target document already uses them.
3. Role documents must preserve their declared role, procedure, reference hierarchy, and required mapping lines.
4. Skill documents must preserve their fixed structural contract, inherited-doctrine line, reference map, and reference detail attached to an owning workflow, sequence, phase, or owner block.
5. New top-level sections, orphaned procedure blocks, orphaned reference blocks, or broken mapping chains require explicit governance review before execution.
6. Record any remaining migration, affected-surface, in-flight-output, or prior-verdict gap explicitly rather than assuming the update is complete.
7. When reducing context footprint, prove that moved meaning remains reachable through an owning trigger or direct reference path.
8. For MCP or external-tool capability updates, verify asset-set coherence: project-root `.mcp.json` server entry, `.claude/settings.json` `enabledMcpjsonServers`/permission/hook posture, role tool authorization, and owning skill trigger/authority. A mismatch is an update blocker or an explicit deferred owner.
9. Promotion from non-blocking rule/fail-open use to blocking authority, SV-stage use, worker lane use, custom wrapper use, or persistent metric automation requires measured benefit, authority/footprint review, and user-visible rollback or fail-open semantics before activation.
10. Hook/settings runtime enforcement expansion requires Hook-Last preflight before execution.
    Required basis: non-hook failure, non-hook insufficiency, exact matcher or payload condition, recovery path, false-positive/regression check, `.claude/hooks/MANIFEST.md` Hook-Last Review Ledger entry, and explicit operator approval.
    Missing basis -> doctrine-only/owner-rule-only or `HOLD`; do not edit runtime enforcement.

Defect admission is owned by `.claude/skills/self-growth-sequence/SKILL.md` `Causal Repair Standard`.
This update/upgrade check supplies update-local evidence only: `TARGET-INTENT-BASIS`, protected function, user-impact risk, removal or weakening risk, and smallest intent-preserving correction.
A literal contradiction, repeated sentence, heavy gate, hook burden, deletion permission, or plausible misuse remains defect evidence until the self-growth defect admission gate proves `confirmed defect`.
If the item is intended protection, preserve the protection and reduce only the avoidable burden.

## Resolve Next Owner And Action
- Completed update checks return evidence to `update-upgrade-sequence`.
- Missing structural preservation opens update patch redesign.
- Broken mapping chain opens owner/reference correction.
- Runtime setting or threshold owner conflict opens single-owner correction.
- Hook/settings expansion without Hook-Last basis opens doctrine-only/owner-rule-only path or `HOLD`.
- Confirmed recurrence-barrier defect opens `self-growth-sequence`.
- Intended protection with avoidable burden opens burden-reduction patch design.

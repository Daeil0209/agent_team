# update-upgrade-sequence: Update Checks
PRIMARY-OWNER: team-lead
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
6. Record any remaining migration gap explicitly rather than assuming the update is complete.
7. When optimizing context cost, prove that moved meaning remains reachable through an owning trigger or direct reference path.

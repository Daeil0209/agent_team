---
paths:
  - ".claude/CLAUDE.md"
  - ".claude/rules/*.md"
  - ".claude/rules/**/*.md"
  - ".claude/agents/**/*.md"
  - ".claude/skills/**/*.md"
  - ".claude/hooks/**/*"
  - ".claude/settings*.json"
---

# Governance Editing Rules
Conditional rule for governance-sensitive setup-surface modifications under `.claude/`.

## Activation

- This rule loads only when Claude reads a matching governance surface under `.claude/`, including conditional rule overlays under `.claude/rules/`. It is not part of ordinary startup doctrine.
- Use it to tighten editing discipline on shared setup surfaces without paying always-on context cost for normal task execution.

Note: This overlay intentionally covers the full .claude/ governance surface rather than a single file. CLAUDE.md §Conditional Rules "genuinely file-scoped" applies to narrowly-targeted overlays; this file is the designated broad-scope governance-editing exception.

## Required Discipline

- Follow the `Change Sequence` and `Patch Execution Method` owned by `self-growth-sequence/SKILL.md` when the modification is consequential, structural, or governance-sensitive.
- Preserve each target document's `Structural Contract`, owner boundary, and protected local restatements.
- Review changed content before execution; plan review alone is not sufficient.
- Keep moved, merged, trimmed, or re-homed meaning reconstructable through explicit source meaning, destination owner, and bounded change scope.
- Before labeling a governance item as a defect, apply `CLAUDE.md [GOV-MIN]`: does it demonstrably break runtime truth, lifecycle integrity, ownership clarity, evidence quality, or acceptance integrity, or is it only less strict, less verbose, less formatted, or less duplicative than expected? If the latter, classify it as intentional minimal-boundary design or clarification candidate, not a defect.
- When the failure mode is non-compliance, harden adherence instead of adding duplicate doctrine.
- If a rule is created or retained under `.claude/rules/`, it must carry valid `paths:` frontmatter and remain a genuinely file-scoped overlay. Always-on doctrine belongs in `CLAUDE.md`, and task- or runtime-specific procedure belongs in the owning skill, agent, hook, or settings surface.

## High-Traffic Surface Guard

- For high-traffic governance surfaces (`CLAUDE.md`, `agents/team-lead.md`, runtime hooks, `settings.json`), revalidate the current-session baseline before resuming modification after interruption.
- Do not widen scope from a bounded hardening patch into unrelated cleanup or doctrine expansion.
- If a setup-surface change is destructive or security-sensitive, explicit user approval remains required.

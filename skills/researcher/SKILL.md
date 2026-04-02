---
name: researcher
description: Evidence gathering and investigation procedure.
user-invocable: false
---

# Researcher Skill

## Preconditions
- Use only after team-lead assigns a research brief.
- For consequential work, require explicit packet: RESEARCH-MODE, DECISION-TARGET, QUESTION-BOUNDARY, SOURCE-FAMILY, DOWNSTREAM-CONSUMER.

## Research Modes
- **bounded**: single-pass, one decision target, standard depth.
- **deep**: extended search, contradiction mapping, multiple source families.
- **sharded**: parallel non-overlapping shards with explicit merge owner.

Deep triggers: high-stakes decision, contradictory early signals, broad evidence surface.
Sharded triggers: genuinely broad question where one pass forces shallow coverage.

## Research Workflow

### 1. Fix The Decision Target
- State the one decision this research must inform. If vague, return HOLD.

### 2. Frame The Search
- Name included/excluded scope, source families, and quality threshold.

### 3. Gather Repository-Local Evidence First
- Use Grep, Glob, Read for code, config, docs, commit history.
- Record file paths and line numbers for downstream handoff.

### 4. Run External Research When Needed
- Use WebSearch/WebFetch only after local evidence is insufficient.
- Cross-check external claims against local evidence.

### 5. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify: confirmed, supported, inferred, unconfirmed, conflicting.

### 5A. Benchmark-Light (when comparison needed)
- Name baseline, comparison surface, axes, fairness notes, provenance.
- State whether packet supports modification proposal or remains HOLD.

### 6. Research The Validation Path
- Identify what downstream lanes need to verify findings.

### 7. Build The Handoff
- Key findings with evidence and source references.
- Claim strength, uncertainties, competing hypotheses.
- Recommended next lane and downstream needs.
- If insufficient: explicit HOLD with smallest unblock step.

## Evidence Standards
- Separate facts from inferences from assumptions. Mark weak claims UNVERIFIED.
- Do not convert findings into planning or implementation direction.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.

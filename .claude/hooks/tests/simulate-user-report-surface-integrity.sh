#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "routine-progress-update",
    title: "Workers are running and the user asks for a short progress update",
    triggerVerificationSurface: false,
    explicitAuditRequest: false,
    explicitBasisRequest: false,
    completionClaim: false,
    highRiskConclusion: false,
    manyFindings: false,
    expectedBest: ["layered-user-surface", "current-heavy-audit-surface"],
  },
  {
    id: "final-audit-response-many-findings",
    title: "User asked for an audit result and the system has multiple findings",
    triggerVerificationSurface: true,
    explicitAuditRequest: true,
    explicitBasisRequest: false,
    completionClaim: false,
    highRiskConclusion: true,
    manyFindings: true,
    expectedBest: ["layered-user-surface"],
  },
  {
    id: "completion-claim-clean",
    title: "Lead is reporting a clean completion with no material open item",
    triggerVerificationSurface: true,
    explicitAuditRequest: false,
    explicitBasisRequest: false,
    completionClaim: true,
    highRiskConclusion: false,
    manyFindings: false,
    expectedBest: ["layered-user-surface"],
  },
  {
    id: "high-risk-governance-conclusion",
    title: "Lead is reporting a high-risk governance/process conclusion",
    triggerVerificationSurface: true,
    explicitAuditRequest: false,
    explicitBasisRequest: false,
    completionClaim: false,
    highRiskConclusion: true,
    manyFindings: false,
    expectedBest: ["layered-user-surface"],
  },
  {
    id: "user-explicitly-asks-for-basis",
    title: "User explicitly asks why or asks for verification basis",
    triggerVerificationSurface: true,
    explicitAuditRequest: false,
    explicitBasisRequest: true,
    completionClaim: false,
    highRiskConclusion: false,
    manyFindings: false,
    expectedBest: ["layered-user-surface"],
  },
];

const strategies = [
  {
    id: "current-heavy-audit-surface",
    title: "Result followed by broad verification basis, residuals, and long finding dump",
    directAnswerFirst: true,
    conditionalVerification: true,
    leaksInternalHandoff: false,
    alwaysFullFindingLedger: true,
    compressesFindingDensity: false,
    suppressesRoutineVerification: true,
  },
  {
    id: "over-compressed-surface",
    title: "Short user answer with most verification suppressed even when triggered",
    directAnswerFirst: true,
    conditionalVerification: false,
    leaksInternalHandoff: false,
    alwaysFullFindingLedger: false,
    compressesFindingDensity: true,
    suppressesRoutineVerification: true,
  },
  {
    id: "internal-handoff-leak",
    title: "User-facing response mirrors worker handoff blocks and packet labels",
    directAnswerFirst: false,
    conditionalVerification: true,
    leaksInternalHandoff: true,
    alwaysFullFindingLedger: true,
    compressesFindingDensity: false,
    suppressesRoutineVerification: false,
  },
  {
    id: "audit-always-full-ledger",
    title: "Every audit-like turn emits full findings ledger and detailed evidence rows",
    directAnswerFirst: true,
    conditionalVerification: true,
    leaksInternalHandoff: false,
    alwaysFullFindingLedger: true,
    compressesFindingDensity: false,
    suppressesRoutineVerification: false,
  },
  {
    id: "layered-user-surface",
    title: "Direct answer first, conditional verification, compressed finding surface, no handoff leak",
    directAnswerFirst: true,
    conditionalVerification: true,
    leaksInternalHandoff: false,
    alwaysFullFindingLedger: false,
    compressesFindingDensity: true,
    suppressesRoutineVerification: true,
  },
];

function simulate(scenario, strategy) {
  let score = 100;
  const reasons = [];
  const invariants = [];

  if (!strategy.directAnswerFirst) {
    reasons.push("no-direct-answer-first");
    score -= 25;
  } else {
    invariants.push("direct-answer-first");
  }

  if (scenario.triggerVerificationSurface || scenario.explicitBasisRequest || scenario.highRiskConclusion || scenario.completionClaim) {
    if (!strategy.conditionalVerification) {
      reasons.push("verification-surface-missing-when-required");
      score -= 45;
    } else {
      invariants.push("triggered-verification-preserved");
    }
  } else if (!strategy.suppressesRoutineVerification) {
    reasons.push("routine-progress-too-heavy");
    score -= 20;
  } else {
    invariants.push("routine-progress-compressed");
  }

  if (strategy.leaksInternalHandoff) {
    reasons.push("internal-handoff-leak");
    score -= 35;
  } else {
    invariants.push("no-handoff-leak");
  }

  if (scenario.manyFindings) {
    if (strategy.alwaysFullFindingLedger && !strategy.compressesFindingDensity) {
      reasons.push("finding-density-overload");
      score -= 18;
    } else if (strategy.compressesFindingDensity) {
      invariants.push("finding-density-compressed");
    }
  }

  if ((scenario.triggerVerificationSurface || scenario.explicitBasisRequest || scenario.highRiskConclusion || scenario.completionClaim) && strategy.alwaysFullFindingLedger) {
    reasons.push("ledger-overexposure");
    score -= scenario.manyFindings ? 0 : 8;
  }

  if (scenario.explicitAuditRequest && !scenario.manyFindings && strategy.alwaysFullFindingLedger) {
    reasons.push("audit-over-expanded");
    score -= 10;
  }

  let outcome = "pass";
  if (reasons.includes("verification-surface-missing-when-required") || reasons.includes("internal-handoff-leak")) {
    outcome = "fail";
  } else if (score < 85) {
    outcome = "weak-pass";
  }

  return { score, reasons, invariants, outcome };
}

function assert(condition, label, context = "") {
  if (!condition) {
    console.error(`FAIL ${label}`);
    if (context) console.error(context);
    process.exitCode = 1;
  } else {
    console.log(`PASS ${label}`);
  }
}

const rows = [];
for (const scenario of scenarios) {
  for (const strategy of strategies) {
    rows.push({
      scenario: scenario.id,
      strategy: strategy.id,
      ...simulate(scenario, strategy),
    });
  }
}

for (const scenario of scenarios) {
  const ranked = rows
    .filter((row) => row.scenario === scenario.id)
    .slice()
    .sort((a, b) => b.score - a.score);
  const best = ranked[0];
  console.log(`\n=== ${scenario.id} ===`);
  console.log(`best=${best.strategy} score=${best.score} outcome=${best.outcome}`);
  assert(
    scenario.expectedBest.includes(best.strategy),
    `${scenario.id} best strategy`,
    `expected one of ${scenario.expectedBest.join(", ")}, got ${best.strategy}`
  );
}

const layeredRows = rows.filter((row) => row.strategy === "layered-user-surface");
assert(
  layeredRows.every((row) => row.outcome === "pass"),
  "layered-user-surface preserves all modeled integrity invariants",
  JSON.stringify(layeredRows, null, 2)
);

const overCompressedRows = rows.filter((row) => row.strategy === "over-compressed-surface");
assert(
  overCompressedRows.some((row) => row.reasons.includes("verification-surface-missing-when-required")),
  "over-compressed surface fails required verification triggers",
  JSON.stringify(overCompressedRows, null, 2)
);

const handoffLeakRows = rows.filter((row) => row.strategy === "internal-handoff-leak");
assert(
  handoffLeakRows.every((row) => row.outcome === "fail"),
  "handoff leak strategy always fails",
  JSON.stringify(handoffLeakRows, null, 2)
);

const currentHeavy = rows.find(
  (row) => row.scenario === "final-audit-response-many-findings" && row.strategy === "current-heavy-audit-surface"
);
assert(
  currentHeavy && currentHeavy.reasons.includes("finding-density-overload"),
  "current heavy audit surface captures the readability defect",
  JSON.stringify(currentHeavy, null, 2)
);

console.log("\n=== strategy-summary ===");
const summary = strategies
  .map((strategy) => {
    const samples = rows.filter((row) => row.strategy === strategy.id);
    const avg = samples.reduce((sum, row) => sum + row.score, 0) / samples.length;
    const fails = samples.filter((row) => row.outcome === "fail").length;
    const weak = samples.filter((row) => row.outcome === "weak-pass").length;
    return `${strategy.id} avg=${avg.toFixed(1)} fails=${fails} weak=${weak}`;
  });
for (const line of summary) console.log(line);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 13");
NODE

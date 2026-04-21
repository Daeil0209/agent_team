#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "manageable-proof-small",
    title: "Manageable proof packet with no generated-runner friction",
    workerBudget: 100,
    envLoad: 10,
    apiLoad: 10,
    browserProofLoad: 22,
    reportLoad: 12,
    remediationLoad: 0,
    generatedArtifacts: false,
    generatedWriteAttempts: 0,
    blockCost: 0,
    longRunning: false,
    browserProofShardable: false,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: false,
    notes: [
      "Baseline should already pass.",
      "Use this as the false-positive guard against over-tight governance.",
    ],
  },
  {
    id: "generated-proof-medium",
    title: "Medium browser proof with generated screenshots/runner path",
    workerBudget: 100,
    envLoad: 12,
    apiLoad: 8,
    browserProofLoad: 28,
    reportLoad: 14,
    remediationLoad: 0,
    generatedArtifacts: true,
    generatedWriteAttempts: 5,
    blockCost: 7,
    longRunning: true,
    browserProofShardable: false,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: true,
    notes: [
      "Hook alignment is the dominant variable here.",
      "Packet sizing is not the main problem.",
    ],
  },
  {
    id: "incident-like-overload",
    title: "Incident-like overloaded tester packet",
    workerBudget: 100,
    envLoad: 22,
    apiLoad: 14,
    browserProofLoad: 46,
    reportLoad: 18,
    remediationLoad: 0,
    generatedArtifacts: true,
    generatedWriteAttempts: 9,
    blockCost: 8,
    longRunning: true,
    browserProofShardable: true,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: true,
    adaptiveRecoveryPossible: true,
    notes: [
      "Grounded in the observed tester trace: repeated hook blocks, context compaction, and weak visibility.",
      "Represents env bring-up + API recert + browser proof + screenshots + report in one packet.",
    ],
  },
  {
    id: "serial-remediation-trap",
    title: "Proof lane discovers defect and remediation is handled serially",
    workerBudget: 100,
    envLoad: 18,
    apiLoad: 10,
    browserProofLoad: 34,
    reportLoad: 16,
    remediationLoad: 26,
    generatedArtifacts: true,
    generatedWriteAttempts: 4,
    blockCost: 7,
    longRunning: true,
    browserProofShardable: false,
    remediationParallelizable: true,
    requiresParallelRemediation: true,
    heavyRuntimeFriction: true,
    adaptiveRecoveryPossible: false,
    notes: [
      "Tests whether team-lead can split proof and corrective work instead of making tester absorb both.",
      "Matches the user's concern about verification and error-fix work running in parallel.",
    ],
  },
  {
    id: "parallel-remediation-window",
    title: "Proof lane with parallelizable remediation and partial-progress reporting",
    workerBudget: 100,
    envLoad: 16,
    apiLoad: 10,
    browserProofLoad: 32,
    reportLoad: 16,
    remediationLoad: 24,
    generatedArtifacts: false,
    generatedWriteAttempts: 0,
    blockCost: 0,
    longRunning: true,
    browserProofShardable: false,
    remediationParallelizable: true,
    requiresParallelRemediation: true,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: false,
    notes: [
      "Sizing is moderate, but serial orchestration still causes avoidable bottlenecks.",
      "Parallel developer remediation should beat status-only fixes.",
    ],
  },
  {
    id: "unavoidable-large-proof-surface",
    title: "Inevitably large proof surface that exceeds one tester context",
    workerBudget: 100,
    envLoad: 18,
    apiLoad: 10,
    browserProofLoad: 92,
    reportLoad: 18,
    remediationLoad: 0,
    generatedArtifacts: true,
    generatedWriteAttempts: 3,
    blockCost: 6,
    longRunning: true,
    browserProofShardable: true,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: false,
    notes: [
      "This covers the user's point that some real-world tasks will be large no matter what.",
      "Only proof sharding plus merge ownership should fully clear this case.",
    ],
  },
  {
    id: "working-but-invisible",
    title: "Worker is actively progressing but lead visibility is weak",
    workerBudget: 100,
    envLoad: 12,
    apiLoad: 8,
    browserProofLoad: 26,
    reportLoad: 12,
    remediationLoad: 0,
    generatedArtifacts: true,
    generatedWriteAttempts: 2,
    blockCost: 5,
    longRunning: true,
    browserProofShardable: false,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: true,
    notes: [
      "Represents the case where work is happening but official upward reporting never arrives in time.",
      "Tests observability without conflating it with proof capacity.",
    ],
  },
  {
    id: "contract-drift-adaptive-proof",
    title: "Worker finishes with adaptive proof but violates the explicit test contract",
    workerBudget: 100,
    envLoad: 14,
    apiLoad: 8,
    browserProofLoad: 24,
    reportLoad: 14,
    remediationLoad: 0,
    generatedArtifacts: true,
    generatedWriteAttempts: 3,
    blockCost: 5,
    longRunning: true,
    browserProofShardable: false,
    remediationParallelizable: false,
    requiresParallelRemediation: false,
    heavyRuntimeFriction: false,
    adaptiveRecoveryPossible: true,
    contractDriftPossible: true,
    notes: [
      "Models the exact class of failure where tester substitutes a different tool path and weaker interaction evidence.",
      "Success here must preserve mismatch truth instead of silently upgrading it to matched.",
    ],
  },
];

const strategies = [
  {
    id: "baseline-current",
    title: "Current baseline",
    leadSizingLint: false,
    phaseSplit: false,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: false,
    heartbeat: false,
    interruptiveMonitoring: false,
    repeatEscalation: false,
    testerHold: false,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "status-only",
    title: "Heartbeat and monitoring only",
    leadSizingLint: false,
    phaseSplit: false,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: false,
    heartbeat: true,
    interruptiveMonitoring: true,
    repeatEscalation: true,
    testerHold: false,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "hook-only",
    title: "Hook alignment only",
    leadSizingLint: false,
    phaseSplit: false,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: true,
    heartbeat: false,
    interruptiveMonitoring: false,
    repeatEscalation: false,
    testerHold: false,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "contract-gates-only",
    title: "Worker handoff lint plus lead acceptance gate",
    leadSizingLint: false,
    phaseSplit: false,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: false,
    heartbeat: false,
    interruptiveMonitoring: false,
    repeatEscalation: false,
    testerHold: false,
    handoffContractLint: true,
    leadAcceptanceGate: true,
  },
  {
    id: "hold-only",
    title: "Overscope detection and HOLD only",
    leadSizingLint: true,
    phaseSplit: false,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: false,
    heartbeat: false,
    interruptiveMonitoring: false,
    repeatEscalation: true,
    testerHold: true,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "phase-split-only",
    title: "Lead sizing plus phase split",
    leadSizingLint: true,
    phaseSplit: true,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: false,
    heartbeat: false,
    interruptiveMonitoring: false,
    repeatEscalation: true,
    testerHold: true,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "phase-split-plus-parallel-remediation",
    title: "Phase split plus parallel remediation",
    leadSizingLint: true,
    phaseSplit: true,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: true,
    hookAlignment: false,
    heartbeat: true,
    interruptiveMonitoring: true,
    repeatEscalation: true,
    testerHold: true,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "phase-split-plus-hook-alignment",
    title: "Phase split plus hook alignment",
    leadSizingLint: true,
    phaseSplit: true,
    proofShards: false,
    mergeOwner: false,
    parallelRemediation: false,
    hookAlignment: true,
    heartbeat: true,
    interruptiveMonitoring: true,
    repeatEscalation: true,
    testerHold: true,
    handoffContractLint: false,
    leadAcceptanceGate: false,
  },
  {
    id: "full-system",
    title: "Sizing, split, sharding, hook alignment, heartbeat, and parallel remediation",
    leadSizingLint: true,
    phaseSplit: true,
    proofShards: true,
    mergeOwner: true,
    parallelRemediation: true,
    hookAlignment: true,
    heartbeat: true,
    interruptiveMonitoring: true,
    repeatEscalation: true,
    testerHold: true,
    handoffContractLint: true,
    leadAcceptanceGate: true,
  },
];

const statusRank = { FAIL: 0, HOLD: 1, PARTIAL: 2, PASS: 3 };
const visibilityRank = { opaque: 0, partial: 1, clear: 2 };

function sum(values) {
  return values.reduce((acc, value) => acc + value, 0);
}

function max(values) {
  return values.length ? Math.max(...values) : 0;
}

function round(value) {
  return Math.round(value * 10) / 10;
}

function unique(items) {
  return [...new Set(items)];
}

function buildGroups(scenario, strategy) {
  const groups = [];
  const remediationParallel =
    scenario.remediationLoad > 0 &&
    scenario.remediationParallelizable &&
    strategy.parallelRemediation;

  if (!strategy.phaseSplit) {
    groups.push({
      owner: "tester",
      name: "all-in-one-proof",
      load:
        scenario.envLoad +
        scenario.apiLoad +
        scenario.browserProofLoad +
        scenario.reportLoad +
        (remediationParallel ? 0 : scenario.remediationLoad),
    });
  } else {
    if (scenario.envLoad > 0) {
      groups.push({ owner: "tester", name: "env-bring-up", load: scenario.envLoad });
    }
    if (scenario.apiLoad > 0) {
      groups.push({ owner: "tester", name: "runtime-recert", load: scenario.apiLoad });
    }

    if (scenario.browserProofLoad > 0) {
      if (
        strategy.proofShards &&
        strategy.mergeOwner &&
        scenario.browserProofShardable &&
        scenario.browserProofLoad > scenario.workerBudget * 0.8
      ) {
        const shardCount = 3;
        const perShard = Math.ceil(scenario.browserProofLoad / shardCount);
        for (let index = 1; index <= shardCount; index += 1) {
          groups.push({
            owner: `tester-shard-${index}`,
            name: `browser-proof-shard-${index}`,
            load: perShard,
          });
        }
        groups.push({ owner: "merge-owner", name: "proof-merge", load: 10 });
      } else {
        groups.push({ owner: "tester", name: "browser-proof", load: scenario.browserProofLoad });
      }
    }

    if (scenario.reportLoad > 0) {
      groups.push({ owner: "tester", name: "report-convergence", load: scenario.reportLoad });
    }

    if (scenario.remediationLoad > 0) {
      groups.push({
        owner: remediationParallel ? "developer" : "tester",
        name: "remediation",
        load: scenario.remediationLoad,
      });
    }
  }

  return groups;
}

function simulateScenario(scenario, strategy) {
  const groups = buildGroups(scenario, strategy);
  const testerLoads = groups
    .filter((group) => group.owner === "tester" || group.owner.startsWith("tester-shard"))
    .map((group) => group.load);

  const testerPeakBeforeHook = max(testerLoads);
  const testerTotalBeforeHook = sum(testerLoads);
  const overscopedSingleWorker =
    !strategy.phaseSplit &&
    testerTotalBeforeHook > scenario.workerBudget * 0.85;

  let status = "PASS";
  const reasons = [];
  let hookBlocks = 0;
  let reports = 1; // dispatch-ack baseline

  if (strategy.leadSizingLint && overscopedSingleWorker && strategy.testerHold) {
    status = "HOLD";
    reasons.push("overscope-caught-before-execution");
  }

  if (status !== "HOLD" && scenario.generatedArtifacts && !strategy.hookAlignment) {
    hookBlocks = scenario.generatedWriteAttempts;
    reasons.push("generated-output-hook-friction");
    if (strategy.repeatEscalation && hookBlocks >= 2) {
      reports += 1;
      reasons.push("repeat-block-escalated");
      if (status === "PASS") status = "HOLD";
    } else if (status === "PASS") {
      status = "PARTIAL";
    }
  }

  let testerPeak = testerPeakBeforeHook;
  if (hookBlocks > 0) {
    const retryLoad = hookBlocks * scenario.blockCost;
    testerPeak += retryLoad;
  }

  const contextRatio = scenario.workerBudget > 0 ? testerPeak / scenario.workerBudget : 0;
  const compactionTriggered = contextRatio >= 1.15;
  const highPressure = contextRatio >= 0.85 && contextRatio < 1.15;

  if (status !== "HOLD") {
    if (compactionTriggered) {
      if (scenario.adaptiveRecoveryPossible && !scenario.requiresParallelRemediation) {
        status = "PARTIAL";
        reasons.push("costly-adaptive-recovery");
      } else {
        status = "FAIL";
        reasons.push("context-overflow");
      }
    } else if (highPressure && status === "PASS") {
      status = "PARTIAL";
      reasons.push("context-pressure");
    }
  }

  if (
    strategy.phaseSplit &&
    !strategy.proofShards &&
    scenario.browserProofShardable &&
    scenario.browserProofLoad > scenario.workerBudget * 0.8 &&
    status !== "HOLD" &&
    status !== "FAIL"
  ) {
    status = "PARTIAL";
    reasons.push("proof-surface-still-too-large-for-one-worker");
  }

  if (
    scenario.requiresParallelRemediation &&
    !strategy.parallelRemediation &&
    status !== "HOLD" &&
    status !== "FAIL"
  ) {
    status = "PARTIAL";
    reasons.push("serial-remediation-bottleneck");
  }

  const longRunning = scenario.longRunning || testerTotalBeforeHook >= 50;
  let visibility = "clear";
  if (longRunning) {
    if (strategy.heartbeat) {
      reports += 2;
      visibility = "clear";
    } else if (strategy.interruptiveMonitoring || strategy.repeatEscalation) {
      visibility = "partial";
    } else {
      visibility = "opaque";
      reasons.push("working-but-invisible");
    }
  }

  if (status === "PASS" && visibility === "opaque") {
    reasons.push("observability-defect");
  }

  if (scenario.contractDriftPossible) {
    if (strategy.hookAlignment) {
      // With the approved path open, the need for adaptive drift should disappear.
    } else if (strategy.handoffContractLint && strategy.leadAcceptanceGate) {
      if (status === "PASS") status = "PARTIAL";
      reasons.push("contract-drift-explicitly-downgraded");
    } else {
      if (status === "PASS") status = "PARTIAL";
      reasons.push("proof-contract-drift-accepted");
    }
  }

  const parallelOwners = unique(
    groups
      .map((group) => group.owner)
      .filter((owner) => owner !== "tester"),
  ).length;

  const governanceFit =
    status === "FAIL"
      ? "misaligned"
      : reasons.includes("overscope-caught-before-execution")
        ? "protective-but-incomplete"
        : reasons.includes("generated-output-hook-friction") ||
            reasons.includes("working-but-invisible") ||
            reasons.includes("serial-remediation-bottleneck") ||
            reasons.includes("proof-surface-still-too-large-for-one-worker") ||
            reasons.includes("proof-contract-drift-accepted")
          ? "costly"
          : "aligned";

  const score =
    statusRank[status] * 40 +
    visibilityRank[visibility] * 15 +
    Math.min(parallelOwners, 3) * 5 +
    (strategy.hookAlignment ? 6 : 0) +
    (strategy.phaseSplit ? 10 : 0) +
    (strategy.proofShards ? 6 : 0) +
    (strategy.handoffContractLint ? 4 : 0) +
    (strategy.leadAcceptanceGate ? 4 : 0) +
    (strategy.parallelRemediation && scenario.requiresParallelRemediation ? 8 : 0) -
    hookBlocks * 2 -
    (reasons.includes("proof-contract-drift-accepted") ? 18 : 0) -
    Math.max(0, round(contextRatio * 10) - 8);

  return {
    scenarioId: scenario.id,
    strategyId: strategy.id,
    status,
    visibility,
    governanceFit,
    score,
    contextRatio: round(contextRatio),
    testerPeak,
    hookBlocks,
    reports,
    parallelOwners,
    groups,
    reasons: unique(reasons),
  };
}

function expectStatus(results, scenarioId, strategyId, expectedStatus) {
  const hit = results.find(
    (result) => result.scenarioId === scenarioId && result.strategyId === strategyId,
  );
  if (!hit) {
    throw new Error(`Missing result for ${scenarioId} / ${strategyId}`);
  }
  if (hit.status !== expectedStatus) {
    throw new Error(
      `Expected ${scenarioId} / ${strategyId} -> ${expectedStatus}, got ${hit.status}`,
    );
  }
}

function expectBetter(results, scenarioId, betterStrategyId, worseStrategyId) {
  const better = results.find(
    (result) => result.scenarioId === scenarioId && result.strategyId === betterStrategyId,
  );
  const worse = results.find(
    (result) => result.scenarioId === scenarioId && result.strategyId === worseStrategyId,
  );
  if (!better || !worse) {
    throw new Error(`Missing result pair for ${scenarioId}`);
  }
  if (better.score <= worse.score) {
    throw new Error(
      `Expected ${betterStrategyId} to beat ${worseStrategyId} in ${scenarioId}, ` +
        `got ${better.score} <= ${worse.score}`,
    );
  }
}

function expectVisibility(results, scenarioId, strategyId, expectedVisibility) {
  const hit = results.find(
    (result) => result.scenarioId === scenarioId && result.strategyId === strategyId,
  );
  if (!hit) {
    throw new Error(`Missing result for ${scenarioId} / ${strategyId}`);
  }
  if (hit.visibility !== expectedVisibility) {
    throw new Error(
      `Expected ${scenarioId} / ${strategyId} visibility ${expectedVisibility}, got ${hit.visibility}`,
    );
  }
}

const results = [];
for (const scenario of scenarios) {
  for (const strategy of strategies) {
    results.push(simulateScenario(scenario, strategy));
  }
}

const assertions = [];

function runAssertion(label, fn) {
  try {
    fn();
    assertions.push({ label, ok: true });
  } catch (error) {
    assertions.push({ label, ok: false, error: error.message });
  }
}

runAssertion("baseline remains permissive on the truly small case", () => {
  expectStatus(results, "manageable-proof-small", "baseline-current", "PASS");
});

runAssertion("hook-only fixes the medium generated-proof case", () => {
  expectStatus(results, "generated-proof-medium", "hook-only", "PASS");
});

runAssertion("status-only does not solve generated-proof friction by itself", () => {
  expectStatus(results, "generated-proof-medium", "status-only", "HOLD");
});

runAssertion("incident-like overload still degrades under the baseline", () => {
  expectStatus(results, "incident-like-overload", "baseline-current", "PARTIAL");
});

runAssertion("phase split plus hook alignment clears the incident-like overload", () => {
  expectStatus(results, "incident-like-overload", "phase-split-plus-hook-alignment", "PASS");
});

runAssertion("phase split beats status-only on the incident-like overload", () => {
  expectBetter(results, "incident-like-overload", "phase-split-only", "status-only");
});

runAssertion("parallel remediation beats serial remediation", () => {
  expectBetter(
    results,
    "serial-remediation-trap",
    "phase-split-plus-parallel-remediation",
    "phase-split-only",
  );
});

runAssertion("full-system beats phase-split-only on unavoidable large proof", () => {
  expectBetter(
    results,
    "unavoidable-large-proof-surface",
    "full-system",
    "phase-split-only",
  );
});

runAssertion("unavoidable large proof still overloads without sharding", () => {
  expectStatus(results, "unavoidable-large-proof-surface", "phase-split-plus-hook-alignment", "PARTIAL");
});

runAssertion("full-system clears unavoidable large proof via sharding", () => {
  expectStatus(results, "unavoidable-large-proof-surface", "full-system", "PASS");
});

runAssertion("visibility-only scenario is opaque in the baseline", () => {
  expectVisibility(results, "working-but-invisible", "baseline-current", "opaque");
});

runAssertion("status-only clears observability on the visibility scenario", () => {
  expectVisibility(results, "working-but-invisible", "status-only", "clear");
});

runAssertion("hold-only is safer than baseline on overload", () => {
  expectBetter(results, "incident-like-overload", "hold-only", "baseline-current");
});

runAssertion("contract gates beat the baseline on explicit contract drift", () => {
  expectBetter(
    results,
    "contract-drift-adaptive-proof",
    "contract-gates-only",
    "baseline-current",
  );
});

runAssertion("full-system clears contract drift by avoiding the adaptive mismatch path", () => {
  expectStatus(results, "contract-drift-adaptive-proof", "full-system", "PASS");
});

const failures = assertions.filter((assertion) => !assertion.ok);

for (const scenario of scenarios) {
  console.log(`\n=== ${scenario.id} :: ${scenario.title} ===`);
  for (const note of scenario.notes) {
    console.log(`note: ${note}`);
  }
  const rows = results
    .filter((result) => result.scenarioId === scenario.id)
    .sort((left, right) => right.score - left.score);

  for (const row of rows) {
    console.log(
      [
        row.strategyId.padEnd(35, " "),
        `status=${row.status.padEnd(7, " ")}`,
        `visibility=${row.visibility.padEnd(7, " ")}`,
        `fit=${row.governanceFit.padEnd(21, " ")}`,
        `score=${String(row.score).padStart(3, " ")}`,
        `peak=${String(row.testerPeak).padStart(3, " ")}`,
        `ctx=${String(row.contextRatio).padStart(4, " ")}`,
        `hooks=${String(row.hookBlocks).padStart(2, " ")}`,
        `reports=${String(row.reports).padStart(2, " ")}`,
        `parallel=${String(row.parallelOwners).padStart(2, " ")}`,
        `reasons=${row.reasons.join(",") || "none"}`,
      ].join(" | "),
    );
  }
}

const aggregate = strategies
  .map((strategy) => {
    const rows = results.filter((result) => result.strategyId === strategy.id);
    return {
      strategyId: strategy.id,
      averageScore: round(sum(rows.map((row) => row.score)) / rows.length),
      passCount: rows.filter((row) => row.status === "PASS").length,
      failCount: rows.filter((row) => row.status === "FAIL").length,
      opaqueCount: rows.filter((row) => row.visibility === "opaque").length,
    };
  })
  .sort((left, right) => right.averageScore - left.averageScore);

console.log("\n=== aggregate-ranking ===");
for (const row of aggregate) {
  console.log(
    `${row.strategyId.padEnd(35, " ")} | avg=${String(row.averageScore).padStart(5, " ")} | ` +
      `passes=${row.passCount} | fails=${row.failCount} | opaque=${row.opaqueCount}`,
  );
}

console.log("\n=== assertions ===");
for (const assertion of assertions) {
  if (assertion.ok) {
    console.log(`PASS ${assertion.label}`);
  } else {
    console.log(`FAIL ${assertion.label}`);
    console.log(`  ${assertion.error}`);
  }
}

if (failures.length > 0) {
  console.error(`\nASSERTIONS_FAILED ${failures.length}`);
  process.exit(1);
}

console.log(`\nASSERTIONS_PASSED ${assertions.length}`);
NODE

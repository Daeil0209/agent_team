#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const workloadProfiles = [
  { id: "small", weight: 42, shardable: false, largeSurface: false },
  { id: "medium", weight: 68, shardable: false, largeSurface: false },
  { id: "overload", weight: 118, shardable: true, largeSurface: false },
  { id: "unavoidable-large", weight: 142, shardable: true, largeSurface: true },
];

const leadPlanningModes = [
  { id: "none", sizing: 0, phaseSplit: 0, planningQuality: 0 },
  { id: "thin", sizing: 0, phaseSplit: 0, planningQuality: 1 },
  { id: "explicit", sizing: 1, phaseSplit: 0, planningQuality: 2 },
  { id: "explicit-split", sizing: 1, phaseSplit: 1, planningQuality: 3 },
  { id: "explicit-split-sharded", sizing: 1, phaseSplit: 1, proofShards: 1, planningQuality: 4 },
];

const testerResponses = [
  { id: "silent-comply", hold: 0, replan: 0, truthfulMismatch: 0, initiative: 0 },
  { id: "status-only", hold: 0, replan: 0, truthfulMismatch: 0, initiative: 1 },
  { id: "truthful-mismatch", hold: 0, replan: 0, truthfulMismatch: 1, initiative: 2 },
  { id: "scope-pushback", hold: 1, replan: 0, truthfulMismatch: 1, initiative: 3 },
  { id: "replan-proposal", hold: 1, replan: 1, truthfulMismatch: 1, initiative: 4 },
];

const hookModes = [
  { id: "none", friction: 0, blocks: 0, contractPathMismatch: 0 },
  { id: "moderate", friction: 1, blocks: 2, contractPathMismatch: 0 },
  { id: "severe", friction: 2, blocks: 6, contractPathMismatch: 1 },
];

const visibilityModes = [
  { id: "weak", heartbeat: 0, interruptive: 0 },
  { id: "strong", heartbeat: 1, interruptive: 1 },
];

const remediationModes = [
  { id: "none", needsParallel: 0, parallelReady: 0 },
  { id: "serial-fix-needed", needsParallel: 1, parallelReady: 0 },
  { id: "parallel-fix-ready", needsParallel: 1, parallelReady: 1 },
];

const contractModes = [
  { id: "exact", driftRisk: 0 },
  { id: "adaptive-truthful", driftRisk: 1, truthfulAdaptive: 1 },
  { id: "adaptive-softened", driftRisk: 1, truthfulAdaptive: 0 },
];

function round(value) {
  return Math.round(value * 10) / 10;
}

function scoreCombo({ workload, lead, tester, hook, visibility, remediation, contract }) {
  const budget = 100;
  let effectiveWeight = workload.weight;
  let status = "PASS";
  const reasons = [];

  if (lead.phaseSplit) effectiveWeight -= workload.weight * 0.28;
  if (lead.proofShards && workload.shardable) effectiveWeight -= workload.weight * 0.24;
  if (remediation.parallelReady && remediation.needsParallel) effectiveWeight -= 18;
  if (hook.friction === 1) effectiveWeight += 12;
  if (hook.friction === 2) effectiveWeight += 32;

  const ctx = effectiveWeight / budget;

  if (lead.sizing && !lead.phaseSplit && workload.weight > 90 && tester.hold) {
    status = "HOLD";
    reasons.push("overscope-caught");
  } else if (ctx >= 1.2) {
    status = "FAIL";
    reasons.push("context-overflow");
  } else if (ctx >= 0.85) {
    status = "PARTIAL";
    reasons.push("context-pressure");
  }

  if (hook.contractPathMismatch && contract.driftRisk) {
    if (tester.truthfulMismatch) {
      if (status === "PASS") status = "PARTIAL";
      reasons.push("adaptive-mismatch-explicit");
    } else {
      if (status === "PASS") status = "PARTIAL";
      reasons.push("adaptive-mismatch-softened");
    }
  }

  if (remediation.needsParallel && !remediation.parallelReady) {
    if (status === "PASS") status = "PARTIAL";
    reasons.push("serial-remediation");
  }

  if (workload.largeSurface && !(lead.proofShards && lead.phaseSplit)) {
    if (status === "PASS") status = "PARTIAL";
    reasons.push("large-surface-unsharded");
  }

  let visibilityState = "clear";
  if (!visibility.heartbeat) {
    visibilityState = "opaque";
    reasons.push("working-but-invisible");
  }

  if (tester.replan) reasons.push("replan-proposal");
  if (tester.hold && status !== "HOLD" && workload.weight > 90) reasons.push("late-pushback");

  const governanceFit =
    status === "FAIL"
      ? "misaligned"
      : reasons.includes("adaptive-mismatch-softened") ||
          reasons.includes("working-but-invisible") ||
          reasons.includes("serial-remediation") ||
          reasons.includes("large-surface-unsharded")
        ? "costly"
        : reasons.includes("overscope-caught")
          ? "protective"
          : "aligned";

  const numeric =
    (status === "PASS" ? 90 : status === "PARTIAL" ? 60 : status === "HOLD" ? 40 : 10) +
    (visibilityState === "clear" ? 10 : 0) +
    lead.planningQuality * 8 +
    tester.initiative * 6 -
    hook.blocks * 3 -
    (reasons.includes("adaptive-mismatch-softened") ? 18 : 0) -
    (reasons.includes("working-but-invisible") ? 10 : 0);

  return {
    status,
    visibility: visibilityState,
    governanceFit,
    ctx: round(ctx),
    score: round(numeric),
    reasons,
  };
}

const rows = [];
for (const workload of workloadProfiles) {
  for (const lead of leadPlanningModes) {
    for (const tester of testerResponses) {
      for (const hook of hookModes) {
        for (const visibility of visibilityModes) {
          for (const remediation of remediationModes) {
            for (const contract of contractModes) {
              rows.push({
                workload: workload.id,
                lead: lead.id,
                tester: tester.id,
                hook: hook.id,
                visibility: visibility.id,
                remediation: remediation.id,
                contract: contract.id,
                ...scoreCombo({ workload, lead, tester, hook, visibility, remediation, contract }),
              });
            }
          }
        }
      }
    }
  }
}

function summarize(filterFn) {
  const subset = rows.filter(filterFn);
  const counts = { PASS: 0, PARTIAL: 0, HOLD: 0, FAIL: 0 };
  for (const row of subset) counts[row.status] += 1;
  return {
    total: subset.length,
    pass: counts.PASS,
    partial: counts.PARTIAL,
    hold: counts.HOLD,
    fail: counts.FAIL,
    avgScore: round(subset.reduce((acc, row) => acc + row.score, 0) / subset.length),
  };
}

const slices = [
  ["lead:none", (row) => row.lead === "none"],
  ["lead:explicit-split", (row) => row.lead === "explicit-split"],
  ["lead:explicit-split-sharded", (row) => row.lead === "explicit-split-sharded"],
  ["tester:silent-comply", (row) => row.tester === "silent-comply"],
  ["tester:scope-pushback", (row) => row.tester === "scope-pushback"],
  ["tester:replan-proposal", (row) => row.tester === "replan-proposal"],
  ["hook:none", (row) => row.hook === "none"],
  ["hook:severe", (row) => row.hook === "severe"],
  ["workload:overload", (row) => row.workload === "overload"],
  ["workload:unavoidable-large", (row) => row.workload === "unavoidable-large"],
  [
    "high-risk-baseline-shape",
    (row) =>
      row.lead === "none" &&
      row.tester === "silent-comply" &&
      row.hook === "severe" &&
      row.visibility === "opaque",
  ],
  [
    "best-practice-shape",
    (row) =>
      row.lead === "explicit-split-sharded" &&
      row.tester === "replan-proposal" &&
      row.hook === "none" &&
      row.visibility === "clear",
  ],
];

console.log(`TOTAL_COMBINATIONS ${rows.length}`);
console.log("\n=== slices ===");
for (const [label, predicate] of slices) {
  const s = summarize(predicate);
  console.log(
    `${label.padEnd(28, " ")} | total=${String(s.total).padStart(4, " ")} | pass=${String(s.pass).padStart(3, " ")} | partial=${String(s.partial).padStart(3, " ")} | hold=${String(s.hold).padStart(3, " ")} | fail=${String(s.fail).padStart(3, " ")} | avg=${String(s.avgScore).padStart(5, " ")}`,
  );
}

const worst = [...rows].sort((a, b) => a.score - b.score).slice(0, 12);
const best = [...rows].sort((a, b) => b.score - a.score).slice(0, 12);

function fmt(row) {
  return [
    `score=${String(row.score).padStart(4, " ")}`,
    `status=${row.status.padEnd(7, " ")}`,
    `ctx=${String(row.ctx).padStart(4, " ")}`,
    `lead=${row.lead}`,
    `tester=${row.tester}`,
    `hook=${row.hook}`,
    `vis=${row.visibility}`,
    `fix=${row.remediation}`,
    `contract=${row.contract}`,
    `reasons=${row.reasons.join(",") || "none"}`,
  ].join(" | ");
}

console.log("\n=== worst-12 ===");
for (const row of worst) console.log(fmt(row));

console.log("\n=== best-12 ===");
for (const row of best) console.log(fmt(row));

const assertions = [];
function assert(label, condition) {
  assertions.push({ label, ok: Boolean(condition) });
}

const overloadNoLead = summarize((row) => row.workload === "overload" && row.lead === "none");
const overloadSplit = summarize(
  (row) => row.workload === "overload" && row.lead === "explicit-split",
);
const overloadSharded = summarize(
  (row) => row.workload === "unavoidable-large" && row.lead === "explicit-split-sharded",
);
const overloadSilent = summarize(
  (row) => row.workload === "overload" && row.tester === "silent-comply",
);
const overloadReplan = summarize(
  (row) => row.workload === "overload" && row.tester === "replan-proposal",
);
const severeHook = summarize((row) => row.hook === "severe");
const noHook = summarize((row) => row.hook === "none");

assert("lead explicit split improves overload average score", overloadSplit.avgScore > overloadNoLead.avgScore);
assert("lead sharding improves unavoidable-large pass count", overloadSharded.pass > 0);
assert("tester replan beats silent comply on overload average score", overloadReplan.avgScore > overloadSilent.avgScore);
assert("severe hook is worse than no hook", severeHook.avgScore < noHook.avgScore);

console.log("\n=== assertions ===");
for (const a of assertions) {
  console.log(`${a.ok ? "PASS" : "FAIL"} ${a.label}`);
}

if (assertions.some((a) => !a.ok)) process.exit(1);
NODE

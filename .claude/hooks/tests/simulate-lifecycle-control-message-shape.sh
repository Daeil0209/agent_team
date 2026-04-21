#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "minimal-standby-control",
    packet: {
      messageClass: "control",
      lifecycleDecision: "standby",
      bodyKind: "empty",
    },
    expected: { classification: "lifecycle-only", risk: "none" },
  },
  {
    id: "standby-with-short-decision-basis",
    packet: {
      messageClass: "control",
      lifecycleDecision: "standby",
      bodyKind: "decision-basis",
      body: "Handoff received and accepted.",
    },
    expected: { classification: "lifecycle-only", risk: "low" },
  },
  {
    id: "standby-with-handoff-recap",
    packet: {
      messageClass: "control",
      lifecycleDecision: "standby",
      bodyKind: "handoff-recap",
      body: "Received handoff; categories a-e classified; residual uncertainties 3; standby approved, recall if another round is needed.",
    },
    expected: { classification: "overloaded-control", risk: "high" },
  },
  {
    id: "reuse-with-future-reroute-hint",
    packet: {
      messageClass: "control",
      lifecycleDecision: "reuse",
      bodyKind: "future-hint",
      body: "Keep this in mind for later review escalation if needed.",
    },
    expected: { classification: "overloaded-control", risk: "high" },
  },
  {
    id: "assignment-packet-separate",
    packet: {
      messageClass: "assignment",
      lifecycleDecision: null,
      bodyKind: "assignment",
      body: "New review request for the same surface.",
    },
    expected: { classification: "assignment-grade", risk: "none" },
  },
];

function classify(packet) {
  if (packet.messageClass !== "control") {
    return { classification: "assignment-grade", risk: "none", reasons: [] };
  }

  const reasons = [];
  let classification = "lifecycle-only";
  let risk = "none";

  if (!packet.lifecycleDecision) {
    classification = "invalid-control";
    risk = "high";
    reasons.push("missing-lifecycle-decision");
    return { classification, risk, reasons };
  }

  if (packet.bodyKind === "decision-basis" || packet.bodyKind === "empty") {
    risk = packet.bodyKind === "empty" ? "none" : "low";
    return { classification, risk, reasons };
  }

  if (["handoff-recap", "future-hint", "renewed-scope", "residual-summary"].includes(packet.bodyKind)) {
    classification = "overloaded-control";
    risk = "high";
    reasons.push("body-can-be-read-as-new-work");
  }

  return { classification, risk, reasons };
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

for (const scenario of scenarios) {
  const actual = classify(scenario.packet);
  console.log(`\n=== ${scenario.id} ===`);
  console.log(JSON.stringify(actual));
  assert(
    actual.classification === scenario.expected.classification,
    `${scenario.id} classification`,
    JSON.stringify({ expected: scenario.expected, actual, packet: scenario.packet }, null, 2)
  );
  assert(
    actual.risk === scenario.expected.risk,
    `${scenario.id} risk`,
    JSON.stringify({ expected: scenario.expected, actual, packet: scenario.packet }, null, 2)
  );
}

const overloaded = scenarios
  .filter((s) => classify(s.packet).classification === "overloaded-control")
  .map((s) => s.id);
assert(
  overloaded.includes("standby-with-handoff-recap") &&
    overloaded.includes("reuse-with-future-reroute-hint"),
  "recap and future-hint control bodies are treated as overloaded control",
  overloaded.join(",")
);

const safeControls = scenarios
  .filter((s) => classify(s.packet).classification === "lifecycle-only")
  .map((s) => s.id);
assert(
  safeControls.includes("minimal-standby-control") &&
    safeControls.includes("standby-with-short-decision-basis"),
  "minimal lifecycle-only control remains valid",
  safeControls.join(",")
);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 12");
NODE

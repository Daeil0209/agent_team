#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const requiredSkills = "work-planning(start), self-verification(plan-verify, handoff)";

const scenarios = [
  {
    id: "authored-audit-review-with-evidence-check",
    kind: "artifact-review-plus-research",
    workSurface: "governance audit report + bounded repo/hook surfaces",
    currentPhase: "governance-review",
    artifact: "existing governance audit report",
    sourceFamily: "mixed",
    immediateLanes: ["researcher", "reviewer"],
    deferredLanes: [],
  },
  {
    id: "fresh-governance-evidence-sweep",
    kind: "research-only",
    workSurface: "broad governance surfaces",
    currentPhase: "governance-analysis",
    artifact: null,
    sourceFamily: "repo",
    immediateLanes: ["researcher"],
    deferredLanes: [],
  },
  {
    id: "bounded-single-artifact-review",
    kind: "review-only",
    workSurface: "single authored artifact under review",
    currentPhase: "artifact-review",
    artifact: "single authored artifact",
    sourceFamily: "repo",
    immediateLanes: ["reviewer"],
    deferredLanes: [],
  },
  {
    id: "design-proposal-review-with-fact-check",
    kind: "artifact-review-plus-research",
    workSurface: "design proposal + surrounding implementation surfaces",
    currentPhase: "design-review",
    artifact: "design proposal",
    sourceFamily: "repo",
    immediateLanes: ["researcher", "reviewer"],
    deferredLanes: [],
  },
  {
    id: "implementation-kickoff-with-acceptance-pipeline",
    kind: "implementation-pipeline",
    workSurface: "bounded product change surface",
    currentPhase: "implementation",
    artifact: null,
    sourceFamily: "repo",
    immediateLanes: ["developer"],
    deferredLanes: ["reviewer", "tester", "validator"],
  },
];

function buildResearcherPacket(s) {
  return {
    lane: "researcher",
    "MESSAGE-CLASS": "assignment",
    "WORK-SURFACE": s.workSurface,
    "CURRENT-PHASE": s.currentPhase,
    "REQUIRED-SKILLS": requiredSkills,
    "WORKER-FIT": "researcher lane matches evidence expansion and contradiction mapping",
    "SCOPE-MATCH": "bounded to evidence expansion only",
    "PRIOR-ANALYSIS": "included",
    "RESEARCH-MODE": s.kind === "research-only" ? "deep" : "bounded",
    "DECISION-TARGET": s.artifact ? `grounding and support quality for ${s.artifact}` : "governance contradiction and evidence map",
    "QUESTION-BOUNDARY": s.artifact
      ? `verify whether the authored artifact's claims are supported without deciding implementation fixes`
      : "map contradictions, observed friction, and evidence classes only",
    "OUTPUT-SURFACE": s.artifact ? "evidence packet for reviewer + team-lead synthesis" : "evidence inventory handoff",
    "SOURCE-FAMILY": s.sourceFamily,
    "DOWNSTREAM-CONSUMER": s.artifact ? "reviewer + team-lead" : "team-lead",
  };
}

function buildReviewerPacket(s) {
  const concurrentResearch = s.immediateLanes.includes("researcher");
  return {
    lane: "reviewer",
    "MESSAGE-CLASS": "assignment",
    "WORK-SURFACE": s.workSurface,
    "CURRENT-PHASE": s.currentPhase,
    "REQUIRED-SKILLS": requiredSkills,
    "WORKER-FIT": "reviewer lane matches independent judgment and finding classification",
    "SCOPE-MATCH": "bounded to review and classification only",
    "PRIOR-ANALYSIS": "included",
    "REVIEW-TARGET": s.artifact ?? "current artifact under review",
    "REVIEW-SCOPE": s.artifact
      ? `review the authored artifact and classify only the supported findings on that surface`
      : "review the bounded artifact under the supplied acceptance surface",
    "PREREQ-STATE": concurrentResearch ? "partial" : "complete",
    "EVIDENCE-BASIS": concurrentResearch
      ? "supplied artifact + bounded repository evidence + active researcher delta as available"
      : "supplied artifact + bounded supporting evidence",
    "ACCEPTANCE-RISK": "meaningful",
    "ACCEPTANCE-SURFACE": s.artifact
      ? "defect class, support quality, severity, and priority claims on the reviewed artifact"
      : "review findings and gate status on the reviewed artifact",
  };
}

function buildDeveloperPacket(s) {
  return {
    lane: "developer",
    "MESSAGE-CLASS": "assignment",
    "WORK-SURFACE": s.workSurface,
    "CURRENT-PHASE": s.currentPhase,
    "REQUIRED-SKILLS": requiredSkills,
    "WORKER-FIT": "developer lane matches bounded implementation",
    "SCOPE-MATCH": "bounded to implementation only",
    "PRIOR-ANALYSIS": "included",
    "PLAN-STATE": "ready",
    "PLAN-STEP": "implementation",
    "ACCEPTANCE-RISK": "high",
    "REVIEW-OWNER": "reviewer",
    "PROOF-OWNER": "tester",
    "ACCEPTANCE-OWNER": "validator",
    "CHANGE-SPEC": "bounded-change",
    "CHANGE-BOUNDARY": "implement the named fix without absorbing review, proof, or verdict work",
    "EXCLUDED-SCOPE": "do not self-certify review, testing, or final acceptance",
    "DONE-CONDITION": "bounded implementation delta complete and ready for downstream review/proof",
    "OUTPUT-SURFACE": "changed artifact set for downstream review/proof",
  };
}

function buildTaskRow(packet) {
  const scope =
    packet["QUESTION-BOUNDARY"] ||
    packet["CHANGE-BOUNDARY"] ||
    packet["EXCLUDED-SCOPE"] ||
    packet["WORK-SURFACE"];
  const completion =
    packet["OUTPUT-SURFACE"] ||
    packet["ACCEPTANCE-SURFACE"] ||
    packet["PROOF-TARGET"] ||
    packet["DECISION-SURFACE"];
  return {
    subject: `${packet.lane} ${packet["CURRENT-PHASE"]}`.trim(),
    description: `WORK-SURFACE: ${packet["WORK-SURFACE"]}; SCOPE: ${scope}; COMPLETION: ${completion}`,
  };
}

function buildImmediatePackets(s) {
  return s.immediateLanes.map((lane) => {
    if (lane === "researcher") return buildResearcherPacket(s);
    if (lane === "reviewer") return buildReviewerPacket(s);
    if (lane === "developer") return buildDeveloperPacket(s);
    throw new Error(`Unsupported immediate lane: ${lane}`);
  });
}

function validateCommon(packet) {
  const required = ["MESSAGE-CLASS", "WORK-SURFACE", "CURRENT-PHASE", "REQUIRED-SKILLS", "WORKER-FIT", "SCOPE-MATCH", "PRIOR-ANALYSIS"];
  return required.filter((field) => !packet[field]);
}

function validateResearcher(packet) {
  const required = ["RESEARCH-MODE", "DECISION-TARGET", "QUESTION-BOUNDARY", "OUTPUT-SURFACE", "SOURCE-FAMILY", "DOWNSTREAM-CONSUMER"];
  return required.filter((field) => !packet[field]);
}

function validateReviewer(packet) {
  const required = ["REVIEW-TARGET", "REVIEW-SCOPE", "PREREQ-STATE", "EVIDENCE-BASIS", "ACCEPTANCE-RISK", "ACCEPTANCE-SURFACE"];
  return required.filter((field) => !packet[field]);
}

function validateDeveloper(packet) {
  const required = [
    "PLAN-STATE",
    "PLAN-STEP",
    "ACCEPTANCE-RISK",
    "REVIEW-OWNER",
    "PROOF-OWNER",
    "ACCEPTANCE-OWNER",
    "CHANGE-SPEC",
    "CHANGE-BOUNDARY",
    "EXCLUDED-SCOPE",
    "DONE-CONDITION",
    "OUTPUT-SURFACE",
  ];
  return required.filter((field) => !packet[field]);
}

function validateTaskRow(row) {
  const failures = [];
  if (!row.subject) failures.push("subject");
  if (!row.description.includes("WORK-SURFACE:")) failures.push("work-surface");
  if (!row.description.includes("SCOPE:")) failures.push("scope");
  if (!row.description.includes("COMPLETION:")) failures.push("completion");
  return failures;
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
  const packets = buildImmediatePackets(scenario);
  console.log(`\n=== ${scenario.id} ===`);
  for (const packet of packets) {
    console.log(`${packet.lane}: ${JSON.stringify(packet)}`);
    const commonMissing = validateCommon(packet);
    assert(commonMissing.length === 0, `${scenario.id} ${packet.lane} common packet completeness`, commonMissing.join(", "));

    let laneMissing = [];
    if (packet.lane === "researcher") laneMissing = validateResearcher(packet);
    if (packet.lane === "reviewer") laneMissing = validateReviewer(packet);
    if (packet.lane === "developer") laneMissing = validateDeveloper(packet);
    assert(laneMissing.length === 0, `${scenario.id} ${packet.lane} lane packet completeness`, laneMissing.join(", "));

    const taskRow = buildTaskRow(packet);
    const taskMissing = validateTaskRow(taskRow);
    assert(taskMissing.length === 0, `${scenario.id} ${packet.lane} task row completeness`, JSON.stringify(taskRow, null, 2));
  }
}

const auditPackets = buildImmediatePackets(scenarios.find((s) => s.id === "authored-audit-review-with-evidence-check"));
assert(
  auditPackets.some((packet) => packet.lane === "researcher") &&
    auditPackets.some((packet) => packet.lane === "reviewer"),
  "artifact review with evidence check emits both researcher and reviewer packets"
);

const freshSweepPackets = buildImmediatePackets(scenarios.find((s) => s.id === "fresh-governance-evidence-sweep"));
assert(
  freshSweepPackets.length === 1 && freshSweepPackets[0].lane === "researcher",
  "fresh evidence sweep emits researcher packet only"
);

const boundedReviewPackets = buildImmediatePackets(scenarios.find((s) => s.id === "bounded-single-artifact-review"));
assert(
  boundedReviewPackets.length === 1 && boundedReviewPackets[0].lane === "reviewer",
  "bounded artifact review emits reviewer packet only"
);

const implPackets = buildImmediatePackets(scenarios.find((s) => s.id === "implementation-kickoff-with-acceptance-pipeline"));
const developerPacket = implPackets[0];
assert(
  developerPacket["REVIEW-OWNER"] === "reviewer" &&
    developerPacket["PROOF-OWNER"] === "tester" &&
    developerPacket["ACCEPTANCE-OWNER"] === "validator",
  "implementation kickoff keeps acceptance pipeline explicit",
  JSON.stringify(developerPacket, null, 2)
);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 20");
NODE

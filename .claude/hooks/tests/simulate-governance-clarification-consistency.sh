#!/usr/bin/env bash
set -euo pipefail

cd /mnt/d/Agent_team

pass() { printf 'PASS %s\n' "$1"; }
fail() { printf 'FAIL %s\n' "$1"; exit 1; }

grep -qF '§Supervisor Decisions on Turn-Ended Signals' .claude/skills/session-boot/SKILL.md \
  && pass "session-boot skill anchor points to Turn-Ended Signals" \
  || fail "session-boot skill anchor still stale"

for field in continuityWritePath globalContinuityMirrorPath lastSessionEndTimestamp; do
  grep -qF "\`$field\`" .claude/skills/session-boot/reference.md \
    && pass "schema includes $field" \
    || fail "schema missing $field"
done

grep -qF 'permission-request-gate.sh' .claude/hooks/lib/hook-policy.sh \
  && pass "hook health required list includes permission-request-gate" \
  || fail "hook health required list missing permission-request-gate"

grep -qF 'is_governance_restricted_write_path()' .claude/hooks/compliance-supervisor.sh \
  && pass "renamed governance path helper exists" \
  || fail "renamed governance path helper missing"

if grep -qF 'is_high_traffic_governance_surface_path()' .claude/hooks/compliance-supervisor.sh; then
  fail "old high-traffic helper name still present"
else
  pass "old high-traffic helper name removed"
fi

grep -qF 'is_governance_restricted_write_path "$CANONICAL_PATH"' .claude/hooks/compliance-supervisor.sh \
  && pass "call site updated to renamed helper" \
  || fail "call site still stale"

printf '\nASSERTIONS_PASSED 7\n'

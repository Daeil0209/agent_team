#!/usr/bin/env bash

pipe_list_has_token() {
  local list="${1-}"
  local token="${2-}"
  local item=""

  [[ -n "$list" ]] || return 1
  [[ -n "$token" ]] || return 1

  IFS='|' read -r -a _pipe_items <<< "$list"
  for item in "${_pipe_items[@]}"; do
    [[ "$item" == "$token" ]] && return 0
  done
  return 1
}

resolve_requested_dispatch_name() {
  local explicit_name="${1-}"
  local description="${2-}"
  local resolved_id=""
  local fallback_name=""
  local canonical_name=""

  explicit_name="$(printf '%s' "$explicit_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$explicit_name" ]]; then
    if canonical_name="$(canonical_registered_role_name "$explicit_name" 2>/dev/null)"; then
      printf '%s' "$canonical_name"
    else
      printf '%s' "$explicit_name"
    fi
    return 0
  fi

  resolved_id="$(resolve_agent_id "$description")"
  if [[ "$resolved_id" != "unknown" ]]; then
    printf '%s' "$resolved_id"
    return 0
  fi

  fallback_name="$(printf '%s' "$description" | sed -n 's/^\([a-zA-Z0-9_-]*\):.*/\1/p')"
  fallback_name="$(printf '%s' "$fallback_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$fallback_name" ]]; then
    if canonical_name="$(canonical_registered_role_name "$fallback_name" 2>/dev/null)"; then
      printf '%s' "$canonical_name"
    else
      printf '%s' "$fallback_name"
    fi
    return 0
  fi

  printf 'unknown'
}

normalize_skill_id() {
  local raw="${1-}"
  local normalized=""
  local canonical_skill=""

  normalized="$(printf '%s' "$raw" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/^[`"'\''[:space:]]*//; s/[`"'\''[:space:]]*$//')"
  if canonical_skill="$(canonical_registered_skill_id "$normalized" 2>/dev/null)"; then
    printf '%s' "$canonical_skill"
    return 0
  fi

  if [[ "$normalized" == */SKILL.md ]]; then
    normalized="$(basename "$(dirname "$normalized")")"
  elif [[ "$normalized" == */* ]]; then
    normalized="$(basename "$normalized")"
  else
    normalized="${normalized##*:}"
  fi
  normalized="$(printf '%s' "$normalized" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  printf '%s' "$normalized"
}

resolve_active_skill_path() {
  local skill_id=""
  skill_id="$(normalize_skill_id "${1-}")"
  printf '%s' "$PROJECT_SKILLS_ROOT/$skill_id/SKILL.md"
}

active_skill_exists() {
  local skill_id=""
  local skill_path=""

  skill_id="$(normalize_skill_id "${1-}")"
  [[ -n "$skill_id" ]] || return 1
  skill_registry_has_name "$skill_id" || return 1
  skill_path="$(resolve_active_skill_path "$skill_id")"
  [[ -f "$skill_path" ]]
}

normalize_lane_id() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

canonicalize_runtime_lane_id() {
  local raw=""
  raw="$(normalize_lane_id "${1-}")"

  case "$raw" in
    *:*)
      raw="${raw#*:}"
      ;;
  esac

  printf '%s' "$raw"
}

normalize_surface_id() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed -E 's/\|/%7C/g; s/[[:space:]]+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

sanitize_ledger_field() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '\n' ' ' | sed -E 's/\|/%7C/g; s/[[:space:]]+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

specialist_skill_requires_explicit_approval() {
  local skill_id=""
  skill_id="$(normalize_skill_id "${1-}")"
  pipe_list_has_token "$SPECIALIST_SKILLS_REQUIRING_APPROVAL" "$skill_id" && active_skill_exists "$skill_id"
}

role_local_skill_owner_role() {
  local skill_id=""
  local canonical_role=""
  skill_id="$(normalize_skill_id "${1-}")"
  [[ -n "$skill_id" ]] || return 1
  active_skill_exists "$skill_id" || return 1

  if canonical_role="$(canonical_registered_agent_name "$skill_id" 2>/dev/null)"; then
    printf '%s' "$canonical_role"
    return 0
  fi

  return 1
}

role_local_skill_requires_matching_role() {
  role_local_skill_owner_role "${1-}" >/dev/null
}

skill_requires_explicit_approval() {
  specialist_skill_requires_explicit_approval "${1-}"
}

resolve_agent_id() {
  local desc="${1:-}"
  local prefix=""
  local lower_desc=""
  local canonical_name=""

  if canonical_name="$(canonical_registered_role_name "$desc" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return
  fi

  prefix="$(printf '%s' "$desc" | sed -n 's/^\([a-zA-Z_-]*\):.*/\1/p' | tr '[:upper:]' '[:lower:]')"
  if canonical_name="$(canonical_registered_role_name "$prefix" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return
  fi

  case "$prefix" in
    team-lead|teamlead|lead) echo "team-lead"; return ;;
    researcher) echo "researcher"; return ;;
    developer|dev-[a-z]) echo "developer"; return ;;
    int-op|integration-operator) echo "int-op"; return ;;
    reviewer) echo "reviewer"; return ;;
    tester) echo "tester"; return ;;
    validator|val-ref) echo "validator"; return ;;
    sw-spec) echo "sw-spec"; return ;;
    biz-sys) echo "biz-sys"; return ;;
    ui-ux) echo "ui-ux"; return ;;
    edu-spec) echo "edu-spec"; return ;;
    eng-spec) echo "eng-spec"; return ;;
    math-spec) echo "math-spec"; return ;;
    doc-auto) echo "doc-auto"; return ;;
    bench-sim) echo "bench-sim"; return ;;
  esac

  lower_desc="$(printf '%s' "$desc" | tr '[:upper:]' '[:lower:]')"
  case "$lower_desc" in
    *team-lead*|*team\ lead*) echo "team-lead"; return ;;
    *integration?operator*|*int-op*) echo "int-op"; return ;;
    *validate?against?reference*|*validator*|*val-ref*) echo "validator"; return ;;
    *software?specialist*|*software?spec*|*sw-spec*) echo "sw-spec"; return ;;
    *business?system*|*biz-sys*) echo "biz-sys"; return ;;
    *ui?ux?specialist*|*ui-ux*) echo "ui-ux"; return ;;
    *education?specialist*|*edu-spec*) echo "edu-spec"; return ;;
    *engineering?specialist*|*eng-spec*) echo "eng-spec"; return ;;
    *mathematics?specialist*|*math-spec*) echo "math-spec"; return ;;
    *document?automation*|*doc-auto*) echo "doc-auto"; return ;;
    *benchmark?simulator*|*bench-sim*) echo "bench-sim"; return ;;
    *researcher*) echo "researcher"; return ;;
    *developer*) echo "developer"; return ;;
    *reviewer*) echo "reviewer"; return ;;
    *tester*) echo "tester"; return ;;
  esac

  echo "unknown"
}

get_agent_category() {
  local id="${1:-}"
  case "$id" in
    researcher) echo "research" ;;
    developer|int-op) echo "implementation" ;;
    reviewer|tester) echo "review" ;;
    validator) echo "validation" ;;
    sw-spec|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto) echo "specialist" ;;
    bench-sim) echo "meta" ;;
    *)
      if skill_registry_has_name "$id"; then
        echo "specialist"
      else
        echo "other"
      fi
      ;;
  esac
}

check_agent_property() {
  local id="${1:-}"
  local prop="${2:-}"

  case "$prop" in
    requires_mode_auto)
      case "$id" in
        developer|int-op) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    requires_plan)
      case "$id" in
        developer|sw-spec|int-op) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    plan_exempt)
      case "$id" in
        researcher|reviewer|tester|validator|bench-sim|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    *)
      echo "false"
      ;;
  esac
}

is_subagent() {
  local input="${1:-}"
  if [[ -z "$input" ]]; then
    echo "false"
    return
  fi
  INPUT_JSON="$input" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(input.agent_id ? "true" : "false");
} catch {
  process.stdout.write("false");
}
NODE
}

normalize_dispatch_text() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

declare -gA DISPATCH_FIELD_CACHE_VALUES=()
DISPATCH_FIELD_CACHE_SOURCE=""

dispatch_reset_field_cache() {
  unset DISPATCH_FIELD_CACHE_VALUES
  declare -gA DISPATCH_FIELD_CACHE_VALUES=()
  DISPATCH_FIELD_CACHE_SOURCE=""
}

dispatch_populate_field_cache() {
  local raw_desc="${1-}"
  local key=""
  local value=""
  local role_name_pattern=""

  dispatch_reset_field_cache
  DISPATCH_FIELD_CACHE_SOURCE="$raw_desc"
  [[ -n "$raw_desc" ]] || return 0

  ensure_role_name_registry
  if [[ -f "$ROLE_NAME_REGISTRY_FILE" ]]; then
    role_name_pattern="$(sed 's/[][(){}.^$*+?|\\]/\\&/g' "$ROLE_NAME_REGISTRY_FILE" 2>/dev/null | paste -sd'|' -)"
  fi

  while IFS=$'\t' read -r key value; do
    [[ -n "$key" ]] || continue
    if [[ -z "${DISPATCH_FIELD_CACHE_VALUES[$key]+_}" ]]; then
      DISPATCH_FIELD_CACHE_VALUES["$key"]="$value"
    fi
  done < <(
    printf '%s\n' "$raw_desc" | awk -v role_pattern="$role_name_pattern" -v alias_pattern='teamlead|lead|integration-operator|val-ref|dev-[[:alnum:]_-]+' '
      BEGIN {
        IGNORECASE = 1
        split(role_pattern, role_entries, /\|/)
        for (idx in role_entries) {
          if (role_entries[idx] != "") {
            known_roles[role_entries[idx]] = 1
          }
        }
      }
      {
        line = $0
        while (length(line) > 0) {
          split_index = index(line, ";")
          if (split_index > 0) {
            segment = substr(line, 1, split_index - 1)
            line = substr(line, split_index + 1)
          } else {
            segment = line
            line = ""
          }

          gsub(/^[[:space:]]+|[[:space:]]+$/, "", segment)
          if (segment == "") {
            continue
          }

          if (match(segment, /^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$/, prefixed_parts)) {
            prefix = tolower(prefixed_parts[1])
            if (known_roles[prefix] || (alias_pattern != "" && prefix ~ ("^(" alias_pattern ")$"))) {
              key = tolower(prefixed_parts[2])
              value = prefixed_parts[3]
              gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
              if (length(key) > 0 && length(value) > 0) {
                printf "%s\t%s\n", key, value
              }
              continue
            }
          }

          if (match(segment, /^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$/, parts)) {
            key = tolower(parts[1])
            value = parts[2]
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
            if (length(key) > 0 && length(value) > 0) {
              printf "%s\t%s\n", key, value
            }
          }
        }
      }
    '
  )
}

dispatch_is_manifest_sync_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1

  if [[ "$desc" == *"task-class: manifest-sync"* ]]; then
    return 0
  fi

  # If TASK-CLASS is explicitly set to a different value, respect that classification
  # Use original text for field lookup: normalize_dispatch_text collapses
  # newlines to spaces, causing the awk field parser to absorb fields that
  # started on separate lines into the preceding field value.
  # Pattern matching (lines below) still uses normalized $desc.
  if dispatch_field_present "${1-}" "task-class"; then
    return 1
  fi

  if printf '%s' "$desc" | grep -Eq "$MANIFEST_SYNC_DISPATCH_VERB_PATTERN" \
    && printf '%s' "$desc" | grep -Eq "$MANIFEST_SYNC_DISPATCH_SCOPE_PATTERN"; then
    return 0
  fi

  return 1
}

dispatch_field_present() {
  local raw_value=""
  raw_value="$(dispatch_field_raw_value "${1-}" "${2-}" 2>/dev/null || true)"
  [[ -n "$raw_value" ]]
}

dispatch_field_value_matches() {
  local raw_value=""
  local field=""
  local value_pattern=""
  field="$(normalize_dispatch_text "${2-}")"
  value_pattern="${3-}"

  [[ -n "$field" && -n "$value_pattern" ]] || return 1
  raw_value="$(dispatch_field_raw_value "${1-}" "$field" 2>/dev/null || true)"
  [[ -n "$raw_value" ]] || return 1
  raw_value="$(normalize_dispatch_text "$raw_value")"
  printf '%s' "$raw_value" | grep -Eq "^(${value_pattern})$"
}

dispatch_field_raw_value() {
  local field=""
  local raw_desc="${1-}"
  field="$(normalize_dispatch_text "${2-}")"

  [[ -n "$raw_desc" && -n "$field" ]] || return 1

  if [[ "$DISPATCH_FIELD_CACHE_SOURCE" != "$raw_desc" ]]; then
    dispatch_populate_field_cache "$raw_desc"
  fi

  if [[ -n "${DISPATCH_FIELD_CACHE_VALUES[$field]+_}" ]]; then
    printf '%s' "${DISPATCH_FIELD_CACHE_VALUES[$field]}"
    return 0
  fi

  return 1
}

dispatch_field_pipe_list_matches() {
  local raw_value=""
  local allowed_pattern=""
  local entry=""
  raw_value="$(dispatch_field_raw_value "${1-}" "${2-}")"
  allowed_pattern="${3-}"

  [[ -n "$raw_value" && -n "$allowed_pattern" ]] || return 1

  IFS='|' read -r -a entries <<< "$raw_value"
  for entry in "${entries[@]}"; do
    entry="$(normalize_dispatch_text "$entry")"
    if [[ -z "$entry" ]] || ! printf '%s' "$entry" | grep -Eq "^(${allowed_pattern})$"; then
      return 1
    fi
  done

  return 0
}

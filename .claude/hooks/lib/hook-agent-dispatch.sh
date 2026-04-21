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

canonical_dispatch_agent_name() {
  local raw="${1-}"
  local canonical_name=""

  if canonical_name="$(canonical_registered_agent_name "$raw" 2>/dev/null)"; then
    if agent_registry_has_name "$canonical_name"; then
      printf '%s' "$canonical_name"
      return 0
    fi
  fi

  return 1
}

dispatch_target_is_dispatchable_agent() {
  local lane=""

  lane="$(resolve_agent_id "${1-}")"
  [[ -n "$lane" && "$lane" != "unknown" && "$lane" != "team-lead" ]] || return 1
  agent_registry_has_name "$lane"
}

resolve_agent_id() {
  local desc="${1:-}"
  local prefix=""
  local lower_desc=""
  local canonical_name=""

  if canonical_name="$(canonical_dispatch_agent_name "$desc" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return
  fi

  prefix="$(printf '%s' "$desc" | sed -n 's/^\([a-zA-Z_-]*\):.*/\1/p' | tr '[:upper:]' '[:lower:]')"
  if canonical_name="$(canonical_dispatch_agent_name "$prefix" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return
  fi

  case "$prefix" in
    team-lead|teamlead|lead) echo "team-lead"; return ;;
    researcher) echo "researcher"; return ;;
    developer|dev-[a-z]*) echo "developer"; return ;;
    reviewer) echo "reviewer"; return ;;
    tester) echo "tester"; return ;;
    validator|val-ref) echo "validator"; return ;;
  esac

  lower_desc="$(printf '%s' "$desc" | tr '[:upper:]' '[:lower:]')"
  case "$lower_desc" in
    *team-lead*|*team\ lead*) echo "team-lead"; return ;;
    *validate?against?reference*|*validator*|*val-ref*) echo "validator"; return ;;
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

dispatch_field_present() {
  local raw_value=""
  raw_value="$(dispatch_field_raw_value "${1-}" "${2-}" 2>/dev/null || true)"
  [[ -n "$raw_value" ]]
}

dispatch_field_raw_value() {
  local field=""
  local raw_desc="${1-}"
  field="$(normalize_dispatch_text "${2-}")"

  [[ -n "$raw_desc" && -n "$field" ]] || return 0

  if [[ "$DISPATCH_FIELD_CACHE_SOURCE" != "$raw_desc" ]]; then
    dispatch_populate_field_cache "$raw_desc"
  fi

  if [[ -n "${DISPATCH_FIELD_CACHE_VALUES[$field]+_}" ]]; then
    printf '%s' "${DISPATCH_FIELD_CACHE_VALUES[$field]}"
    return 0
  fi

  return 0
}

dispatch_field_declared_empty() {
  local raw_desc="${1-}"
  local field=""
  field="$(normalize_dispatch_text "${2-}")"

  [[ -n "$raw_desc" && -n "$field" ]] || return 1

  printf '%s\n' "$raw_desc" | awk -v field="$field" '
    BEGIN {
      IGNORECASE = 1
      found = 0
    }
    {
      if (match($0, /^[[:space:]]*([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*$/, parts)) {
        key = tolower(parts[1])
        if (key == field) {
          found = 1
          exit
        }
      }
    }
    END {
      exit(found ? 0 : 1)
    }
  '
}

dispatch_field_empty_header_has_body() {
  local raw_desc="${1-}"
  local field=""
  field="$(normalize_dispatch_text "${2-}")"

  [[ -n "$raw_desc" && -n "$field" ]] || return 1

  printf '%s\n' "$raw_desc" | awk -v field="$field" '
    BEGIN {
      IGNORECASE = 1
      pending = 0
      continuation = 0
    }
    {
      if (pending) {
        if (match($0, /^[[:space:]]*([[:alnum:]_-]+)[[:space:]]*:/, parts)) {
          exit
        }
        if ($0 ~ /^[[:space:]]*$/) {
          next
        }
        continuation = 1
        exit
      }

      if (match($0, /^[[:space:]]*([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*$/, parts)) {
        key = tolower(parts[1])
        if (key == field) {
          pending = 1
        }
      }
    }
    END {
      exit(continuation ? 0 : 1)
    }
  '
}

dispatch_field_format_hint() {
  local raw_desc="${1-}"
  local field_label="${2-}"

  [[ -n "$raw_desc" && -n "$field_label" ]] || return 0

  if dispatch_field_declared_empty "$raw_desc" "$field_label"; then
    if dispatch_field_empty_header_has_body "$raw_desc" "$field_label"; then
      printf '%s' "${field_label} is present as an empty header with multiline body. Hook parsing requires same-line 'KEY: value'; keep a one-line summary on the header line and move bullets under DETAILS."
      return 0
    fi

    printf '%s' "${field_label} header is present but empty. Hook parsing treats empty headers as missing until the value is placed on the same line."
  fi
}

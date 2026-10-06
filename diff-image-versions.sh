#!/usr/bin/env bash
################################################################################
##  File:  diff-image-versions.sh
##  Desc:  Compare software versions between two runner image releases
##  Usage: ./diff-image-versions.sh <os-name> <version1> <version2>
##
##  Example:
##    ./diff-image-versions.sh ubuntu22 20251102.127 20251125.163
##    ./diff-image-versions.sh win25 20251102.77 20251125.122
##    ./diff-image-versions.sh macos-14 20251102.0024 20251125.0031
################################################################################

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<USAGE
Usage: $(basename "${0}") <os-name> <version1> <version2>

Compare runner image versions and display software changes.

Arguments:
  os-name    OS identifier (ubuntu22, ubuntu24, ubuntu26, win22, win25,
             win11, macos-14, macos-15, macos-26, and arm64 variants)
  version1   Earlier version (YYYYMMDD.NNN)
  version2   Later version (YYYYMMDD.NNN)

Examples:
  $(basename "${0}") ubuntu22 20251102.127 20251125.163
  $(basename "${0}") win25 20251102.77 20251125.122
  $(basename "${0}") macos-14 20251102.0024 20251125.0031
USAGE
}

resolve_readme_path() {
  local os_name="${1}"
  local folder=""
  local pattern=""
  local candidate=""
  local version=""
  local -a matches=()

  case "${os_name}" in
    ubuntu22|ubuntu24|ubuntu26)
      folder="ubuntu"
      version="${os_name#ubuntu}"
      pattern="Ubuntu${version}04-Readme.md"
      ;;
    ubuntu22-arm64|ubuntu24-arm64|ubuntu26-arm64)
      folder="ubuntu"
      version="${os_name#ubuntu}"
      version="${version%-arm64}"
      pattern="Ubuntu${version}04-Arm64-Readme.md"
      ;;
    win22|win25)
      folder="windows"
      version="${os_name#win}"
      pattern="Windows20${version}-Readme.md"
      ;;
    win22-vs2026|win25-vs2026)
      folder="windows"
      version="${os_name#win}"
      version="${version%-vs2026}"
      pattern="Windows20${version}-VS2026-Readme.md"
      ;;
    win22-vs2026-arm64|win25-vs2026-arm64)
      folder="windows"
      version="${os_name#win}"
      version="${version%-vs2026-arm64}"
      pattern="Windows20${version}-VS2026-Arm64-Readme.md"
      ;;
    win11|win11-arm64)
      folder="windows"
      if [[ "${os_name}" == *"-arm64" ]]; then
        pattern="Windows11-Arm64-Readme.md"
      else
        pattern="Windows11-Readme.md"
      fi
      ;;
    win11-vs2026|win11-vs2026-arm64)
      folder="windows"
      if [[ "${os_name}" == *"-arm64" ]]; then
        pattern="Windows11-VS2026-Arm64-Readme.md"
      else
        pattern="Windows11-VS2026-Readme.md"
      fi
      ;;
    macos-14|macos-15|macos-26)
      folder="macos"
      pattern="${os_name}-Readme.md"
      ;;
    macos-14-arm64|macos-15-arm64|macos-26-arm64)
      folder="macos"
      pattern="${os_name}-Readme.md"
      ;;
    *)
      echo "Error: Unknown OS '${os_name}'" >&2
      echo "Valid: ubuntu22|ubuntu24|ubuntu26, win22|win25|win11, macos-14|macos-15|macos-26, and arm64 variants" >&2
      return 1
      ;;
  esac

  candidate="images/${folder}/${pattern}"
  if git -C "${SCRIPT_DIR}" cat-file -e "HEAD:${candidate}" 2>/dev/null; then
    echo "${candidate}"
    return 0
  fi

  if [[ -f "${SCRIPT_DIR}/${candidate}" ]]; then
    echo "${candidate}"
    return 0
  fi

  shopt -s nullglob
  matches=("${SCRIPT_DIR}/images/${folder}"/*Readme.md)
  shopt -u nullglob

  for candidate in "${matches[@]}"; do
    if [[ "$(basename "${candidate}")" == "${pattern}" ]]; then
      echo "images/${folder}/$(basename "${candidate}")"
      return 0
    fi
  done

  echo "Error: Readme not found for OS '${os_name}' (expected: ${candidate})" >&2
  return 1
}

validate_version() {
  local version="${1}"

  if [[ ! "${version}" =~ ^[0-9]{8}\.[0-9]+$ ]]; then
    echo "Error: Invalid version '${version}'" >&2
    echo "Format: YYYYMMDD.NNN (e.g., 20251102.127)" >&2
    return 1
  fi

  return 0
}

tag_exists() {
  local tag="${1}"

  if git -C "${SCRIPT_DIR}" rev-parse --verify --quiet "${tag}^{commit}" >/dev/null; then
    return 0
  fi

  echo "Error: Tag '${tag}' not found" >&2
  return 1
}

main() {
  if [[ $# -ne 3 ]]; then
    usage
    return 1
  fi

  local os_name="${1}"
  local version1="${2}"
  local version2="${3}"
  local readme_path=""
  local tag1=""
  local tag2=""
  local date1=""
  local date2=""
  local days_diff=""

  validate_version "${version1}" || return 1
  validate_version "${version2}" || return 1

  readme_path="$(resolve_readme_path "${os_name}")" || return 1

  tag1="${os_name}/${version1}"
  tag2="${os_name}/${version2}"

  tag_exists "${tag1}" || return 1
  tag_exists "${tag2}" || return 1

  date1=$(git -C "${SCRIPT_DIR}" log -1 --format="%ci" "${tag1}" | cut -d' ' -f1)
  date2=$(git -C "${SCRIPT_DIR}" log -1 --format="%ci" "${tag2}" | cut -d' ' -f1)

  days_diff=$(( ($(date -d "${date2}" +%s) - $(date -d "${date1}" +%s)) / 86400 ))

  echo "================================================================================"
  echo "Comparing: ${os_name}"
  echo "  From: ${version1} (${date1})"
  echo "    To: ${version2} (${date2})"
  echo "  Span: ${days_diff} days"
  echo "================================================================================"
  echo ""

  local diff_output=""
  diff_output=$(git -C "${SCRIPT_DIR}" diff --color=always --unified=0 "${tag1}:${readme_path}" "${tag2}:${readme_path}" | \
    grep -E $'(^\x1b\[(31|32|36)m|^@@)' || true)

  if [[ -n "${diff_output}" ]]; then
    local announcements1=""
    local announcements2=""
    announcements1=$(git -C "${SCRIPT_DIR}" show "${tag1}:${readme_path}" | sed -n '/| Announcements |/,/^[*][*][*]$/p' | grep -E '^| \[' | sed 's/^| \[/• [/' | sed 's/ |$//' || true)
    announcements2=$(git -C "${SCRIPT_DIR}" show "${tag2}:${readme_path}" | sed -n '/| Announcements |/,/^[*][*][*]$/p' | grep -E '^| \[' | sed 's/^| \[/• [/' | sed 's/ |$//' || true)

    if [[ "${announcements1}" != "${announcements2}" ]]; then
      echo "📢 Announcement Changes:"
      echo "────────────────────────────────────────────────────────────────────────────────"
      if [[ -n "${announcements2}" ]]; then
        echo "${announcements2}"
      else
        echo "(no announcements)"
      fi
      echo "────────────────────────────────────────────────────────────────────────────────"
      echo ""
    fi

    local cached_tools1=""
    local cached_tools2=""
    cached_tools1=$(git -C "${SCRIPT_DIR}" show "${tag1}:${readme_path}" | sed -n '/^### Cached Tools$/,/^###[^#]/p' | head -n -1 || true)
    cached_tools2=$(git -C "${SCRIPT_DIR}" show "${tag2}:${readme_path}" | sed -n '/^### Cached Tools$/,/^###[^#]/p' | head -n -1 || true)

    if [[ "${cached_tools1}" != "${cached_tools2}" ]]; then
      local cached_diff=""
      cached_diff=$(git -C "${SCRIPT_DIR}" diff --color=always --unified=2 --no-index \
        <(printf '%s\n' "${cached_tools1}") <(printf '%s\n' "${cached_tools2}") 2>/dev/null | \
        grep -E $'(^\x1b\[(31|32)m[-+]|^\x1b\[1m#### )' || true)

      if [[ -n "${cached_diff}" ]]; then
        echo "🔧 Cached Tools Changes (setup-* actions):"
        echo "────────────────────────────────────────────────────────────────────────────────"
        echo "${cached_diff}"
        echo "────────────────────────────────────────────────────────────────────────────────"
        echo ""
      fi
    fi

    echo "Full Diff:"
    echo "────────────────────────────────────────────────────────────────────────────────"
    echo "${diff_output}"
    echo "────────────────────────────────────────────────────────────────────────────────"
    echo ""

    local changes
    changes=$(printf '%s\n' "${diff_output}" | grep -c '^' || true)
    echo "Changes: ${changes} lines"

    local -a removals=()
    local -a additions=()
    local -a breaking_changes=()

    while IFS= read -r line; do
      if [[ "${line}" =~ ^\-(.+)$ ]]; then
        removals+=("${BASH_REMATCH[1]}")
      elif [[ "${line}" =~ ^\+(.+)$ ]]; then
        additions+=("${BASH_REMATCH[1]}")
      fi
    done < <(printf '%s\n' "${diff_output}" | sed -r 's/\x1b\[[0-9;]*m//g')

    for removed in "${removals[@]}"; do
      local tool_name=""
      local old_version=""
      local found_match=false

      if [[ "${removed}" =~ ^([^0-9]+[[:space:]]+)([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
        tool_name="${BASH_REMATCH[1]}"
        old_version="${BASH_REMATCH[2]}"
      elif [[ "${removed}" =~ ^([^0-9]+[[:space:]]+v)([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
        tool_name="${BASH_REMATCH[1]}"
        old_version="${BASH_REMATCH[2]}"
      fi

      if [[ -n "${tool_name}" && -n "${old_version}" ]]; then
        for added in "${additions[@]}"; do
          if [[ "${added}" =~ ^${tool_name}([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
            local new_version="${BASH_REMATCH[1]}"
            found_match=true

            if [[ "${old_version}" =~ ^([0-9]+)\.[0-9]+ && "${new_version}" =~ ^([0-9]+)\.[0-9]+ ]]; then
              local old_major="${BASH_REMATCH[1]}"
              local new_major="${BASH_REMATCH[1]}"
              if [[ "${new_major}" -gt "${old_major}" ]]; then
                breaking_changes+=("🔴 ${tool_name}${old_version} → ${new_version} (major version bump)")
              fi
            fi
            break
          fi
        done
      fi

      if [[ ${found_match} == false && -n "${old_version}" ]]; then
        breaking_changes+=("❌ ${removed} (removed)")
      elif [[ ${found_match} == false && "${removed}" =~ [0-9]+\.[0-9]+ ]]; then
        breaking_changes+=("❌ ${removed} (removed)")
      fi
    done

    if [[ ${#breaking_changes[@]} -gt 0 ]]; then
      echo ""
      echo "⚠️  Breaking changes detected (${#breaking_changes[@]}):"
      echo "--------------------------------------------------------------------------------"
      printf '%s\n' "${breaking_changes[@]}"
      echo "--------------------------------------------------------------------------------"
    fi
  else
    echo "No changes found."
  fi

  local pr_number=""
  pr_number=$(git -C "${SCRIPT_DIR}" log --all --format="%s" --grep="${version2}" | grep -oP '\(#\K[0-9]+(?=\))' | head -1 || true)

  local commit_count
  commit_count=$(git -C "${SCRIPT_DIR}" rev-list --count "${tag1}..${tag2}")

  echo "Commits: ${commit_count}"

  if [[ -n "${pr_number}" ]]; then
    echo "PR: https://github.com/actions/runner-images/pull/${pr_number}"
  fi

  return 0
}

main "$@"

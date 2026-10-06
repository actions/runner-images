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

usage() {
  cat <<EOF
Usage: $(basename "${0}") <os-name> <version1> <version2>

Compare runner image versions and display software changes.

Arguments:
  os-name    OS identifier (ubuntu22, ubuntu24, win19, win22, win25, 
             macos-13, macos-14, macos-15, or arm64 variants)
  version1   Earlier version (YYYYMMDD.NNN)
  version2   Later version (YYYYMMDD.NNN)

Examples:
  $(basename "${0}") ubuntu22 20251102.127 20251125.163
  $(basename "${0}") win25 20251102.77 20251125.122
EOF
}

get_readme_path() {
  local os_name="${1}"
  local os_folder=""
  local pattern=""
  
  # Determine OS folder and readme filename pattern
  case "${os_name}" in
    ubuntu*)
      os_folder="ubuntu"
      local version="${os_name#ubuntu}"
      pattern="Ubuntu${version}04-Readme.md"
      ;;
    win*)
      os_folder="windows"
      local version="${os_name#win}"
      pattern="Windows20${version}-Readme.md"
      ;;
    macos*)
      os_folder="macos"
      pattern="${os_name}-Readme.md"
      ;;
    *)
      echo "Error: Unknown OS '${os_name}'" >&2
      echo "Valid: ubuntu*, win*, macos-*" >&2
      return 1
      ;;
  esac
  
  local readme_path="images/${os_folder}/${pattern}"
  
  # Verify file exists in git repository
  if ! git cat-file -e "HEAD:${readme_path}" 2>/dev/null; then
    echo "Error: Readme not found: ${readme_path}" >&2
    return 1
  fi
  
  echo "${readme_path}"
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
  
  if git rev-parse "${tag}" >/dev/null 2>&1; then
    return 0
  else
    echo "Error: Tag '${tag}' not found" >&2
    return 1
  fi
}

main() {
  # Check arguments
  if [[ $# -ne 3 ]]; then
    usage
    return 1
  fi
  
  local os_name="${1}"
  local version1="${2}"
  local version2="${3}"
  
  # Validate inputs
  validate_version "${version1}" || return 1
  validate_version "${version2}" || return 1
  
  # Get readme path
  local readme_path
  readme_path="$(get_readme_path "${os_name}")" || return 1
  
  # Construct git tags
  local tag1="${os_name}/${version1}"
  local tag2="${os_name}/${version2}"
  
  # Verify tags exist
  tag_exists "${tag1}" || return 1
  tag_exists "${tag2}" || return 1
  
  # Get release dates
  local date1
  local date2
  date1=$(git log -1 --format="%ci" "${tag1}" | cut -d' ' -f1)
  date2=$(git log -1 --format="%ci" "${tag2}" | cut -d' ' -f1)
  
  # Calculate days between releases
  local days_diff
  days_diff=$(( ($(date -d "${date2}" +%s) - $(date -d "${date1}" +%s)) / 86400 ))
  
  # Display header
  echo "================================================================================"
  echo "Comparing: ${os_name}"
  echo "  From: ${version1} (${date1})"
  echo "    To: ${version2} (${date2})"
  echo "  Span: ${days_diff} days"
  echo "================================================================================"
  echo ""
  
  # Perform diff with minimal context (only changed lines with colors)
  # ANSI codes: ^[[31m (red for -), ^[[32m (green for +), ^[[36m (cyan for @@)
  # Filter to show only lines starting with red/green (additions/deletions)
  local diff_output
  diff_output=$(git diff --color=always --unified=0 "${tag1}:${readme_path}" "${tag2}:${readme_path}" | \
                grep -E $'^\x1b\\[(31|32)m' | \
                grep -v -E $'^\x1b\\[1m(---|\\+\\+\\+)')
  
  if [[ -n "${diff_output}" ]]; then
    # Extract announcements from both versions
    local announcements1
    local announcements2
    announcements1=$(git show "${tag1}:${readme_path}" | sed -n '/| Announcements |/,/^\*\*\*$/p' | grep -E '^\| \[' | sed 's/^| \[/• [/' | sed 's/ |$//' || true)
    announcements2=$(git show "${tag2}:${readme_path}" | sed -n '/| Announcements |/,/^\*\*\*$/p' | grep -E '^\| \[' | sed 's/^| \[/• [/' | sed 's/ |$//' || true)
    
    # Show announcement changes
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
    
    # Extract cached tools sections
    local cached_tools1
    local cached_tools2
    cached_tools1=$(git show "${tag1}:${readme_path}" | sed -n '/^### Cached Tools$/,/^###[^#]/p' | head -n -1 || true)
    cached_tools2=$(git show "${tag2}:${readme_path}" | sed -n '/^### Cached Tools$/,/^###[^#]/p' | head -n -1 || true)
    
    # Show cached tools changes
    if [[ "${cached_tools1}" != "${cached_tools2}" ]]; then
      local cached_diff
      cached_diff=$(git diff --color=always --unified=2 --no-index \
                    <(echo "${cached_tools1}") <(echo "${cached_tools2}") 2>/dev/null | \
                    grep -E $'(^\x1b\\[(31|32)m[-+]| #### )' | \
                    sed -r 's/\x1b\[m$//' || true)
      
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
    
    # Count changes
    local changes
    changes=$(echo "${diff_output}" | wc -l)
    echo "Changes: ${changes} lines"
    
    # Parse version changes for breaking change analysis
    local breaking_changes=()
    local removals=()
    local additions=()
    
    # Extract clean lines (strip ANSI codes)
    while IFS= read -r line; do
      if [[ "${line}" =~ ^\-(.+)$ ]]; then
        removals+=("${BASH_REMATCH[1]}")
      elif [[ "${line}" =~ ^\+(.+)$ ]]; then
        additions+=("${BASH_REMATCH[1]}")
      fi
    done < <(echo "${diff_output}" | sed -r 's/\x1b\[[0-9;]*m//g')
    
    # Detect breaking changes
    for removed in "${removals[@]}"; do
      local tool_name=""
      local old_version=""
      local found_match=false
      
      # Try to extract tool name and version (handle various formats)
      if [[ "${removed}" =~ ^([^0-9]+[[:space:]]+)([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
        tool_name="${BASH_REMATCH[1]}"
        old_version="${BASH_REMATCH[2]}"
      elif [[ "${removed}" =~ ^([^0-9]+[[:space:]]+v)([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
        tool_name="${BASH_REMATCH[1]}"
        old_version="${BASH_REMATCH[2]}"
      fi
      
      # If we found a semver-style version, look for matching addition
      if [[ -n "${tool_name}" && -n "${old_version}" ]]; then
        for added in "${additions[@]}"; do
          if [[ "${added}" =~ ^${tool_name}([0-9]+\.[0-9]+[^[:space:]]*) ]]; then
            local new_version="${BASH_REMATCH[1]}"
            found_match=true
            
            # Extract major version for semver comparison
            if [[ "${old_version}" =~ ^([0-9]+)\. && "${new_version}" =~ ^([0-9]+)\. ]]; then
              local old_major="${BASH_REMATCH[1]}"
              local new_major="${BASH_REMATCH[1]}"
              
              [[ "${old_version}" =~ ^([0-9]+)\. ]] && old_major="${BASH_REMATCH[1]}"
              [[ "${new_version}" =~ ^([0-9]+)\. ]] && new_major="${BASH_REMATCH[1]}"
              
              if [[ ${new_major} -gt ${old_major} ]]; then
                breaking_changes+=("🔴 ${tool_name}${old_version} → ${new_version} (major version bump)")
              fi
            fi
            break
          fi
        done
      fi
      
      # If no match found and looks like a versioned tool, it's a removal
      if [[ ${found_match} == false && -n "${old_version}" ]]; then
        breaking_changes+=("❌ ${removed} (removed)")
      elif [[ ${found_match} == false && "${removed}" =~ [0-9]+\.[0-9]+ ]]; then
        breaking_changes+=("❌ ${removed} (removed)")
      fi
    done
    
    # Display breaking changes
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
  
  # Display PR link and commit count
  local pr_number
  pr_number=$(git log --all --format="%s" --grep="${version2}" | \
              grep -oP '\(#\K[0-9]+(?=\))' | head -1)
  
  local commit_count
  commit_count=$(git rev-list --count "${tag1}..${tag2}")
  
  echo "Commits: ${commit_count}"
  
  if [[ -n "${pr_number}" ]]; then
    echo "PR: https://github.com/actions/runner-images/pull/${pr_number}"
  fi
  
  return 0
}

# Execute main function
main "$@"

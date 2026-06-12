#!/bin/bash -e
################################################################################
##  File:  install-copilot-cli.sh
##  Desc:  Install GitHub Copilot CLI from GitHub Releases with SHA256 checksum
##         verification, pinned to the version validated by the gh-aw agent
##         compatibility matrix.
##  Supply chain security: Copilot CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Detect host architecture to pick the matching release asset and toolcache
# subdirectory.
case "$(uname -m)" in
    x86_64) arch="x64" ;;
    aarch64) arch="arm64" ;;
    *) echo "Error: unsupported architecture $(uname -m)"; exit 1 ;;
esac

# Pin to the catch-all max-agent published in the gh-aw compatibility matrix
# (https://github.com/github/gh-aw-actions/blob/main/.github/aw/compat.json).
# This is the highest copilot CLI version validated against the current gh-aw
# release line.
#
# Fail the bake on any fetch or parse failure (matches the install-awf.sh
# pattern). The matrix is the single source of truth for which Copilot CLI
# version is approved for the runner image; if it cannot be resolved we would
# rather rebuild later than ship an unvalidated version.
COMPAT_URL="https://raw.githubusercontent.com/github/gh-aw-actions/main/.github/aw/compat.json"

echo "Fetching agent compatibility matrix from $COMPAT_URL..."
compat_json=$(curl -fsSL --proto '=https' --proto-redir '=https' --retry 3 --retry-delay 2 "$COMPAT_URL") || {
    echo "Error: Unable to fetch agent compatibility matrix from $COMPAT_URL."
    exit 1
}

# Select the catch-all row (max-gh-aw == "*") and read its max-agent.
# Use jq -e so a missing/null result exits non-zero and we surface a clear
# error instead of silently installing whatever happens to be on the latest tag.
copilot_version=$(echo "$compat_json" | jq -er '.["agent-compat-v1"].copilot[] | select(.["max-gh-aw"] == "*") | .["max-agent"]') || {
    echo "Error: catch-all max-agent (max-gh-aw == \"*\") not found in compat.json."
    exit 1
}

# Guard against malformed matrix entries: there must be exactly one catch-all
# row, and its value must be a SemVer string.
if [[ $(echo "$copilot_version" | wc -l) -ne 1 ]]; then
    echo "Error: compat.json has more than one catch-all copilot row; expected exactly one."
    echo "Got:"
    echo "$copilot_version"
    exit 1
fi
if ! [[ "$copilot_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
    echo "Error: compat.json catch-all max-agent ('$copilot_version') is not a valid SemVer version."
    exit 1
fi

# Download the release tarball for this arch.
tarball_name="copilot-linux-${arch}.tar.gz"
release_base="https://github.com/github/copilot-cli/releases/download/v${copilot_version}"
tarball_path=$(download_with_retry "${release_base}/${tarball_name}")

# Supply chain security - Copilot CLI: verify SHA256 against the published
# SHA256SUMS.txt from the same release.
external_hash=$(get_checksum_from_url "${release_base}/SHA256SUMS.txt" "$tarball_name" "SHA256")
use_checksum_comparison "$tarball_path" "$external_hash"

# Install into the agent tool cache so the gh-aw-actions/setup action's
# tc.find("copilot-cli", ...) lookup succeeds on hosted runners. Layout:
#   $AGENT_TOOLSDIRECTORY/copilot-cli/<version>/<arch>/bin/copilot
#   $AGENT_TOOLSDIRECTORY/copilot-cli/<version>/<arch>.complete
# Mirrors the conventions used by install-awf.sh and install-codeql-bundle.sh.
copilot_toolcache_path="$AGENT_TOOLSDIRECTORY/copilot-cli/$copilot_version/$arch"
mkdir -p "$copilot_toolcache_path/bin"

echo "Installing GitHub Copilot CLI v$copilot_version into $copilot_toolcache_path..."
tar -xzf "$tarball_path" -C "$copilot_toolcache_path/bin"
rm -f "$tarball_path"

# Mark the tool-cache entry complete so @actions/tool-cache#find returns it.
touch "$copilot_toolcache_path.complete"

invoke_tests "Tools" "Copilot CLI"

#!/bin/bash -e
################################################################################
##  File:  install-copilot-cli.sh
##  Desc:  Install GitHub Copilot CLI via npm, pinned to the version validated
##         by the gh-aw agent compatibility matrix.
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

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
# error instead of installing whatever happens to be on the npm `latest` tag.
copilot_version=$(echo "$compat_json" | jq -er '.["agent-compat-v1"].copilot[] | select(.["max-gh-aw"] == "*") | .["max-agent"]') || {
    echo "Error: catch-all max-agent (max-gh-aw == \"*\") not found in compat.json."
    exit 1
}

# Guard against malformed matrix entries: there must be exactly one catch-all
# row, and its value must be a SemVer string. Multiple matches would produce a
# multi-line value that npm install cannot interpret; a non-semver value would
# install a phantom dist-tag (or fail with a confusing npm error).
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

# Install into the agent tool cache so the gh-aw-actions/setup action's
# tc.find("copilot-cli", ...) lookup succeeds on hosted runners. Layout:
#   $AGENT_TOOLSDIRECTORY/copilot-cli/<version>/x64/{bin,lib}
#   $AGENT_TOOLSDIRECTORY/copilot-cli/<version>/x64.complete
# Mirrors the conventions used by install-awf.sh and install-codeql-bundle.sh.
copilot_toolcache_path="$AGENT_TOOLSDIRECTORY/copilot-cli/$copilot_version/x64"
mkdir -p "$copilot_toolcache_path"

echo "Installing GitHub Copilot CLI v$copilot_version into $copilot_toolcache_path (pinned via compat.json)..."
npm install -g --prefix "$copilot_toolcache_path" \
    "@github/copilot@${copilot_version}" --ignore-scripts

# Mark the tool-cache entry complete so @actions/tool-cache#find returns it.
touch "$copilot_toolcache_path.complete"

invoke_tests "Tools" "Copilot CLI"

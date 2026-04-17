#!/bin/bash -e
################################################################################
##  File:  install-awf.sh
##  Desc:  Install Agent Workflow Firewall JS bundle (most recent 3 versions)
##  Supply chain security: AWF - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Number of versions to install (current + 2 previous)
NUM_VERSIONS=3

# Get the most recent stable releases (exclude pre-releases, beta and release without assets)
releases=$(curl -fsSL "https://api.github.com/repos/github/gh-aw-firewall/releases?per_page=10")
versions=$(echo "$releases" | jq -r '[.[] | select(.assets | length > 0) | select(.prerelease == false) | select(.tag_name | test(".*-[a-z]|beta") | not)] | .[:'"$NUM_VERSIONS"'] | .[].tag_name')

if [[ -z "$versions" ]]; then
    echo "Error: Unable to find AWF releases."
    exit 1
fi

for tag in $versions; do
    version="${tag#v}"
    echo "Installing AWF JS bundle version $version to toolcache..."

    # Download the JS bundle
    bundle_url="https://github.com/github/gh-aw-firewall/releases/download/${tag}/awf-bundle.js"
    bundle_path=$(download_with_retry "$bundle_url")

    # Supply chain security - AWF
    checksums_url="https://github.com/github/gh-aw-firewall/releases/download/${tag}/checksums.txt"
    external_hash=$(get_checksum_from_url "$checksums_url" "awf-bundle.js" "SHA256")
    use_checksum_comparison "$bundle_path" "$external_hash"

    # Install to toolcache
    awf_toolcache_path="$AGENT_TOOLSDIRECTORY/agentic-workflow-firewall-js/$version/x64"
    mkdir -p "$awf_toolcache_path"
    cp "$bundle_path" "$awf_toolcache_path/awf-bundle.js"

    # Mark installation complete
    touch "$AGENT_TOOLSDIRECTORY/agentic-workflow-firewall-js/$version/x64.complete"
done

invoke_tests "Tools" "AWF"

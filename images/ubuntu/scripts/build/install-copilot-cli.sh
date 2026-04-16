#!/bin/bash -e
################################################################################
##  File:  install-copilot-cli.sh
##  Desc:  Install Copilot CLI (most recent 3 versions)
##  Supply chain security: Copilot CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Following the pattern in install-docker.sh where the core AW container images are only installed on ubuntu-latest
if is_ubuntu22; then
    exit 0
fi

# Number of versions to cache (current + 2 previous)
NUM_VERSIONS=3

# Get the most recent stable releases (exclude pre-releases, rc, and beta)
releases=$(curl -fsSL "https://api.github.com/repos/github/copilot-cli/releases?per_page=10")
versions=$(echo "$releases" | jq -r '[.[] | select(.assets | length > 0) | select(.prerelease == false) | select(.tag_name | test(".*-[a-z]|beta") | not)] | .[:'"$NUM_VERSIONS"'] | .[].tag_name')

if [[ -z "$versions" ]]; then
    echo "Error: Unable to find Copilot CLI releases."
    exit 1
fi

for tag in $versions; do
    version="${tag#v}"
    echo "Installing Copilot CLI version $version to toolcache..."

    # Download Copilot CLI
    archive_url="https://github.com/github/copilot-cli/releases/download/${tag}/copilot-linux-x64.tar.gz"
    copilot_cli_archive=$(download_with_retry "$archive_url")

    # Supply chain security - Copilot CLI
    checksums_url="https://github.com/github/copilot-cli/releases/download/${tag}/SHA256SUMS.txt"
    external_hash=$(get_checksum_from_url "$checksums_url" "copilot-linux-x64.tar.gz" "SHA256")
    use_checksum_comparison "$copilot_cli_archive" "$external_hash"

    # Install to toolcache
    copilot_cli_toolcache_path="$AGENT_TOOLSDIRECTORY/copilot-cli/$version/x64"
    mkdir -p "$copilot_cli_toolcache_path"
    tar -xzf "$copilot_cli_archive" -C "$copilot_cli_toolcache_path"

    # Mark installation complete
    touch "$AGENT_TOOLSDIRECTORY/copilot-cli/$version/x64.complete"
done

# Symlink the latest version to /usr/local/bin
latest_version=$(echo "$versions" | head -n 1)
latest_version="${latest_version#v}"
ln -sf "$AGENT_TOOLSDIRECTORY/copilot-cli/$latest_version/x64/copilot" /usr/local/bin/copilot

invoke_tests "CLI.Tools" "Copilot CLI"

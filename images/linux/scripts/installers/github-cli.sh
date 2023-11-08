#!/bin/bash -e
################################################################################
##  File:  github-cli.sh
##  Desc:  Installs GitHub CLI
##         Must be run as non-root user after homebrew
##  Supply chain security: GitHub CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download GitHub CLI
URL=$(get_github_package_download_url "cli/cli" "contains(\"linux\") and contains(\"amd64\") and contains(\".deb\")")
download_with_retries "${URL}" "/tmp" "gh_cli_linux_amd64.deb"
# Supply chain security - GitHub CLI
hash_url=$(get_github_package_download_url "cli/cli" "contains(\"checksums.txt\")")
external_hash=$(get_hash_from_remote_file "${hash_url}" "linux_amd64.deb")
use_checksum_comparison "/tmp/gh_cli_linux_amd64.deb" "${external_hash}"
# Install GitHub CLI
apt install /tmp/gh_cli_linux_amd64.deb

invoke_tests "CLI.Tools" "GitHub CLI"

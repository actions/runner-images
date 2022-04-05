#!/bin/bash -e
################################################################################
##  File:  github-cli.sh
##  Desc:  Installs GitHub CLI
##         Must be run as non-root user after homebrew
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install GitHub CLI
downloadUrl=$(get_github_package_download_url "cli/cli" "contains(\"linux\") and contains(\"amd64\") and contains(\".deb\")")
download_with_retries $downloadUrl "/tmp"
apt install /tmp/gh_*_linux_amd64.deb

invoke_tests "CLI.Tools" "GitHub CLI"

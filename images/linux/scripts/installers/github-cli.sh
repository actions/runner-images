#!/bin/bash -e
################################################################################
##  File:  github-cli.sh
##  Desc:  Installs GitHub CLI
##         Must be run as non-root user after homebrew
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install GitHub CLI
url=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | jq -r '.assets[].browser_download_url|select(contains("linux") and contains("amd64") and contains(".deb"))')
download_with_retries $url "/tmp"
apt install /tmp/gh_*_linux_amd64.deb

invoke_tests "CLI.Tools" "GitHub CLI"

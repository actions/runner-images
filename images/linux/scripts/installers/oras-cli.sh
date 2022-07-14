#!/bin/bash -e
################################################################################
##  File:  oras-cli.sh
##  Desc:  Installs ORAS CLI
################################################################################

source $HELPER_SCRIPTS/install.sh

# Download ORAS CLI version 0.12 since it is the version compatible with GHCR (Tracking issue to fix CLI for GHCR login https://github.com/oras-project/oras/issues/446)
ORAS_CLI_DOWNLOAD_URL=$(get_github_package_download_url "oras-project/oras" "endswith(\"linux_amd64.tar.gz\")" "0.12.0")
ORAS_CLI_ARCHIVE=$(basename $ORAS_CLI_DOWNLOAD_URL)

# Install ORAS CLI
cd /tmp
download_with_retries $ORAS_CLI_DOWNLOAD_URL
tar xzf $ORAS_CLI_ARCHIVE -C /usr/local/bin oras

invoke_tests "CLI.Tools" "Oras CLI"

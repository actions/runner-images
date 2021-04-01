#!/bin/bash -e
################################################################################
##  File:  oras-cli.sh
##  Desc:  Installs ORAS CLI
################################################################################

source $HELPER_SCRIPTS/install.sh

# Determine latest ORAS CLI version
ORAS_CLI_LATEST_VERSION_URL=https://api.github.com/repos/deislabs/oras/releases/latest
ORAS_CLI_DOWNLOAD_URL=$(curl -s $ORAS_CLI_LATEST_VERSION_URL | jq -r '.assets[].browser_download_url | select(endswith("linux_amd64.tar.gz"))')
ORAS_CLI_ARCHIVE=$(basename $ORAS_CLI_DOWNLOAD_URL)

# Install ORAS CLI
cd /tmp
download_with_retries $ORAS_CLI_DOWNLOAD_URL
tar xzf $ORAS_CLI_ARCHIVE -C /usr/local/bin oras

invoke_tests "CLI.Tools" "Oras CLI"

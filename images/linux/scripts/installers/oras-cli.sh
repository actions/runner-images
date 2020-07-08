#!/bin/bash
################################################################################
##  File:  oras-cli.sh
##  Desc:  Installs ORAS CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/install.sh

# Determine latest ORAS CLI version
ORAS_CLI_LATEST_VERSION_URL=https://api.github.com/repos/deislabs/oras/releases/latest
ORAS_CLI_DOWNLOAD_URL=$(curl -s $ORAS_CLI_LATEST_VERSION_URL | jq -r '.assets[].browser_download_url | select(contains("linux_amd64.tar.gz"))')
ORAS_CLI_ARCHIVE=$(basename $ORAS_CLI_DOWNLOAD_URL)

# Install ORAS CLI
cd /tmp
download_with_retries $ORAS_CLI_DOWNLOAD_URL
tar -zxvf $ORAS_CLI_ARCHIVE -C /usr/local/bin oras

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! oras version; then
    echo "ORAS CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "ORAS CLI $(oras version | awk 'NR==1{print $2}')"
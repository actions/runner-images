#!/bin/bash
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

LSB_CODENAME=$(lsb_release -cs)

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $LSB_CODENAME main" | tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys B02C46DF417A0893
apt-get update
apt-get install -y --no-install-recommends apt-transport-https azure-cli

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v az; then
    echo "azure-cli was not installed"
    exit 1
fi

# Document what was added to the image
DocumentInstalledItem "Azure CLI ($(az -v | head -n 1))"

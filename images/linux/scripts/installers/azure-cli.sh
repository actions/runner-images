#!/bin/bash
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v az; then
    echo "azure-cli was not installed"
    exit 1
fi

# Document what was added to the image
DocumentInstalledItem "Azure CLI ($(az -v | head -n 1))"

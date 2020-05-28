#!/bin/bash
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# Temporary downgrade to 2.5.1 installation until version 2.7.0 with the fix for the issue is not released https://github.com/actions/virtual-environments/issues/948
# There is no 2.5.1 version for Ubuntu20
if isUbuntu16 || isUbuntu18 ; then
    label=$(getOSVersionLabel)
    apt-get install -y --allow-downgrades azure-cli=2.5.1-1~$label
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v az; then
    echo "azure-cli was not installed"
    exit 1
fi

# Document what was added to the image
DocumentInstalledItem "Azure CLI ($(az -v | head -n 1))"

#!/bin/bash -e
################################################################################
##  File:  azpowershell.sh
##  Desc:  Installed Azure PowerShell
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# List of versions
toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
versions=$(jq -r '.azureModules[] | select(.name | contains("az")) | .versions[]' $toolset)

# Try to install and update PowerShellGet before the actual installation
pwsh -Command "Install-Module -Name PowerShellGet -Force"
pwsh -Command "Update-Module -Name PowerShellGet -Force"

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
for version in ${versions[@]}; do
    pwsh -Command "Save-Module -Name Az -LiteralPath /usr/share/az_$version -RequiredVersion $version -Force -Verbose"
done

invoke_tests "PowerShellModules" "AzureModules"

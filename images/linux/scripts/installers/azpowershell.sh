#!/bin/bash
################################################################################
##  File:  azpowershell.sh
##  Desc:  Installed Azure PowerShell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# List of versiion
versions=(1.0.0 1.6.0 2.3.2 2.6.0 2.8.0 3.1.0 3.5.0 3.8.0)

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
for version in ${versions[@]}; do
    sudo pwsh -Command "Save-Module -Name Az -LiteralPath /usr/share/az_$version -RequiredVersion $version -Force"
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for version in ${versions[@]}; do
    pwsh -Command '
        $actualPSModulePath = $env:PSModulePath;
        $env:PSModulePath = "/usr/share/az_${version}:" + $env:PSModulePath;
        if (!(get-module -listavailable -name Az.accounts))
        {
            Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
        }
        $env:PSModulePath = $actualPSModulePath'
    if [ $? -eq 1 ]; then
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
for version in ${versions[@]}; do
    DocumentInstalledItem "Az Module ($version)"
done

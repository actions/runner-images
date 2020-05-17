#!/bin/bash
################################################################################
##  File:  azpowershell.sh
##  Desc:  Installed Azure PowerShell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_1.0.0 -RequiredVersion 1.0.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_1.6.0 -RequiredVersion 1.6.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_2.3.2 -RequiredVersion 2.3.2 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_2.6.0 -RequiredVersion 2.6.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_2.8.0 -RequiredVersion 2.8.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_3.1.0 -RequiredVersion 3.1.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_3.5.0 -RequiredVersion 3.5.0 -Force'
sudo pwsh -Command 'Save-Module -Name Az -LiteralPath /usr/share/az_3.8.0 -RequiredVersion 3.8.0 -Force'

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! pwsh -Command '$actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_1.0.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_1.6.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_2.3.2:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_2.6.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_2.8.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_3.1.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_3.5.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath
    $actualPSModulePath = $env:PSModulePath ; $env:PSModulePath = "/usr/share/az_3.8.0:" + $env:PSModulePath;
    if (!(get-module -listavailable -name Az.accounts)) {
        Write-Host "Az Module was not installed"; $env:PSModulePath = $actualPSModulePath; exit 1
    }
    $env:PSModulePath = $actualPSModulePath'; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Az Module (1.0.0)"
DocumentInstalledItem "Az Module (1.6.0)"
DocumentInstalledItem "Az Module (2.3.2)"
DocumentInstalledItem "Az Module (2.6.0)"
DocumentInstalledItem "Az Module (2.8.0)"
DocumentInstalledItem "Az Module (3.1.0)"
DocumentInstalledItem "Az Module (3.5.0)"
DocumentInstalledItem "Az Module (3.8.0)"

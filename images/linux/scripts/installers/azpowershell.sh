#!/bin/bash
################################################################################
##  File:  azpowershell.sh
##  Desc:  Installed Azure PowerShell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
if isUbuntu20 ; then
    latestVersion=$(pwsh -Command '(Find-Module -Name Az).Version')
    modulePath="/usr/share/az_$latestVersion"
    echo "Save Az Module ($latestVersion) to $modulePath"
    pwsh -Command "Save-Module -Name Az -LiteralPath $modulePath -RequiredVersion $latestVersion -Force"

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    if ! pwsh -Command "\$env:PSModulePath = '${modulePath}:' + \$env:PSModulePath
        if ( -not (Get-Module -ListAvailable -Name Az.Accounts)) {
            Write-Host 'Az Module was not installed'
            exit 1
        }"; then
        exit 1
    fi

    # Document what was added to the image
    DocumentInstalledItem "Az Module ($latestVersion)"
    exit 0
fi

# List of versiion
if isUbuntu20 ; then
    latestVersion=$(pwsh -Command '(Find-Module -Name Az).Version')
    versions=($latestVersion)
else
    versions=(1.0.0 1.6.0 2.3.2 2.6.0 2.8.0 3.1.0 3.5.0 3.8.0)
fi

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
for version in ${versions[@]}; do
    pwsh -Command "Save-Module -Name Az -LiteralPath /usr/share/az_$version -RequiredVersion $version -Force"
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for version in ${versions[@]}; do
    modulePath="/usr/share/az_$version"
    pwsh -Command
        "\$env:PSModulePath = '${modulePath}:' + \$env:PSModulePath;
        if ( -not (Get-Module -ListAvailable -Name Az.Accounts)) {
            Write-Host 'Az Module was not installed'
            exit 1
        }";
    if [ $? -eq 1 ]; then
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
for version in ${versions[@]}; do
    DocumentInstalledItem "Az Module ($version)"
done

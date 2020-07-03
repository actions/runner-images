#!/bin/bash
################################################################################
##  File:  azpowershell.sh
##  Desc:  Installed Azure PowerShell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# List of versions
if isUbuntu20 ; then
    versions=$(pwsh -Command '(Find-Module -Name Az).Version')
else
    toolsetJson="$INSTALLER_SCRIPT_FOLDER/toolset.json"
    versions=$(cat $toolsetJson | jq -r '.azureModules[] | select(.name | contains("az")) | .versions[]')
fi

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
for version in ${versions[@]}; do
    pwsh -Command "Save-Module -Name Az -LiteralPath /usr/share/az_$version -RequiredVersion $version -Force"
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for version in ${versions[@]}; do
    modulePath="/usr/share/az_$version"
    pwsh -Command "
        \$env:PSModulePath = '${modulePath}:' + \$env:PSModulePath;
        if ( -not (Get-Module -ListAvailable -Name Az.Accounts)) {
            Write-Host 'Az Module was not installed'
            exit 1
        }"
    if [ $? -ne 0 ]; then
        echo "Az version $version is not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
for version in ${versions[@]}; do
    DocumentInstalledItem "Az Module ($version)"
done

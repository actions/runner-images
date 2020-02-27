#!/bin/bash
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# libicu64, which comes with php-intl module, has powershell breaking issue https://github.com/PowerShell/PowerShell/issues/9746
# Fix - install additional libicu65 where the issue is fixed
echo "install libicu65"
apt get install libicu65

# Install Powershell
apt-get install -y powershell

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v pwsh; then
    echo "pwsh was not installed"
    exit 1
fi
if ! pwsh -c 'Write-Host Hello world'; then
    echo "pwsh failed to run"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Powershell ($(pwsh --version))"

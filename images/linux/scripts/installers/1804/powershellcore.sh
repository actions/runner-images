#!/bin/bash
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

LSB_RELEASE=$(lsb_release -rs)
echo "Addin the repository [microsoft-ubuntu-bionic-prod] to /etc/apt/sources.list.d/dotnetdev.list"
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'

# Install Powershell
echo "Running the PowerShell core installation"
apt-get install -y powershell

# Temp fix based on: https://github.com/PowerShell/PowerShell/issues/9746
echo "Remove the libicu64"
sudo apt remove libicu64

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

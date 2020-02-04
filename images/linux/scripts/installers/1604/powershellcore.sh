#!/bin/bash
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

LSB_RELEASE=$(lsb_release -rs)
#echo "Installing the libicu60 library"
#wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3_amd64.deb
#dpkg -i libicu60_60.2-3ubuntu3_amd64.deb

echo "Installing the PowerShell Core"
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

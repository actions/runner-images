#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

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

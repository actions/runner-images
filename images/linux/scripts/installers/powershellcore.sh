#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Powershell
apt-get install -y powershell

invoke_tests "Tools" "PowerShell Core"
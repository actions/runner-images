#!/bin/bash -e
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install PowerShell Core
################################################################################

source $HELPER_SCRIPTS/install.sh

pwshversion=$(get_toolset_value .pwsh.version)

# Install Powershell
apt-get install -y powershell=$pwshversion*

#!/bin/bash -e
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install PowerShell Core
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

pwsh_version=$(get_toolset_value .pwsh.version)

# Install Powershell
apt-get install -y powershell=$pwsh_version*

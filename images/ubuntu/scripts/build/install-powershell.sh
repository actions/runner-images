#!/bin/bash -e
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install PowerShell Core
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

pwsh_version=$(get_toolset_value .pwsh.version)

# Install Powershell
if is_ubuntu24; then
    dependency_path=$(download_with_retry "http://mirrors.kernel.org/ubuntu/pool/main/i/icu/libicu72_72.1-3ubuntu2_amd64.deb")
    sudo dpkg -i "$dependency_path"
    package_path=$(download_with_retry "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-lts_7.4.2-1.deb_amd64.deb")
    sudo dpkg -i "$package_path"
else
    apt-get install powershell=$pwsh_version*
fi

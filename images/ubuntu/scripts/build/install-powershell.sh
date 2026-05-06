#!/bin/bash -e
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install PowerShell Core
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

pwsh_version=$(get_toolset_value .pwsh.version)

if is_ubuntu26; then
    # pwsh for ubuntu 26.04 is not yet available in apt repo, install from GitHub release tarball
    # Ubuntu 26.04: install from GitHub release tarball
    download_url=$(resolve_github_release_asset_url "PowerShell/PowerShell" "endswith(\"linux-x64.tar.gz\")" "$pwsh_version" "" "true")
    archive_path=$(download_with_retry "$download_url")

    # Create the target folder where powershell will be placed
    sudo mkdir -p /opt/microsoft/powershell/7

    # Expand powershell to the target folder
    sudo tar zxf "$archive_path" -C /opt/microsoft/powershell/7

    # Set execute permissions
    sudo chmod +x /opt/microsoft/powershell/7/pwsh

    # Create the symbolic link that points to pwsh
    sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
else
    # Install Powershell via apt
    apt-get install powershell=$pwsh_version*
fi

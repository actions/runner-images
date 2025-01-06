#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-powershell.sh
##  Desc:  Install PowerShell
################################################################################

source ~/utils/utils.sh

echo Installing PowerShell...
arch=$(get_arch)

metadata_json_path=$(download_with_retry "https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json")
pwshVersionToolset=$(get_toolset_value '.pwsh.version')
pwshVersions=$(jq -r '.LTSReleaseTag[]' $metadata_json_path)

for version in ${pwshVersions[@]}; do
    if [[ "$version" =~ "$pwshVersionToolset" ]]; then
        download_url=$(resolve_github_release_asset_url "PowerShell/PowerShell" "contains(\"osx-$arch.pkg\")" "$version" "$API_PAT")
        break
    fi
done

pkg_path=$(download_with_retry $download_url)

# Work around the issue on macOS Big Sur 11.5 or higher for possible error message ("can't be opened because Apple cannot check it for malicious software") when installing the package
sudo xattr -rd com.apple.quarantine $pkg_path

sudo installer -pkg $pkg_path -target /

# Install PowerShell modules
psModules=$(get_toolset_value '.powershellModules[].name')
for module in ${psModules[@]}; do
    echo "Installing $module module"
    moduleVersions="$(get_toolset_value ".powershellModules[] | select(.name==\"$module\") | .versions[]?")"
    if [[ -z $moduleVersions ]];then
        # Check MacOS architecture and sudo on Arm64
        if [[ $arch == "arm64" ]]; then
            sudo pwsh -command "& {Install-Module $module -Force -Scope AllUsers}"
        else
            pwsh -command "& {Install-Module $module -Force -Scope AllUsers}"
        fi
    else
        for version in ${moduleVersions[@]}; do
            # Check MacOS architecture and sudo on Arm64
            if [[ $arch == "arm64" ]]; then
                echo " - $version"
                sudo pwsh -command "& {Install-Module $module -RequiredVersion $version -Force -Scope AllUsers}"
            else
                echo " - $version"
                pwsh -command "& {Install-Module $module -RequiredVersion $version -Force -Scope AllUsers}"
            fi
        done
    fi
done

# Fix permission root => runner after installing powershell for arm64 arch
if [[ $arch == "arm64" ]]; then
    sudo chown -R $USER ~/.local ~/.cache ~/.config
fi

# A dummy call to initialize .IdentityService directory
pwsh -command "& {Import-Module Az}"

# powershell link was removed in powershell-6.0.0-beta9
sudo ln -s /usr/local/bin/pwsh /usr/local/bin/powershell

invoke_tests "Powershell"

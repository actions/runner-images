#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing PowerShell...
arch=$(get_arch)

psmetadata=$(curl "https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json" -s)
psver=$(echo $psmetadata | jq -r '.LTSReleaseTag[0]')
psDownloadUrl=$(get_github_package_download_url "PowerShell/PowerShell" "contains(\"osx-$arch.pkg\")" "$psver" "$API_PAT")
download_with_retries $psDownloadUrl "/tmp" "powershell.pkg"

# Work around the issue on macOS Big Sur 11.5 or higher for possible error message ("can't be opened because Apple cannot check it for malicious software") when installing the package
sudo xattr -rd com.apple.quarantine /tmp/powershell.pkg


sudo installer -pkg /tmp/powershell.pkg -target /

# Install PowerShell modules
psModules=$(get_toolset_value '.powershellModules[].name')
for module in ${psModules[@]}; do
    echo "Installing $module module"
    moduleVersions="$(get_toolset_value ".powershellModules[] | select(.name==\"$module\") | .versions[]?")"
    if [[ -z "$moduleVersions" ]];then
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

if [[ $arch == "arm64" ]]; then
    sudo chown -R $USER ~/.local
fi

# A dummy call to initialize .IdentityService directory
pwsh -command "& {Import-Module Az}"

# powershell link was removed in powershell-6.0.0-beta9
sudo ln -s /usr/local/bin/pwsh /usr/local/bin/powershell

invoke_tests "Powershell"

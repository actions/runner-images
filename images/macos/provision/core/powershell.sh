#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing PowerShell...
psDownloadUrl=$(get_github_package_download_url "PowerShell/PowerShell" "contains(\"osx-x64.pkg\")" "latest" "$API_PAT")
download_with_retries $psDownloadUrl "/tmp" "powershell.pkg"

# Work around the issue on macOS Big Sur 11.5 or higher for possible error message ("can't be opened because Apple cannot check it for malicious software") when installing the package
if ! is_Catalina; then
    sudo xattr -rd com.apple.quarantine /tmp/powershell.pkg
fi

sudo installer -pkg /tmp/powershell.pkg -target /

# Install PowerShell modules
psModules=$(get_toolset_value '.powershellModules[].name')
for module in ${psModules[@]}; do
    echo "Installing $module module"
    moduleVersions="$(get_toolset_value ".powershellModules[] | select(.name==\"$module\") | .versions[]?")"
    if [[ -z "$moduleVersions" ]];then
        pwsh -command "& {Install-Module $module -Force -Scope AllUsers}"
    else
        for version in ${moduleVersions[@]}; do
            echo " - $version"
            pwsh -command "& {Install-Module $module -RequiredVersion $version -Force -Scope AllUsers}"
        done
    fi
done

# A dummy call to initialize .IdentityService directory
pwsh -command "& {Import-Module Az}"

# powershell link was removed in powershell-6.0.0-beta9
sudo ln -s /usr/local/bin/pwsh /usr/local/bin/powershell

invoke_tests "Powershell"

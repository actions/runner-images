#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Monterey needs future review:
# aliyun-cli, gnupg, helm have issues with building from the source code.
# Added gmp for now, because toolcache ruby needs its libs. Remove it when php starts to build from source code.
common_packages=$(get_toolset_value '.brew.common_packages[]')
for package in $common_packages; do
    echo "Installing $package..."
    brew_smart_install "$package"
done

cask_packages=$(get_toolset_value '.brew.cask_packages[]')
for package in $cask_packages; do
    echo "Installing $package..."
    brew install --cask $package
done

# Execute AppleScript to change security preferences for virtualbox
# System Preferences -> Security & Privacy -> General -> Unlock -> Allow -> Not now
if is_Monterey; then
    if is_Veertu; then
        retry=10
        while [ $retry -gt 0 ]; do
            {
                osascript -e 'tell application "System Events" to get application processes where visible is true'
            } && break

            retry=$((retry-1))
            if [ $retry -eq 0 ]; then
                echo "No retry attempts left"
                exit 1
            fi
            sleep 10
        done
    fi

    osascript $HOME/utils/confirm-identified-developers.scpt $USER_PASSWORD
fi

# Invoke bazel to download bazel version via bazelisk
bazel

# Install Azure DevOps extension for Azure Command Line Interface
az extension add -n azure-devops

# Workaround https://github.com/actions/runner-images/issues/4931
# by making Tcl/Tk paths the same on macOS 10.15 and macOS 11
if is_BigSur; then
    version=$(brew info tcl-tk --json | jq -r '.[].installed[].version')
    ln -s /usr/local/Cellar/tcl-tk/$version/lib/libtcl8.6.dylib /usr/local/lib/libtcl8.6.dylib
    ln -s /usr/local/Cellar/tcl-tk/$version/lib/libtk8.6.dylib /usr/local/lib/libtk8.6.dylib
fi

# Invoke tests for all basic tools
invoke_tests "BasicTools"

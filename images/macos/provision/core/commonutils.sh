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

# Load "Parallels International GmbH"
if is_Monterey; then
    sudo kextload /Applications/Parallels\ Desktop.app/Contents/Library/Extensions/10.9/prl_hypervisor.kext || true
fi

# Execute AppleScript to change security preferences
# System Preferences -> Security & Privacy -> General -> Unlock -> Allow -> Not now
if is_Monterey; then
    if is_Veertu; then
        for retry in {4..0}; do
            echo "Executing AppleScript to change security preferences. Retries left: $retry"
            {
                set -e
                osascript -e 'tell application "System Events" to get application processes where visible is true'
                osascript $HOME/utils/confirm-identified-developers.scpt $USER_PASSWORD
            } && break

            if [ "$retry" -eq 0 ]; then
                echo "Executing AppleScript failed. No retries left"
                exit 1
            fi

            echo "Executing AppleScript failed. Sleeping for 10 seconds and retrying"
            sleep 10
        done
    else
        echo "Executing AppleScript to change security preferences"
        osascript $HOME/utils/confirm-identified-developers.scpt $USER_PASSWORD
    fi
fi

# Validate "Parallels International GmbH" kext
if is_Monterey; then
    echo "Closing System Preferences window if it is still opened"
    killall "System Preferences" || true

    echo "Checking parallels kexts"
    dbName="/var/db/SystemPolicyConfiguration/KextPolicy"
    dbQuery="SELECT * FROM kext_policy WHERE bundle_id LIKE 'com.parallels.kext.%';"
    kext=$(sudo sqlite3 $dbName "$dbQuery")

    if [ -z "$kext" ]; then
        echo "Parallels International GmbH not found"
        exit 1
    fi

    # Create env variable
    url=$(brew info --json=v2 --installed | jq -r '.casks[] | select(.name[] == "Parallels Desktop").url')
    if [ -z "$url" ]; then
        echo "Unable to parse url for Parallels Desktop cask"
        exit 1
    fi
    echo "export PARALLELS_DMG_URL=$url" >> "${HOME}/.bashrc"
fi

# Invoke bazel to download bazel version via bazelisk
bazel

# Install Azure DevOps extension for Azure Command Line Interface
az extension add -n azure-devops

# Invoke tests for all basic tools
invoke_tests "BasicTools"

#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-common-utils.sh
##  Desc:  Install utils listed in toolset file
################################################################################

source ~/utils/utils.sh

# Download and install YQ in cases when it is not available in the formulae as for macOS 11: https://formulae.brew.sh/formula/yq
if is_BigSur; then
    binary_path=$(download_with_retry "https://github.com/mikefarah/yq/releases/latest/download/yq_darwin_amd64")
    sudo install "$binary_path" /usr/local/bin/yq
fi

# Monterey needs future review:
# aliyun-cli, gnupg, helm have issues with building from the source code.
# Added gmp for now, because toolcache ruby needs its libs. Remove it when php starts to build from source code.
common_packages=$(get_toolset_value '.brew.common_packages[]')
for package in $common_packages; do
    echo "Installing $package..."
    if is_Monterey && [[ $package == "xcbeautify" ]]; then
        # Pin the version on Monterey as 2.0.x requires Xcode >=15.0 which is not available on OS12
        xcbeautify_path=$(download_with_retry "https://raw.githubusercontent.com/Homebrew/homebrew-core/d3653e83f9c029a3fddb828ac804b07ac32f7b3b/Formula/x/xcbeautify.rb")
        brew install "$xcbeautify_path"
    else
        brew_smart_install "$package"
    fi
done

cask_packages=$(get_toolset_value '.brew.cask_packages[]')
for package in $cask_packages; do
    echo "Installing $package..."
    if is_Monterey && [[ $package == "virtualbox" ]]; then
        # Do not update VirtualBox on macOS 12 due to the issue with VMs in gurumediation state which blocks Vagrant on macOS: https://github.com/actions/runner-images/issues/8730
        # macOS host: Dropped all kernel extensions. VirtualBox relies fully on the hypervisor and vmnet frameworks provided by Apple now.
        virtualbox_cask_path=$(download_with_retry "https://raw.githubusercontent.com/Homebrew/homebrew-cask/aa3c55951fc9d687acce43e5c0338f42c1ddff7b/Casks/virtualbox.rb")
        brew install $virtualbox_cask_path
    else
        brew install --cask $package
    fi
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

            if [[ $retry -eq 0 ]]; then
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

    if [[ -z $kext ]]; then
        echo "Parallels International GmbH not found"
        exit 1
    fi

    # Create env variable
    url=$(brew info --json=v2 --installed | jq -r '.casks[] | select(.name[] == "Parallels Desktop").url')
    if [[ -z $url ]]; then
        echo "Unable to parse url for Parallels Desktop cask"
        exit 1
    fi
    echo "export PARALLELS_DMG_URL=$url" >> ${HOME}/.bashrc
fi

if ! is_BigSur; then
    # Install Azure DevOps extension for Azure Command Line Interface
    az extension add -n azure-devops
fi

# Invoke tests for all basic tools
invoke_tests "BasicTools"

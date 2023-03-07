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
    if [[ $package == "virtualbox" ]]; then
        if ! is_Ventura; then
            # VirtualBox 7 crashes
            # macOS host: Dropped all kernel extensions. VirtualBox relies fully on the hypervisor and vmnet frameworks provided by Apple now.
            vbcask_url="https://raw.githubusercontent.com/Homebrew/homebrew-cask/aa3c55951fc9d687acce43e5c0338f42c1ddff7b/Casks/virtualbox.rb"
            download_with_retries $vbcask_url
            brew install ./virtualbox.rb
            rm ./virtualbox.rb
        fi
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
        retry=5
        while [ $retry -gt 0 ]; do
            {
                osascript -e 'tell application "System Events" to get application processes where visible is true'
            }
            osascript $HOME/utils/confirm-identified-developers.scpt $USER_PASSWORD

            retry=$((retry-1))
            echo "retries left "$retry
            sleep 10
        done
    else
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

# Workaround https://github.com/actions/runner-images/issues/4931
# by making Tcl/Tk paths the same on macOS 10.15 and macOS 11
if is_Monterey; then
    version=$(brew info tcl-tk --json | jq -r '.[].installed[].version')
    ln -s /usr/local/Cellar/tcl-tk/$version/lib/libtcl8.6.dylib /usr/local/lib/libtcl8.6.dylib
    ln -s /usr/local/Cellar/tcl-tk/$version/lib/libtk8.6.dylib /usr/local/lib/libtk8.6.dylib
fi

# Invoke tests for all basic tools
invoke_tests "BasicTools"

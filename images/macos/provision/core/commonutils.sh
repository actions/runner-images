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
        # VirtualBox 7 crashes
        # macOS host: Dropped all kernel extensions. VirtualBox relies fully on the hypervisor and vmnet frameworks provided by Apple now.
        vbcask_url="https://raw.githubusercontent.com/Homebrew/homebrew-cask/aa3c55951fc9d687acce43e5c0338f42c1ddff7b/Casks/virtualbox.rb"
        download_with_retries $vbcask_url
        brew install ./virtualbox.rb
        rm ./virtualbox.rb
    else
        brew install --cask $package
    fi
done


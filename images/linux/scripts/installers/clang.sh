#!/bin/bash -e
################################################################################
##  File:  clang.sh
##  Desc:  Installs Clang compiler
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

function InstallClang {
    local version=$1

    echo "Installing clang-$version..."
    apt-get install -y "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version" 
}

function SetDefaultClang {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
}

versions=$(get_toolset_value '.clang.versions[]')
default_clang_version=$(get_toolset_value '.clang.default_version')

for version in ${versions[*]}; do
    if [[ $version != $default_clang_version ]]; then
        InstallClang $version
    fi
done

InstallClang $default_clang_version
SetDefaultClang $default_clang_version

invoke_tests "Tools" "clang"

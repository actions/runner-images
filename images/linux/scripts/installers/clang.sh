#!/bin/bash -e
################################################################################
##  File:  clang.sh
##  Desc:  Installs Clang compiler
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

function InstallClang {
    local version=$1

    echo "Installing clang-$version..."
    if [[ $version =~ 9 ]] && isUbuntu16; then
        ./llvm.sh $version
        apt-get install -y "clang-format-$version"
    else
        apt-get install -y "clang-$version" "lldb-$version" "lld-$version" "clang-format-$version"
    fi    
}

function SetDefaultClang {
    local version=$1

    echo "Make Clang ${version} default"
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
}

# Download script for automatic installation
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"

versions=$(jq -r '.clang.versions[]' $toolset)
default_clang_version=$(jq -r '.clang.default_version' $toolset)

for version in ${versions[*]}; do
    InstallClang $version
done

SetDefaultClang $default_clang_version
rm llvm.sh

invoke_tests "Tools" "clang"
#!/bin/bash -e
################################################################################
##  File:  gcc.sh
##  Desc:  Installs GNU C++
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

function InstallGcc {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y
}

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"

versions=$(jq -r '.gcc.versions[]' $toolset)

for version in ${versions[*]}; do
    InstallGcc $version
done

invoke_tests "Tools" "gcc"
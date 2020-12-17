#!/bin/bash -e
################################################################################
##  File:  gcc.sh
##  Desc:  Installs GNU C++
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/invoke-tests.sh

function InstallGcc {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y
}

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"

versions=$(jq -r '.Gcc.versions[]' $toolset)

for version in ${versions[*]}; do
    InstallGcc $version
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
invoke_tests "Tools" "Gcc"
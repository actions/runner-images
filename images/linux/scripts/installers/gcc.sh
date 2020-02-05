#!/bin/bash
################################################################################
##  File:  gcc.sh
##  Desc:  Installs GNU C++
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

function InstallGcc {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"
    if ! command -v $version; then
        echo "$version was not installed"
        exit 1
    fi

    # Document what was added to the image
    echo "Documenting $version..."
    DocumentInstalledItem "GNU C++ $($version --version | head -n 1 | cut -d ' ' -f 4)"
}

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=(
    "g++-7"
    "g++-8"
    "g++-9"
)

for version in ${versions[*]}
do
    InstallGcc $version
done

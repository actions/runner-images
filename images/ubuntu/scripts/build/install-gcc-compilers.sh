#!/bin/bash -e
################################################################################
##  File:  install-gcc-compilers.sh
##  Desc:  Install GNU C++ compilers
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=$(get_toolset_value '.gcc.versions[]')

for version in ${versions[*]}; do
    echo "Installing $version..."
    apt-get install $version -y
done

invoke_tests "Tools" "gcc"

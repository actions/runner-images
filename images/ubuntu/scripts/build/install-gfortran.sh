#!/bin/bash -e
################################################################################
##  File:  install-gfortran.sh
##  Desc:  Install GNU Fortran
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

# Install GNU Fortran compiler
if ! is_ubuntu24 ; then
    add-apt-repository ppa:ubuntu-toolchain-r/test -y
    apt-get update -y
fi

versions=$(get_toolset_value '.gfortran.versions[]')

for version in ${versions[*]}; do
    echo "Installing $version..."
    apt-get install $version -y
done

invoke_tests "Tools" "gfortran"

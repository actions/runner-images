#!/bin/bash -e
################################################################################
##  File:  gfortran.sh
##  Desc:  Installs GNU Fortran
################################################################################

source $HELPER_SCRIPTS/os.sh

function InstallFortran {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y
}

# Install GNU Fortran compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
versions=$(jq -r '.gfortran.versions[]' $toolset)

for version in ${versions[*]}
do
    InstallFortran $version
done

invoke_tests "Tools" "gfortran"
#!/bin/bash -e
################################################################################
##  File:  gfortran.sh
##  Desc:  Installs GNU Fortran
################################################################################
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

REPO_URL="http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu"

function InstallFortran {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y
}

# Install GNU Fortran compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=$(get_toolset_value '.gfortran.versions[]')

for version in ${versions[*]}
do
    InstallFortran $version
done

echo "gfortran $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Tools" "gfortran"
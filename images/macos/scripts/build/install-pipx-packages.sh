#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-pipx-packages.sh
##  Desc:  Install Pipx Packages
################################################################################

source ~/utils/utils.sh

export PATH="$PATH:/opt/pipx_bin"

pipx_packages=$(get_toolset_value '.pipx[].package')

for package in $pipx_packages; do
    echo "Install $package into default python"
    pipx install $package
done

invoke_tests "PipxPackages"

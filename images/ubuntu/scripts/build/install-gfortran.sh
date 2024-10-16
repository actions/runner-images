#!/bin/bash -e
################################################################################
##  File:  install-gfortran.sh
##  Desc:  Install GNU Fortran
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

versions=$(get_toolset_value '.gfortran.versions[]')

for version in ${versions[*]}; do
    echo "Installing $version..."
    apt-get install $version
done

echo "Install versionless gfortran (latest)"
apt-get install gfortran

invoke_tests "Tools" "gfortran"

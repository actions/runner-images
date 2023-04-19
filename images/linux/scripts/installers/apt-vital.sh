#!/bin/bash -e
################################################################################
##  File:  apt-vital.sh
##  Desc:  Installs vital command line utilities
################################################################################
source $HELPER_SCRIPTS/install.sh

vital_packages=$(get_toolset_value .apt.vital_packages[])
for package in $vital_packages; do
    echo "Install $package"
    apt-get install -y --no-install-recommends $package
done

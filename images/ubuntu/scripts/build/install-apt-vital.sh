#!/bin/bash -e
################################################################################
##  File:  install-apt-vital.sh
##  Desc:  Install vital command line utilities
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

vital_packages=$(get_toolset_value .apt.vital_packages[])
apt-get install --no-install-recommends $vital_packages

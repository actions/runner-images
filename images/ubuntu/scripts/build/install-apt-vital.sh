#!/bin/bash -e
################################################################################
##  File:  install-apt-vital.sh
##  Desc:  Install vital command line utilities
################################################################################
source $HELPER_SCRIPTS/install.sh

vital_packages=$(get_toolset_value .apt.vital_packages[])
apt-get install -y --no-install-recommends $vital_packages

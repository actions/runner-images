#!/bin/bash -e
################################################################################
##  File:  install-apt-playwright.sh
##  Desc:  Install playwright dependencies
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

playwright_packages=$(get_toolset_value .apt.playwright_packages[])
apt-get install -y --no-install-recommends $playwright_packages

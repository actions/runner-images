#!/bin/bash -e
################################################################################
##  File:  chromium-browser.sh
##  Desc:  Installs Chromium browser
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

if ! isUbuntu20 ; then
    exit 0
fi

#Install chromium browser
apt install chromium-browser -y

invoke_tests "Browsers" "Chromium"

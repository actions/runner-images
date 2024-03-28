#!/bin/bash -e
################################################################################
##  File:  install-playwright.sh
##  Desc:  Install playwright dependencies
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

npm install -g playwright
su ubuntu -c "npx playwright install --with-deps"

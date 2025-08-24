#!/bin/bash -e
################################################################################
##  File:  install-xmllint.sh
##  Desc:  Install xmllint
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

## xmllint is provided by the libxml2-utils package
apt-get update
apt-get install libxml2-utils

invoke_tests "Tools" "xmllint"

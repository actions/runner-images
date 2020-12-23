#!/bin/bash -e
################################################################################
##  File:  pollinate.sh
##  Desc:  Installs Pollinate
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Pollinate
apt-get install -y --no-install-recommends pollinate

invoke_tests "Tools" "Pollinate"

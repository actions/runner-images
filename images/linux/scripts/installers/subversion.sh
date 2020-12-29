#!/bin/bash -e
################################################################################
##  File:  subversion.sh
##  Desc:  Installs Subversion client
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Subversion
apt-get install -y --no-install-recommends subversion

invoke_tests "Tools" "SVN"

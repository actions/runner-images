#!/bin/bash -e
################################################################################
##  File:  sphinx.sh
##  Desc:  Installs Sphinx
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Sphinx
apt-get install -y sphinxsearch

invoke_tests "Tools" "Sphinx"
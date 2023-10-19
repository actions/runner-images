#!/bin/bash -e
################################################################################
##  File:  sphinx.sh
##  Desc:  Installs Sphinx
################################################################################


# Install Sphinx
apt-get install -y sphinxsearch

invoke_tests "Tools" "Sphinx"
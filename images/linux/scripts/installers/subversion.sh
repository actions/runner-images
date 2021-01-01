#!/bin/bash -e
################################################################################
##  File:  subversion.sh
##  Desc:  Installs Subversion client
################################################################################

# Install Subversion
apt-get install -y --no-install-recommends subversion

invoke_tests "Tools" "SVN"

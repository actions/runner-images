#!/bin/bash -e
################################################################################
##  File:  pollinate.sh
##  Desc:  Installs Pollinate
################################################################################

# Install Pollinate
apt-get install -y --no-install-recommends pollinate

invoke_tests "Tools" "Pollinate"

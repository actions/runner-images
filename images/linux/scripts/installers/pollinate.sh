#!/bin/bash -e
################################################################################
##  File:  pollinate.sh
##  Desc:  Installs Pollinate
################################################################################


# Install Pollinate
apt-get install -y --no-install-recommends pollinate

invoke-tests.sh "Tools" "Pollinate"

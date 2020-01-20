#!/bin/bash
################################################################################
##  File:  ruby.sh
##  Desc:  Installs Ruby requirements
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

sudo apt-get install ruby-full
sudo gem update --system

# Install Ruby requirements
apt-get install -y libz-dev openssl libssl-dev
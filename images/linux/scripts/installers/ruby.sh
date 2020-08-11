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

DocumentInstalledItem "ruby ($(ruby --version 2>&1 | cut -d ' ' -f 2))"
DocumentInstalledItem "gem ($(gem -v 2>&1 | tail -n 1))"
DocumentInstalledItem "$(openssl version)"
DocumentInstalledItem "Libssl $(dpkg -l libssl-dev | grep '^ii' | awk '{print $3}')"

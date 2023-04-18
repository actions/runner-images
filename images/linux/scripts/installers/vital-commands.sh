#!/bin/bash -e
################################################################################
##  File:  vital-commands.sh
##  Desc:  Installs vital command line utilities
################################################################################
source $HELPER_SCRIPTS/install.sh

apt-get install -y --no-install-recommends \
  build-essential bzip2 curl jq tar unzip wget

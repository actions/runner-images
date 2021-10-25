#!/bin/bash -e
################################################################################
##  File:  mercurial.sh
##  Desc:  Installs Mercurial
################################################################################

source $HELPER_SCRIPTS/os.sh

apt-get install -y --no-install-recommends mercurial

invoke_tests "Tools" "Mercurial"
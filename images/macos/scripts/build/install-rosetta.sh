#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rosetta.sh
##  Desc:  Install Rosetta
################################################################################

echo "Installing Rosetta"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

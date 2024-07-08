#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-oc-cli.sh
##  Desc:  Install the OC CLI
################################################################################

# Source the helpers for use with the script

source ~/utils/utils.sh

echo "Installing Openshift CLI tools..."
brew_smart_install "openshift-cli"

invoke_tests "OC.Tests" "OC CLI"

#!/bin/bash -e
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

invoke_tests "Tools" "7-Zip"
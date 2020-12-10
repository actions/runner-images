#!/bin/bash -e
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################

source $HELPER_SCRIPTS/invoke-pester-tests.sh

# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

# Run tests to determine that the software installed as expected
invoke-pester-tests "Common.Tools" "7-Zip"
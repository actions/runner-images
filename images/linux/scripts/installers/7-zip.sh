#!/bin/bash -e
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################

# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

# Run tests to determine that the software installed as expected
pwsh -Command "Invoke-PesterTests -TestFile 'Common.Tools' -TestName '7-Zip'"
#!/bin/bash -e
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################

# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

invoke_tests "Tools" "7-Zip"
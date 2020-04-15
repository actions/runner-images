#!/bin/bash
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs Mongo DB
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/document.sh

#  Install Mongo DB
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
version=$(getOSVersionLabel)
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $version/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Validate the installation
echo "Validate the installation"
if ! command -v mongod; then
    echo "mongodb was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "MongoDB on Linux ($(mongod -v|grep -i version 2>&1))"

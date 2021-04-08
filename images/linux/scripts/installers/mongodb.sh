#!/bin/bash -e
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs Mongo DB
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/os.sh

REPO_URL="https://repo.mongodb.org/apt/ubuntu"

#  Install Mongo DB
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
version=$(getOSVersionLabel)
echo "deb [ arch=amd64,arm64 ] $REPO_URL $version/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org

rm /etc/apt/sources.list.d/mongodb-org-4.4.list

echo "mongodb $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "MongoDB"

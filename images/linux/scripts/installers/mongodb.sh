#!/bin/bash -e
################################################################################
##  File:  mongodb.sh
##  Desc:  Installs Mongo DB
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://repo.mongodb.org/apt/ubuntu"
osLabel=$(getOSVersionLabel)
toolsetVersion=$(get_toolset_value '.mongodb.version')

#  Install Mongo DB
wget -qO - https://www.mongodb.org/static/pgp/server-$toolsetVersion.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] $REPO_URL $osLabel/mongodb-org/$toolsetVersion multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$toolsetVersion.list
sudo apt-get update
sudo apt-get install -y mongodb-org

rm /etc/apt/sources.list.d/mongodb-org-$toolsetVersion.list

echo "mongodb $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "MongoDB"

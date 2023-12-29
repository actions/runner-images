#!/bin/bash -e
################################################################################
##  File:  install-mongodb.sh
##  Desc:  Install Mongo DB
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://repo.mongodb.org/apt/ubuntu"
os_label=$(lsb_release -cs)
toolset_version=$(get_toolset_value '.mongodb.version')

#  Install Mongo DB
wget -qO - https://www.mongodb.org/static/pgp/server-$toolset_version.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] $REPO_URL $os_label/mongodb-org/$toolset_version multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$toolset_version.list
sudo apt-get update
sudo apt-get install -y mongodb-org

rm /etc/apt/sources.list.d/mongodb-org-$toolset_version.list

echo "mongodb $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "MongoDB"

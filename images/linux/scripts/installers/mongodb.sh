#!/bin/bash -e
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs Mongo DB
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://repo.mongodb.org/apt/ubuntu"
osLabel=$(getOSVersionLabel)
toolsetVersion=$(get_toolset_value '.mongodb.version')
latestVersion=$(curl $REPO_URL/dists/$osLabel/mongodb-org/ | awk -F'>|<' '{print $3}' | grep "^$toolsetVersion" | tail -1)

#  Install Mongo DB
wget -qO - https://www.mongodb.org/static/pgp/server-$latestVersion.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] $REPO_URL $osLabel/mongodb-org/$latestVersion multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$latestVersion.list
sudo apt-get update
sudo apt-get install -y mongodb-org

rm /etc/apt/sources.list.d/mongodb-org-$latestVersion.list

echo "mongodb $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "MongoDB"

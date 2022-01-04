#!/bin/bash -e
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs Apache Cassandra
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://downloads.apache.org/cassandra"
osLabel=$(getOSVersionLabel)
toolsetVersion=$(get_toolset_value '.cassandra.version')
seriesVersion=$(get_toolset_value '.cassandra.series')

#  Install Apache Cassandra
curl "$REPO_URL/KEYS" | sudo apt-key add -

echo "deb $REPO_URL/debian $seriesVersion main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
sudo apt-get update
sudo apt-get install -y cassandra

rm /etc/apt/sources.list.d/cassandra.sources.list

echo "cassandra $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Databases" "Cassandra"
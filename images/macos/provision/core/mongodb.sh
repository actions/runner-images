#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# MongoDB object-value database
# Install latest release version of MongoDB Community Edition
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x
toolsetVersion=$(get_toolset_value '.mongodb.version')
versionToInstall=$(brew search --formulae /mongodb-community@$toolsetVersion/ | awk -F'/' '{print $3}' | tail -1)

echo "Installing mongodb $versionToInstall"
brew tap mongodb/brew
brew_smart_install "mongodb-community@$versionToInstall"

invoke_tests "Databases" "MongoDB"

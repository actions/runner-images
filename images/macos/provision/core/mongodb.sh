#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# MongoDB object-value database
# Install latest release version of MongoDB Community Edition
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x
toolsetVersion=$(get_toolset_value '.mongodb.version')

echo "Installing mongodb $toolsetVersion"
brew tap mongodb/brew
brew_smart_install "mongodb-community@$toolsetVersion"

invoke_tests "Databases" "MongoDB"

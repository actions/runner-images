#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# MongoDB object-value database
# Install latest release version of MongoDB Community Edition
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x

echo "Installing mongodb..."
brew tap mongodb/brew
brew_smart_install "mongodb-community@5.0"

invoke_tests "Databases" "MongoDB"

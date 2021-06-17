#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# MongoDB object-value database
# installs last version of MongoDB Community Edition
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/v

echo "Installing mongodb..."

brew tap mongodb/brew
brew_smart_install "mongodb-community@4.4"
ln -sf $(brew --prefix mongodb-community@4.4)/bin/* /usr/local/bin/

invoke_tests "Databases" "Mongo"

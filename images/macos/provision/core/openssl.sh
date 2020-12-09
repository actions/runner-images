#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Install latest openssl"
brew install openssl

echo "Install openssl@1.1"
brew install openssl@1.1

# Set brew openssl@1.1 as the default one
ln -sf $(brew --prefix openssl@1.1)/bin/openssl /usr/local/bin/openssl

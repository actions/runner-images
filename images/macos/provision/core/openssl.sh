#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Install latest openssl"
brew install openssl

echo "Install openssl@1.1"
brew install openssl@1.1

# Symlink brew openssl@1.1 to `/usr/local/bin` as Homebrew refuses
ln -sf $(brew --prefix openssl@1.1)/bin/openssl /usr/local/bin/openssl

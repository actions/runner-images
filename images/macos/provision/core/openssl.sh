#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install openssl@3"
brew_smart_install "openssl@3"

# Symlink brew openssl@3 to `/usr/local/bin` as Homebrew refuses
ln -sf $(brew --prefix openssl@3)/bin/openssl /usr/local/bin/openssl

# Most of buildsystems and scripts look up ssl here
ln -sf $(brew --cellar openssl@3)/3* /usr/local/opt/openssl

invoke_tests "OpenSSL"

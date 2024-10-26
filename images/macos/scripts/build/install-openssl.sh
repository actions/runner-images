#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-openssl.sh
##  Desc:  Install openssl
################################################################################

source ~/utils/utils.sh

echo "Install openssl@3"
brew_smart_install "openssl@3"

if ! is_Arm64; then
  # Symlink brew openssl@3 to `/usr/local/bin` as Homebrew refuses
  ln -sf $(brew --prefix openssl@3)/bin/openssl /usr/local/bin/openssl
else
  # arm64 has a different installation prefix for brew
  ln -sf $(brew --prefix openssl@3)/bin/openssl /opt/homebrew/bin/openssl
fi

if ! is_Arm64; then
  # Most of build systems and scripts look up ssl here
  ln -sf $(brew --cellar openssl@3)/3* /usr/local/opt/openssl
fi

invoke_tests "OpenSSL"

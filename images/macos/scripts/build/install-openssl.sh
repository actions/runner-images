#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-openssl.sh
##  Desc:  Install openssl
################################################################################

source ~/utils/utils.sh

echo "Install openssl@1.1"

COMMIT=d91dabd087cb0b906c92a825df9e5e5e1a4f59f8
FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/o/openssl@1.1.rb"
FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/o/openssl@1.1.rb"
mkdir -p "$(dirname $FORMULA_PATH)"
curl -fsSL $FORMULA_URL -o $FORMULA_PATH
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install openssl@1.1

if ! is_Arm64; then
  # Symlink brew openssl@1.1 to `/usr/local/bin` as Homebrew refuses
  ln -sf $(brew --prefix openssl@1.1)/bin/openssl /usr/local/bin/openssl
else
  # arm64 has a different installation prefix for brew
  ln -sf $(brew --prefix openssl@1.1)/bin/openssl /opt/homebrew/bin/openssl
fi

if ! is_Arm64; then
  # Most of build systems and scripts look up ssl here
  ln -sf $(brew --cellar openssl@1.1)/1.1* /usr/local/opt/openssl
fi

invoke_tests "OpenSSL"

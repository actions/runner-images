#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-openssl.sh
##  Desc:  Install openssl
################################################################################

source ~/utils/utils.sh

if is_Tahoe || is_GoldenGate; then
  echo "Set openssl@4 as the default OpenSSL"
  ln -sf "$(brew --prefix openssl@4)/bin/openssl" "$(brew --prefix)/bin/openssl"
  invoke_tests "OpenSSL"
  exit 0
fi

if brew list --versions openssl@4 > /dev/null 2>&1; then
  echo "Unlink openssl@4 before installing openssl@1.1"
  brew unlink openssl@4
fi

echo "Install openssl@1.1"

COMMIT=d91dabd087cb0b906c92a825df9e5e5e1a4f59f8
FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/o/openssl@1.1.rb"
FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/o/openssl@1.1.rb"
mkdir -p "$(dirname $FORMULA_PATH)"
curl -fsSL $FORMULA_URL -o $FORMULA_PATH

if is_SequoiaArm64; then
  # Since Homebrew 7.0.13, an install with HOMEBREW_NO_INSTALL_FROM_API=1 looks up
  # dependencies only in the local tap, so the ca-certificates formula must be there too.
  # Copy the formula of the installed version so ca-certificates is left unchanged.
  brew_smart_install ca-certificates
  CA_FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/c/ca-certificates.rb"
  mkdir -p "$(dirname "$CA_FORMULA_PATH")"
  cp "$(brew --prefix ca-certificates)/.brew/ca-certificates.rb" "$CA_FORMULA_PATH"
fi

HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install openssl@1.1

if brew list --versions openssl@4 > /dev/null 2>&1; then
  echo "Unlink openssl@1.1 and relink openssl@4"
  brew unlink openssl@1.1
  brew link openssl@4
fi

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

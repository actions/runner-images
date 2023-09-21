#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install openssl@1.1"
brew_smart_install "openssl@1.1"

if ! is_VenturaArm64; then
  # Symlink brew openssl@1.1 to `/usr/local/bin` as Homebrew refuses
  ln -sf $(brew --prefix openssl@1.1)/bin/openssl /usr/local/bin/openssl
else
  # arm64 has a different installation prefix for brew
  ln -sf $(brew --prefix openssl@1.1)/bin/openssl /opt/homebrew/bin/openssl
fi

if ! is_VenturaArm64; then
  # Most of buildsystems and scripts look up ssl here
  ln -sf $(brew --cellar openssl@1.1)/1.1* /usr/local/opt/openssl
fi

invoke_tests "OpenSSL"

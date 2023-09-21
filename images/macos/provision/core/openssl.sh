#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install openssl@1.1"
brew_smart_install "openssl@1.1"

# Intel-related symlinks, not needed on arm64 for now
if ! is_VenturaArm64; then
  # Symlink brew openssl@1.1 to `/usr/local/bin` as Homebrew refuses
  ln -sf $(brew --prefix openssl@1.1)/bin/openssl /usr/local/bin/openssl

  # Most of buildsystems and scripts look up ssl here
  ln -sf $(brew --cellar openssl@1.1)/1.1* /usr/local/opt/openssl
fi

invoke_tests "OpenSSL"

#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo Installing OpenSSL...
brew install openssl

# Install OpenSSL 1.0.2t
# https://www.openssl.org/policies/releasestrat.html - Version 1.0.2 will be supported until 2019-12-31 (LTS)
# To preserve backward compatibility with ruby-toolcache
brew tap-new --no-git local/openssl
FORMULA_PATH=$(brew extract openssl local/openssl | grep "Homebrew/Library/Taps")
brew install $FORMULA_PATH

# Set OpenSSL 1.0.2t as default
ln -sf /usr/local/Cellar/openssl@1.0.2t /usr/local/Cellar/openssl
ln -sf /usr/local/Cellar/openssl/1.0.2t/bin/openssl /usr/local/bin/openssl
rm /usr/local/opt/openssl
ln -sf ../Cellar/openssl/1.0.2t /usr/local/opt/openssl

# Resolve dot net core openssl dependency issue for agent
# https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/start/envosx.md
mkdir -p /usr/local/lib/
ln -s /usr/local/opt/openssl@1.0.2t/lib/libcrypto.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl@1.0.2t/lib/libssl.1.0.0.dylib /usr/local/lib/

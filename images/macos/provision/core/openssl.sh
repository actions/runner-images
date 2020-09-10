#!/bin/sh
echo "Installing OpenSSL..."
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

echo Installing OpenSSL...
/usr/local/bin/brew install openssl
/usr/local/bin/brew link openssl --force

# Install OpenSSL 1.0.2t
# https://www.openssl.org/policies/releasestrat.html - Version 1.0.2 will be supported until 2019-12-31 (LTS)
# To preserve backward compatibility with ruby-toolcache
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/8b9d6d688f483a0f33fcfc93d433de501b9c3513/Formula/openssl.rb

# Set OpenSSL 1.0.2t as default
ln -sf /usr/local/Cellar/openssl/1.*/bin/openssl /usr/local/bin/openssl

# Resolve dot net core openssl dependency issue for agent
# https://github.com/microsoft/azure-pipelines-agent/blob/master/docs/start/envosx.md
mkdir -p /usr/local/lib/
ln -s /usr/local/opt/openssl*/lib/libcrypto.1.0.*.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl*/lib/libssl.1.0.*.dylib /usr/local/lib/
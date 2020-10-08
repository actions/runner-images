#!/bin/sh

source ~/utils/utils.sh

echo "Installing OpenSSL..."
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

echo Installing OpenSSL...
/usr/local/bin/brew install openssl

if is_BigSur; then
    ln -sf $(brew --prefix openssl)/bin/openssl /usr/local/bin/openssl
    exit 0
fi

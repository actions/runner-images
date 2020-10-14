#!/bin/sh

echo Installing OpenSSL...
/usr/local/bin/brew install openssl

ln -sf $(brew --prefix openssl)/bin/openssl /usr/local/bin/openssl
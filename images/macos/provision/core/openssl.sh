#!/bin/sh

echo Installing OpenSSL...
/usr/local/bin/brew install openssl

ln -sf $(/usr/local/bin/brew --prefix openssl)/bin/openssl /usr/local/bin/openssl
ln -sf $(/usr/local/bin/brew --prefix openssl) /usr/local/opt/openssl

#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-openssl.sh
##  Desc:  Install openssl
################################################################################

source ~/utils/utils.sh

echo "Install openssl@1.1"

wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz
tar -xvf openssl-1.1.1w.tar.gz
cd openssl-1.1.1w
./config --prefix=/usr/local/openssl
make
sudo make install
export OPENSSL="/usr/local/openssl/bin"
echo "export OPENSSL=${OPENSSL}" >> ${HOME}/.bashrc

if ! is_Arm64; then
  ln -sf ${OPENSSL}/openssl /usr/local/bin/openssl
  ln -sf ${OPENSSL}/openssl /usr/local/opt/openssl
else
  ln -sf ${OPENSSL}/openssl /opt/homebrew/bin/openssl
fi

invoke_tests "OpenSSL"

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

ln -sf /usr/local/openssl/bin/openssl /usr/local/bin/openssl

if ! is_Arm64; then
  # Most of build systems and scripts look up ssl here
  ln -sf $(brew --cellar openssl@1.1)/1.1* /usr/local/opt/openssl
fi

invoke_tests "OpenSSL"

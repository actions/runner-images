#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Build openssl from src
apt install build-essential checkinstall zlib1g-dev -y
cd /usr/local/src/
wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz
tar -xf openssl-1.1.1n.tar.gz
cd openssl-1.1.1n
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
make
make test
make install

# Install Powershell
#apt-get install -y powershell
wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
dpkg --ignore-depends=libssl1.1 -i powershell_7.2.2-1.deb_amd64.deb
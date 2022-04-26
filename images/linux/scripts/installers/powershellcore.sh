#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

if isUbuntu22; then
    # Build openssl from src
    apt install build-essential checkinstall zlib1g-dev equivs -y
    cd /usr/local/src/
    wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz
    tar -xf openssl-1.1.1n.tar.gz
    cd openssl-1.1.1n
    ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
    make
    make test
    make install

    # Create symlinks
    ln -s /usr/local/ssl/lib/libssl.so.1.1 /lib/libssl.so.1.0.0
    ln -s /usr/local/ssl/lib/libcrypto.so.1.1 /lib/libcrypto.so.1.0.0

    # make dummy deb pkg
    equivs-control libssl1.1.control
    sed -i 's/<package name; defaults to equivs-dummy>/libssl1.1/g' libssl1.1.control
    dpkg -i libssl1.1_1.0_all.deb

    # Install Powershell
    wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
    dpkg -i powershell_7.2.2-1.deb_amd64.deb
    rm -rf libssl1.1_1.0_all.deb powershell_7.2.2-1.deb_amd64.deb
else
    # Install Powershell
    apt-get install -y powershell
fi
#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

if isUbuntu22; then
    # Install libssl
    wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb
    dpkg -i libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb

    # Install Powershell
    wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell_7.2.2-1.deb_amd64.deb
    dpkg -i powershell_7.2.2-1.deb_amd64.deb
    rm -rf libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb powershell_7.2.2-1.deb_amd64.deb
else
    # Install Powershell
    apt-get install -y powershell
fi

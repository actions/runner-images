#!/bin/bash
################################################################################
##  File:  go.sh
##  Desc:  Installs go, configures GOROOT, and adds go to the path
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# This function installs Go using the specified arguments:
#   $1=MajorVersion (1.11)
#   $2=MajorAndMinorVersion (1.11.1)
#   $3=IsDefaultVersion (true or false)
function InstallGo () {
    curl -sL https://dl.google.com/go/go$2.linux-amd64.tar.gz -o go$2.linux-amd64.tar.gz
    mkdir -p /usr/local/go$1
    tar -C /usr/local/go$1 -xzf go$2.linux-amd64.tar.gz --strip-components=1 go
    rm go$2.linux-amd64.tar.gz
    echo "GOROOT_${1//./_}_X64=/usr/local/go$1" | tee -a /etc/environment
    DocumentInstalledItem "Go $1 ($(/usr/local/go$1/bin/go version))"

    # If this version of Go is to be the default version,
    # symlink it into the path and point GOROOT to it.
    if [ $3 = true ]
    then
        ln -s /usr/local/go$1/bin/* /usr/bin/
        echo "GOROOT=/usr/local/go$1" | tee -a /etc/environment
    fi
}

# Install Go versions
InstallGo 1.11 1.11.12 false
InstallGo 1.12 1.12.7 true
InstallGo 1.13 1.13 false

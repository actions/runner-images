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
    pattern="refs/tags/go$1([.0-9]{0,3})$"

    ref=$( echo ./tmp/output.json | jq --arg pattern "$pattern" '[.[] | select( .ref | test($pattern))] | .[-1] | .ref' )
    echo $ref
    version=$(echo "$ref" | cut -d '/' -f 3) # go1.12.17
    echo $version
    curl -sL https://dl.google.com/go/$version.linux-amd64.tar.gz -o $version.linux-amd64.tar.gz
    mkdir -p /usr/local/go$1
    tar -C /usr/local/go$1 -xzf $version.linux-amd64.tar.gz --strip-components=1 go
    rm $version.linux-amd64.tar.gz
    echo "GOROOT_${1//./_}_X64=/usr/local/go$1" | tee -a /etc/environment
    DocumentInstalledItem "Go $1 ($(/usr/local/go$1/bin/go version))"

    # If this version of Go is to be the default version,
    # symlink it into the path and point GOROOT to it.
    if [ $2 = true ]
    then
        ln -s /usr/local/go$1/bin/* /usr/bin/
        echo "GOROOT=/usr/local/go$1" | tee -a /etc/environment
    fi
}

# load json file
curl -s 'https://api.github.com/repos/golang/go/git/refs/tags' >> /tmp/output.json

# Install Go versions
InstallGo 1.11 false
InstallGo 1.12 false
InstallGo 1.13 true
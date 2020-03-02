#!/bin/bash
################################################################################
##  File:  go.sh
##  Desc:  Installs go, configures GOROOT, and adds go to the path
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
golangTags="/tmp/golang_tags.json"
# This function installs Go using the specified arguments:
#   $1=MajorVersion (1.11)
#   $2=IsDefaultVersion (true or false)
function InstallGo () {
    pattern="refs/tags/go$1([.0-9]{0,3})$"
    conditionJq='[.[] | select( .ref | test($pattern))] | .[-1] | .ref'
    ref=$(jq --arg pattern "$pattern" "$conditionJq" $golangTags)
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

# load golang_tags.json file
curl -s 'https://api.github.com/repos/golang/go/git/refs/tags' >> $golangTags

# Install Go versions

IFS=',' # hyphen (-) is set as delimiter
for go in "${GO_VERSIONS[@]}"; do
    echo "Installing Go ${go}"
    if($go == $env:GO_DEFAULT) {
        InstallGo $go true
    } else {
        InstallGo $go false
    }
done
IFS=' ' # reset to default value after usage
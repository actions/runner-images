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
    version=$( getFullGoVersion $1 )
    downloadVersion="go$version.linux-amd64.tar.gz"
    goFolder="$AGENT_TOOLSDIRECTORY/go/$version/x64"

    echo "Install Go $version"
    curl -sL https://dl.google.com/go/${downloadVersion} -o ${downloadVersion}
    mkdir -p $goFolder
    tar -C $goFolder -xzf $downloadVersion --strip-components=1 go
    rm $downloadVersion
    echo "GOROOT_${1//./_}_X64=$goFolder" | tee -a /etc/environment
    DocumentInstalledItem "Go $version ($($goFolder/bin/go version))"

    # Create symlink in old location /usr/local/go<version> to new location
    ln -s $goFolder /usr/local/go$version

    # If this version of Go is to be the default version,
    # symlink it into the path and point GOROOT to it.
    if [ $2 = true ]
    then
        ln -s $goFolder/bin/* /usr/bin/
        echo "GOROOT=$goFolder" | tee -a /etc/environment
    fi
}

function getFullGoVersion () {
    local pattern="refs/tags/go$1([.0-9]{0,3})$"
    local query='[.[] | select( .ref | test($pattern))] | .[-1] | .ref'
    refValue=$(jq --arg pattern "$pattern" "$query" $golangTags)
    version=$(echo "$refValue" | cut -d '/' -f 3 | awk -F 'go' '{print $2}')
    version=$(echo "${version//\"}") # 1.12.17
    echo $version
}

# load golang_tags.json file
curl -s 'https://api.github.com/repos/golang/go/git/refs/tags' > $golangTags
# Install Go versions
for go in ${GO_VERSIONS}; do
    echo "Installing Go ${go}"
    if [[ $go == $GO_DEFAULT ]]; then
        InstallGo $go true
    else
        InstallGo $go false
    fi
done

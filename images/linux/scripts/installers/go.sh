#!/bin/bash
################################################################################
##  File:  go.sh
##  Desc:  Installs go, configures GOROOT, and adds go to the path
################################################################################

# Fail out if any setups fail
set -e

toolsetJson="$INSTALLER_SCRIPT_FOLDER/toolset.json"
toolsetVersions=(`ls $AGENT_TOOLSDIRECTORY/go`)
defaultVersion=$(jq -r '.toolcache[] | select(.name | contains("go")) | .default' $toolsetJson)

for toolsetVersion in ${toolsetVersions[@]}
do
    major="$(cut -d'.' -f1 <<< "$toolsetVersion")"
    minor="$(cut -d'.' -f2 <<< "$toolsetVersion")"
    goFolder="$AGENT_TOOLSDIRECTORY/go/$toolsetVersion/x64"

    echo "GOROOT_${major}_${minor}_X64=$goFolder" | tee -a /etc/environment

    if [[ "$toolsetVersion" =~ $defaultVersion ]]; then
        ln -s $goFolder/bin/* /usr/bin/
        echo "GOROOT=$goFolder" | tee -a /etc/environment
    fi
done
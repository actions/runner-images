#!/bin/bash
################################################################################
##  File:  go.sh
##  Desc:  Installs go, configures GOROOT, and adds go to the path
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
# Fail out if any setups fail
set -e

toolsetJson="$INSTALLER_SCRIPT_FOLDER/toolset.json"
toolsetVersions=$(cat $toolsetJson | jq -r '.toolcache[] | select(.name | contains("go")) | .versions[]')
defaultVersion=$(cat $toolsetJson | jq -r '.toolcache[] | select(.name | contains("go")) | .default')

for toolsetVersion in $toolsetVersions; do
    version="$(cut -d'.' -f1,2 <<< "$toolsVersion")"
    goFolder="$AGENT_TOOLSDIRECTORY/go/$toolsetVersion/x64"
    echo "GOROOT_${version//d+/_}_X64=$goFolder" | tee -a /etc/environment
    DocumentInstalledItem "Go version ($($goFolder/bin/go version))"
done

defaultGoFolder="$AGENT_TOOLSDIRECTORY/go/$defaultVersion/x64"
ln -s $defaultGoFolder/bin/* /usr/bin/
echo "GOROOT=$defaultGoFolder" | tee -a /etc/environment
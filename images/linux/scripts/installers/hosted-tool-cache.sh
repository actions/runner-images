#!/bin/bash
################################################################################
##  File:  hosted-tool-cache.sh
##  Desc:  Downloads and installs hosted tools cache
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Fail out if any setups fail
set -e

AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
mkdir $AGENT_TOOLSDIRECTORY
echo "AGENT_TOOLSDIRECTORY=$AGENT_TOOLSDIRECTORY" | tee -a /etc/environment

chmod -R 777 $AGENT_TOOLSDIRECTORY

echo "Installing npm-toolcache..."
TOOLSET_PATH="$INSTALLER_SCRIPT_FOLDER/toolcache.json"

PACKAGE_LIST=($(jq -r 'keys | .[]' $TOOLSET_PATH))

for PACKAGE_NAME in ${PACKAGE_LIST[@]}; do
    PACKAGE_VERSIONS=($(jq -r ".[\"$PACKAGE_NAME\"] | .[]" $TOOLSET_PATH))
    for PACKAGE_VERSION in ${PACKAGE_VERSIONS[@]}; do
        echo "Install ${PACKAGE_NAME}@${PACKAGE_VERSION}"
        npm install ${PACKAGE_NAME}@${PACKAGE_VERSION} --registry=${TOOLCACHE_REGISTRY}
    done;
done;

DocumentInstalledItem "Python:"
pythons=$(ls $AGENT_TOOLSDIRECTORY/Python)
for python in $pythons; do
	DocumentInstalledItemIndent "Python $python"
done;

DocumentInstalledItem "Ruby:"
rubys=$(ls $AGENT_TOOLSDIRECTORY/Ruby)
for ruby in $rubys; do
	DocumentInstalledItemIndent "Ruby $ruby"
done;

DocumentInstalledItem "PyPy:"
pypys=$(ls $AGENT_TOOLSDIRECTORY/PyPy)
for pypy in $pypys; do
	DocumentInstalledItemIndent "PyPy $pypy"
done;

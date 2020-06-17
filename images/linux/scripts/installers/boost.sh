#!/bin/bash
################################################################################
##  File:  boost.sh
##  Desc:  Installs Boost C++ Libraries
################################################################################

TOOLSET_PATH="$INSTALLER_SCRIPT_FOLDER/toolset.json"
BOOST_LIB="$AGENT_TOOLSDIRECTORY/boost"
BOOST_VERSIONS=$(cat $TOOLSET_PATH | jq -r '.toolcache[] | select(.name | contains("boost")) | .versions[]')
BOOST_ARCH=$(cat $TOOLSET_PATH | jq -r '.toolcache[] | select(.name | contains("boost")) | .arch')

# Install Boost
for BOOST_VERSION in ${BOOST_VERSIONS}
do
    BOOST_SYMLINK_VER=$(echo "${BOOST_VERSION//[.]/_}")
    BOOST_ROOT_VERSION="BOOST_ROOT_$BOOST_SYMLINK_VER"

    echo "$BOOST_ROOT_VERSION=$BOOST_LIB/$BOOST_VERSION/$BOOST_ARCH" | tee -a /etc/environment
done

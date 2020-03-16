#!/bin/bash
################################################################################
##  File:  boost.sh
##  Desc:  Installs Boost C++ Libraries
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

TOOLSET_PATH="$INSTALLER_SCRIPT_FOLDER/toolcache.json"
BOOST_LIB=/usr/local/share/boost
BOOST_VERSIONS=$(cat $TOOLSET_PATH | jq -r 'to_entries[] | select(.key | match("boost")) | .value[] +".0"')

# Install Boost
for BOOST_VERSION in ${BOOST_VERSIONS}
do
    BOOST_SYMLINK_VER=$(echo "${BOOST_VERSION//[.]/_}")
    BOOST_ROOT_VERSION="BOOST_ROOT_$BOOST_SYMLINK_VER"

    echo "$BOOST_ROOT_VERSION=$BOOST_LIB/$BOOST_VERSION" | tee -a /etc/environment
    DocumentInstalledItem "Boost C++ Libraries $BOOST_VERSION"
done

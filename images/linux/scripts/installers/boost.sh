#!/bin/bash
################################################################################
##  File:  boost.sh
##  Desc:  Installs Boost C++ Libraries
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

BOOST_LIB=/usr/local/share/boost

# Install Boost
for BOOST_VERSION in ${BOOST_VERSIONS//,/ }
do
    BOOST_SYMLINK_VER=`echo "${BOOST_VERSION//[.]/_}"`
    BOOST_ROOT="BOOST_ROOT_$BOOST_SYMLINK_VER"

    wget -q https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_SYMLINK_VER}.tar.bz2
    tar -xf boost_${BOOST_SYMLINK_VER}.tar.bz2
    cd boost_${BOOST_SYMLINK_VER}
    ./bootstrap.sh --prefix=$BOOST_LIB/$BOOST_VERSION
    ./b2 install

    echo "$BOOST_ROOT=$BOOST_LIB/$BOOST_VERSION" | tee -a /etc/environment
    if [[ $BOOST_VERSION == $BOOST_DEFAULT ]]; then
        echo "BOOST_ROOT=$BOOST_LIB/$BOOST_VERSION" | tee -a /etc/environment
    fi

    DocumentInstalledItem "Boost C++ Libraries $BOOST_VERSION"
done

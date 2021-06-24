#!/bin/bash -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if [ -z $YQ_VERSION ]; then
    YQ_VERSION=v4.9.6
    YQ_BINARY=yq_linux_amd64

    # As per https://github.com/mikefarah/yq#wget
    YQ_URL="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz"
    
    download_with_retries "$YQ_URL" "/tmp" "${YQ_BINARY}.tar.gz"
    tar xzf "/tmp/${YQ_BINARY}.tar.gz"
    mv ${YQ_BINARY} /usr/bin/yq
else
    echo "yq already installed with version $YQ_VERSION"
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if [ ! "$(yq -n eval '.somekey = "somevalue"')" = "somekey: somevalue" ]; then
    echo "yq installation failed"
    exit 1
else
    echo "yq successfully installed"
fi

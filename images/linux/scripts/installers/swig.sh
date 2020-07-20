#!/bin/bash
################################################################################
##  File:  swig.sh
##  Desc:  Installs Swig
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Swig
apt-get update -y
sudo apt-get install -y swig

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v swig; then
    echo "Swig was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "$(swig -version | sed -n 2p)"

#!/bin/bash
################################################################################
##  File:  ninja.sh
##  Desc:  Installs ninja
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

set -e

echo "Install ninja"
apt-get install -y --no-install-recommends ninja-build

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v ninja ; then
    echo "$cmd was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "ninja"

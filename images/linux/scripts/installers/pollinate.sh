#!/bin/bash
################################################################################
##  File:  pollinate.sh
##  Desc:  Installs Pollinate
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Pollinate
apt-get install -y --no-install-recommends pollinate

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v pollinate; then
    echo "pollinate was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Pollinate"

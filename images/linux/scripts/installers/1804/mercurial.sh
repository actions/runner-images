#!/bin/bash
################################################################################
##  File:  mercurial.sh
##  Desc:  Installs Mercurial
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

apt-get install -y --no-install-recommends mercurial

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v hg; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Mercurial ($(hg --version | head -n 1))"

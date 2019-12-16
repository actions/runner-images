#!/bin/bash
################################################################################
##  File:  subversion.sh
##  Desc:  Installs Subversion client
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Subversion
apt-get install -y --no-install-recommends subversion

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v svn; then
    echo "Subversion (svn) was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Subversion ($(svn --version | head -n 1))"

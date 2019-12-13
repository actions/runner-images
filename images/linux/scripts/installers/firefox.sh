#!/bin/bash
################################################################################
##  File:  firefox.sh
##  Desc:  Installs Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Install Firefox
apt-get install -y firefox

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v firefox; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
# Resolves: Running Firefox as root in a regular user's session is not supported.
#           ($HOME is /home/packer which is owned by packer.)
HOME=/root
DocumentInstalledItem "Firefox ($(firefox --version))"

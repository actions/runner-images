#!/bin/bash
################################################################################
##  File:  7-zip.sh
##  Desc:  Installs 7-zip
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install 7-Zip
apt-get update -y
apt-get install -y p7zip p7zip-full p7zip-rar

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v 7z; then
    echo "7-Zip was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "7-Zip $(7z i | head --lines=2 | cut -d ' ' -f 3 | tr -d '\n')"

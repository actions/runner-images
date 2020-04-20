#!/bin/bash
################################################################################
##  File:  open-cobol.sh
##  Desc:  Installs OpenCOBOL
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install OpenCOBOL
apt-get install open-cobol -y
cobc --version

# Run tests to determine that the software installed as expected
echo "Testing OpenCOBOL installation"
if ! command -v cobc; then
    echo "OpenCOBOL was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, document the installed version"
DocumentInstalledItem "OpenCOBOL ($(echo $(cobc -V) | cut -d ' ' -f3))"

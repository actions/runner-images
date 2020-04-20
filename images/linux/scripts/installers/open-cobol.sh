#!/bin/bash
################################################################################
##  File:  open-cobol.sh
##  Desc:  Installs open-cobol
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install open-cobol
apt-get update
apt-get install gcc open-cobol -y
cobc --version

# Run tests to determine that the software installed as expected
echo "Testing open-cobol installation"
if ! command -v cobc; then
    echo "open-cobol was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, document the installed version"
DocumentInstalledItem "Open-Cobol ($(echo $(cobc -V) | cut -c 18-22))"

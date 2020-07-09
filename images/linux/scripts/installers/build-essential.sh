#!/bin/bash
################################################################################
##  File:  build-essential.sh
##  Desc:  Installs build-essential package
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/install.sh

PACKAGE=build-essential

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if ! IsPackageInstalled $PACKAGE; then
    echo "Installing $PACKAGE"
    apt-get install -y --no-install-recommends $PACKAGE
else
    echo "$PACKAGE is already installed"
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "$PACKAGE"

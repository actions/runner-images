#!/bin/bash -e
################################################################################
##  File:  bicep.sh
##  Desc:  Installs bicep cli
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Bicep CLI
download_with_retries "https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64" "." "bicep.bin"
# Mark it as executable
chmod +x ./bicep.bin
# Add bicep to PATH (requires admin)
sudo mv ./bicep.bin /usr/local/bin/bicep

invoke_tests "Tools" "Bicep"
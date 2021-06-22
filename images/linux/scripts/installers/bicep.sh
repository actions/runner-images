#!/bin/bash -e
################################################################################
##  File:  bicep.sh
##  Desc:  Installs bicep cli
################################################################################

# Fetch the latest Bicep CLI binary
curl -Lo bicep.bin https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
# Mark it as executable
chmod +x ./bicep.bin
# Add bicep to PATH (requires admin)
sudo mv ./bicep.bin /usr/local/bin/bicep

invoke_tests "Tools" "Bicep"
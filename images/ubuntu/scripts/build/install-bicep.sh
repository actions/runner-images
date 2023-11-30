#!/bin/bash -e
################################################################################
##  File:  install-bicep.sh
##  Desc:  Install bicep cli
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Bicep CLI
bicep_binary_path=$(download_with_retry "https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64")
# Mark it as executable
install "$bicep_binary_path" /usr/local/bin/bicep

invoke_tests "Tools" "Bicep"

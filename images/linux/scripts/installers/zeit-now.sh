#!/bin/bash
################################################################################
##  File:  zeit-now.sh
##  Desc:  Installs the Zeit Now CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install the Zeit Now CLI
npm i -g now

# Validate the installation
echo "Validate the installation"
if ! command -v now; then
    echo "Zeit Now CLI was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "Zeit Now CLI ($(now --version))"

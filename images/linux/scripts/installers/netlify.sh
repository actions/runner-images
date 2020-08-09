#!/bin/bash
################################################################################
##  File:  netlify.sh
##  Desc:  Installs the Netlify CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install the Netlify CLI
npm i -g netlify-cli

# Validate the installation
echo "Validate the installation"
if ! command -v netlify; then
    echo "Netlify CLI was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "Netlify CLI ($(netlify --version))"

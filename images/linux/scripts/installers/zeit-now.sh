#!/bin/bash
################################################################################
##  File:  zeit-now.sh
##  Desc:  Installs the Zeit Now CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install the Zeit Vercel CLI
npm i -g vercel

# Validate the installation
echo "Validate the installation"
if ! command -v vercel; then
    echo "Zeit Vercel CLI was not installed"
    exit 1
fi

echo "Creating the symlink now to vercel"
ln -s /usr/local/bin/vercel /usr/local/bin/now

echo "Validate the link"
if ! command -v now; then
    echo "Now link to Zeit Vercel CLI was not created"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "Zeit Vercel CLI ($(vercel --version))"

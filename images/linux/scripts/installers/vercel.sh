#!/bin/bash
################################################################################
##  File:  vercel.sh
##  Desc:  Installs the Vercel CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install the Vercel CLI
npm i -g vercel

# Validate the installation
echo "Validate the installation"
if ! command -v vercel; then
    echo "Vercel CLI was not installed"
    exit 1
fi

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

echo "Validate the link"
if ! command -v now; then
    echo "[Now] symlink to Vercel CLI was not created"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "Vercel CLI ($(vercel --version))"

#!/bin/bash
################################################################################
##  File:  google-cloud-sdk.sh
##  Desc:  Installs the Google Cloud SDK
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/document.sh

# Install the Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update -y
sudo apt-get install -y google-cloud-sdk

# Validate the installation
echo "Validate the installation"
if ! command -v gcloud; then
    echo "gcloud was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "Google Cloud SDK ($(gcloud --version | head -n 1 | cut -d ' ' -f 4))"

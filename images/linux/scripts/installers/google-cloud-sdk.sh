#!/bin/bash -e
################################################################################
##  File:  google-cloud-sdk.sh
##  Desc:  Installs the Google Cloud SDK
################################################################################

REPO_URL="https://packages.cloud.google.com/apt"

# Install the Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] $REPO_URL cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update -y
sudo apt-get install -y google-cloud-sdk

# remove apt
rm /etc/apt/sources.list.d/google-cloud-sdk.list
rm /usr/share/keyrings/cloud.google.gpg /usr/share/keyrings/cloud.google.gpg~

# add repo to the apt-sources.txt
echo "google-cloud-sdk $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "CLI.Tools" "Google Cloud SDK"
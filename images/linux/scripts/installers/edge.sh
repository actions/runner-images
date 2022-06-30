#!/bin/bash -e
################################################################################
##  File:  edge.sh
##  Desc:  Installs Edge
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Update Ubuntu
apt update && sudo apt upgrade -y

# Import Microsoft Edge GPG Key and Repository
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg

# Import the Microsoft Edge Repo
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list

# Refresh repository list
sudo apt update

# Install Microsoft Edge Browser
sudo apt install microsoft-edge-stable

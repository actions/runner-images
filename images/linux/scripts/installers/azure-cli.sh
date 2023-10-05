#!/bin/bash -e
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
# temporary pin v2.25.0
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
gpg --dearmor |
sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
AZ_DIST=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
AZ_VER=2.52.0
sudo apt-get install azure-cli=$AZ_VER-1~$AZ_DIST
echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt
rm -f /etc/apt/sources.list.d/azure-cli.list
rm -f /etc/apt/sources.list.d/azure-cli.list.save

invoke_tests "CLI.Tools" "Azure CLI"

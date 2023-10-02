#!/bin/bash -e
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
echo "AZURE_EXTENSION_DIR=$AZURE_EXTENSION_DIR" | tee -a /etc/environment

export AZURE_CONFIG_DIR=/opt/az/config
echo "AZURE_CONFIG_DIR=$AZURE_CONFIG_DIR" | tee -a /etc/environment

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt
rm -f /etc/apt/sources.list.d/azure-cli.list
rm -f /etc/apt/sources.list.d/azure-cli.list.save

# Warm-up CLI

# az --version performs an update check and caches the results
az --version >> /dev/null
# az --help forces a command cache rebuild
az --help >> /dev/null

invoke_tests "CLI.Tools" "Azure CLI"

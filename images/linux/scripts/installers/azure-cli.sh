#!/bin/bash -e
################################################################################
##  File:  azure-cli.sh
##  Desc:  Installed Azure CLI (az)
################################################################################

source $HELPER_SCRIPTS/etc-environment.sh
# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
setEtcEnvironmentVariable "AZURE_EXTENSION_DIR" "$AZURE_EXTENSION_DIR"

export AZURE_CONFIG_DIR=/opt/az/config
setEtcEnvironmentVariable "AZURE_CONFIG_DIR" "$AZURE_CONFIG_DIR"

sudo mkdir /opt/az

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt
rm -f /etc/apt/sources.list.d/azure-cli.list
rm -f /etc/apt/sources.list.d/azure-cli.list.save

# Warm-up CLI

# az --version performs an update check and caches the results
az --version > /dev/null
# az --help forces a command cache rebuild
az --help > /dev/null

invoke_tests "CLI.Tools" "Azure CLI"

chown -R "$SUDO_USER:$SUDO_USER" "/opt/az"

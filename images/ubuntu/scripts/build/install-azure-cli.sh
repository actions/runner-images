#!/bin/bash -e
################################################################################
##  File:  install-azure-cli.sh
##  Desc:  Install Azure CLI (az)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

# AZURE_CONFIG_DIR shell variable defines where the CLI configuration file for managing behavior are stored
# https://learn.microsoft.com/en-us/cli/azure/azure-cli-configuration#cli-configuration-file
# This path SHOULD be different from the installation directory /opt/az/
export AZURE_CONFIG_DIR="/opt/az-config"
mkdir -p $AZURE_CONFIG_DIR
set_etc_environment_variable "AZURE_CONFIG_DIR" "${AZURE_CONFIG_DIR}"

# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
# This path SHOULD be different from the installation directory /opt/az/
export AZURE_EXTENSION_DIR="/opt/az-extension"
mkdir -p $AZURE_EXTENSION_DIR
set_etc_environment_variable "AZURE_EXTENSION_DIR" "${AZURE_EXTENSION_DIR}"

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt

# Remove Azure CLI repository (instructions taken from https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#uninstall-azure-cli)
rm -f /etc/apt/sources.list.d/azure-cli.sources

echo "Warmup 'az'"
az --help > /dev/null
if [ $? -ne 0 ]; then
    echo "Command 'az --help' failed"
    exit 1
fi

# Hand over the ownership of the directories and files to the non-root user
chown -R "$SUDO_USER:$SUDO_USER" $AZURE_CONFIG_DIR
chown -R "$SUDO_USER:$SUDO_USER" $AZURE_EXTENSION_DIR

invoke_tests "CLI.Tools" "Azure CLI"

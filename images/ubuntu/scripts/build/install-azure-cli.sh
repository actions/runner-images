#!/bin/bash -e
################################################################################
##  File:  install-azure-cli.sh
##  Desc:  Install Azure CLI (az)
################################################################################

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "azure-cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt" >> $HELPER_SCRIPTS/apt-sources.txt

rm -f /etc/apt/sources.list.d/azure-cli.list
rm -f /etc/apt/sources.list.d/azure-cli.list.save

echo "Warmup 'az'"
az --help > /dev/null
if [ $? -ne 0 ]; then
    echo "Command 'az --help' failed"
    exit 1
fi

invoke_tests "CLI.Tools" "Azure CLI"

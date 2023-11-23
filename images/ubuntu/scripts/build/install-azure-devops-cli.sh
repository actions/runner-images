#!/bin/bash -e
################################################################################
##  File:  install-azure-devops-cli.sh
##  Desc:  Install Azure DevOps CLI (az devops)
################################################################################

# AZURE_EXTENSION_DIR shell variable defines where modules are installed
# https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
echo "AZURE_EXTENSION_DIR=$AZURE_EXTENSION_DIR" | tee -a /etc/environment

export AZ_DEVOPS_GLOBAL_CONFIG_DIR=/opt/az-devops/config
echo "AZ_DEVOPS_GLOBAL_CONFIG_DIR=$AZ_DEVOPS_GLOBAL_CONFIG_DIR" | tee -a /etc/environment

export AZURE_DEVOPS_CACHE_DIR=/opt/az-devops/config/cache
echo "AZURE_DEVOPS_CACHE_DIR=$AZURE_DEVOPS_CACHE_DIR" | tee -a /etc/environment

sudo mkdir /opt/az-devops

# install azure devops Cli extension
az extension add -n azure-devops

# calling az devops login to force it to install `keyring`. 
echo "dummy" | az devops login > /dev/null
# calling az devops logout to be sure no credentials remain.
az devops logout > /dev/null

# warm-up az devops
az devops --help > /dev/null
az pipelines --help > /dev/null
az boards --help > /dev/null
az repos --help > /dev/null
az artifacts --help > /dev/null

invoke_tests "CLI.Tools" "Azure DevOps CLI"

chown -R "$SUDO_USER:$SUDO_USER" "/opt/az"
chown -R "$SUDO_USER:$SUDO_USER" "/opt/az-devops"

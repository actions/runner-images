#!/bin/bash -e
################################################################################
##  File:  azure-devops-cli.sh
##  Desc:  Installed Azure DevOps CLI (az devops)
################################################################################

export AZURE_DEVOPS_EXT_CONFIG_DIR=/opt/az-devops/config
echo "AZURE_DEVOPS_EXT_CONFIG_DIR=$AZURE_DEVOPS_EXT_CONFIG_DIR" | tee -a /etc/environment

export AZURE_DEVOPS_CACHE_DIR=/opt/az-devops/config/cache
echo "AZURE_DEVOPS_CACHE_DIR=$AZURE_DEVOPS_CACHE_DIR" | tee -a /etc/environment

# install azure devops Cli extension
az extension add -n azure-devops

# calling az devops login to force it to install `keyring`. Login will actually fail, redirecting error to null
echo "dummy" | az devops login >> /dev/null
# calling az devops logout to be sure no credentials remain.
az devops logout >> /dev/null

# warm-up az devops
az devops --help >> /dev/null
az pipelines --help >> /dev/null
az boards --help >> /dev/null
az repos --help >> /dev/null
az artifacts --help >> /dev/null

invoke_tests "CLI.Tools" "Azure DevOps CLI"

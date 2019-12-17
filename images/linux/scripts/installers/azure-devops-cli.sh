#!/bin/bash
################################################################################
##  File:  azure-devops-cli.sh
##  Desc:  Installed Azure DevOps CLI (az devops)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# install azure devops Cli extension
az extension add -n azure-devops

# check to determine if extension was installed or not
if [ $? -eq 0 ]
then
    echo "azure DevOps Cli extension was installed"
else
    echo "azure DevOps Cli extension was not installed"
    exit 1
fi

# Document what was added to the image
DocumentInstalledItem "Azure CLI ($(az -v | grep azure-devops))"

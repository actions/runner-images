#!/bin/bash -e
################################################################################
##  File:  install-azure-devops-cli.sh
##  Desc:  Install Azure DevOps CLI (az devops)
################################################################################

# install azure devops Cli extension
az extension add -n azure-devops

invoke_tests "CLI.Tools" "Azure DevOps CLI"

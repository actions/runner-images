#!/bin/bash -e
################################################################################
##  File:  azure-devops-cli.sh
##  Desc:  Installed Azure DevOps CLI (az devops)
################################################################################

# install azure devops Cli extension
az extension add -n azure-devops

invoke_tests "CLI.Tools" "Azure DevOps CLI"

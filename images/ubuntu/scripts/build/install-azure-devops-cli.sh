#!/bin/bash

################################################################################
##  File:  install-azure-devops-cli.sh
##  Desc:  Install and upgrade Azure DevOps CLI (az devops) with error handling
################################################################################

# Source the helpers for use with the script
source /path/to/helpers.sh  # Update to the actual path of helpers.sh

# Set Azure CLI extension directory
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
set_etc_environment_variable "AZURE_EXTENSION_DIR" "${AZURE_EXTENSION_DIR}"

# Install or update Azure DevOps CLI extension
function install_or_update_devops_cli() {
    echo "Checking if Azure DevOps CLI extension is installed..."

    # Check if the extension exists
    if az extension show -n azure-devops &> /dev/null; then
        echo "Azure DevOps CLI extension found. Attempting to update..."
        
        # Try updating the extension
        if az extension update -n azure-devops; then
            echo "Azure DevOps CLI extension updated successfully."
        else
            echo "Error updating Azure DevOps CLI extension." >&2
            exit 1
        fi
    else
        echo "Azure DevOps CLI extension not found. Installing..."
        
        # Try installing the extension
        if az extension add -n azure-devops; then
            echo "Azure DevOps CLI extension installed successfully."
        else
            echo "Error installing Azure DevOps CLI extension." >&2
            exit 1
        fi
    fi
}

# Invoke the function
install_or_update_devops_cli

# Run tests to verify installation
invoke_tests "CLI.Tools" "Azure DevOps CLI"

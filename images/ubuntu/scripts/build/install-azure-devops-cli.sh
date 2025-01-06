#!/bin/bash

################################################################################
##  File:  install-azure-devops-cli.sh
##  Desc:  Install and upgrade Azure DevOps CLI (az devops) with robust error handling
################################################################################

# Constants
LOG_FILE="/var/log/install-azure-devops-cli.log"
AZURE_EXTENSION_NAME="azure-devops"
AZURE_CLI_CMD="az"
RETRY_COUNT=3
RETRY_INTERVAL=5  # in seconds

# Source the helpers for use with the script
source /path/to/helpers.sh  # Update to the actual path of helpers.sh

# Set Azure CLI extension directory
export AZURE_EXTENSION_DIR=/opt/az/azcliextensions
set_etc_environment_variable "AZURE_EXTENSION_DIR" "${AZURE_EXTENSION_DIR}"

# Log function
function log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a "${LOG_FILE}"
}

# Check prerequisites
function check_prerequisites() {
    log_message "Checking prerequisites for Azure CLI installation..."

    if ! command -v ${AZURE_CLI_CMD} &> /dev/null; then
        log_message "Azure CLI is not installed. Please install Azure CLI first." >&2
        exit 1
    fi

    log_message "Prerequisites verified successfully."
}

# Retry logic
function retry_command() {
    local cmd="$1"
    local retries="${2:-${RETRY_COUNT}}"
    local interval="${3:-${RETRY_INTERVAL}}"

    for ((i = 0; i < retries; i++)); do
        if ${cmd}; then
            return 0
        else
            log_message "Command failed. Retrying in ${interval} seconds... (Attempt $((i + 1))/${retries})"
            sleep "${interval}"
        fi
    done

    log_message "Command failed after ${retries} attempts." >&2
    return 1
}

# Install or update Azure DevOps CLI extension
function install_or_update_devops_cli() {
    log_message "Checking if Azure DevOps CLI extension is installed..."

    # Check if the extension exists
    if ${AZURE_CLI_CMD} extension show -n ${AZURE_EXTENSION_NAME} &> /dev/null; then
        log_message "Azure DevOps CLI extension found. Attempting to update..."

        # Try updating the extension
        if retry_command "${AZURE_CLI_CMD} extension update -n ${AZURE_EXTENSION_NAME}"; then
            log_message "Azure DevOps CLI extension updated successfully."
        else
            log_message "Error updating Azure DevOps CLI extension." >&2
            exit 1
        fi
    else
        log_message "Azure DevOps CLI extension not found. Installing..."

        # Try installing the extension
        if retry_command "${AZURE_CLI_CMD} extension add -n ${AZURE_EXTENSION_NAME}"; then
            log_message "Azure DevOps CLI extension installed successfully."
        else
            log_message "Error installing Azure DevOps CLI extension." >&2
            exit 1
        fi
    fi
}

# Run tests to verify installation
function verify_installation() {
    log_message "Verifying Azure DevOps CLI installation..."
    if ! ${AZURE_CLI_CMD} extension show -n ${AZURE_EXTENSION_NAME} &> /dev/null; then
        log_message "Verification failed: Azure DevOps CLI extension is not installed correctly." >&2
        exit 1
    fi
    log_message "Azure DevOps CLI extension installation verified successfully."
}

# Main execution
function main() {
    log_message "Starting Azure DevOps CLI installation script..."
    check_prerequisites
    install_or_update_devops_cli
    verify_installation
    log_message "Azure DevOps CLI installation completed successfully."
}

# Run the script
main


# Invoke the function
install_or_update_devops_cli

# Run tests to verify installation
invoke_tests "CLI.Tools" "Azure DevOps CLI"

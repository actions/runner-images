#!/bin/bash -e
################################################################################
##  File:  runner-package.sh
##  Desc:  Downloads and Installs runner package
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

LATEST_VERSION = $(
    curl -L \ -H "Accept: application/vnd.github+json" \ -H "X-GitHub-Api-Version: 2022-11-28" \ https://api.github.com/repos/actions/runner/releases/latest 
    | jq '.name' 
    | tr -d "v" 
)
URL = "https://github.com/actions/runner/releases/download/v${LATEST_VERSION}/actions-runner-linux-x64-${LATEST_VERSION}.tar.gz"
FILE_NAME = "actions-runner-linux-x64-${LATEST_VERSION}.tar.gz"


download_with_retries "${URL}" "/opt/runner-cache" "${FILE_NAME}"

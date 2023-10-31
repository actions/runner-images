#!/bin/bash -e
################################################################################
##  File:  runner-package.sh
##  Desc:  Downloads and Installs runner package
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

DOWNLOAD_URL=$(get_github_package_download_url "actions/runner" "contains(\"actions-runner-linux-x64-\") and endswith(\".tar.gz\")" "latest")

FILE_NAME=echo ${DOWNLOAD_URL##*/}

mkdir -p /opt/runner-cache

download_with_retries "${URL}" "/opt/runner-cache"  "${FILE_NAME}"

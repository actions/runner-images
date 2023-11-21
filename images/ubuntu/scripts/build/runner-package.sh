#!/bin/bash -e
################################################################################
##  File:  runner-package.sh
##  Desc:  Downloads and Installs runner package
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

DOWNLOAD_URL=$(get_github_package_download_url "actions/runner" 'test("actions-runner-linux-x64-[0-9]+\\.[0-9]{3}\\.[0-9]+\\.tar\\.gz")')

FILE_NAME="${DOWNLOAD_URL##*/}"

sudo mkdir -p /opt/runner-cache

download_with_retries "${DOWNLOAD_URL}" "/tmp" "${FILE_NAME}"

sudo mv /tmp/$FILE_NAME /opt/runner-cache/$FILE_NAME

#!/bin/bash -e
################################################################################
##  File:  packer.sh
##  Desc:  Installs packer
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Packer
URL=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/packer/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
ZIP_NAME="packer_linux_amd64.zip"
download_with_retries "${URL}" "/tmp" "${ZIP_NAME}"
unzip -qq "/tmp/${ZIP_NAME}" -d /usr/local/bin
rm -f "/tmp/${ZIP_NAME}"

invoke_tests "Tools" "Packer"
#!/bin/bash -e
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Terraform
# Pin Terraform until v1.6.1 is released
# Ref: https://github.com/hashicorp/terraform/issues/33977
URL=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/terraform/1.5.7 | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
ZIP_NAME="terraform_linux_amd64.zip"
download_with_retries "${URL}" "/tmp" "${ZIP_NAME}"
unzip -qq "/tmp/${ZIP_NAME}" -d /usr/local/bin
rm -f "/tmp/${ZIP_NAME}"

invoke_tests "Tools" "Terraform"

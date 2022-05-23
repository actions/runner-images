#!/bin/bash -e
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Terraform
URL=$(curl -s https://api.releases.hashicorp.com/v1/releases/terraform/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
ZIP_NAME="terraform_linux_amd64.zip"
download_with_retries "${URL}" "/tmp" "${ZIP_NAME}"
unzip -qq "/tmp/${ZIP_NAME}" -d /usr/local/bin
rm -f "/tmp/${ZIP_NAME}"

invoke_tests "Tools" "Terraform"
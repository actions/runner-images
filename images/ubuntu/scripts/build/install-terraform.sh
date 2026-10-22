#!/bin/bash -e
################################################################################
##  File:  install-terraform.sh
##  Desc:  Install terraform
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

if is_x64; then
  terraform_arch="amd64"
elif is_arm64; then
  terraform_arch="arm64"
else
  echo "Unsupported architecture"
  exit 1
fi

# Install Terraform
download_url=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/terraform/latest | jq -r ".builds[] | select((.arch==\"$terraform_arch\") and (.os==\"linux\")).url")
archive_path=$(download_with_retry "${download_url}")
unzip -qq "$archive_path" -d /usr/local/bin

invoke_tests "Tools" "Terraform"

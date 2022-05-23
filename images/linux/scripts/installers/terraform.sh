#!/bin/bash -e
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

# Install Terraform
URL=$(curl -s https://api.releases.hashicorp.com/v1/releases/terraform/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
curl -L -o terraform_linux_amd64.zip "${URL}"
unzip -qq terraform_linux_amd64.zip -d /usr/local/bin
rm -f terraform_linux_amd64.zip

invoke_tests "Tools" "Terraform"
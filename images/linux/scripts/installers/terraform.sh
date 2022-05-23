#!/bin/bash -e
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

# Install Terraform
TERRAFORM_VERSION=$(curl -s https://api.releases.hashicorp.com/v1/releases/terraform/latest | jq -r .version)
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip -qq "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/local/bin
rm -f "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

invoke_tests "Tools" "Terraform"
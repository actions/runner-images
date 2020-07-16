#!/bin/bash
################################################################################
##  File:  terraform.sh
##  Desc:  Installs terraform
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Terraform
TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d /usr/local/bin
rm -f "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v terraform; then
    echo "Terraform was not installed or found on PATH"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Terraform ($(terraform --version))"

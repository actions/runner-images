#!/bin/bash -e
################################################################################
##  File:  packer.sh
##  Desc:  Installs packer
################################################################################

# Install Packer
PACKER_VERSION=$(curl -s https://api.releases.hashicorp.com/v1/releases/packer/latest | jq -r .version)
curl -LO "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
unzip -qq "packer_${PACKER_VERSION}_linux_amd64.zip" -d /usr/local/bin
rm -f "packer_${PACKER_VERSION}_linux_amd64.zip"

invoke_tests "Tools" "Packer"
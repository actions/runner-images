#!/bin/bash -e
################################################################################
##  File:  packer.sh
##  Desc:  Installs packer
################################################################################

# Install Packer
URL=$(curl -s https://api.releases.hashicorp.com/v1/releases/packer/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
curl -L -o packer_linux_amd64.zip "${URL}"
unzip -qq packer_linux_amd64.zip -d /usr/local/bin
rm -f packer_linux_amd64.zip

invoke_tests "Tools" "Packer"
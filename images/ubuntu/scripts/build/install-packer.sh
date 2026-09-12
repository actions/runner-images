#!/bin/bash -e
################################################################################
##  File:  install-packer.sh
##  Desc:  Install packer
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

packer_arch=$(select_by_arch "amd64" "arm64")

# Install Packer
download_url=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/packer/latest | jq -r ".builds[] | select((.arch==\"$packer_arch\") and (.os==\"linux\")).url")
archive_path=$(download_with_retry "$download_url")
unzip -o -qq "$archive_path" -d /usr/local/bin

invoke_tests "Tools" "Packer"

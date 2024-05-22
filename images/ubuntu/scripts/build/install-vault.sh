#!/bin/bash -e
################################################################################
##  File:  install-vault.sh
##  Desc:  Install vault
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Vault
download_url=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
archive_path=$(download_with_retry "${download_url}")
unzip -o -qq "$archive_path" -d /usr/local/bin

invoke_tests "Tools" "Vault"

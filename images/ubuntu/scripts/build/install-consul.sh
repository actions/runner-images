#!/bin/bash -e
################################################################################
##  File:  install-consul.sh
##  Desc:  Install consul
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install Consul
download_url=$(curl -fsSL https://api.releases.hashicorp.com/v1/releases/consul/latest | jq -r '.builds[] | select((.arch=="amd64") and (.os=="linux")).url')
archive_path=$(download_with_retry "${download_url}")
unzip -qq "$archive_path" -d /usr/local/bin

invoke_tests "Tools" "Consul"

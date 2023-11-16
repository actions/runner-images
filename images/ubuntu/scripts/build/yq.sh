#!/bin/bash -e
################################################################################
##  File:  yq.sh
##  Desc:  Installs YQ
##  Supply chain security: YQ - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download YQ
base_url="https://github.com/mikefarah/yq/releases/latest/download"
download_with_retries "${base_url}/yq_linux_amd64" "/tmp" "yq"
# Supply chain security - YQ
external_hash=$(get_hash_from_remote_file "${base_url}/checksums" "yq_linux_amd64 " "" " " "19")
use_checksum_comparison "/tmp/yq" "${external_hash}"
# Install YQ
sudo install /tmp/yq /usr/bin/yq

invoke_tests "Tools" "yq"

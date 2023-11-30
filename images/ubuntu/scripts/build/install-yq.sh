#!/bin/bash -e
################################################################################
##  File:  install-yq.sh
##  Desc:  Install yq - a command-line YAML, JSON and XML processor
##  Supply chain security: yq - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download yq
base_url="https://github.com/mikefarah/yq/releases/latest/download"
binary_path=$(download_with_retry "${base_url}/yq_linux_amd64")

# Supply chain security - yq
external_hash=$(get_hash_from_remote_file "${base_url}/checksums" "yq_linux_amd64 " "" " " "19")
use_checksum_comparison "$binary_path" "$external_hash"

# Install yq
sudo install "$binary_path" /usr/bin/yq

invoke_tests "Tools" "yq"

#!/bin/bash -e
################################################################################
##  File:  install-yq.sh
##  Desc:  Install yq - a command-line YAML, JSON and XML processor
##  Supply chain security: yq - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

if is_x64; then
  yq_arch="amd64"
elif is_arm64; then
  yq_arch="arm64"
else
  echo "Unsupported architecture"
  exit 1
fi

# Download yq
yq_url=$(resolve_github_release_asset_url "mikefarah/yq" "endswith(\"yq_linux_${yq_arch}\")" "latest")
binary_path=$(download_with_retry "${yq_url}")

# Supply chain security - yq
hash_url=$(resolve_github_release_asset_url "mikefarah/yq" "endswith(\"checksums\")" "latest")
external_hash=$(get_checksum_from_url "${hash_url}" "yq_linux_${yq_arch} " "SHA256" "true" " " "19")
use_checksum_comparison "$binary_path" "$external_hash"

# Install yq
install "$binary_path" /usr/bin/yq

invoke_tests "Tools" "yq"

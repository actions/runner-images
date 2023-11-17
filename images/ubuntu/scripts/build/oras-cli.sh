#!/bin/bash -e
################################################################################
##  File:  oras-cli.sh
##  Desc:  Installs ORAS CLI
##  Supply chain security: ORAS CLI - checksum validation
################################################################################

source $HELPER_SCRIPTS/install.sh

# Determine latest ORAS CLI version
URL=$(get_github_package_download_url "oras-project/oras" "endswith(\"linux_amd64.tar.gz\")")
archive_name=$(basename "${URL}")

# Download ORAS CLI
download_with_retries "${URL}" "/tmp" "${archive_name}"
# Supply chain security - ORAS CLI
hash_url=$(get_github_package_download_url "oras-project/oras" "contains(\"checksums.txt\")")
external_hash=$(get_hash_from_remote_file "${hash_url}" "linux_amd64.tar.gz")
use_checksum_comparison "/tmp/${archive_name}" "${external_hash}"
# Unzip ORAS CLI
tar xzf "/tmp/${archive_name}" -C /usr/local/bin oras

invoke_tests "CLI.Tools" "Oras CLI"

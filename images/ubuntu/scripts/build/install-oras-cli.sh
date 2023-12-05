#!/bin/bash -e
################################################################################
##  File:  install-oras-cli.sh
##  Desc:  Install ORAS CLI
##  Supply chain security: ORAS CLI - checksum validation
################################################################################

source $HELPER_SCRIPTS/install.sh

# Determine latest ORAS CLI version
download_url=$(resolve_github_release_asset_url "oras-project/oras" "endswith(\"linux_amd64.tar.gz\")" "latest")

# Download ORAS CLI
archive_path=$(download_with_retry "$download_url")

# Supply chain security - ORAS CLI
hash_url=$(resolve_github_release_asset_url "oras-project/oras" "contains(\"checksums.txt\")" "latest")
external_hash=$(get_hash_from_remote_file "${hash_url}" "linux_amd64.tar.gz")
use_checksum_comparison "$archive_path" "${external_hash}"

# Unzip ORAS CLI
tar xzf "$archive_path" -C /usr/local/bin oras

invoke_tests "CLI.Tools" "Oras CLI"

#!/bin/bash -e
################################################################################
##  File:  install-aliyun-cli.sh
##  Desc:  Install Alibaba Cloud CLI
##  Supply chain security: Alibaba Cloud CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install Alibaba Cloud CLI

download_url=$(resolve_github_release_asset_url "aliyun/aliyun-cli" "contains(\"aliyun-cli-linux\") and endswith(\"amd64.tgz\")" "latest")
hash_url="https://github.com/aliyun/aliyun-cli/releases/latest/download/SHASUMS256.txt"

archive_path=$(download_with_retry "$download_url")

# Supply chain security - Alibaba Cloud CLI
external_hash=$(get_checksum_from_url "$hash_url" "aliyun-cli-linux.*amd64.tgz" "SHA256")

use_checksum_comparison "$archive_path" "$external_hash"

tar xzf "$archive_path"
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"

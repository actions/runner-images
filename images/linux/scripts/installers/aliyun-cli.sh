#!/bin/bash -e
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
##  Supply chain security: Alibaba Cloud CLI - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install Alibaba Cloud CLI
# Pin tool version on ubuntu20 due to issues with GLIBC_2.32 not available
if isUbuntu20; then
    toolset_version=$(get_toolset_value '.aliyunCli.version')
    download_url="https://github.com/aliyun/aliyun-cli/releases/download/v$toolset_version/aliyun-cli-linux-$toolset_version-amd64.tgz"
    hash_url="https://github.com/aliyun/aliyun-cli/releases/download/v$toolset_version/SHASUMS256.txt"
else
    download_url="https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz"
    hash_url="https://github.com/aliyun/aliyun-cli/releases/latest/download/SHASUMS256.txt"
fi

download_with_retries "$download_url" "/tmp" "aliyun-cli-linux-amd64.tgz"

# Supply chain security - Alibaba Cloud CLI
external_hash=$(get_hash_from_remote_file "$hash_url" "aliyun-cli-linux" "amd64.tgz")
use_checksum_comparison "/tmp/aliyun-cli-linux-amd64.tgz" "$external_hash"

tar xzf /tmp/aliyun-cli-linux-amd64.tgz
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"

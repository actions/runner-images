#!/bin/bash -e
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install Alibaba Cloud CLI
downloadUrl=$(get_github_package_download_url "aliyun/aliyun-cli" "contains(\"aliyun-cli-linux\") and endswith(\"amd64.tgz\")")
download_with_retries $downloadUrl "/tmp"
tar xzf /tmp/aliyun-cli-linux-*-amd64.tgz
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"

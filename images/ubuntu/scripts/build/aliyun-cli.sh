#!/bin/bash -e
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install Alibaba Cloud CLI
# Pin tool version on ubuntu20 due to issues with GLIBC_2.32 not available
if isUbuntu20; then
    toolsetVersion=$(get_toolset_value '.aliyunCli.version')
    downloadUrl="https://github.com/aliyun/aliyun-cli/releases/download/v$toolsetVersion/aliyun-cli-linux-$toolsetVersion-amd64.tgz"
else
    downloadUrl="https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz"
fi

download_with_retries $downloadUrl "/tmp"
tar xzf /tmp/aliyun-cli-linux-*-amd64.tgz
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"

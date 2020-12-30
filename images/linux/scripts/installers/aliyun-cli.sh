#!/bin/bash -e
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
################################################################################

# Install Alibaba Cloud CLI
URL=$(curl -s https://api.github.com/repos/aliyun/aliyun-cli/releases/latest | jq -r '.assets[].browser_download_url | select(contains("aliyun-cli-linux"))')
wget -P /tmp $URL
tar xzvf /tmp/aliyun-cli-linux-*-amd64.tgz
mv aliyun /usr/local/bin

invoke_tests "CLI.Tools" "Aliyun CLI"

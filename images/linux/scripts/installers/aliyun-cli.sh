#!/bin/bash
################################################################################
##  File:  aliyun-cli.sh
##  Desc:  Installs Alibaba Cloud CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Alibaba Cloud CLI
URL=$(curl -s https://github.com/aliyun/aliyun-cli/releases | grep -m1 "/aliyun/aliyun-cli/releases/download/" | cut -d "\"" -f 2)
wget -P /tmp "https://github.com/$URL"
tar xzvf /tmp/aliyun-cli-linux-*-amd64.tgz
mv aliyun /usr/local/bin

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v aliyun ; then
    echo "aliyun was not installed"
    exit 1
fi

# Document what was added to the image
aliyun_version="$(aliyun --version | grep "Alibaba Cloud Command Line Interface Version" | cut -d " " -f 7)"
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Alibaba Cloud CLI ($aliyun_version)"
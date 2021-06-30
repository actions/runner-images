#!/bin/bash -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

YQ_VERSION=$(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.tag_name')
YQ_BINARY=yq_linux_amd64

# As per https://github.com/mikefarah/yq#wget
echo "Downloading yq version ${YQ_VERSION}"
YQ_URL="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz"

download_with_retries "$YQ_URL" "/tmp" "${YQ_BINARY}.tar.gz"
tar xzf "/tmp/${YQ_BINARY}.tar.gz" -C "/tmp"
mv /tmp/${YQ_BINARY} /usr/local/bin/yq

invoke_tests "Tools" "yq"

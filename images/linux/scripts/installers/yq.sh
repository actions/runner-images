#!/bin/bash -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

YQ_BINARY=yq_linux_amd64

# As per https://github.com/mikefarah/yq#wget
YQ_URL=$(get_github_package_download_url "mikefarah/yq" "endswith(\"$YQ_BINARY.tar.gz\")")
echo "Downloading latest yq from $YQ_URL"

download_with_retries "$YQ_URL" "/tmp" "${YQ_BINARY}.tar.gz"
tar xzf "/tmp/${YQ_BINARY}.tar.gz" -C "/tmp"
mv /tmp/${YQ_BINARY} /usr/bin/yq

invoke_tests "Tools" "yq"

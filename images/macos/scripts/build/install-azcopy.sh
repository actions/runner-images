#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh

if is_Arm64; then
    filter="arm64"
else
    filter="amd64"
fi

download_url=$(resolve_github_release_asset_url "Azure/azure-storage-azcopy" "contains(\"azcopy_darwin_${filter}_\")" "latest" "$API_PAT")

# Install AzCopy
archive_path=$(download_with_retry "${download_url}")
unzip -qq "$archive_path" -d /tmp/azcopy
extract_path=$(echo /tmp/azcopy/azcopy*)
cp "$extract_path/azcopy" /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy


invoke_tests "Common" "AzCopy"

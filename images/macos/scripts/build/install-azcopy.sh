#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh

# Determine the architecture for azcopy download
# azcopy uses "amd64" instead of "x64" in their release names
# For reference check this specific release
# https://github.com/Azure/azure-storage-azcopy/releases/tag/v10.30.1
arch=$(get_arch)
if [ "$arch" == "x64" ]; then
    azcopy_arch="amd64"
else
    azcopy_arch="arm64"
fi

# Download AzCopy from GitHub releases
download_url=$(resolve_github_release_asset_url "Azure/azure-storage-azcopy" "contains(\"darwin_${azcopy_arch}\") and endswith(\".zip\")" "latest")

# Install AzCopy
archive_path=$(download_with_retry ${download_url})
unzip -qq $archive_path -d /tmp/azcopy
extract_path=$(echo /tmp/azcopy/azcopy*)
cp $extract_path/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy


invoke_tests "Common" "AzCopy"

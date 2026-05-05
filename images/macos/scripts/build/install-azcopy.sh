#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh

if is_Arm64; then
    # Temporarily hardcoded until common link is fixed
    # url="https://aka.ms/downloadazcopy-v10-mac-arm64"
    url="https://github.com/Azure/azure-storage-azcopy/releases/download/v10.32.3/azcopy_darwin_arm64_10.32.3.zip"
else
    url="https://aka.ms/downloadazcopy-v10-mac"
fi

# Install AzCopy
archive_path=$(download_with_retry ${url})
unzip -qq $archive_path -d /tmp/azcopy
extract_path=$(echo /tmp/azcopy/azcopy*)
cp $extract_path/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy


invoke_tests "Common" "AzCopy"

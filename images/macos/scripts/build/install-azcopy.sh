#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh

if is_Arm64; then
    # latest is available by https://aka.ms/downloadazcopy-v10-mac-arm64
    url="https://azcopyvnext.azureedge.net/releases/release-10.21.2-20231106/azcopy_darwin_arm64_10.21.2.zip"
else
    # latest is available by https://aka.ms/downloadazcopy-v10-mac
    url="https://azcopyvnext.azureedge.net/releases/release-10.21.2-20231106/azcopy_darwin_amd64_10.21.2.zip"
fi

# Install AzCopy
archive_path=$(download_with_retry ${url})
unzip -qq $archive_path -d /tmp/azcopy
extract_path=$(echo /tmp/azcopy/azcopy*)
cp $extract_path/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy


invoke_tests "Common" "AzCopy"

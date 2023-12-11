#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh
arch=$(get_arch)

# Check MacOS architecture and if ARM install using brew
if [ "$arch" == "arm64" ]; then
    brew_smart_install azcopy
else
    # Temporary pin 10.21.2 version of AzCopy until 10.22.0 is fixed
    archive_path=$(download_with_retry "https://azcopyvnext.azureedge.net/releases/release-10.21.2-20231106/azcopy_darwin_amd64_10.21.2.zip")
    unzip -qq "$archive_path" -d /tmp/azcopy
    extract_path=$(echo /tmp/azcopy/azcopy*)
    cp "$extract_path/azcopy" "/usr/local/bin/azcopy"
    chmod +x "/usr/local/bin/azcopy"
fi

invoke_tests "Common" "AzCopy"

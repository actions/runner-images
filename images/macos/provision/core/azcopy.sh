#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

AZCOPY_DOWNLOAD_URL="https://aka.ms/downloadazcopy-v10-mac"

download_with_retries $AZCOPY_DOWNLOAD_URL "/tmp" "azcopy.zip"
unzip /tmp/azcopy.zip -d azcopy
AZCOPY_EXTRACTED=$(echo azcopy/azcopy*)
cp "$AZCOPY_EXTRACTED/azcopy" "/usr/local/bin/azcopy"
chmod +x "/usr/local/bin/azcopy"

echo "Done, cleaning up"
rm -rf azcopy*

invoke_tests "Common" "AzCopy"

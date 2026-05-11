#!/bin/bash -e
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

if is_x64; then
  azcopy_download_url="https://aka.ms/downloadazcopy-v10-linux"
elif is_arm64; then
  azcopy_download_url="https://aka.ms/downloadazcopy-v10-linux-arm64"
else
  echo "Unsupported architecture"
  exit 1
fi

# Install AzCopy10
archive_path=$(download_with_retry "$azcopy_download_url")
tar xzf "$archive_path" --strip-components=1 -C /tmp
install /tmp/azcopy /usr/local/bin/azcopy

# Create azcopy 10 alias for backward compatibility
ln -sf /usr/local/bin/azcopy /usr/local/bin/azcopy10

invoke_tests "Tools" "azcopy"

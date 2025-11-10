#!/bin/bash -e
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

download_url=$(resolve_github_release_asset_url "Azure/azure-storage-azcopy" "contains(\"azcopy_linux_amd64\")" "latest")

# Install AzCopy10
archive_path=$(download_with_retry "$download_url")
tar xzf "$archive_path" --strip-components=1 -C /tmp
install /tmp/azcopy /usr/local/bin/azcopy

# Create azcopy 10 alias for backward compatibility
ln -sf /usr/local/bin/azcopy /usr/local/bin/azcopy10

invoke_tests "Tools" "azcopy"

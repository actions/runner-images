#!/bin/bash -e
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install AzCopy10
# Temporary pin 10.21.2 version of AzCopy until 10.22.0 is fixed
archive_path=$(download_with_retry "https://azcopyvnext.azureedge.net/releases/release-10.21.2-20231106/azcopy_linux_amd64_10.21.2.tar.gz")
tar xzf "$archive_path" --strip-components=1 -C /tmp
install /tmp/azcopy /usr/local/bin/azcopy
# Create azcopy 10 alias for backward compatibility
ln -sf /usr/local/bin/azcopy /usr/local/bin/azcopy10

invoke_tests "Tools" "azcopy"

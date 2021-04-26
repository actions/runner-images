#!/bin/bash -e
################################################################################
##  File:  azcopy.sh
##  Desc:  Installs AzCopy
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install AzCopy10
download_with_retries "https://aka.ms/downloadazcopy-v10-linux" "/tmp" "azcopy.tar.gz"
tar xzf /tmp/azcopy.tar.gz --strip-components=1 -C /tmp
mv /tmp/azcopy /usr/local/bin/azcopy
chmod +x /usr/local/bin/azcopy
# Create azcopy 10 alias for backward compatibility
ln -sf /usr/local/bin/azcopy /usr/local/bin/azcopy10

invoke_tests "Tools" "azcopy"
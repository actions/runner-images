#!/bin/bash -e
################################################################################
##  File:  pulumi.sh
##  Desc:  Installs Pulumi
##  Supply chain security: Pulumi - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Dowload Pulumi
version=$(curl -fsSL "https://www.pulumi.com/latest-version")
URL="https://get.pulumi.com/releases/sdk/pulumi-v${version}-linux-x64.tar.gz"
download_with_retries "${URL}" "/tmp" "pulumi-v${version}.tar.gz"
# Supply chain security - Pulumi
external_hash=$(get_hash_from_remote_file "https://github.com/pulumi/pulumi/releases/download/v${version}/SHA512SUMS" "linux-x64.tar.gz")
use_checksum_comparison "/tmp/pulumi-v${version}.tar.gz" "${external_hash}" "512"
# Unzipping Pulumi
tar --strip=1 -xf "/tmp/pulumi-v${version}.tar.gz" -C /usr/local/bin

invoke_tests "Tools" "Pulumi"

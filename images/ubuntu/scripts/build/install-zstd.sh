#!/bin/bash -e
################################################################################
##  File:  install-zstd.sh
##  Desc:  Install zstd
##  Supply chain security: zstd - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download zstd
release_tag=$(curl -fsSL https://api.github.com/repos/facebook/zstd/releases/latest | jq -r '.tag_name')
release_name="zstd-${release_tag//v}"
download_url="https://github.com/facebook/zstd/releases/download/${release_tag}/${release_name}.tar.gz"
archive_path=$(download_with_retry "${download_url}")

# Supply chain security - zstd
external_hash=$(get_checksum_from_url "${download_url}.sha256" "${release_name}.tar.gz" "SHA256")
use_checksum_comparison "$archive_path" "$external_hash"

# Install zstd
apt-get install liblz4-dev
tar xzf "$archive_path" -C /tmp

make -C "/tmp/${release_name}/contrib/pzstd" all
make -C "/tmp/${release_name}" zstd-release

for copyprocess in zstd zstdless zstdgrep; do
    cp "/tmp/${release_name}/programs/${copyprocess}" /usr/local/bin/
done

cp "/tmp/${release_name}/contrib/pzstd/pzstd" /usr/local/bin/

for symlink in zstdcat zstdmt unzstd; do
    ln -sf /usr/local/bin/zstd /usr/local/bin/${symlink}
done

invoke_tests "Tools" "Zstd"

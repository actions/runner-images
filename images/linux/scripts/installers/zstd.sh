#!/bin/bash -e
################################################################################
##  File:  zstd.sh
##  Desc:  Installs zstd
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

apt-get install -y liblz4-dev
release_tag=$(curl -fsSL https://api.github.com/repos/facebook/zstd/releases/latest | jq -r '.tag_name')
zstd_tar_name=zstd-${release_tag//v}.tar.gz
URL=https://github.com/facebook/zstd/releases/download/${release_tag}/${zstd_tar_name}
download_with_retries "${URL}" "/tmp" "${zstd_tar_name}"
tar xzf /tmp/$zstd_tar_name -C /tmp
make -C /tmp/zstd-${release_tag//v}/contrib/pzstd all
make -C /tmp/zstd-${release_tag//v} zstd-release
for copyprocess in zstd zstdless zstdgrep; do cp /tmp/zstd-${release_tag//v}/programs/$copyprocess /usr/local/bin/; done
cp /tmp/zstd-${release_tag//v}/contrib/pzstd/pzstd /usr/local/bin/
for symlink in zstdcat zstdmt unzstd; do ln -sf /usr/local/bin/zstd /usr/local/bin/$symlink; done

invoke_tests "Tools" "Zstd"

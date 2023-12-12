#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-azcopy.sh
##  Desc:  Install AzCopy
################################################################################

source ~/utils/utils.sh

# Build variables for download URL
arch=$(get_arch)

if [ "$arch" == "x64" ]; then
    arch="amd64"
fi

repo="Azure/azure-storage-azcopy"
json=$(curl -fsSL "https://api.github.com/repos/${repo}/releases?per_page=100" | jq -r '.[] | select(.prerelease==false)')
version=$(get_toolset_value '.azcopy.version')

if [[ $version == "latest" ]]; then
    version=$(echo "$json" | jq -r '.tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]|beta" | tail -n 1 | tr -d 'v')
elif [[ $version == *"*"* ]]; then
    version=$(echo "$json" | jq -r '.tag_name' | sort --unique --version-sort | egrep -v ".*-[a-z]|beta" | egrep "${version}" | tail -n 1 | tr -d 'v')
fi

date=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/tags/v${version}" | jq -r '.published_at' | cut -c 1-4,6-7,9-10)
url="https://azcopyvnext.azureedge.net/releases/release-${version}-${date}/azcopy_darwin_${arch}_${version}.zip"

# Install AzCopy
archive_path=$(download_with_retry "${url}")
unzip -qq "$archive_path" -d /tmp/azcopy
extract_path=$(echo /tmp/azcopy/azcopy*)
cp "$extract_path/azcopy" "/usr/local/bin/azcopy"
chmod +x "/usr/local/bin/azcopy"


invoke_tests "Common" "AzCopy"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Get the latest Stack version..."
stackRelease=$(curl -s "https://api.github.com/repos/commercialhaskell/stack/releases/latest")
stackDownloadUrl=$(get_github_package_download_url "commercialhaskell" "stack" "contains(\"osx-x86_64.tar.gz\")")
stackVersion=$(echo $stackRelease | jq -r '.name' | cut -c2-)
stackArchive="/tmp/stack.tar.gz"

echo "Download stack version $stackVersion..."
download_with_retries $stackDownloadUrl "/tmp" "stack.tar.gz"

stackToolcachePath="$AGENT_TOOLSDIRECTORY/stack/$stackVersion"
destinationPath="$stackToolcachePath/x64"

mkdir -p $destinationPath

echo "Unzip stack archive..."
tar -xzf $stackArchive -C $destinationPath --strip 1

touch $stackToolcachePath/x64.complete

echo "export PATH="\$PATH":$destinationPath" >> "$HOME/.bashrc"

invoke_tests "Common" "Stack"

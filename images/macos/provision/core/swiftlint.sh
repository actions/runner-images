#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
swiftlintUrl=$(curl -s "https://api.github.com/repos/realm/SwiftLint/releases/latest" | jq -r '.assets[].browser_download_url | select(contains("SwiftLint.pkg"))')
download_with_retries $swiftlintUrl "/tmp" "SwiftLint.pkg"
sudo installer -pkg /tmp/SwiftLint.pkg -target /
rm -rf /tmp/SwiftLint.pkg

invoke_tests "Linters" "SwiftLint"

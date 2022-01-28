#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
swiftlintUrl=$(curl -H "Authorization: token $API_PAT" -s "https://api.github.com/repos/realm/SwiftLint/releases/latest" | jq -r '.assets[].browser_download_url | select(contains("portable_swiftlint.zip"))')
download_with_retries $swiftlintUrl "/tmp" "portable_swiftlint.zip"
unzip -q "/tmp/portable_swiftlint.zip" -d /usr/local/bin
# Remove the LICENSE file that comes along with the binary and the downloaded archive
rm -rf "/usr/local/bin/LICENSE"
rm -rf "/tmp/portable_swiftlint.zip"

invoke_tests "Linters" "SwiftLint"

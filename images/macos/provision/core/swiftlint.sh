#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
swiftlintUrl=$(get_github_package_download_url "realm/SwiftLint" "contains(\"portable_swiftlint.zip\")" "latest" "$API_PAT")
download_with_retries $swiftlintUrl "/tmp" "portable_swiftlint.zip"
unzip -q "/tmp/portable_swiftlint.zip" -d /usr/local/bin
# Remove the LICENSE file that comes along with the binary and the downloaded archive
rm -rf "/usr/local/bin/LICENSE"
rm -rf "/tmp/portable_swiftlint.zip"

invoke_tests "Linters" "SwiftLint"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
# SwiftLint now requires Swift 5.6 or higher to build, and macOS 12 or higher to run https://github.com/realm/SwiftLint/releases/tag/0.49.0
if is_Less_Monterey; then
    version="0.48.0"
else
    version="latest"
fi

swiftlintUrl=$(get_github_package_download_url "realm/SwiftLint" "contains(\"portable_swiftlint.zip\")" "$version" "$API_PAT")
download_with_retries $swiftlintUrl "/tmp" "portable_swiftlint.zip"
unzip -q "/tmp/portable_swiftlint.zip" -d /usr/local/bin
# Remove the LICENSE file that comes along with the binary and the downloaded archive
rm -rf "/usr/local/bin/LICENSE"
rm -rf "/tmp/portable_swiftlint.zip"

invoke_tests "Linters" "SwiftLint"

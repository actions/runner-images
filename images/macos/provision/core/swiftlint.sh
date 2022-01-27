#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Temporary hardcode swiftlint version due to the issues with installer https://github.com/realm/SwiftLint/issues/3815
echo "Install SwiftLint"
swiftlintUrl=$(get_github_package_download_url "realm" "SwiftLint" "contains(\"SwiftLint.pkg\")" "0.46.0" "$API_PAT")
download_with_retries $swiftlintUrl "/tmp" "SwiftLint.pkg"
sudo installer -pkg /tmp/SwiftLint.pkg -target /
rm -rf /tmp/SwiftLint.pkg

invoke_tests "Linters" "SwiftLint"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
swiftlintUrl=$(get_github_package_download_url "realm" "SwiftLint" "contains(\"SwiftLint.pkg\")")
download_with_retries $swiftlintUrl "/tmp" "SwiftLint.pkg"
sudo installer -pkg /tmp/SwiftLint.pkg -target /
rm -rf /tmp/SwiftLint.pkg

invoke_tests "Linters" "SwiftLint"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Install SwiftLint"
# Temporary hardcode swiftlint version due to the issues with installer https://github.com/realm/SwiftLint/issues/3815
swiftlintUrl="https://github.com/realm/SwiftLint/releases/download/0.46.0/SwiftLint.pkg"
#swiftlintUrl=$(curl -H "Authorization: token $API_PAT" -s "https://api.github.com/repos/realm/SwiftLint/releases/latest" | jq -r '.assets[].browser_download_url | select(contains("SwiftLint.pkg"))')
download_with_retries $swiftlintUrl "/tmp" "SwiftLint.pkg"
sudo installer -pkg /tmp/SwiftLint.pkg -target /
rm -rf /tmp/SwiftLint.pkg

invoke_tests "Linters" "SwiftLint"

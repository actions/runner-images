#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing Swiftlint...
if is_BigSur; then
    # SwiftLint now requires Swift 5.6 or higher to build, and macOS 12 or higher to run https://github.com/realm/SwiftLint/releases/tag/0.49.0
    brew_smart_install "swiftlint@0.48.0"
else
    brew_smart_install "swiftlint"
fi

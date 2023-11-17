#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing Swiftlint...
if is_BigSur; then
  # SwiftLint now requires Swift 5.6 or higher to build, and macOS 12 or higher to run https://github.com/realm/SwiftLint/releases/tag/0.49.0
  COMMIT=d1d5743344227fe6e3c37cfba19f0cfe15a9448a
  FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/swiftlint.rb"

  curl -fsSL "$FORMULA_URL" > $(find $(brew --repository) -name swiftlint.rb)
  HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install swiftlint
else
  brew_smart_install "swiftlint"
fi

invoke_tests "Linters" "SwiftLint"

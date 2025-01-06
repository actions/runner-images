#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-swiftlint.sh
##  Desc:  Install SwiftLint
################################################################################

source ~/utils/utils.sh

echo "Installing Swiftlint..."
if is_Monterey; then
  # SwiftLint now requires Xcode 15.3 or higher to build https://github.com/realm/SwiftLint/releases/tag/0.55.1
  COMMIT=d91dabd087cb0b906c92a825df9e5e5e1a4f59f8
  FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/s/swiftlint.rb"

  curl -fsSL $FORMULA_URL > $(find $(brew --repository) -name swiftlint.rb)
  HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install swiftlint
else
  brew_smart_install "swiftlint"
fi

invoke_tests "Linters" "SwiftLint"

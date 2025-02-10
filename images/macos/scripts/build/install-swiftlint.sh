#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-swiftlint.sh
##  Desc:  Install SwiftLint
################################################################################

source ~/utils/utils.sh

echo "Installing Swiftlint..."

brew_smart_install "swiftlint"

invoke_tests "Linters" "SwiftLint"

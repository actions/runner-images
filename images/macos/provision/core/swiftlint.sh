#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing Swiftlint...
brew_smart_install "swiftlint"

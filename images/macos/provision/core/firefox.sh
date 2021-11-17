#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Firefox..."
brew install --cask firefox

echo "Installing Geckodriver..."
brew_smart_install "geckodriver"
geckoPath="$(brew --prefix geckodriver)/bin"

echo "Add GECKOWEBDRIVER to bashrc..."
echo "export GECKOWEBDRIVER=${geckoPath}" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Firefox"

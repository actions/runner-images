#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Chrome..."
brew_cask_install_ignoring_sha256 "google-chrome"

echo "Installing Chrome Driver"
brew install --cask chromedriver

echo "Installing Selenium"
brew_smart_install "selenium-server"

echo "Installing Geckodriver"
brew_smart_install "geckodriver"

invoke_tests "Browsers" "Chrome"

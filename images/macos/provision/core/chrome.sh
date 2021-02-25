#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Chrome..."
brew_cask_install_ignoring_sha256 "google-chrome"

echo "Installing Chrome Driver"
brew install --cask chromedriver

echo "Installing Selenium"
brew_smart_install "selenium-server-standalone"

CHROMEWEBDRIVER_DIR=$(readlink $(which chromedriver) | xargs dirname)
echo "export CHROMEWEBDRIVER=$CHROMEWEBDRIVER_DIR" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Chrome"

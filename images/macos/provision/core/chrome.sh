#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Chrome..."
brew_cask_install_ignoring_sha256 "google-chrome"

echo "Installing Chrome Driver"
brew cask install chromedriver

echo "Installing Selenium"
brew install selenium-server-standalone

CHROMEWEBDRIVER_DIR=$(readlink $(which chromedriver) | xargs dirname)
echo "export CHROMEWEBDRIVER=$CHROMEWEBDRIVER_DIR" >> "${HOME}/.bashrc"
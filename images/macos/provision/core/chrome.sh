#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Chrome..."
brew_cask_install_ignoring_sha256 "google-chrome"

echo "Installing Chrome Driver"
brew install --cask chromedriver

# Temporarily download Selenium 3.141.59, since 4.* can contain some breaking changes
echo "Installing Selenium"
cd $(brew --repo homebrew/core)
git checkout dc37198
brew_smart_install "selenium-server-standalone"
git checkout master

CHROMEWEBDRIVER_DIR=$(readlink $(which chromedriver) | xargs dirname)
echo "export CHROMEWEBDRIVER=$CHROMEWEBDRIVER_DIR" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Chrome"

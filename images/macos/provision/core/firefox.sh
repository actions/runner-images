#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Firefox..."
brew install --cask firefox

echo "Installing Geckodriver..."
geckoUrl="$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.assets[].browser_download_url | select(endswith("macos.tar.gz"))')"
download_with_retries $geckoUrl "/tmp" "geckodriver.tar.gz"
geckoPath="/usr/local/bin"
tar -xzf /tmp/geckodriver.tar.gz -C $geckoPath

echo "Add GECKOWEBDRIVER to bashrc..."
echo "export GECKOWEBDRIVER=${geckoPath}" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Firefox"

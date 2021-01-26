#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Firefox..."
brew install --cask firefox

# High Sierra builds driver from sources, and it takes about 2 hours. It's much faster to download the binary directly
if ! is_HighSierra; then
    echo "Installing Geckodriver..."
    brew_smart_install "geckodriver"
    geckoPath="$(brew --prefix geckodriver)/bin"
else
    geckoVersion=$(curl https://formulae.brew.sh/api/formula/geckodriver.json 2>/dev/null | jq .versions.stable | tr -d \")
    geckoUrl="https://github.com/mozilla/geckodriver/releases/download/v${geckoVersion}/geckodriver-v${geckoVersion}-macos.tar.gz"
    download_with_retries $geckoUrl "/tmp" "geckodriver.tar.gz"
    geckoPath="/usr/local/bin"
    tar -xzf /tmp/geckodriver.tar.gz -C $geckoPath
fi

echo "Add GECKOWEBDRIVER to bashrc..."
echo "export GECKOWEBDRIVER=${geckoPath}" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Firefox"

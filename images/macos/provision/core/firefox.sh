#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Firefox..."
brew install --cask firefox

# High Sierra builds driver from sources and it takes about 2 hours, it's much faster to download the binary directly
if ! is_HighSierra; then
    echo "Installing Geckodriver..."
    brew_smart_install "geckodriver"
    echo "Add GECKOWEBDRIVER to bashrc..."
    echo "export GECKOWEBDRIVER=$(brew --prefix geckodriver)/bin" >> "${HOME}/.bashrc"
else
    geckoVersion=$(curl https://formulae.brew.sh/api/formula/geckodriver.json 2>/dev/null | jq .versions.stable | tr -d \")
    geckorUrl="https://github.com/mozilla/geckodriver/releases/download/v${geckoVersion}/geckodriver-v${geckoVersion}-macos.tar.gz"
    download_with_retries $geckorUrl "/tmp" "geckodriver.tar.gz"
    tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin
    echo "Add GECKOWEBDRIVER to bashrc..."
    echo "export GECKOWEBDRIVER=$(which geckodriver)" >> "${HOME}/.bashrc"
fi

invoke_tests "Browsers" "Firefox"

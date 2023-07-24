#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Chrome..."
brew_cask_install_ignoring_sha256 "google-chrome"

echo "Installing Chrome Driver"

$arch=mac-$(get_arch)

CHROME_VERSION_FULL=$(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version) && CHROME_VERSION_FULL=($CHROME_VERSION_FULL)
CHROME_VERSION=${CHROME_VERSION_FULL[2]%.*}

echo "Chrome version: " ${CHROME_VERSION_FULL[2]}
CHROME_VERSIONS_JSON=$(curl -fsSL https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json)
CHROMEDRIVER_VERSION=$(echo $CHROME_VERSIONS_JSON | jq -r '.builds["'"$CHROME_VERSION"'"].version')

CHROMEDRIVER_URL=$(echo $CHROME_VERSIONS_JSON | jq -r '.builds["'"$CHROME_VERSION"'"].downloads.chromedriver[] | select(.platform=="'"$arch"'").url')

echo "Installing chromedriver version:" $CHROMEDRIVER_VERSION
download_with_retries $CHROMEDRIVER_URL "/tmp" "chromedriver_mac.zip"
unzip -qq /tmp/chromedriver_mac.zip -d /tmp/
cp /tmp/chromedriver-mac-$arch/chromedriver /usr/local/bin/chromedriver

echo "Installing Selenium"
brew_smart_install "selenium-server"

CHROMEWEBDRIVER_DIR=$(readlink $(which chromedriver) | xargs dirname)
echo "export CHROMEWEBDRIVER=$CHROMEWEBDRIVER_DIR" >> "${HOME}/.bashrc"

invoke_tests "Browsers" "Chrome"

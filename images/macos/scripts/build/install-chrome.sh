#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-chrome.sh
##  Desc:  Install chrome and chrome for testing browsers
################################################################################

source ~/utils/utils.sh
arch=$(get_arch)

echo "Installing Google Chrome..."
brew install --cask google-chrome

# Parse Google Chrome version
FULL_CHROME_VERSION=$("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --version)
FULL_CHROME_VERSION=${FULL_CHROME_VERSION#Google Chrome }
CHROME_VERSION=${FULL_CHROME_VERSION%.*}
echo "Google Chrome version is $FULL_CHROME_VERSION"

# Get Google Chrome versions information
CHROME_PLATFORM="mac-$arch"
CHROME_VERSIONS_URL="https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"
CHROME_VERSIONS_JSON="$(cat "$(download_with_retry "$CHROME_VERSIONS_URL")")"

# Download and unpack the latest release of Chrome Driver
CHROMEDRIVER_VERSION=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].version')
echo "Installing Chrome Driver version $CHROMEDRIVER_VERSION"

CHROMEDRIVER_URL=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].downloads.chromedriver[] | select(.platform=="'"${CHROME_PLATFORM}"'").url')
CHROMEDRIVER_DIR="/usr/local/share/chromedriver-${CHROME_PLATFORM}"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"

CHROMEDRIVER_ARCHIVE_PATH=$(download_with_retry "$CHROMEDRIVER_URL")
unzip -qq "$CHROMEDRIVER_ARCHIVE_PATH" -d /tmp/
sudo mv "/tmp/chromedriver-${CHROME_PLATFORM}" "$CHROMEDRIVER_DIR"
ln -s "$CHROMEDRIVER_BIN" /usr/local/bin/chromedriver
echo "export CHROMEWEBDRIVER=$CHROMEDRIVER_DIR" >> "${HOME}/.bashrc"

# Download and unpack the latest release of Google Chrome for Testing
CHROME_FOR_TESTING_VERSION=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].version')
echo "Installing Google Chrome for Testing version $CHROME_FOR_TESTING_VERSION"

CHROME_FOR_TESTING_URL=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].downloads.chrome[] | select(.platform=="'"${CHROME_PLATFORM}"'").url')
CHROME_FOR_TESTING_APP="Google Chrome for Testing.app"

CHROME_FOR_TESTING_ARCHIVE_PATH=$(download_with_retry "$CHROME_FOR_TESTING_URL")
unzip -qq "$CHROME_FOR_TESTING_ARCHIVE_PATH" -d /tmp/
mv "/tmp/chrome-${CHROME_PLATFORM}/${CHROME_FOR_TESTING_APP}" "/Applications/${CHROME_FOR_TESTING_APP}"

echo "Installing Selenium"
brew_smart_install "selenium-server"

invoke_tests "Browsers" "Chrome"

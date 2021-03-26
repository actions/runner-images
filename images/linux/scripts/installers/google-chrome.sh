#!/bin/bash -e
################################################################################
##  File:  google-chrome.sh
##  Desc:  Installs google-chrome  and chromedriver
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download and install Google Chrome
CHROME_DEB_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
CHROME_DEB_NAME="google-chrome-stable_current_amd64.deb"
download_with_retries $CHROME_DEB_URL "/tmp" "${CHROME_DEB_NAME}"
apt install "/tmp/${CHROME_DEB_NAME}" -f
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment

# Parse Google Chrome version
CHROME_VERSION=$(google-chrome --product-version)
CHROME_VERSION=${CHROME_VERSION%.*}

# Determine the latest release of chromedriver
# Compatibility of Google Chrome and Chromedriver: https://sites.google.com/a/chromium.org/chromedriver/downloads/version-selection
LATEST_CHROMEDRIVER_VERSION=$(curl -sL "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")

# Download and unpack the latest release of chromedriver
echo "Downloading chromedriver v$LATEST_CHROMEDRIVER_VERSION..."
CHROMEDRIVER_DIR="/usr/local/share/chrome_driver"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"
CHROMEDRIVER_URL="https://chromedriver.storage.googleapis.com/$LATEST_CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
download_with_retries $CHROMEDRIVER_URL "/tmp" "chromedriver_linux64.zip"

mkdir -p $CHROMEDRIVER_DIR
unzip /tmp/chromedriver_linux64.zip -d $CHROMEDRIVER_DIR
chmod +x $CHROMEDRIVER_BIN
ln -s "$CHROMEDRIVER_BIN" /usr/bin/
echo "CHROMEWEBDRIVER=$CHROMEDRIVER_DIR" | tee -a /etc/environment

invoke_tests "Browsers" "Chrome"

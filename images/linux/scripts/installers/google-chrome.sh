#!/bin/bash
################################################################################
##  File:  google-chrome.sh
##  Desc:  Installs google-chrome, chromedriver and selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

LSB_RELEASE=$(lsb_release -rs)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt-get update
apt-get install -y google-chrome-stable
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v google-chrome; then
    echo "google-chrome was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Google Chrome ($(google-chrome --version))"

CHROME_VERSION=$(google-chrome --version | grep -Eo "([0-9]+\.?){4}" | cut -d "." -f 1,2,3)
echo "Current Google Chrome version: $CHROME_VERSION"

# Determine latest release of chromedriver
LATEST_RELEASE_FILENAME="LATEST_RELEASE_$CHROME_VERSION"
wget "https://chromedriver.storage.googleapis.com/$LATEST_RELEASE_FILENAME"
LATEST_CHROMEDRIVER_VERSION=$(cat $LATEST_RELEASE_FILENAME)
rm $LATEST_RELEASE_FILENAME

# Download and unpack latest release of chromedriver
echo "Downloading chromedriver v$LATEST_CHROMEDRIVER_VERSION..."
wget "https://chromedriver.storage.googleapis.com/$LATEST_CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip
mv chromedriver /usr/bin/chromedriver
chown root:root /usr/bin/chromedriver
chmod +x /usr/bin/chromedriver

# Run tests to determine that the chromedriver installed as expected
if ! command -v chromedriver; then
    echo "chromedriver was not installed"
    exit 1
fi

# Download selenium standalone server (hardcoded version 3.141.59)
echo "Downloading selenium-server-standalone v3.141.59..."
wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
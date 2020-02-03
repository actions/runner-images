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

CHROME_VERSION=$(google-chrome --product-version)
CHROME_VERSION=${CHROME_VERSION%.*}

# Determine latest release of chromedriver
# Compatibility of Google Chrome and Chromedriver: https://sites.google.com/a/chromium.org/chromedriver/downloads/version-selection
LATEST_CHROMEDRIVER_VERSION=$(curl "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")

# Download and unpack latest release of chromedriver
echo "Downloading chromedriver v$LATEST_CHROMEDRIVER_VERSION..."
wget "https://chromedriver.storage.googleapis.com/$LATEST_CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip

CHROMEDRIVER_BIN="/usr/bin/chromedriver"
mv "chromedriver" $CHROMEDRIVER_BIN
chown root:root $CHROMEDRIVER_BIN
chmod +x $CHROMEDRIVER_BIN
echo "CHROMEWEBDRIVER=$CHROMEDRIVER_BIN" | tee -a /etc/environment

# Run tests to determine that the chromedriver installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v chromedriver; then
    echo "chromedriver was not installed"
    exit 1
fi

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Chromedriver ($(chromedriver --version)); Chrome Driver is available via CHROMEWEBDRIVER environment variable"

# Determine latest selenium standalone server version
SELENIUM_LATEST_VERSION_URL=https://api.github.com/repos/SeleniumHQ/selenium/releases/latest
SELENIUM_VERSION=$(curl $SELENIUM_LATEST_VERSION_URL | jq '.name' | tr -d '"' | cut -d ' ' -f 2)
SELENIUM_VERSION_MAJOR_MINOR=$(echo $SELENIUM_VERSION | cut -d '.' -f 1,2)

# Download selenium standalone server
echo "Downloading selenium-server-standalone v$SELENIUM_VERSION..."
SELENIUM_JAR_NAME="selenium-server-standalone-$SELENIUM_VERSION.jar"
wget https://selenium-release.storage.googleapis.com/$SELENIUM_VERSION_MAJOR_MINOR/$SELENIUM_JAR_NAME

echo "Testing to make sure that script performed as expected, and basic scenarios work"
if [ ! -f "$SELENIUM_JAR_NAME" ]; then
    echo "Selenium server was not installed"
    exit 1
fi

SELENIUM_JAR_PATH="/usr/share/java/selenium-server-standalone.jar"
mv $SELENIUM_JAR_NAME $SELENIUM_JAR_PATH
echo "SELENIUM_JAR_PATH=$SELENIUM_JAR_PATH" | tee -a /etc/environment

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Selenium server standalone (available via SELENIUM_JAR_PATH environment variable)"

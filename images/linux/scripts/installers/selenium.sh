#!/bin/bash
################################################################################
##  File:  selenium.sh
##  Desc:  Installs selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

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
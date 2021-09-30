#!/bin/bash -e
################################################################################
##  File:  selenium.sh
##  Desc:  Installs selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download selenium standalone server
SELENIUM_JAR_NAME="selenium-server-standalone.jar"
SELENIUM_JAR_PATH="/usr/share/java"
SELENIUM_LATEST_VERSION_URL="$(curl -s https://api.github.com/repos/SeleniumHQ/selenium/releases/latest |\
    jq -r '.assets[].browser_download_url | select(contains("selenium-server-standalone") and endswith(".jar"))')"
download_with_retries $SELENIUM_LATEST_VERSION_URL $SELENIUM_JAR_PATH $SELENIUM_JAR_NAME

# Add SELENIUM_JAR_PATH environment variable
echo "SELENIUM_JAR_PATH=$SELENIUM_JAR_PATH/$SELENIUM_JAR_NAME" | tee -a /etc/environment

invoke_tests "Tools" "Selenium"

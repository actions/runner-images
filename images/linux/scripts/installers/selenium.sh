#!/bin/bash -e
################################################################################
##  File:  selenium.sh
##  Desc:  Installs selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download Selenium server
SELENIUM_MAJOR_VERSION=$(get_toolset_value '.selenium.version')
SELENIUM_JAR_PATH="/usr/share/java"
json=$(curl -s "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100")
SELENIUM_DOWNLOAD_URL=$(echo $json | jq -r ".[] | select(.prerelease==false).assets[].browser_download_url | select(contains(\"selenium-server\") and contains(\"-${SELENIUM_MAJOR_VERSION}.\") and endswith(\".jar\"))" | head -1)
SELENIUM_FULL_VERSION=$(echo $SELENIUM_DOWNLOAD_URL | cut -d"-" -f2 | cut -d"/" -f1)
SELENIUM_JAR_NAME="selenium-server-$SELENIUM_FULL_VERSION.jar"
download_with_retries $SELENIUM_DOWNLOAD_URL $SELENIUM_JAR_PATH $SELENIUM_JAR_NAME

# Add SELENIUM_JAR_PATH environment variable
echo "SELENIUM_JAR_PATH=$SELENIUM_JAR_PATH/$SELENIUM_JAR_NAME" | tee -a /etc/environment

invoke_tests "Tools" "Selenium"

#!/bin/bash -e
################################################################################
##  File:  selenium.sh
##  Desc:  Installs selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download Selenium server
SELENIUM_MAJOR_VERSION=$(get_toolset_value '.selenium.version')
SELENIUM_BINARY_NAME=$(get_toolset_value '.selenium.binary_name')
SELENIUM_JAR_PATH="/usr/share/java"
SELENIUM_JAR_NAME="$SELENIUM_BINARY_NAME.jar"
SELENIUM_DOWNLOAD_URL=$(get_github_package_download_url "SeleniumHQ/selenium" "contains(\"${SELENIUM_BINARY_NAME}-${SELENIUM_MAJOR_VERSION}\") and endswith(\".jar\")")
download_with_retries $SELENIUM_DOWNLOAD_URL $SELENIUM_JAR_PATH $SELENIUM_JAR_NAME

# Create an epmty file to retrive selenium version 
SELENIUM_FULL_VERSION=$(echo $SELENIUM_DOWNLOAD_URL | awk -F"${SELENIUM_BINARY_NAME}-|.jar" '{print $2}')
touch "$SELENIUM_JAR_PATH/$SELENIUM_BINARY_NAME-$SELENIUM_FULL_VERSION"

# Add SELENIUM_JAR_PATH environment variable
echo "SELENIUM_JAR_PATH=$SELENIUM_JAR_PATH/$SELENIUM_JAR_NAME" | tee -a /etc/environment

invoke_tests "Tools" "Selenium"

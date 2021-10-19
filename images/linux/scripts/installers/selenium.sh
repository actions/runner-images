#!/bin/bash -e
################################################################################
##  File:  selenium.sh
##  Desc:  Installs selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Temporarily download Selenium 3.141.59, since 4.* can contain some breaking changes
SELENIUM_MAJOR_VERSION=$(get_toolset_value '.selenium.version')
SELENIUM_JAR_NAME="selenium-server-standalone.jar"
SELENIUM_JAR_PATH="/usr/share/java"
json=$(curl -s "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100")
tag_name=$(echo $json | jq -r ".[] | select(.prerelease==false).tag_name" | sort --unique --version-sort | grep "selenium-${SELENIUM_MAJOR_VERSION}.*" | tail -1)
SELENIUM_DOWNLOAD_URL=$(echo $json | jq -r ".[] | select(.tag_name==\"${tag_name}\").assets[].browser_download_url | select(contains(\"selenium-server-standalone\") and endswith(\".jar\"))")
download_with_retries $SELENIUM_DOWNLOAD_URL $SELENIUM_JAR_PATH $SELENIUM_JAR_NAME

# Add SELENIUM_JAR_PATH environment variable
echo "SELENIUM_JAR_PATH=$SELENIUM_JAR_PATH/$SELENIUM_JAR_NAME" | tee -a /etc/environment

invoke_tests "Tools" "Selenium"

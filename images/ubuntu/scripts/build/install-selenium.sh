#!/bin/bash -e
################################################################################
##  File:  install-selenium.sh
##  Desc:  Install selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

SELENIUM_MAJOR_VERSION=$(get_toolset_value '.selenium.version')

# Download Selenium server
SELENIUM_DOWNLOAD_URL=$(resolve_github_release_asset_url "SeleniumHQ/selenium" "contains(\"selenium-server-\") and endswith(\".jar\")" "$SELENIUM_MAJOR_VERSION\.*")
SELENIUM_JAR_PATH=$(download_with_retry "$SELENIUM_DOWNLOAD_URL" "/usr/share/java/selenium-server.jar")

# Create an epmty file to retrive selenium version
SELENIUM_FULL_VERSION=$(echo $SELENIUM_DOWNLOAD_URL | awk -F"selenium-server-|.jar" '{print $2}')
touch "/usr/share/java/selenium-server-$SELENIUM_FULL_VERSION"

# Add SELENIUM_JAR_PATH environment variable
setEtcEnvironmentVariable "SELENIUM_JAR_PATH" "$SELENIUM_JAR_PATH"

invoke_tests "Tools" "Selenium"

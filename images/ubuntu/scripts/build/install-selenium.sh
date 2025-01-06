#!/bin/bash -e
################################################################################
##  File:  install-selenium.sh
##  Desc:  Install selenium server
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

selenium_major_version=$(get_toolset_value '.selenium.version')

# Download Selenium server
selenium_download_url=$(resolve_github_release_asset_url "SeleniumHQ/selenium" "contains(\"selenium-server-\") and endswith(\".jar\")" "$selenium_major_version\.+" "" "true")
selenium_jar_path=$(download_with_retry "$selenium_download_url" "/usr/share/java/selenium-server.jar")

# Create an empty file to retrieve selenium version
selenium_full_version=$(echo $selenium_download_url | awk -F"selenium-server-|.jar" '{print $2}')
touch "/usr/share/java/selenium-server-$selenium_full_version"

# Add SELENIUM_JAR_PATH environment variable
set_etc_environment_variable "SELENIUM_JAR_PATH" "$selenium_jar_path"

invoke_tests "Tools" "Selenium"

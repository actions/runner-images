#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Temporarily download Selenium 3.* since 4.* can contain some breaking changes
echo "Downloading Selenium..."
SELENIUM_MAJOR_VERSION=$(get_toolset_value '.selenium.version')
SELENIUM_JAR_NAME="selenium-server-standalone.jar"
SELENIUM_JAR_PATH="usr/local/Cellar"
json=$(curl -s "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100")
tag_name=$(echo $json | jq -r ".[] | select(.prerelease==false).tag_name" | grep "selenium-${SELENIUM_MAJOR_VERSION}.*" | head -1)
SELENIUM_DOWNLOAD_URL=$(echo $json | jq -r ".[] | select(.tag_name==\"${tag_name}\").assets[].browser_download_url | select(contains(\"selenium-server-standalone\") and endswith(\".jar\"))")
download_with_retries $SELENIUM_DOWNLOAD_URL $SELENIUM_JAR_PATH $SELENIUM_JAR_NAME

echo 'export PATH="\$PATH:$SELENIUM_JAR_PATH/$SELENIUM_JAR_NAME"' >> "$HOME/.bashrc"

invoke_tests "BasicTools" "Selenium"

#!/bin/bash -e -o pipefail

echo "Enabling safari driver..."
# https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari
# Safari’s executable is located at /usr/bin/safaridriver
# Configure Safari to Enable WebDriver Support
sudo safaridriver --enable

echo "Enabling the 'Allow Remote Automation' option in Safari's Develop menu"
mkdir -p $HOME/Library/WebDriver
safari_plist="$HOME/Library/WebDriver/com.apple.Safari.plist"
# "|| true" is needed to suppress exit code 1 in case if property or file doesn't exist 
/usr/libexec/PlistBuddy -c 'delete AllowRemoteAutomation' $safari_plist || true
/usr/libexec/PlistBuddy -c 'add AllowRemoteAutomation bool true' $safari_plist

invoke_tests "Browsers" "Safari"
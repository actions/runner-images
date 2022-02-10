#!/bin/bash -e
################################################################################
##  File:  firefox.sh
##  Desc:  Installs Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install Firefox
apt-get install -y firefox

# add to gloabl system preferences for firefox locale en_US, because other browsers have en_US local.
# Default firefox local is en_GB
echo 'pref("intl.locale.requested","en_US");' >> "/usr/lib/firefox/browser/defaults/preferences/syspref.js"

# Download and unpack latest release of geckodriver
downloadUrl=$(get_github_package_download_url "mozilla/geckodriver" "test(\"linux64.tar.gz$\")")
echo "Downloading geckodriver $downloadUrl"
download_with_retries "$downloadUrl" "/tmp" geckodriver.tar.gz

GECKODRIVER_DIR="/usr/local/share/gecko_driver"
GECKODRIVER_BIN="$GECKODRIVER_DIR/geckodriver"

mkdir -p $GECKODRIVER_DIR
tar -xzf /tmp/geckodriver.tar.gz -C $GECKODRIVER_DIR

chmod +x $GECKODRIVER_BIN
ln -s "$GECKODRIVER_BIN" /usr/bin/
echo "GECKOWEBDRIVER=$GECKODRIVER_DIR" | tee -a /etc/environment

invoke_tests "Browsers" "Firefox"

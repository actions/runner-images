#!/bin/bash
################################################################################
##  File:  firefox.sh
##  Desc:  Installs Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Install Firefox
apt-get install -y firefox

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v firefox; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
# Resolves: Running Firefox as root in a regular user's session is not supported.
#           ($HOME is /home/packer which is owned by packer.)
HOME=/root
DocumentInstalledItem "Firefox ($(firefox --version))"

# Download and unpack latest release of geckodriver
URL=https:`curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest|grep 'browser_download_url.*linux64.tar.gz'|sed -e 's/^.*"https://'|sed -e 's/"//g'`
echo "Downloading geckodriver $URL..."
wget "$URL" -O geckodriver.tar.gz
tar -xzf geckodriver.tar.gz
rm geckodriver.tar.gz

GECKODRIVER_BIN="/usr/bin/geckodriver"
mv "geckodriver" $GECKODRIVER_BIN
chown root:root $GECKODRIVER_BIN
chmod +x $GECKODRIVER_BIN
echo "GECKOWEBDRIVER=$GECKODRIVER_BIN" | tee -a /etc/environment

# Run tests to determine that the geckodriver installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v geckodriver; then
    echo "geckodriver was not installed"
    exit 1
fi

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Geckodriver ($(geckodriver --version)); Gecko Driver is available via GECKOWEBDRIVER environment variable"

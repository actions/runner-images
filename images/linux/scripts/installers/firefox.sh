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
URL=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest|grep 'browser_download_url.*linux64.tar.gz'|sed -E 's/^.*(https:.+)".*/\1/g')
echo "Downloading geckodriver $URL..."
wget "$URL" -O geckodriver.tar.gz
tar -xzf geckodriver.tar.gz
rm geckodriver.tar.gz

GECKODRIVER_DIR="/usr/local/share/gecko_driver"
GECKODRIVER_BIN="$GECKODRIVER_DIR/geckodriver"

mkdir -p $GECKODRIVER_DIR
mv "geckodriver" $GECKODRIVER_BIN

chmod +x $GECKODRIVER_BIN
ln -s "$GECKODRIVER_BIN" /usr/bin/
echo "GECKOWEBDRIVER=$GECKODRIVER_DIR" | tee -a /etc/environment

# Run tests to determine that the geckodriver installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v geckodriver; then
    echo "geckodriver was not installed"
    exit 1
fi

echo "Lastly, documenting what we added to the metadata file"
ver=`geckodriver --version | head -1 |awk '{print $2}'`
DocumentInstalledItem "Geckodriver (${ver}); Gecko Driver is available via GECKOWEBDRIVER environment variable"

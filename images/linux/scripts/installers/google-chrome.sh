#!/bin/bash -e
################################################################################
##  File:  google-chrome.sh
##  Desc:  Installs google-chrome, chromedriver and chromium
################################################################################

source $HELPER_SCRIPTS/install.sh

function GetChromiumRevision {
    CHROME_VERSION=$1

    URL="https://omahaproxy.appspot.com/deps.json?version=${CHROME_VERSION}"
    REVISION=$(curl -s $URL | jq -r '.chromium_base_position')
    # Take the first part of revision variable for search
    FIRST_PART_OF_REVISION=${REVISION:0:${#REVISION}/2}
    URL="https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o?delimiter=/&prefix=Linux_x64/${FIRST_PART_OF_REVISION}"
    VERSIONS=$(curl -s $URL | jq -r '.prefixes[]' | cut -d "/" -f 2 | sort --version-sort)

    RIGHT_REVISION=$(echo $VERSIONS | cut -f 1 -d " ")
    for version in $VERSIONS; do
        if [ $REVISION -lt  $version ]; then
            echo $RIGHT_REVISION
            return
        fi
        RIGHT_REVISION=$version
    done
    echo $RIGHT_REVISION
}

LSB_RELEASE=$(lsb_release -rs)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt-get update
apt-get install -y google-chrome-stable
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment

FULL_CHROME_VERSION=$(google-chrome --product-version)
CHROME_VERSION=${FULL_CHROME_VERSION%.*}

# Determine latest release of chromedriver
# Compatibility of Google Chrome and Chromedriver: https://sites.google.com/a/chromium.org/chromedriver/downloads/version-selection
LATEST_CHROMEDRIVER_VERSION=$(curl "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")

# Download and unpack latest release of chromedriver
echo "Downloading chromedriver v$LATEST_CHROMEDRIVER_VERSION..."
wget "https://chromedriver.storage.googleapis.com/$LATEST_CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip

CHROMEDRIVER_DIR="/usr/local/share/chrome_driver"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"

mkdir -p $CHROMEDRIVER_DIR
mv "chromedriver" $CHROMEDRIVER_BIN
chmod +x $CHROMEDRIVER_BIN
ln -s "$CHROMEDRIVER_BIN" /usr/bin/
echo "CHROMEWEBDRIVER=$CHROMEDRIVER_DIR" | tee -a /etc/environment

# Get Chromium version corresponding to the Google Chrome version
REVISION=$(GetChromiumRevision $FULL_CHROME_VERSION)

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${REVISION}%2Fchrome-linux.zip?alt=media"
ZIP_FILE="${REVISION}-chromium-linux.zip"

CHROMIUM_DIR="/usr/local/share/chromium"
CHROMIUM_BIN="$CHROMIUM_DIR/chrome-linux/chrome"

# Download and unzip Chromium archive
download_with_retries $ZIP_URL "/tmp" $ZIP_FILE
mkdir $CHROMIUM_DIR
unzip /tmp/${ZIP_FILE} -d $CHROMIUM_DIR

ln -s $CHROMIUM_BIN /usr/bin/chromium

invoke_tests "Browsers" "Chrome"
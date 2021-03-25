#!/bin/bash -e

# Get URL to download the latest Chromium
LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
REVISION=$(curl -s -S $LASTCHANGE_URL)
ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$REVISION%2Fchrome-linux.zip?alt=media"
ZIP_FILE="${REVISION}-chromium-linux.zip"
rm -rf $REVISION

CHROMIUM_DIR="/usr/local/share/chromium"
CHROMIUM_BIN="$CHROMIUM_DIR/chrome-linux/chrome"

# Download and unzip Chromium archive
download_with_retries $ZIP_URL "/tmp" $ZIP_FILE
mkdir $CHROMIUM_DIR
unzip /tmp/${ZIP_FILE} -d $CHROMIUM_DIR

ln -s $CHROMIUM_BIN /usr/bin/chromium

invoke_tests "Browsers" "Chromium"

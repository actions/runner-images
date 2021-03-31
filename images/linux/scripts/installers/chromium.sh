#!/bin/bash -e

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

CHROME_VERSION=$(google-chrome --version | cut -d " " -f 3)

# Get Chromium version corresponding to the Google Chrome version
REVISION=$(GetChromiumRevision $CHROME_VERSION)

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${REVISION}%2Fchrome-linux.zip?alt=media"
ZIP_FILE="${REVISION}-chromium-linux.zip"

CHROMIUM_DIR="/usr/local/share/chromium"
CHROMIUM_BIN="$CHROMIUM_DIR/chrome-linux/chrome"

# Download and unzip Chromium archive
download_with_retries $ZIP_URL "/tmp" $ZIP_FILE
mkdir $CHROMIUM_DIR
unzip /tmp/${ZIP_FILE} -d $CHROMIUM_DIR

ln -s $CHROMIUM_BIN /usr/bin/chromium

invoke_tests "Browsers" "Chromium"

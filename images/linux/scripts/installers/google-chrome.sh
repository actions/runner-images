#!/bin/bash -e
################################################################################
##  File:  google-chrome.sh
##  Desc:  Installs google-chrome, chromedriver and chromium
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

function GetChromiumRevision {
    CHROME_REVISION=$1

    # Take the first part of the revision variable to search not only for a specific version,
    # but also for similar ones, so that we can get a previous one if the required revision is not found
    CHROME_REVISION_PREFIX=${CHROME_REVISION:0:${#CHROME_REVISION}/2+1}
    SEARCH_URL="https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o?delimiter=/&prefix=Linux_x64"
    # Revision can include a hash instead of a number. Need to filter it out https://github.com/actions/runner-images/issues/5256
    REVISIONS_AVAILABLE=$(curl -s $SEARCH_URL/${CHROME_REVISION_PREFIX} | jq -r '.prefixes[]' | grep -E "Linux_x64\/[0-9]+\/"| cut -d "/" -f 2 | sort --version-sort)

    # If required Chromium revision is not found in the list
    # we should have to decrement the revision number until we find one.
    # This is mentioned in the documentation we use for this installation:
    # https://www.chromium.org/getting-involved/download-chromium
    LATEST_VALID_REVISION=$(echo $REVISIONS_AVAILABLE | cut -f 1 -d " ")
    for REVISION in $REVISIONS_AVAILABLE; do
        if [ "$CHROME_REVISION" -lt "$REVISION" ]; then
          break
        fi
        LATEST_VALID_REVISION=$REVISION
    done
    echo $LATEST_VALID_REVISION
}

# Download and install Google Chrome
CHROME_DEB_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
CHROME_DEB_NAME="google-chrome-stable_current_amd64.deb"
download_with_retries $CHROME_DEB_URL "/tmp" "${CHROME_DEB_NAME}"
apt install "/tmp/${CHROME_DEB_NAME}" -f
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment

# Remove Google Chrome repo
rm -f /etc/cron.daily/google-chrome /etc/apt/sources.list.d/google-chrome.list /etc/apt/sources.list.d/google-chrome.list.save

# Parse Google Chrome version
FULL_CHROME_VERSION=$(google-chrome --product-version)
CHROME_VERSION=${FULL_CHROME_VERSION%.*}
echo "Chrome version is $FULL_CHROME_VERSION"

# Get chrome versions information
CHROME_PLATFORM="linux64"
CHROME_VERSIONS_URL="https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"
CHROME_VERSIONS_JSON=$(curl -fsSL "${CHROME_VERSIONS_URL}")

# Download and unpack the latest release of chromedriver
CHROMEDRIVER_VERSION=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].version')
CHROMEDRIVER_URL=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].downloads.chromedriver[] | select(.platform=="'"${CHROME_PLATFORM}"'").url')
CHROMEDRIVER_ARCHIVE="chromedriver_linux64.zip"
CHROMEDRIVER_DIR="/usr/local/share/chromedriver-linux64"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"

echo "Installing chromedriver version $CHROMEDRIVER_VERSION"
download_with_retries $CHROMEDRIVER_URL "/tmp" $CHROMEDRIVER_ARCHIVE
unzip -qq /tmp/$CHROMEDRIVER_ARCHIVE -d /usr/local/share

chmod +x $CHROMEDRIVER_BIN
ln -s "$CHROMEDRIVER_BIN" /usr/bin/
echo "CHROMEWEBDRIVER=$CHROMEDRIVER_DIR" | tee -a /etc/environment

# Download and unpack Chromium
CHROME_REVISION=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].revision')
CHROMIUM_REVISION=$(GetChromiumRevision $CHROME_REVISION)
CHROMIUM_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${CHROMIUM_REVISION}%2Fchrome-linux.zip?alt=media"
CHROMIUM_ARCHIVE="${CHROMIUM_REVISION}-chromium-linux.zip"
CHROMIUM_DIR="/usr/local/share/chromium"
CHROMIUM_BIN="${CHROMIUM_DIR}/chrome-linux/chrome"

echo "Installing chromium revision $CHROMIUM_REVISION"
download_with_retries $CHROMIUM_URL "/tmp" $CHROMIUM_ARCHIVE
mkdir $CHROMIUM_DIR
unzip -qq /tmp/$CHROMIUM_ARCHIVE -d $CHROMIUM_DIR

ln -s $CHROMIUM_BIN /usr/bin/chromium
ln -s $CHROMIUM_BIN /usr/bin/chromium-browser

invoke_tests "Browsers" "Chrome"
invoke_tests "Browsers" "Chromium"
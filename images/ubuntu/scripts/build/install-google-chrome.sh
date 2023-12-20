#!/bin/bash -e
################################################################################
##  File:  install-google-chrome.sh
##  Desc:  Install google-chrome, chromedriver and chromium
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

get_chromium_revision() {
    local chrome_revision=$1

    # Take the first part of the revision variable to search not only for a specific version,
    # but also for similar ones, so that we can get a previous one if the required revision is not found
    chrome_revision_prefix=${chrome_revision:0:${#chrome_revision}/2+1}
    SEARCH_URL="https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o?delimiter=/&prefix=Linux_x64"
    # Revision can include a hash instead of a number. Need to filter it out https://github.com/actions/runner-images/issues/5256
    revisions_available=$(curl -s $SEARCH_URL/${chrome_revision_prefix} | jq -r '.prefixes[]' | grep -E "Linux_x64\/[0-9]+\/"| cut -d "/" -f 2 | sort --version-sort)

    # If required Chromium revision is not found in the list
    # we should have to decrement the revision number until we find one.
    # This is mentioned in the documentation we use for this installation:
    # https://www.chromium.org/getting-involved/download-chromium
    latest_valid_revision=$(echo $revisions_available | cut -f 1 -d " ")
    for revision in $revisions_available; do
        if [ "$chrome_revision" -lt "$revision" ]; then
          break
        fi

        latest_valid_revision=$revision
    done

    echo $latest_valid_revision
}

# Download and install Google Chrome
CHROME_DEB_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
CHROME_DEB_PATH=$(download_with_retry "$CHROME_DEB_URL")
apt install "$CHROME_DEB_PATH" -f
set_etc_environment_variable "CHROME_BIN" "/usr/bin/google-chrome"

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
CHROMEDRIVER_DIR="/usr/local/share/chromedriver-linux64"
CHROMEDRIVER_BIN="$CHROMEDRIVER_DIR/chromedriver"

echo "Installing chromedriver version $CHROMEDRIVER_VERSION"
driver_archive_path=$(download_with_retry "$CHROMEDRIVER_URL")
unzip -qq "$driver_archive_path" -d /usr/local/share

chmod +x $CHROMEDRIVER_BIN
ln -s "$CHROMEDRIVER_BIN" /usr/bin/
set_etc_environment_variable "CHROMEWEBDRIVER" "${CHROMEDRIVER_DIR}"

# Download and unpack Chromium
CHROME_REVISION=$(echo "${CHROME_VERSIONS_JSON}" | jq -r '.builds["'"$CHROME_VERSION"'"].revision')
CHROMIUM_REVISION=$(get_chromium_revision $CHROME_REVISION)
CHROMIUM_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${CHROMIUM_REVISION}%2Fchrome-linux.zip?alt=media"
CHROMIUM_DIR="/usr/local/share/chromium"
CHROMIUM_BIN="${CHROMIUM_DIR}/chrome-linux/chrome"

echo "Installing chromium revision $CHROMIUM_REVISION"
CHROMIUM_ARCHIVE_PATH=$(download_with_retry "$CHROMIUM_URL")
mkdir $CHROMIUM_DIR
unzip -qq "$CHROMIUM_ARCHIVE_PATH" -d $CHROMIUM_DIR

ln -s $CHROMIUM_BIN /usr/bin/chromium
ln -s $CHROMIUM_BIN /usr/bin/chromium-browser

invoke_tests "Browsers" "Chrome"
invoke_tests "Browsers" "Chromium"

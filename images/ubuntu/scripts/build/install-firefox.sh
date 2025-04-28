#!/bin/bash -e
################################################################################
##  File:  install-firefox.sh
##  Desc:  Install Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Use Mozilla's official apt repo:
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions-recommended

REPO_URL="https://packages.mozilla.org/apt"
GPG_KEY="/usr/share/keyrings/packages.mozilla.org.asc"
REPO_PATH="/etc/apt/sources.list.d/mozilla.list"

# Install Firefox
curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg -o $GPG_KEY
echo "deb [signed-by=$GPG_KEY] $REPO_URL mozilla main" > $REPO_PATH

apt-get update
apt-get install --target-release mozilla firefox
rm $REPO_PATH

# Document apt source repo's
echo "mozilla $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

# Download and unpack latest release of geckodriver
download_url=$(resolve_github_release_asset_url "mozilla/geckodriver" "test(\"linux64.tar.gz$\")" "latest")
driver_archive_path=$(download_with_retry "$download_url")

GECKODRIVER_DIR="/usr/local/share/gecko_driver"
GECKODRIVER_BIN="$GECKODRIVER_DIR/geckodriver"

mkdir -p $GECKODRIVER_DIR
tar -xzf "$driver_archive_path" -C $GECKODRIVER_DIR

chmod +x $GECKODRIVER_BIN
ln -s "$GECKODRIVER_BIN" /usr/bin/
set_etc_environment_variable "GECKOWEBDRIVER" "${GECKODRIVER_DIR}"

invoke_tests "Browsers" "Firefox"

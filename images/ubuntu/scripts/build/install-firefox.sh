#!/bin/bash -e
################################################################################
##  File:  install-firefox.sh
##  Desc:  Install Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

REPO_URL="https://packages.mozilla.org/apt"
GPG_KEY="/etc/apt/keyrings/packages.mozilla.org.asc"
REPO_PATH="/etc/apt/sources.list.d/mozilla.list"
PREFERENCES_PATH="/etc/apt/preferences.d/mozilla"

# Install Firefox from Mozilla's official APT repository
curl -fsSL "${REPO_URL}/repo-signing-key.gpg" | sudo tee $GPG_KEY > /dev/null

# Verify the signing key fingerprint matches Mozilla's expected fingerprint
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
EXPECTED_FINGERPRINT="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"
GNUPG_TEMP=$(mktemp -d)
ACTUAL_FINGERPRINT=$(
    gpg --homedir "$GNUPG_TEMP" -n -q --import --import-options import-show $GPG_KEY \
        | awk '/pub/{getline; gsub(/^ +| +$/,""); print}'
)
rm -rf "$GNUPG_TEMP"

if [[ "$ACTUAL_FINGERPRINT" != "$EXPECTED_FINGERPRINT" ]]; then
    echo "ERROR: Mozilla APT key fingerprint mismatch."
    echo "Expected: $EXPECTED_FINGERPRINT"
    echo "Actual:   $ACTUAL_FINGERPRINT"
    exit 1
fi
echo "Mozilla APT key fingerprint verified: $ACTUAL_FINGERPRINT"

echo "deb [signed-by=${GPG_KEY}] ${REPO_URL} mozilla main" > $REPO_PATH

# Pin Firefox packages to prefer Mozilla's repo
cat <<EOF | sudo tee $PREFERENCES_PATH > /dev/null
Package: firefox*
Pin: origin packages.mozilla.org
Pin-Priority: 1001
EOF

apt-get update
apt-get install firefox

# Clean up
rm $REPO_PATH
rm $PREFERENCES_PATH
rm $GPG_KEY

# Document apt source repo's
echo "mozillateam $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

# add to global system preferences for firefox locale en_US, because other browsers have en_US local.
# Default firefox local is en_GB
echo 'pref("intl.locale.requested","en_US");' >> "/usr/lib/firefox/browser/defaults/preferences/syspref.js"

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

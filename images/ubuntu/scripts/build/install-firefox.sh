#!/bin/bash -e
################################################################################
##  File:  install-firefox.sh
##  Desc:  Install Firefox
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Install Firefox
REPO_URL="https://packages.mozilla.org/apt"
REPO_PATH="/etc/apt/sources.list.d/mozilla.list"
EXPECTED_FINGERPRINT="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"
KEY_PATH="/etc/apt/keyrings/packages.mozilla.org.asc"

install -d -m 0755 /etc/apt/keyrings

wget -q $REPO_URL/repo-signing-key.gpg -O- | tee "$KEY_PATH" > /dev/null

FINGERPRINT=$(
  gpg -n -q --import --import-options import-show "$KEY_PATH" |
    awk '/pub/ { getline; gsub(/^ +| +$/, ""); print }'
)

if [ "$FINGERPRINT" = "$EXPECTED_FINGERPRINT" ]; then
  echo "The key fingerprint matches ($FINGERPRINT)."
else
  echo "Verification failed: the fingerprint ($FINGERPRINT) does not match the expected one."
  exit 1
fi

cat <<EOF | tee /etc/apt/preferences.d/mozilla > /dev/null
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF

echo "deb [signed-by=$KEY_PATH] $REPO_URL mozilla main" | tee "$REPO_PATH" > /dev/null

apt-get update
apt-get install -y firefox
rm $REPO_PATH

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

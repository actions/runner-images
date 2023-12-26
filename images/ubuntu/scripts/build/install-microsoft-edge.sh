#!/bin/bash -e
################################################################################
##  File:  install-microsoft-edge.sh
##  Desc:  Install Microsoft Edge and WebDriver
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

REPO_URL="https://packages.microsoft.com/repos/edge"
gpg_key="/usr/share/keyrings/microsoft-edge.gpg"
repo_path="/etc/apt/sources.list.d/microsoft-edge.list"


wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $gpg_key
# Specify an arch as Microsoft repository supports armhf and arm64 as well
echo "deb [arch=amd64 signed-by=$gpg_key] $REPO_URL stable main" > $repo_path

apt-get update
apt-get install --no-install-recommends microsoft-edge-stable

rm $gpg_key
rm $repo_path

echo "microsoft-edge $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

# Install Microsoft Edge Webdriver

EDGEDRIVER_DIR="/usr/local/share/edge_driver"
EDGEDRIVER_BIN="$EDGEDRIVER_DIR/msedgedriver"

mkdir -p $EDGEDRIVER_DIR

EDGE_VERSION=$(microsoft-edge --version | cut -d' ' -f 3)
EDGE_VERSION_MAJOR=$(echo $EDGE_VERSION | cut -d'.' -f 1)

EDGE_DRIVER_VERSION_URL="https://msedgedriver.azureedge.net/LATEST_RELEASE_${EDGE_VERSION_MAJOR}_LINUX"
# Convert a resulting file to normal UTF-8
EDGE_DRIVER_LATEST_VERSION=$(curl -fsSL "$EDGE_DRIVER_VERSION_URL" | iconv -f utf-16 -t utf-8 | tr -d '\r')

EDGEDRIVER_URL="https://msedgedriver.azureedge.net/${EDGE_DRIVER_LATEST_VERSION}/edgedriver_linux64.zip"
EDGEDRIVER_ARCHIVE_PATH=$(download_with_retry "$EDGEDRIVER_URL")

unzip -qq "$EDGEDRIVER_ARCHIVE_PATH" -d "$EDGEDRIVER_DIR"
chmod +x $EDGEDRIVER_BIN
ln -s $EDGEDRIVER_BIN /usr/bin

set_etc_environment_variable "EDGEWEBDRIVER" "${EDGEDRIVER_DIR}"

invoke_tests "Browsers" "Edge"

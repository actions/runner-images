#!/bin/bash -e
################################################################################
##  File:  install-microsoft-edge.sh
##  Desc:  Install Microsoft Edge and WebDriver
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

REPO_URL="https://packages.microsoft.com/repos/edge"
GPG_KEY="/usr/share/keyrings/microsoft-edge.gpg"
REPO_PATH="/etc/apt/sources.list.d/microsoft-edge.list"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $GPG_KEY
# Specify an arch as Microsoft repository supports armhf and arm64 as well
echo "deb [arch=amd64 signed-by=$GPG_KEY] $REPO_URL stable main" > $REPO_PATH

apt-get update
apt-get install --no-install-recommends microsoft-edge-stable

rm $GPG_KEY
rm $REPO_PATH

echo "microsoft-edge $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

# Install Microsoft Edge Webdriver

EDGEDRIVER_DIR="/usr/local/share/edge_driver"
edgedriver_bin="$EDGEDRIVER_DIR/msedgedriver"

mkdir -p $EDGEDRIVER_DIR

edge_version=$(microsoft-edge --version | cut -d' ' -f 3)
edge_version_major=$(echo $edge_version | cut -d'.' -f 1)

edgedriver_version_url="https://msedgedriver.azureedge.net/LATEST_RELEASE_${edge_version_major}_LINUX"
# Convert a resulting file to normal UTF-8
edgedriver_latest_version=$(curl -fsSL "$edgedriver_version_url" | iconv -f utf-16 -t utf-8 | tr -d '\r')

edgedriver_url="https://msedgedriver.azureedge.net/${edgedriver_latest_version}/edgedriver_linux64.zip"
edgedriver_archive_path=$(download_with_retry "$edgedriver_url")

unzip -qq "$edgedriver_archive_path" -d "$EDGEDRIVER_DIR"
chmod +x $edgedriver_bin
ln -s $edgedriver_bin /usr/bin

set_etc_environment_variable "EDGEWEBDRIVER" "${EDGEDRIVER_DIR}"

invoke_tests "Browsers" "Edge"

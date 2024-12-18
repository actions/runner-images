#!/bin/bash -e
################################################################################
##  File:  install-flox.sh
##  Desc:  Install Flox and Nix
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://downloads.flox.dev/by-env/stable/deb"
GPG_KEY="/usr/share/keyrings/flox-archive-keyring.gpg"
REPO_PATH="/etc/apt/sources.list.d/flox.list"

wget -qO- https://downloads.flox.dev/by-env/stable/deb/flox-archive-keyring.gpg > $GPG_KEY
# Specify an arch as repository supports aarch64, armhf and arm64 as well
echo "deb [arch=amd64 signed-by=$GPG_KEY] $REPO_URL stable/" > $REPO_PATH

apt-get update
apt-get install --no-install-recommends flox

rm $GPG_KEY
rm $REPO_PATH

echo "flox $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

#!/bin/bash -e
################################################################################
##  File:  microsoft-edge.sh
##  Desc:  Installs Microsoft Edge
################################################################################

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

invoke_tests "Browsers" "Edge"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

VAGRANT_VERSION="2.3.7"

arch=$(get_arch)

if [ $arch == "arm64" ]; then
    VAGRANT_DOWNLOAD_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_darwin_arm64.dmg"
else
    VAGRANT_DOWNLOAD_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_darwin_amd64.dmg"
fi


echo "Installing Vagrant ${VAGRANT_VERSION}"
TMPMOUNT=`/usr/bin/mktemp -d /tmp/vagrant.XXXX`
TMPMOUNT_DOWNLOADS="$TMPMOUNT/downloads"
mkdir $TMPMOUNT_DOWNLOADS

download_with_retries $VAGRANT_DOWNLOAD_URL $TMPMOUNT_DOWNLOADS

echo "Mounting Vagrant..."

if [ $arch == "arm64" ]; then
    hdiutil attach "${TMPMOUNT_DOWNLOADS}/vagrant_${VAGRANT_VERSION}_darwin_arm64.dmg" -mountpoint "$TMPMOUNT"
else
    hdiutil attach "${TMPMOUNT_DOWNLOADS}/vagrant_${VAGRANT_VERSION}_darwin_amd64.dmg" -mountpoint "$TMPMOUNT"
fi



echo "Moving Vagrant to /..."
sudo installer -pkg "${TMPMOUNT}/vagrant.pkg" -target /

sudo hdiutil detach "$TMPMOUNT"
sudo rm -rf "$TMPMOUNT"
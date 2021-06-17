#!/bin/bash -e -o pipefail
source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

VSMAC_VERSION=$(get_toolset_value '.xamarin.vsmac')
if [ $VSMAC_VERSION == "latest" ]; then
    VSMAC_VERSION=$(curl -L "http://aka.ms/manifest/stable" | jq -r ".items[] | select(.genericName==\"VisualStudioMac\").version")
fi
VSMAC_DOWNLOAD_URL=$(buildVSMacDownloadUrl $VSMAC_VERSION)

TMPMOUNT=`/usr/bin/mktemp -d /tmp/visualstudio.XXXX`
TMPMOUNT_DOWNLOADS="$TMPMOUNT/downloads"
mkdir $TMPMOUNT_DOWNLOADS

download_with_retries $VSMAC_DOWNLOAD_URL $TMPMOUNT_DOWNLOADS

echo "Mounting Visual studio..."
VISUAL_STUDIO_NAME=${VSMAC_DOWNLOAD_URL##*/}
hdiutil attach "$TMPMOUNT_DOWNLOADS/$VISUAL_STUDIO_NAME" -mountpoint "$TMPMOUNT"

echo "Moving Visual Studio to /Applications/..."
pushd $TMPMOUNT
tar cf - "./Visual Studio.app" | tar xf - -C /Applications/

popd
sudo hdiutil detach "$TMPMOUNT"
sudo rm -rf "$TMPMOUNT"

invoke_tests "Common" "VSMac"

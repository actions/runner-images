#!/bin/bash -e -o pipefail
source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

install_vsmac() {
    local VSMAC_VERSION=$1
    if [ $VSMAC_VERSION == "latest" ]; then
        VSMAC_DOWNLOAD_URL=$(curl -sL "https://aka.ms/manifest/stable" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    elif [ $VSMAC_VERSION == "preview" ]; then
        VSMAC_DOWNLOAD_URL=$(curl -sL "https://aka.ms/manifest/preview" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    else
        VSMAC_DOWNLOAD_URL=$(buildVSMacDownloadUrl $VSMAC_VERSION)
    fi

    TMPMOUNT=`/usr/bin/mktemp -d /tmp/visualstudio.XXXX`
    TMPMOUNT_DOWNLOADS="$TMPMOUNT/downloads"
    mkdir $TMPMOUNT_DOWNLOADS

    download_with_retries $VSMAC_DOWNLOAD_URL $TMPMOUNT_DOWNLOADS

    echo "Mounting Visual Studio..."
    VISUAL_STUDIO_NAME=${VSMAC_DOWNLOAD_URL##*/}
    hdiutil attach "$TMPMOUNT_DOWNLOADS/$VISUAL_STUDIO_NAME" -mountpoint "$TMPMOUNT"

    echo "Moving Visual Studio to /Applications/..."
    pushd $TMPMOUNT
    tar cf - "./Visual Studio.app" | tar xf - -C /Applications/

    if [ $VSMAC_VERSION == "preview" ]; then
        mv "/Applications/Visual Studio.app" "/Applications/Visual Studio Preview.app"
    fi

    popd
    sudo hdiutil detach "$TMPMOUNT"
    sudo rm -rf "$TMPMOUNT"
}

VSMAC_VERSION_PREVIEW=$(get_toolset_value '.xamarin.vsmac_preview')
if [ VSMAC_VERSION_PREVIEW != "null" ];then
    echo "Installing Visual Studio 2022 for Mac Preview"
    install_vsmac $VSMAC_VERSION_PREVIEW
fi

echo "Installing Visual Studio 2019 for Mac Stable"
VSMAC_VERSION_STABLE=$(get_toolset_value '.xamarin.vsmac')
install_vsmac $VSMAC_VERSION_STABLE

invoke_tests "Common" "VSMac"

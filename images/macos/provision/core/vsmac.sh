#!/bin/bash -e -o pipefail
source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

install_vsmac() {
    local VSMAC_VERSION=$1
    local VSMAC_DEFAULT=$2
    if [ $VSMAC_VERSION == "2019" ]; then
        VSMAC_DOWNLOAD_URL=$(curl -sL "https://aka.ms/manifest/stable" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    elif [ $VSMAC_VERSION == "2022" ]; then
        VSMAC_DOWNLOAD_URL=$(curl -sL "https://aka.ms/manifest/stable-2022" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    elif [ $VSMAC_VERSION == "preview" ]; then
        VSMAC_DOWNLOAD_URL=$(curl -sL "https://aka.ms/manifest/preview" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    else
        VSMAC_DOWNLOAD_URL=$(buildVSMacDownloadUrl $VSMAC_VERSION)
    fi

    echo "Installing Visual Studio ${VSMAC_VERSION} for Mac"
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

    if [ $VSMAC_VERSION != $VSMAC_DEFAULT ]; then
        mv "/Applications/Visual Studio.app" "/Applications/Visual Studio ${VSMAC_VERSION}.app"
    fi

    popd
    sudo hdiutil detach "$TMPMOUNT"
    sudo rm -rf "$TMPMOUNT"
}

VSMAC_VERSIONS=($(get_toolset_value '.xamarin.vsmac.versions[]'))
DEFAULT_VSMAC_VERSION=$(get_toolset_value '.xamarin.vsmac.default')

for VERSION in "${VSMAC_VERSIONS[@]}"; do
    install_vsmac $VERSION $DEFAULT_VSMAC_VERSION
done

invoke_tests "Common" "VSMac"

#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-visualstudio.sh
##  Desc:  Install Visual Studio
################################################################################

source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

install_vsmac() {
    local vsmac_version=$1
    local vsmac_default=$2
    if [[ $vsmac_version == "2019" ]]; then
        vsmac_download_url=$(curl -fsSL "https://aka.ms/manifest/stable" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    elif [[ $vsmac_version == "2022" ]]; then
        vsmac_download_url=$(curl -fsSL "https://aka.ms/manifest/stable-2022" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    elif [[ $vsmac_version == "preview" ]]; then
        vsmac_download_url=$(curl -fsSL "https://aka.ms/manifest/preview" | jq -r '.items[] | select(.genericName=="VisualStudioMac").url')
    else
        vsmac_download_url=$(buildVSMacDownloadUrl $vsmac_version)
    fi

    echo "Installing Visual Studio ${vsmac_version} for Mac"
    TMPMOUNT=$(/usr/bin/mktemp -d /tmp/visualstudio.XXXX)
    mkdir -p "$TMPMOUNT/downloads"

    vsmac_installer=$(download_with_retry $vsmac_download_url "$TMPMOUNT/downloads/${vsmac_download_url##*/}")

    echo "Mounting Visual Studio..."
    hdiutil attach $vsmac_installer -mountpoint $TMPMOUNT

    echo "Moving Visual Studio to /Applications/..."
    pushd $TMPMOUNT
    tar cf - "./Visual Studio.app" | tar xf - -C /Applications/

    if [[ $vsmac_version != $vsmac_default ]]; then
        mv "/Applications/Visual Studio.app" "/Applications/Visual Studio ${vsmac_version}.app"
    fi

    popd
    sudo hdiutil detach $TMPMOUNT
    sudo rm -rf $TMPMOUNT
}

vsmac_versions=($(get_toolset_value '.xamarin.vsmac.versions[]'))
default_vsmac_version=$(get_toolset_value '.xamarin.vsmac.default')

for version in ${vsmac_versions[@]}; do
    install_vsmac $version $default_vsmac_version
done

invoke_tests "Common" "VSMac"

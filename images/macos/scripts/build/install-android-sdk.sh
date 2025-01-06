#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-android-sdk.sh
##  Desc:  Install Android SDK, NDK and tools
################################################################################

source ~/utils/utils.sh

add_filtered_installation_components() {
    local minimum_version=$1
    shift
    local tools_array=("$@")

    for item in ${tools_array[@]}; do
        # take the last argument after splitting string by ';'' and '-''
        version=$(echo "${item##*[-;]}")
        if [[ "$(printf "${minimum_version}\n${version}\n" | sort -V | head -n1)" == "$minimum_version" ]]; then
            components+=($item)
        fi
    done
}

get_full_ndk_version() {
    local majorVersion=$1

    ndkVersion=$(${SDKMANAGER} --list | grep "ndk;${majorVersion}.*" | awk '{gsub("ndk;", ""); print $1}' | sort -V | tail -n1)
    echo "$ndkVersion"
}

components=()

android_platform=$(get_toolset_value '.android.platform_min_version')
android_build_tool=$(get_toolset_value '.android.build_tools_min_version')
android_extra_list=($(get_toolset_value '.android."extras"[]'))
android_addon_list=($(get_toolset_value '.android."addons"[]'))
android_additional_tools=($(get_toolset_value '.android."additional_tools"[]'))
android_ndk_major_versions=($(get_toolset_value '.android.ndk."versions"[]'))
android_ndk_major_default=$(get_toolset_value '.android.ndk.default')
android_ndk_major_latest=$(get_toolset_value '.android.ndk."versions"[-1]')
# Get the latest command line tools from https://developer.android.com/studio#cmdline-tools
# Newer version(s) require Java 11 by default
# See https://github.com/actions/runner-images/issues/6960
ANDROID_HOME=$HOME/Library/Android/sdk

# Download the latest command line tools so that we can accept all of the licenses.
# See https://developer.android.com/studio/#command-tools
cmdlineToolsVersion=$(get_toolset_value '.android."cmdline-tools"')

if [[ $cmdlineToolsVersion == "latest" ]]; then
    repository_xml_url="https://dl.google.com/android/repository/repository2-1.xml"
    repository_xml_path=$(download_with_retry $repository_xml_url)
    cmdlineToolsVersion=$(
    yq -p=xml \
    '.sdk-repository.remotePackage[] | select(."+@path" == "cmdline-tools;latest" and .channelRef."+@ref" == "channel-0").archives.archive[].complete.url | select(contains("commandlinetools-mac"))' \
    "$repository_xml_path"
    )

    if [[ -z $cmdlineToolsVersion ]]; then
        echo "Failed to parse latest command-line tools version"
        exit 1
    fi
fi

echo "Downloading android command line tools..."
archive_path=$(download_with_retry "https://dl.google.com/android/repository/${cmdlineToolsVersion}")

echo "Uncompressing android command line tools..."
mkdir -p "$ANDROID_HOME"
unzip -q "$archive_path" -d "$ANDROID_HOME/cmdline-tools"
# Command line tools need to be placed in $ANDROID_HOME/cmdline-tools/latest to function properly
mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"

echo ANDROID_HOME is "$ANDROID_HOME"
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest:$ANDROID_HOME/cmdline-tools/latest/bin

SDKMANAGER=$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager

echo "Installing latest tools & platform tools..."
echo y | $SDKMANAGER "tools" "platform-tools"

echo "Installing latest ndk..."
for ndk_version in "${android_ndk_major_versions[@]}"
do
    ndk_full_version=$(get_full_ndk_version $ndk_version)
    echo y | $SDKMANAGER "ndk;$ndk_full_version"
done

ndkDefault=$(get_full_ndk_version $android_ndk_major_default)
ANDROID_NDK_HOME=$ANDROID_HOME/ndk/$ndkDefault
ndkLatest=$(get_full_ndk_version $android_ndk_major_latest)
ANDROID_NDK_LATEST_HOME=$ANDROID_HOME/ndk/$ndkLatest
# ANDROID_NDK, ANDROID_NDK_HOME, and ANDROID_NDK_ROOT variables should be set as many customer builds depend on them https://github.com/actions/runner-images/issues/5879
echo "export ANDROID_NDK=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_HOME=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_LATEST_HOME=$ANDROID_NDK_LATEST_HOME" >> "${HOME}/.bashrc"

availablePlatforms=($($SDKMANAGER --list | grep "platforms;android-[0-9]" | cut -d"|" -f 1 | sort -u))
add_filtered_installation_components $android_platform "${availablePlatforms[@]}"

allBuildTools=($($SDKMANAGER --list --include_obsolete | grep "build-tools;" | cut -d"|" -f 1 | sort -u))
availableBuildTools=$(echo ${allBuildTools[@]//*rc[0-9]/})
add_filtered_installation_components $android_build_tool "${availableBuildTools[@]}"

echo "y" | $SDKMANAGER ${components[@]}

for extra_name in "${android_extra_list[@]}"
do
    echo "Installing extra $extra_name ..."
    echo y | $SDKMANAGER "extras;$extra_name"
done

for addon_name in "${android_addon_list[@]}"
do
    echo "Installing add-on $addon_name ..."
    echo y | $SDKMANAGER "add-ons;$addon_name"
done

for tool_name in "${android_additional_tools[@]}"
do
    echo "Installing additional tool $tool_name ..."
    echo y | $SDKMANAGER "$tool_name"
done

# Download SDK tools to preserve backward compatibility
sdk_tools_version=$(get_toolset_value '.android."sdk-tools"')
if [ "$sdk_tools_version" != "null" ]; then
    sdk_tools_archive_path=$(download_with_retry "https://dl.google.com/android/repository/${sdk_tools_version}")
    unzip -o -qq "$sdk_tools_archive_path" -d "${ANDROID_SDK_ROOT}"
fi

invoke_tests "Android"

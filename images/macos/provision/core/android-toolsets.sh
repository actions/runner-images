#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

function filter_components_by_version {
    minimumVersion=$1
    shift
    toolsArr=("$@")

    for item in ${toolsArr[@]}
    do
        # take the last argument after spliting string by ';'' and '-''
        version=$(echo "${item##*[-;]}")
        if verlte $minimumVersion $version
        then
            components+=($item)
        fi
    done
}

function get_full_ndk_version {
    majorVersion=$1
    ndkVersion=$(${SDKMANAGER} --list | grep "ndk;${majorVersion}.*" | awk '{gsub("ndk;", ""); print $1}' | sort -V | tail -n1)

    echo "$ndkVersion"
}

components=()

ANDROID_PLATFORM=$(get_toolset_value '.android.platform_min_version')
ANDROID_BUILD_TOOL=$(get_toolset_value '.android.build_tools_min_version')
ANDROID_EXTRA_LIST=($(get_toolset_value '.android."extra-list"[]'))
ANDROID_ADDON_LIST=($(get_toolset_value '.android."addon-list"[]'))
ANDROID_ADDITIONAL_TOOLS=($(get_toolset_value '.android."additional-tools"[]'))
ANDROID_NDK_MAJOR_VERSIONS=($(get_toolset_value '.android.ndk."versions"[]'))
ANDROID_NDK_MAJOR_DEFAULT=$(get_toolset_value '.android.ndk.default')
ANDROID_NDK_MAJOR_LATEST=$(get_toolset_value '.android.ndk."versions"[-1]')
# Get the latest command line tools from https://developer.android.com/studio#cmdline-tools
cmdlineToolsVersion=$(get_toolset_value '.android."cmdline-tools"')
if [[ $cmdlineToolsVersion == "latest" ]]; then
    repositoryXmlUrl="https://dl.google.com/android/repository/repository2-1.xml"
    download_with_retries $repositoryXmlUrl "/tmp" "repository2-1.xml"
    cmdlineToolsVersion=$(
      yq -p=xml \
      '.sdk-repository.remotePackage[] | select(."+@path" == "cmdline-tools;latest").archives.archive[].complete.url | select(contains("commandlinetools-mac"))' \
      /tmp/repository2-1.xml
    )

    if [[ -z $cmdlineToolsVersion ]]; then
        echo "Failed to parse latest command-line tools version"
        exit 1
    fi
fi

ANDROID_OSX_SDK_URL="https://dl.google.com/android/repository/${cmdlineToolsVersion}"
ANDROID_HOME=$HOME/Library/Android/sdk
ANDROID_OSX_SDK_FILE=tools-macosx.zip

pushd $HOME

echo "Downloading android command line tools..."
download_with_retries $ANDROID_OSX_SDK_URL "." $ANDROID_OSX_SDK_FILE

echo "Uncompressing android command line tools..."
mkdir -p $HOME/Library/Android/sdk
unzip -q $ANDROID_OSX_SDK_FILE -d $HOME/Library/Android/sdk/cmdline-tools
# Command line tools need to be placed in $HOME/Library/Android/sdk/cmdline-tools/latest to function properly
mv $HOME/Library/Android/sdk/cmdline-tools/cmdline-tools $HOME/Library/Android/sdk/cmdline-tools/latest
rm -f $ANDROID_OSX_SDK_FILE

echo ANDROID_HOME is $ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest:$ANDROID_HOME/cmdline-tools/latest/bin

SDKMANAGER=$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager

echo "Installing latest tools & platform tools..."
echo y | $SDKMANAGER "tools" "platform-tools"

echo "Installing latest ndk..."
for ndk_version in "${ANDROID_NDK_MAJOR_VERSIONS[@]}"
do
    ndk_full_version=$(get_full_ndk_version $ndk_version)
    echo y | $SDKMANAGER "ndk;$ndk_full_version"
done

ndkDefault=$(get_full_ndk_version $ANDROID_NDK_MAJOR_DEFAULT)
ANDROID_NDK_HOME=$ANDROID_HOME/ndk/$ndkDefault
ndkLatest=$(get_full_ndk_version $ANDROID_NDK_MAJOR_LATEST)
ANDROID_NDK_LATEST_HOME=$ANDROID_HOME/ndk/$ndkLatest
# ANDROID_NDK, ANDROID_NDK_HOME, and ANDROID_NDK_ROOT variables should be set as many customer builds depend on them https://github.com/actions/runner-images/issues/5879
echo "export ANDROID_NDK=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_HOME=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME" >> "${HOME}/.bashrc"
echo "export ANDROID_NDK_LATEST_HOME=$ANDROID_NDK_LATEST_HOME" >> "${HOME}/.bashrc"

availablePlatforms=($($SDKMANAGER --list | grep "platforms;android-[0-9]" | cut -d"|" -f 1 | sort -u))
filter_components_by_version $ANDROID_PLATFORM "${availablePlatforms[@]}"

allBuildTools=($($SDKMANAGER --list --include_obsolete | grep "build-tools;" | cut -d"|" -f 1 | sort -u))
availableBuildTools=$(echo ${allBuildTools[@]//*rc[0-9]/})
filter_components_by_version $ANDROID_BUILD_TOOL "${availableBuildTools[@]}"

echo "y" | $SDKMANAGER ${components[@]}

for extra_name in "${ANDROID_EXTRA_LIST[@]}"
do
    echo "Installing extra $extra_name ..."
    echo y | $SDKMANAGER "extras;$extra_name"
done

# Intel x86 Emulator Accelerator (HAXM installer)
# The Android Emulator uses the built-in Hypervisor.Framework by default, and falls back to using Intel HAXM if Hypervisor.Framework fails to initialize
# https://developer.android.com/studio/run/emulator-acceleration#vm-mac
# The installation doesn't work properly on macOS Big Sur, /dev/HAX is not created
if is_Catalina; then
    chmod +x $ANDROID_HOME/extras/intel/Hardware_Accelerated_Execution_Manager/silent_install.sh
    sudo $ANDROID_HOME/extras/intel/Hardware_Accelerated_Execution_Manager/silent_install.sh
fi

for addon_name in "${ANDROID_ADDON_LIST[@]}"
do
    echo "Installing add-on $addon_name ..."
    echo y | $SDKMANAGER "add-ons;$addon_name"
done

for tool_name in "${ANDROID_ADDITIONAL_TOOLS[@]}"
do
    echo "Installing additional tool $tool_name ..."
    echo y | $SDKMANAGER "$tool_name"
done

invoke_tests "Android"

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

ANDROID_PLATFORM=($(get_toolset_value '.android.platform_min_version'))
ANDROID_BUILD_TOOL=($(get_toolset_value '.android.build_tools_min_version'))
ANDROID_EXTRA_LIST=($(get_toolset_value '.android."extra-list"[]'))
ANDROID_ADDON_LIST=($(get_toolset_value '.android."addon-list"[]'))
ANDROID_ADDITIONAL_TOOLS=($(get_toolset_value '.android."additional-tools"[]'))
ANDROID_NDK_MAJOR_LTS=($(get_toolset_value '.android.ndk.lts'))
ANDROID_NDK_MAJOR_LATEST=($(get_toolset_value '.android.ndk.latest'))
# Get the latest command line tools from https://developer.android.com/studio#cmdline-tools
ANDROID_OSX_SDK_URL="https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip"
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
ndkLtsLatest=$(get_full_ndk_version  $ANDROID_NDK_MAJOR_LTS)
ndkLatest=$(get_full_ndk_version  $ANDROID_NDK_MAJOR_LATEST)
echo y | $SDKMANAGER  "ndk;$ndkLtsLatest" "ndk;$ndkLatest"
# This changes were added due to incompatibility with android ndk-bundle (ndk;22.0.7026061).
# Link issue virtual-environments: https://github.com/actions/virtual-environments/issues/2481
# Link issue xamarin-android: https://github.com/xamarin/xamarin-android/issues/5526
ln -s $ANDROID_HOME/ndk/$ndkLtsLatest $ANDROID_HOME/ndk-bundle
ANDROID_NDK_LATEST_HOME=$ANDROID_HOME/ndk/$ndkLatest
echo "export ANDROID_NDK_LATEST_HOME=$ANDROID_NDK_LATEST_HOME" >> "${HOME}/.bashrc"

availablePlatforms=($($SDKMANAGER --list | grep "platforms;android-" | cut -d"|" -f 1 | sort -u))
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
if is_Less_BigSur; then
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

popd

echo "Installing ProGuard-5..."
PROGUARD_LOCATION="https://github.com/Guardsquare/proguard/archive/proguard5.3.3.tar.gz"
pushd $ANDROID_HOME
cd tools
mv proguard proguard4
mkdir proguard && cd proguard
curl -L -o proguard5.tgz $PROGUARD_LOCATION
tar xzf proguard5.tgz --strip 1 && rm -f proguard5.tgz
cp ../proguard4/proguard-*.txt . # Copy the Proguard Android definitions from the previous version
popd

invoke_tests "Android"

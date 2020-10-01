#!/bin/bash
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

verlte() {
    sortedVersion=$(echo -e "$1\n$2" | sort -V | head -n1)
    [  "$1" = "$sortedVersion" ]
}

function install_android_packages {
    minimumVersion=$1
    shift
    toolsArr=("$@")

    for item in ${toolsArr[@]}
    do
        version=$(echo "${item##*[-;]}")
        if verlte $minimumVersion $version
        then
            echo "Start installing $item"
            echo "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager $item
        fi
    done
}

# Set env variable for SDK Root (https://developer.android.com/studio/command-line/variables)
ANDROID_ROOT=/usr/local/lib/android
ANDROID_SDK_ROOT=${ANDROID_ROOT}/sdk
echo "ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# ANDROID_HOME is deprecated, but older versions of Gradle rely on it
echo "ANDROID_HOME=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# Create android sdk directory
mkdir -p ${ANDROID_SDK_ROOT}

# Download the latest command line tools so that we can accept all of the licenses.
# See https://developer.android.com/studio/#command-tools
wget -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip android-sdk.zip -d ${ANDROID_SDK_ROOT}
rm -f android-sdk.zip

if isUbuntu20 ; then
    # Sdk manager doesn't work with Java > 8, set version 8 explicitly
    sed -i "2i export JAVA_HOME=${JAVA_HOME_8_X64}" /usr/local/lib/android/sdk/tools/bin/sdkmanager
fi

# Check sdk manager installation
/usr/local/lib/android/sdk/tools/bin/sdkmanager --list 1>/dev/null
if [ $? -eq 0 ]
then
    echo "Android SDK manager was installed"
else
    echo "Android SDK manager was not installed"
    exit 1
fi

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
minimumBuildToolVersion=$(jq -r '.android.build_tools_min_version' $toolset)
minimumPlatformVersion=$(jq -r '.android.platform_min_version' $toolset)
extras=$(jq -r '.android.extra_list[]|"extras;" + .' $toolset)
addons=$(jq -r '.android.addon_list[]|"add-ons;" + .' $toolset)
additional=$(jq -r '.android.additional_tools[]' $toolset)

# Install the following SDKs and build tools, passing in "y" to accept licenses.
echo "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager $extras $google_api_list $addons $additional

platforms=$(${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --list | sed -n '/Available Packages:/,/^$/p' | grep "platforms;android" | sed -E "s/[[:space:]]+//g" | sed -E "s/\|.*//g")
buildTools=$(${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --list | sed -n '/Available Packages:/,/^$/p' | grep "build-tools;" | sed -E "s/[[:space:]]+//g" | sed -E "s/\|.*//g")

platformsArr=(${platforms})
install_android_packages $minimumPlatformVersion "${platformsArr[@]}"
buildToolsArr=(${buildTools})
install_android_packages $minimumBuildToolVersion "${buildToolsArr[@]}"

# Add required permissions
chmod -R a+rwx ${ANDROID_SDK_ROOT}

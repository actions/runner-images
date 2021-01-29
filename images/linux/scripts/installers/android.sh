#!/bin/bash -e
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

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
    packagesList=$2
    
    ndkFullVersion=$($packagesList | grep "ndk;${majorVersion}.*" | awk '{gsub("ndk;", ""); print $1}' | sort -V | tail -n1)

    echo "$ndkFullVersion"
}

# Set env variable for SDK Root (https://developer.android.com/studio/command-line/variables)
ANDROID_ROOT=/usr/local/lib/android
ANDROID_SDK_ROOT=${ANDROID_ROOT}/sdk
ANDROID_NDK_ROOT=${ANDROID_SDK_ROOT}/ndk-bundle
SDKMANAGER=${ANDROID_SDK_ROOT}/tools/bin/sdkmanager
echo "ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# ANDROID_HOME is deprecated, but older versions of Gradle rely on it
echo "ANDROID_HOME=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# Set env variables for NDK Root
echo "ANDROID_NDK_HOME=${ANDROID_NDK_ROOT}" | tee -a /etc/environment
echo "ANDROID_NDK_ROOT=${ANDROID_NDK_ROOT}" | tee -a /etc/environment

# Create android sdk directory
mkdir -p ${ANDROID_SDK_ROOT}

# Download the latest command line tools so that we can accept all of the licenses.
# See https://developer.android.com/studio/#command-tools
wget -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip android-sdk.zip -d ${ANDROID_SDK_ROOT}
rm -f android-sdk.zip

if isUbuntu20 ; then
    # Sdk manager doesn't work with Java > 8, set version 8 explicitly
    sed -i "2i export JAVA_HOME=${JAVA_HOME_8_X64}" "$SDKMANAGER"
fi

# Get list of packages from SDK Manager 
sdkPackagesList=$(${SDKMANAGER} --list)

# Check sdk manager installation
${SDKMANAGER} --list 1>/dev/null
if [ $? -eq 0 ]
then
    echo "Android SDK manager was installed"
else
    echo "Android SDK manager was not installed"
    exit 1
fi

minimumBuildToolVersion=$(get_toolset_value '.android.build_tools_min_version')
minimumPlatformVersion=$(get_toolset_value '.android.platform_min_version')
extras=$(get_toolset_value '.android.extra_list[]|"extras;" + .')
addons=$(get_toolset_value '.android.addon_list[]|"add-ons;" + .')
additional=$(get_toolset_value '.android.additional_tools[]')
ANDROID_NDK_MAJOR_LTS=($(get_toolset_value '.android.ndk.lts'))
ANDROID_NDK_MAJOR_LATEST=($(get_toolset_value '.android.ndk.latest'))
ndkLTSFullVersion=$(get_full_ndk_version  $ANDROID_NDK_MAJOR_LTS $sdkPackagesList)
ndkLatestFullVersion=$(get_full_ndk_version  $ANDROID_NDK_MAJOR_LATEST $sdkPackagesList)

# Install the following SDKs and build tools, passing in "y" to accept licenses.
components=( "${extras[@]}" "${addons[@]}" "${additional[@]}" "ndk;$ndkLTSFullVersion" "ndk;$ndkLatestFullVersion" )

# This changes were added due to incompatibility with android ndk-bundle (ndk;22.0.7026061).
# Link issue virtual-environments: https://github.com/actions/virtual-environments/issues/2481
# Link issue xamarin-android: https://github.com/xamarin/xamarin-android/issues/5526
ln -s $ANDROID_SDK_ROOT/ndk/$ndkLTSFullVersion $ANDROID_NDK_ROOT

echo "ANDROID_NDK_LATEST_HOME=${ANDROID_SDK_ROOT}/ndk/$ndkLatestFullVersion" | tee -a /etc/environment

availablePlatforms=($($sdkPackagesList | sed -n '/Available Packages:/,/^$/p' | grep "platforms;android-" | cut -d"|" -f 1))
allBuildTools=($($sdkPackagesList | grep "build-tools;" | cut -d"|" -f 1 | sort -u))
availableBuildTools=$(echo ${allBuildTools[@]//*rc[0-9]/})

filter_components_by_version $minimumPlatformVersion "${availablePlatforms[@]}"
filter_components_by_version $minimumBuildToolVersion "${availableBuildTools[@]}"

echo "y" | $SDKMANAGER ${components[@]}

# Add required permissions
chmod -R a+rwx ${ANDROID_SDK_ROOT}

invoke_tests "Android"

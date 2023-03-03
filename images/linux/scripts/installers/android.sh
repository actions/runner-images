#!/bin/bash -e
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

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
    ndkFullVersion=$($SDKMANAGER --list | grep "ndk;${majorVersion}.*" | awk '{gsub("ndk;", ""); print $1}' | sort -V | tail -n1)
    echo "$ndkFullVersion"
}

# Set env variable for SDK Root (https://developer.android.com/studio/command-line/variables)
ANDROID_ROOT=/usr/local/lib/android
ANDROID_SDK_ROOT=${ANDROID_ROOT}/sdk
SDKMANAGER=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager
echo "ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# ANDROID_HOME is deprecated, but older versions of Gradle rely on it
echo "ANDROID_HOME=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# Create android sdk directory
mkdir -p ${ANDROID_SDK_ROOT}

cmdlineTools="android-cmdline-tools.zip"

if isUbuntu18; then
    # Newer command-line-tools require Java 11 which is not default on ubuntu-18.04
    download_with_retries "https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip" "." $cmdlineTools
else
    # Download the latest command line tools so that we can accept all of the licenses.
    # See https://developer.android.com/studio/#command-tools
    cmdlineToolsVersion=$(get_toolset_value '.android."cmdline-tools"')
    if [[ $cmdlineToolsVersion == "latest" ]]; then
        repositoryXmlUrl="https://dl.google.com/android/repository/repository2-1.xml"
        download_with_retries $repositoryXmlUrl "/tmp" "repository2-1.xml"
        cmdlineToolsVersion=$(
        yq -p=xml \
        '.sdk-repository.remotePackage[] | select(."+@path" == "cmdline-tools;latest" and .channelRef."+@ref" == "channel-0").archives.archive[].complete.url | select(contains("commandlinetools-linux"))' \
        /tmp/repository2-1.xml
        )

        if [[ -z $cmdlineToolsVersion ]]; then
            echo "Failed to parse latest command-line tools version"
            exit 1
        fi
fi

download_with_retries "https://dl.google.com/android/repository/${cmdlineToolsVersion}" "." $cmdlineTools
fi

unzip -qq $cmdlineTools -d ${ANDROID_SDK_ROOT}/cmdline-tools
# Command line tools need to be placed in ${ANDROID_SDK_ROOT}/sdk/cmdline-tools/latest to determine SDK root
mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest
rm -f $cmdlineTools

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
ANDROID_NDK_MAJOR_VERSIONS=($(get_toolset_value '.android.ndk.versions[]'))
ANDROID_NDK_MAJOR_DEFAULT=$(get_toolset_value '.android.ndk.default')

components=("${extras[@]}" "${addons[@]}" "${additional[@]}")
for ndk_version in "${ANDROID_NDK_MAJOR_VERSIONS[@]}"
do
    ndk_full_version=$(get_full_ndk_version $ndk_version)
    components+=("ndk;$ndk_full_version")
done

ANDROID_NDK_MAJOR_LATEST=(${ANDROID_NDK_MAJOR_VERSIONS[-1]})
ndkDefaultFullVersion=$(get_full_ndk_version $ANDROID_NDK_MAJOR_DEFAULT)
ndkLatestFullVersion=$(get_full_ndk_version $ANDROID_NDK_MAJOR_LATEST)
ANDROID_NDK="$ANDROID_SDK_ROOT/ndk/$ndkDefaultFullVersion"
# ANDROID_NDK, ANDROID_NDK_HOME, and ANDROID_NDK_ROOT variables should be set as many customer builds depend on them https://github.com/actions/runner-images/issues/5879
echo "ANDROID_NDK=${ANDROID_NDK}" | tee -a /etc/environment
echo "ANDROID_NDK_HOME=${ANDROID_NDK}" | tee -a /etc/environment
echo "ANDROID_NDK_ROOT=${ANDROID_NDK}" | tee -a /etc/environment
echo "ANDROID_NDK_LATEST_HOME=$ANDROID_SDK_ROOT/ndk/$ndkLatestFullVersion" | tee -a /etc/environment

availablePlatforms=($($SDKMANAGER --list | sed -n '/Available Packages:/,/^$/p' | grep "platforms;android-[0-9]" | cut -d"|" -f 1))
allBuildTools=($($SDKMANAGER --list | grep "build-tools;" | cut -d"|" -f 1 | sort -u))
availableBuildTools=$(echo ${allBuildTools[@]//*rc[0-9]/})

filter_components_by_version $minimumPlatformVersion "${availablePlatforms[@]}"
filter_components_by_version $minimumBuildToolVersion "${availableBuildTools[@]}"

echo "y" | $SDKMANAGER ${components[@]}

# Old skdmanager from sdk tools doesn't work with Java > 8, set version 8 explicitly
if isUbuntu20 || isUbuntu22; then
    sed -i "2i export JAVA_HOME=${JAVA_HOME_8_X64}" ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager
fi

# Add required permissions
chmod -R a+rwx ${ANDROID_SDK_ROOT}

reloadEtcEnvironment
invoke_tests "Android"

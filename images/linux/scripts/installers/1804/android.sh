#!/bin/bash
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

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

# Add required permissions
chmod -R a+X ${ANDROID_SDK_ROOT}

# Check sdk manager installation
/usr/local/lib/android/sdk/tools/bin/sdkmanager --list 1>/dev/null
if [ $? -eq 0 ]
then
    echo "Android SDK manager was installed"
else
    echo "Android SDK manager was not installed"
    exit 1
fi

# Install the following SDKs and build tools, passing in "y" to accept licenses.
echo "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager \
    "ndk-bundle" \
    "platform-tools" \
    "platforms;android-30" \
    "platforms;android-29" \
    "platforms;android-28" \
    "platforms;android-27" \
    "platforms;android-26" \
    "platforms;android-25" \
    "platforms;android-24" \
    "platforms;android-23" \
    "platforms;android-22" \
    "platforms;android-21" \
    "platforms;android-19" \
    "platforms;android-17" \
    "build-tools;30.0.0" \
    "build-tools;29.0.3" \
    "build-tools;29.0.2" \
    "build-tools;29.0.0" \
    "build-tools;28.0.3" \
    "build-tools;28.0.2" \
    "build-tools;28.0.1" \
    "build-tools;28.0.0" \
    "build-tools;27.0.3" \
    "build-tools;27.0.2" \
    "build-tools;27.0.1" \
    "build-tools;27.0.0" \
    "build-tools;26.0.3" \
    "build-tools;26.0.2" \
    "build-tools;26.0.1" \
    "build-tools;26.0.0" \
    "build-tools;25.0.3" \
    "build-tools;25.0.2" \
    "build-tools;25.0.1" \
    "build-tools;25.0.0" \
    "build-tools;24.0.3" \
    "build-tools;24.0.2" \
    "build-tools;24.0.1" \
    "build-tools;24.0.0" \
    "build-tools;23.0.3" \
    "build-tools;23.0.2" \
    "build-tools;23.0.1" \
    "build-tools;22.0.1" \
    "build-tools;21.1.2" \
    "build-tools;20.0.0" \
    "build-tools;19.1.0" \
    "build-tools;17.0.0" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "add-ons;addon-google_apis-google-24" \
    "add-ons;addon-google_apis-google-23" \
    "add-ons;addon-google_apis-google-22" \
    "add-ons;addon-google_apis-google-21" \
    "cmake;3.6.4111459" \
    "cmake;3.10.2.4988404" \
    "patcher;v4"

# Document what was added to the image
echo "Lastly, document what was added to the metadata file"
DocumentInstalledItem "Google Repository $(cat ${ANDROID_SDK_ROOT}/extras/google/m2repository/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"
DocumentInstalledItem "Google Play services $(cat ${ANDROID_SDK_ROOT}/extras/google/google_play_services/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"
DocumentInstalledItem "Google APIs 24"
DocumentInstalledItem "Google APIs 23"
DocumentInstalledItem "Google APIs 22"
DocumentInstalledItem "Google APIs 21"
DocumentInstalledItem "CMake $(ls ${ANDROID_SDK_ROOT}/cmake 2>&1)"
DocumentInstalledItem "Android Support Repository 47.0.0"
DocumentInstalledItem "Android SDK Platform-Tools $(cat ${ANDROID_SDK_ROOT}/platform-tools/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"
DocumentInstalledItem "Android SDK Platform 30"
DocumentInstalledItem "Android SDK Platform 29"
DocumentInstalledItem "Android SDK Platform 28"
DocumentInstalledItem "Android SDK Platform 27"
DocumentInstalledItem "Android SDK Platform 26"
DocumentInstalledItem "Android SDK Platform 25"
DocumentInstalledItem "Android SDK Platform 24"
DocumentInstalledItem "Android SDK Platform 23"
DocumentInstalledItem "Android SDK Platform 22"
DocumentInstalledItem "Android SDK Platform 21"
DocumentInstalledItem "Android SDK Platform 19"
DocumentInstalledItem "Android SDK Platform 17"
DocumentInstalledItem "Android SDK Patch Applier v4"
DocumentInstalledItem "Android SDK Build-Tools 30.0.0"
DocumentInstalledItem "Android SDK Build-Tools 29.0.3"
DocumentInstalledItem "Android SDK Build-Tools 29.0.2"
DocumentInstalledItem "Android SDK Build-Tools 29.0.0"
DocumentInstalledItem "Android SDK Build-Tools 28.0.3"
DocumentInstalledItem "Android SDK Build-Tools 28.0.2"
DocumentInstalledItem "Android SDK Build-Tools 28.0.1"
DocumentInstalledItem "Android SDK Build-Tools 28.0.0"
DocumentInstalledItem "Android SDK Build-Tools 27.0.3"
DocumentInstalledItem "Android SDK Build-Tools 27.0.2"
DocumentInstalledItem "Android SDK Build-Tools 27.0.1"
DocumentInstalledItem "Android SDK Build-Tools 27.0.0"
DocumentInstalledItem "Android SDK Build-Tools 26.0.3"
DocumentInstalledItem "Android SDK Build-Tools 26.0.2"
DocumentInstalledItem "Android SDK Build-Tools 26.0.1"
DocumentInstalledItem "Android SDK Build-Tools 26.0.0"
DocumentInstalledItem "Android SDK Build-Tools 25.0.3"
DocumentInstalledItem "Android SDK Build-Tools 25.0.2"
DocumentInstalledItem "Android SDK Build-Tools 25.0.1"
DocumentInstalledItem "Android SDK Build-Tools 25.0.0"
DocumentInstalledItem "Android SDK Build-Tools 24.0.3"
DocumentInstalledItem "Android SDK Build-Tools 24.0.2"
DocumentInstalledItem "Android SDK Build-Tools 24.0.1"
DocumentInstalledItem "Android SDK Build-Tools 24.0.0"
DocumentInstalledItem "Android SDK Build-Tools 23.0.3"
DocumentInstalledItem "Android SDK Build-Tools 23.0.2"
DocumentInstalledItem "Android SDK Build-Tools 23.0.1"
DocumentInstalledItem "Android SDK Build-Tools 22.0.1"
DocumentInstalledItem "Android SDK Build-Tools 21.1.2"
DocumentInstalledItem "Android SDK Build-Tools 20.0.0"
DocumentInstalledItem "Android SDK Build-Tools 19.1.0"
DocumentInstalledItem "Android SDK Build-Tools 17.0.0"
DocumentInstalledItem "Android NDK $(cat ${ANDROID_SDK_ROOT}/ndk-bundle/source.properties 2>&1 | grep Pkg.Revision | cut -d ' ' -f 3)"

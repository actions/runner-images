#!/bin/bash
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

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
chmod -R a+rwx ${ANDROID_SDK_ROOT}

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

toolsetJson="$INSTALLER_SCRIPT_FOLDER/toolset.json"
platforms=$(cat $toolsetJson  | jq -r '.android.platform_list[]|"platforms;" + .')
buildtools=$(cat $toolsetJson  | jq -r '.android.build_tools[]|"build-tools;" + .')
extras=$(cat $toolsetJson  | jq -r '.android.extra_list[]|"extras;" + .')
addons=$(cat $toolsetJson  | jq -r '.android.addon_list[]|"add-ons;" + .')
additional=$(cat $toolsetJson  | jq -r '.android.additional_tools[]')

# Install the following SDKs and build tools, passing in "y" to accept licenses.
echo "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager $platforms $buildtools $extras $google_api_list $addons $additional

# Document what was added to the image

google_api_versions_list=$(echo "$addons"|awk -F- '/addon-google_apis-google/  {print $5}')
constraint_layout_versions_list=$(echo "$extras"|awk -F';' '/constraint-layout;/  {print $8}')
constraint_layout_solver_versions_list=$(echo "$extras"|awk -F';' '/constraint-layout-solver;/  {print $8}')
platform_versions_list=$(echo "$platforms"|awk -F- '{print $2}')
buildtools_versions_list=$(echo "$buildtools"|awk -F';' '{print $2}')

echo "Lastly, document what was added to the metadata file"
DocumentInstalledItem "Google Repository $(cat ${ANDROID_SDK_ROOT}/extras/google/m2repository/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"
DocumentInstalledItem "Google Play services $(cat ${ANDROID_SDK_ROOT}/extras/google/google_play_services/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"

for version in $google_api_versions_list; do
  DocumentInstalledItem "Google APIs $version"
done

DocumentInstalledItem "CMake $(ls ${ANDROID_SDK_ROOT}/cmake 2>&1)"

for version in $constraint_layout_versions_list; do
  DocumentInstalledItem "Android ConstraintLayout $version"
done

for version in $constraint_layout_solver_versions_list; do
  DocumentInstalledItem "Android ConstraintLayout Solver $version"
done

DocumentInstalledItem "Android SDK Platform-Tools $(cat ${ANDROID_SDK_ROOT}/platform-tools/source.properties 2>&1 | grep Pkg.Revision | cut -d '=' -f 2)"
for version in $platform_versions_list; do
  DocumentInstalledItem "Android SDK Platform $version"
done

DocumentInstalledItem "Android SDK Patch Applier v4"

for version in $buildtools_versions_list; do
  DocumentInstalledItem "Android SDK Build-Tools $version"
done

DocumentInstalledItem "Android NDK $(cat ${ANDROID_SDK_ROOT}/ndk-bundle/source.properties 2>&1 | grep Pkg.Revision | cut -d ' ' -f 3)"

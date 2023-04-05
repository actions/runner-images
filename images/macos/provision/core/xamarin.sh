#!/bin/bash -e -o pipefail
source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

MONO_VERSIONS=($(get_toolset_value '.xamarin."mono-versions" | reverse | .[]'))
XAMARIN_IOS_VERSIONS=($(get_toolset_value '.xamarin."ios-versions" | reverse | .[]'))
XAMARIN_MAC_VERSIONS=($(get_toolset_value '.xamarin."mac-versions" | reverse | .[]'))
XAMARIN_ANDROID_VERSIONS=($(get_toolset_value '.xamarin."android-versions" | reverse | .[]'))
LATEST_SDK_SYMLINK=$(get_toolset_value '.xamarin.bundles[0].symlink')
CURRENT_SDK_SYMLINK=$(get_toolset_value '.xamarin."bundle-default"')
DEFAULT_XCODE_VERSION=$(get_toolset_value '.xcode.default')

if [ "$CURRENT_SDK_SYMLINK" == "latest" ]; then
  CURRENT_SDK_SYMLINK=$LATEST_SDK_SYMLINK
fi

MONO_VERSIONS_PATH='/Library/Frameworks/Mono.framework/Versions'
IOS_VERSIONS_PATH='/Library/Frameworks/Xamarin.iOS.framework/Versions'
ANDROID_VERSIONS_PATH='/Library/Frameworks/Xamarin.Android.framework/Versions'
MAC_VERSIONS_PATH='/Library/Frameworks/Xamarin.Mac.framework/Versions'

TMPMOUNT=`/usr/bin/mktemp -d /tmp/visualstudio.XXXX`
TMPMOUNT_FRAMEWORKS="$TMPMOUNT/frameworks"
createBackupFolders

pushd $TMPMOUNT

# Download NUnit console
downloadNUnitConsole

# Install Mono sdks
for VERSION in "${MONO_VERSIONS[@]}"; do installMono $VERSION; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/mono/* $MONO_VERSIONS_PATH/

# Install Xamarin.iOS sdks
for VERSION in "${XAMARIN_IOS_VERSIONS[@]}"; do installXamarinIOS $VERSION; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/ios/* $IOS_VERSIONS_PATH/

# Install Xamarin.Mac sdks
for VERSION in "${XAMARIN_MAC_VERSIONS[@]}"; do installXamarinMac $VERSION; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/mac/* $MAC_VERSIONS_PATH/

# Install Xamarin.Android sdks
for VERSION in "${XAMARIN_ANDROID_VERSIONS[@]}"; do installXamarinAndroid $VERSION; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/android/* $ANDROID_VERSIONS_PATH/


# Create bundles
BUNDLES_COUNT=$(get_toolset_value '.xamarin.bundles | length')
for ((BUNDLE_INDEX=0; BUNDLE_INDEX<BUNDLES_COUNT; BUNDLE_INDEX++)); do
    SYMLINK=$(get_toolset_value ".xamarin.bundles[$BUNDLE_INDEX].symlink")
    MONO=$(get_toolset_value ".xamarin.bundles[$BUNDLE_INDEX].mono")
    IOS=$(get_toolset_value ".xamarin.bundles[$BUNDLE_INDEX].ios")
    MAC=$(get_toolset_value ".xamarin.bundles[$BUNDLE_INDEX].mac")
    ANDROID=$(get_toolset_value ".xamarin.bundles[$BUNDLE_INDEX].android")
    createBundle $SYMLINK $MONO $IOS $MAC $ANDROID
done

# Symlinks for the latest Xamarin bundle
createBundleLink $LATEST_SDK_SYMLINK "Latest"
createBundleLink $CURRENT_SDK_SYMLINK "Current"

#
# Fix nuget in some mono versions because of known bugs
#

# Creating UWP Shim to hack UWP build failure
createUWPShim

popd

echo "Clean up packages..."
sudo rm -rf "$TMPMOUNT"

# Fix Xamarin issue with Xcode symlink: https://github.com/xamarin/xamarin-macios/issues/9960
PREFERENCES_XAMARIN_DIR="${HOME}/Library/Preferences/Xamarin"
mkdir -p $PREFERENCES_XAMARIN_DIR
/usr/libexec/PlistBuddy -c "add :AppleSdkRoot string /Applications/Xcode_${DEFAULT_XCODE_VERSION}.app" $PREFERENCES_XAMARIN_DIR/Settings.plist

# Temporary workaround to recreate nuget.config file with a correct feed https://github.com/actions/runner-images/issues/5768
rm -rf $HOME/.config/NuGet/NuGet.Config
nuget config

invoke_tests "Xamarin"

#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-xamarin.sh
##  Desc:  Install Xamarin
################################################################################

source ~/utils/utils.sh
source ~/utils/xamarin-utils.sh

mono_versions=($(get_toolset_value '.xamarin."mono_versions" | reverse | .[]'))
xamarin_ios_versions=($(get_toolset_value '.xamarin."ios_versions" | reverse | .[]'))
xamarin_mac_versions=($(get_toolset_value '.xamarin."mac_versions" | reverse | .[]'))
xamarin_android_versions=($(get_toolset_value '.xamarin."android_versions" | reverse | .[]'))
latest_sdk_symlink=$(get_toolset_value '.xamarin.bundles[0].symlink')
current_sdk_symlink=$(get_toolset_value '.xamarin."bundle_default"')
default_xcode_version=$(get_toolset_value '.xcode.default')

if [[ $current_sdk_symlink == "latest" ]]; then
  current_sdk_symlink=$latest_sdk_symlink
fi

MONO_VERSIONS_PATH="/Library/Frameworks/Mono.framework/Versions"
IOS_VERSIONS_PATH="/Library/Frameworks/Xamarin.iOS.framework/Versions"
ANDROID_VERSIONS_PATH="/Library/Frameworks/Xamarin.Android.framework/Versions"
MAC_VERSIONS_PATH="/Library/Frameworks/Xamarin.Mac.framework/Versions"

TMPMOUNT=$(/usr/bin/mktemp -d /tmp/visualstudio.XXXX)
TMPMOUNT_FRAMEWORKS=$TMPMOUNT/frameworks
createBackupFolders

pushd $TMPMOUNT

# Download NUnit console
downloadNUnitConsole

# Install Mono sdks
for version in ${mono_versions[@]}; do installMono $version; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/mono/* $MONO_VERSIONS_PATH/

# Install Xamarin.iOS sdks
for version in ${xamarin_ios_versions[@]}; do installXamarinIOS $version; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/ios/* $IOS_VERSIONS_PATH/

# Install Xamarin.Mac sdks
for version in ${xamarin_mac_versions[@]}; do installXamarinMac $version; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/mac/* $MAC_VERSIONS_PATH/

# Install Xamarin.Android sdks
for version in ${xamarin_android_versions[@]}; do installXamarinAndroid $version; done
sudo mv -v $TMPMOUNT_FRAMEWORKS/android/* $ANDROID_VERSIONS_PATH/


# Create bundles
bundles_count=$(get_toolset_value '.xamarin.bundles | length')
for ((bundle_index=0; bundle_index<bundles_count; bundle_index++)); do
    symlink=$(get_toolset_value ".xamarin.bundles[$bundle_index].symlink")
    mono=$(get_toolset_value ".xamarin.bundles[$bundle_index].mono")
    ios=$(get_toolset_value ".xamarin.bundles[$bundle_index].ios")
    mac=$(get_toolset_value ".xamarin.bundles[$bundle_index].mac")
    android=$(get_toolset_value ".xamarin.bundles[$bundle_index].android")
    createBundle $symlink $mono $ios $mac $android
done

# Symlinks for the latest Xamarin bundle
createBundleLink $latest_sdk_symlink "Latest"
createBundleLink $current_sdk_symlink "Current"

#
# Fix nuget in some mono versions because of known bugs
#

# Creating UWP Shim to hack UWP build failure
createUWPShim

popd

echo "Clean up packages..."
sudo rm -rf $TMPMOUNT

# Fix Xamarin issue with Xcode symlink: https://github.com/xamarin/xamarin-macios/issues/9960
PREFERENCES_XAMARIN_DIR="${HOME}/Library/Preferences/Xamarin"
mkdir -p $PREFERENCES_XAMARIN_DIR
/usr/libexec/PlistBuddy -c "add :AppleSdkRoot string /Applications/Xcode_${default_xcode_version}.app" $PREFERENCES_XAMARIN_DIR/Settings.plist

# Temporary workaround to recreate nuget.config file with a correct feed https://github.com/actions/runner-images/issues/5768
rm -rf $HOME/.config/NuGet/NuGet.Config
nuget config

# Temporary workaround to point Mono to the proper NUnit console
sudo sed -Ei '' 's/3.6.0/3.6.1/' /Library/Frameworks/Mono.framework/Versions/Current/Commands/nunit3-console

invoke_tests "Xamarin"

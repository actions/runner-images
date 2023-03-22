#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

# Close all finder windows because they can interfere with UI tests
close_finder_window

# Remove Parallels Desktop
# https://github.com/actions/runner-images/issues/6105
if is_Monterey; then
    brew uninstall parallels
fi

# Put documentation to $HOME root
cp $HOME/image-generation/output/software-report/systeminfo.* $HOME/

# Put build vm assets scripts to proper directory
mkdir -p /usr/local/opt/$USER/scripts
mv $HOME/image-generation/assets/* /usr/local/opt/$USER/scripts

find /usr/local/opt/$USER/scripts -type f -name "*\.sh" -exec chmod +x {} \;

# Remove fastlane cached cookie
rm -rf ~/.fastlane

# Clean up npm cache which collected during image-generation
# we have to do that here because `npm install` is run in a few different places during image-generation
npm cache clean --force

# Clean yarn cache
if ! is_Ventura; then
    yarn cache clean
fi
# Clean up temporary directories
sudo rm -rf ~/utils ~/image-generation /tmp/*

# Disable indexing volumes/Spotlight
sudo defaults write ~/.Spotlight-V100/VolumeConfiguration.plist Exclusions -array "/Volumes" || true
sudo defaults write ~/.Spotlight-V100/VolumeConfiguration.plist Exclusions -array "/Network" || true
sudo killall mds || true
sleep 60 # needed or else subsequent commands may fail
sudo mdutil -a -i off / || true
sudo mdutil -a -i off || true
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist || true
sudo rm -rf /.Spotlight-V100/*
# disable coreduetd due to unnecessary CPU/RAM usage
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.coreduetd.osx.plist || true


# delete symlink for tests running
sudo rm -f /usr/local/bin/invoke_tests

#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-system.sh
##  Desc:  Post deployment system configuration actions
################################################################################

source ~/utils/utils.sh

# Close all finder windows because they can interfere with UI tests
close_finder_window

# Remove Parallels Desktop
# https://github.com/actions/runner-images/issues/6105
# https://github.com/actions/runner-images/issues/10143
if is_Monterey || is_SonomaX64 || is_VenturaX64; then
    brew uninstall parallels
fi

# Put documentation to $HOME root
cp $HOME/image-generation/output/software-report/systeminfo.* $HOME/

# Put build vm assets (xamarin-selector) scripts to proper directory
if is_Monterey || is_Sonoma || is_Ventura; then
    mkdir -p /usr/local/opt/$USER/scripts
    mv $HOME/image-generation/assets/* /usr/local/opt/$USER/scripts
    find /usr/local/opt/$USER/scripts -type f -name "*\.sh" -exec chmod +x {} \;
fi

# Remove fastlane cached cookie
rm -rf ~/.fastlane

# Clean up npm cache which collected during image-generation
# we have to do that here because `npm install` is run in a few different places during image-generation
npm cache clean --force

# Clean yarn cache
yarn cache clean

# Clean up temporary directories
sudo rm -rf ~/utils /tmp/*

# Erase all indexes and wait until the rebuilding process ends,
# for now there is no way to get status of indexing process, it takes around 3 minutes to accomplish
sudo mdutil -E /
sudo log stream | grep -q -E 'mds.*Released.*BackgroundTask' || true
echo "Indexing completed"

# delete symlink for tests running
sudo rm -f /usr/local/bin/invoke_tests

# Clean Homebrew downloads
sudo rm -rf /Users/$USER/Library/Caches/Homebrew/downloads/*

# Uninstall expect used in configure-machine.sh
brew uninstall expect

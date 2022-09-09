#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

# Close all finder windows because they can interfere with UI tests
close_finder_window

if is_Catalina; then
    # Ignore available updates to prevent system pop-ups
    updateName=$(softwareupdate -l | grep "Title: " | awk -F[:,] '{print $2}' | awk '{$1=$1};1') || true
    if [ ! -z "$updateName" ]; then
        sudo softwareupdate --ignore "$updateName"
    fi
fi

# Put documentation to $HOME root
cp $HOME/image-generation/output/software-report/systeminfo.txt $HOME/image-generation/output/software-report/systeminfo.md $HOME/

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
yarn cache clean

# Clean up temporary directories
sudo rm -rf ~/utils ~/image-generation /tmp/*

# Erase all indexes and wait until the rebuilding process ends,
# for now there is no way to get status of indexing process, it takes around 3 minutes to accomplish
sudo mdutil -E /
sudo log stream | grep -q -E 'mds.*Released.*BackgroundTask' || true
echo "Indexing completed"

# delete symlink for tests running
sudo rm -f /usr/local/bin/invoke_tests

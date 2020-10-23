#!/bin/bash

# Close all finder windows because they can interfere with UI tests
osascript -e 'tell application "Finder" to close windows'

# Ignore available updates to prevent system pop-ups
updateName=$(softwareupdate -l | grep "Title: " | awk -F[:,] '{print $2}' | awk '{$1=$1};1')
if [ ! -z "$updateName" ]; then
    sudo softwareupdate --ignore "$updateName"
fi

# Put documentation to $HOME root
cp $HOME/image-generation/output/software-report/systeminfo.txt $HOME/image-generation/output/software-report/systeminfo.md $HOME/

# Clean up npm cache which collected during image-generation
# we have to do that here because `npm install` is run in a few different places during image-generation
npm cache clean --force

# Clean up temporary directories
rm -rf ~/utils ~/image-generation

# Erase all indexes and wait until the rebuilding process ends,
# for now there is no way to get status of indexing process, it takes around 3 minutes to accomplish
sudo mdutil -E /

sudo log stream | while true; do
    if read -rt5 && [[ $REPLY =~ "Unlinked journal" ]]; then
      echo "indexing completed"
      exit 0
    fi
done
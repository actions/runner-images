#!/bin/bash
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Heroku CLI
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v heroku; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Heroku ($(heroku version))"

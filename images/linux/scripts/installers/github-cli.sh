#!/bin/bash
################################################################################
##  File:  github-cli.sh
##  Desc:  Installs GitHub CLI
##         Must be run as non-root user after homebrew
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/github-api.sh

# Install GitHub CLI
url=$(getLatestReleaseURI cli/cli .deb)
wget $url
sudo apt install ./gh_*_linux_amd64.deb
rm gh_*_linux_amd64.deb

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! gh --version; then
    echo "GitHub CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "GitHub CLI $(gh --version|head -1|sed -E 's/gh version ([0-9.]+).*/\1/')"
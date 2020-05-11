#!/bin/bash
################################################################################
##  File:  aws-sam-cli.sh
##  Desc:  Installs AWS SAM CLI
##         Must be run as non-root user after homebrew and clang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install aws sam cli
brew tap aws/tap
brew install aws-sam-cli

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! sam --version; then
    echo "AWS SAM CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "AWS $(sam --version)"
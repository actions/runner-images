#!/bin/bash
################################################################################
##  File:  pulumi.sh
##  Desc:  Installs Pulumi
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Pulumi
curl -fsSL https://get.pulumi.com | sh
cp -r ~/.pulumi/bin/* /usr/local/bin/

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v pulumi ; then
    echo "Pulumi was not installed"
    exit 1
fi

# Document what was added to the image
pulumi_version="$(pulumi version)"
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Pulumi ($pulumi_version)"
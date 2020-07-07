#!/bin/bash
################################################################################
##  File:  oras-cli.sh
##  Desc:  Installs ORAS CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Determine latest ORAS CLI version
ORAS_CLI_LATEST_VERSION_URL=https://api.github.com/repos/deislabs/oras/releases/latest
ORAS_CLI_VERSION=$(curl $ORAS_CLI_LATEST_VERSION_URL | jq '.name' | tr -d '"' | cut -d 'v' -f 2)
ORAS_CLI_ARCHIVE="oras_${ORAS_CLI_VERSION}_linux_amd64.tar.gz"

# Install ORAS CLI
curl -LO https://github.com/deislabs/oras/releases/download/v${ORAS_CLI_VERSION}/${ORAS_CLI_ARCHIVE}
mkdir -p oras-install/
tar -xzvf $ORAS_CLI_ARCHIVE -C oras-install/
mv oras-install/oras /usr/local/bin/
rm -rf $ORAS_CLI_ARCHIVE oras-install/

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! oras version; then
    echo "ORAS CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "ORAS $(oras version | head -1 | awk {'print $2'})"
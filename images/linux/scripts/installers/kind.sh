#!/bin/bash
################################################################################
##  File:  kind.sh
##  Desc:  Installs kind
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install KIND
URL=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets[].browser_download_url | select(contains("kind-linux-amd64"))')
curl -L -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v kind; then
    echo "Kind was not installed or found on PATH"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Kind ($(kind version))"

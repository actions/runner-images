#!/bin/bash
################################################################################
##  File:  openvpn.sh
##  Desc:  Installs OpenVPN
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Install latest OpenVPN
apt-get install -y --no-install-recommends openvpn

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v openvpn; then
    echo "OpenVPN was not installed or found on PATH"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "OpenVPN ($(openvpn --version |& head -n 1))"

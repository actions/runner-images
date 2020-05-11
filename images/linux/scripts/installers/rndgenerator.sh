#!/bin/bash
################################################################################
##  File:  rndgenerator.sh
##  Desc:  Install random number generator
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install haveged
apt-get -y install haveged

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in haveged; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Haveged $(dpkg-query --showformat='${Version}' --show haveged)"
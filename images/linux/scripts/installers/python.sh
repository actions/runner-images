#!/bin/bash
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Python, Python 3, pip, pip3
apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in python pip python3 pip3; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Python ($(python --version 2>&1))"
DocumentInstalledItem "pip ($(pip --version))"
DocumentInstalledItem "Python3 ($(python3 --version))"
DocumentInstalledItem "pip3 ($(pip3 --version))"
#!/bin/bash
################################################################################
##  File:  bazel.sh
##  Desc:  Installs bazel
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install bazel
apt-get update -y
apt-get install -y bazel

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v bazel; then
    echo "Bazel was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Bazel ($(bazel version))"

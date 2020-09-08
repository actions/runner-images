#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

set -e
# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

toolset="$INSTALLER_SCRIPT_FOLDER/toolset.json"
common_packages=$(jq -r ".apt.common_packages[]" $toolset)
cmd_packages=$(jq -r ".apt.cmd_packages[]" $toolset)
for package in $common_packages $cmd_packages; do
    echo "Install $package"
    apt-get install -y --no-install-recommends $package
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in $cmd_packages; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Basic packages:"
for package in $common_packages $cmd_packages; do
    DocumentInstalledItemIndent $package
done

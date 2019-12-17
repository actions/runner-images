#!/bin/bash
################################################################################
##  File:  example.sh
##  Desc:  This is an example script that can be copied to add a new software
##         installer to the image
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if [ -z $EXAMPLE_VAR ]; then
    $EXAMPLE_VAR=1.0.0
else
    echo "Example variable already set to $EXAMPLE_VAR"
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if [ -z $EXAMPLE_VAR ]; then
    echo "EXAMPLE_VAR variable was not set as expected"
    exit 1
else
    echo "EXAMPLE_VAR was set properly"
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Example Var ($EXAMPLE_VAR)"

#!/bin/bash -e
################################################################################
##  File:  toolset.sh
##  Desc:  Helper functions to retrive toolset data
################################################################################

toolset_path="/imagegeneration/installers/toolset.json"
echo "$(jq -r "$1" $toolset_path)"
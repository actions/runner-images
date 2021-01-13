#!/bin/bash -e
################################################################################
##  File:  toolset.sh
##  Desc:  Helper functions to retrive toolset data
################################################################################

toolset_path="/imagegeneration/installers/toolset.json"
query=$1
echo "$(jq -r "$query" $toolset_path)"
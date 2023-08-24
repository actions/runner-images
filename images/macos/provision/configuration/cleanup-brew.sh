#!/bin/bash -e -o pipefail
################################################################################
##  File:  cleanup-brew.sh
##  Desc:  The script removes local Homebrew cache
################################################################################

rm -rf "$(brew --cache)"

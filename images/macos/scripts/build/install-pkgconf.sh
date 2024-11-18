#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-pkgconf.sh
##  Desc:  Install pkgconf
################################################################################

source ~/utils/utils.sh

echo "Installing pkgconf..."

brew tap-new my-org/old-formulas
brew extract pkgconf my-org/old-formulas --version=0.29.2
brew install my-org/old-formulas/pkgconf@0.29.2

invoke_tests "Common" "pkgconf"

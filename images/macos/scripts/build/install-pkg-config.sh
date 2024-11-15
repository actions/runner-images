#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-pkg-config.sh
##  Desc:  Install pkg-config
################################################################################

source ~/utils/utils.sh

echo "Installing pkg-config..."

brew tap-new my-org/old-formulas
brew extract pkg-config my-org/old-formulas --version=0.29.2
brew install my-org/old-formulas/pkg-config@0.29.2

invoke_tests "Common" "pkg-config"

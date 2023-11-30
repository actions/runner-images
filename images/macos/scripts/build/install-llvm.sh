#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-llvm.sh
##  Desc:  Install LLVM
################################################################################

source ~/utils/utils.sh

llvmVersion=$(get_toolset_value '.llvm.version')

brew_smart_install "llvm@${llvmVersion}"

invoke_tests "LLVM"

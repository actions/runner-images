#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-llvm.sh
##  Desc:  Install LLVM
################################################################################

source ~/utils/utils.sh

llvmVersion=$(get_toolset_value '.llvm.version')

brew_smart_install "llvm@${llvmVersion}"
# After brew update to 5.1.0 we have to manually unlink llvm to avoid conflicts with pre-installed llvm on macOS
brew unlink "llvm@${llvmVersion}"

invoke_tests "LLVM"

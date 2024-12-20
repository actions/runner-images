#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-golang.sh
##  Desc:  Install Go
################################################################################

source ~/utils/utils.sh

default_go_version=$(get_toolset_value '.go.default')
echo "Installing Go..."
brew_smart_install "go@${default_go_version}"

# Create symlinks to preserve backward compatibility. Symlinks are not created when non-latest go is being installed
ln -sf $(brew --prefix go@${default_go_version})/bin/* /usr/local/bin/

invoke_tests "Common" "Go"

#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

DEFAULT_GO_VERSION=$(get_toolset_value '.go.default')
echo "Installing Go..."
brew_smart_install "$DEFAULT_GO_VERSION"

# Create symlinks for Go 1.15 to preserve backward compatibility
ln -sf $(brew --prefix ${DEFAULT_GO_VERSION})/bin/* /usr/local/bin/

invoke_tests "Common" "Go"
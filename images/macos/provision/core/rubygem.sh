#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Updating RubyGems...
gem update --system

gemsToInstall=$(get_toolset_value '.ruby.rubygems | .[]')
if [ -n "$gemsToInstall" ]; then
    for gem in $gemsToInstall; do
        echo "Installing gem $gem"
        gem install $gem
    done
fi

# Temporary uninstall public_suffix 5.0 gem as Cocoapods is not compatible with it yet https://github.com/actions/runner-images/issues/6149
gem uninstall public_suffix -v 5.0.0

invoke_tests "RubyGem"

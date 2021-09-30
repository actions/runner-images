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

invoke_tests "RubyGem"

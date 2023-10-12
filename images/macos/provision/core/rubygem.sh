#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Updating RubyGems...
gem update --system

# Temporarily install activesupport 7.0.8 due to compatibility issues with cocoapods https://github.com/CocoaPods/CocoaPods/issues/12081
gem install activesupport -v 7.0.8

gemsToInstall=$(get_toolset_value '.ruby.rubygems | .[]')
if [ -n "$gemsToInstall" ]; then
    for gem in $gemsToInstall; do
        echo "Installing gem $gem"
        gem install $gem
    done
fi

invoke_tests "RubyGem"

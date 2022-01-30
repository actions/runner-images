#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Temporarily downgrade RubyGems version to 3.2.33 due to issue with RubyGems 3.3.3 (https://github.com/actions/virtual-environments-internal/issues/3162)
echo Updating RubyGems...
gem update --system 3.2.33

gemsToInstall=$(get_toolset_value '.ruby.rubygems | .[]')
if [ -n "$gemsToInstall" ]; then
    for gem in $gemsToInstall; do
        echo "Installing gem $gem"
        gem install $gem
    done
fi

invoke_tests "RubyGem"

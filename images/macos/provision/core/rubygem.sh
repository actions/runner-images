#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Updating RubyGems...
gem update --system

echo Installing xcode-install utility...
gem install xcode-install --force

echo Installing CocoaPods...
gem install cocoapods

if is_Less_BigSur; then
    # fix nomad-cli installation
    if is_HighSierra; then
        brew_smart_install "libxml2"
        gem install nokogiri -v 1.6.8.1 -- --use-system-libraries --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
    fi

    echo Installing nomad-cli...
    gem install nomad-cli
fi

echo Installing xcpretty...
gem install xcpretty

echo Installing bundler...
gem install bundler --force

# AppStoreRelease Azure DevOps has issues with Fastlane 2.184.0. Temporary hardcoding the version until the issue is fixed
# https://github.com/microsoft/app-store-vsts-extension/issues/244
echo Installing fastlane tools...
gem uninstall fastlane -aI
gem install fastlane -v 2.183.2

invoke_tests "RubyGem"

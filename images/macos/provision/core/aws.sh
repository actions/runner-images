#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo Installing aws...
AWSCLIURL="https://awscli.amazonaws.com/AWSCLIV2.pkg"
download_with_retries $AWSCLIURL "."
sudo installer -pkg AWSCLIV2.pkg -target /
rm -rf AWSCLIV2.pkg

echo Installing aws sam cli...
brew tap aws/tap
brew install aws-sam-cli

echo "Install aws cli session manager"
brew cask install session-manager-plugin

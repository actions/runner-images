#!/bin/bash -e -o pipefail

echo Installing aws...
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
rm -rf AWSCLIV2.pkg

echo Installing aws sam cli...
brew tap aws/tap
brew install aws-sam-cli

echo "Install aws cli session manager"
brew cask install session-manager-plugin

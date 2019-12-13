#!/bin/bash
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/document.sh

# Install the AWS CLI
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm awscli-bundle.zip
rm -rf awscli-bundle

# Validate the installation
echo "Validate the installation"
if ! command -v aws; then
    echo "aws was not installed"
    exit 1
fi

# Document the installed version
echo "Document the installed version"
DocumentInstalledItem "AWS CLI ($(aws --version 2>&1))"

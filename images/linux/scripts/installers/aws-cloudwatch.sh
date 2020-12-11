#!/bin/bash -e
################################################################################
##  File:  aws-cloudwatch.sh
##  Desc:  Installs AWS CloudWatch Agent
################################################################################

# Install AWS CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb
rm amazon-cloudwatch-agent.deb

# Validate the installation
echo "Validate the installation"
if ! command -v amazon-cloudwatch-agent-ctl; then
    echo "amazon-cloudwatch-agent-ctl was not installed"
    exit 1
fi

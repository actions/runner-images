#!/bin/bash -e -o pipefail

echo "Removing macos-init instance logs..."
sudo rm -rf /usr/local/aws/ec2-macos-init/instances/*

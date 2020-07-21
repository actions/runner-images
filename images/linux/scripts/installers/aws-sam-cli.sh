#!/bin/bash
################################################################################
##  File:  aws-sam-cli.sh
##  Desc:  Installs AWS SAM CLI
##         Requires Python >=3.6, must be run as non-root user after toolset installation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Download latest aws sam cli sources
TarballUrl=$(curl -s https://api.github.com/repos/awslabs/aws-sam-cli/releases/latest | jq -r '.tarball_url')
TarballPath="/tmp/aws-sam-cli.tar.gz"
wget $TarballUrl -O $TarballPath
tar -xzvf $TarballPath -C /tmp
cd /tmp/awslabs-aws-sam-cli*

sudo mkdir /opt/python-aws-sam-cli
sudo cp -r /opt/hostedtoolcache/Python/3.7* /opt/python-aws-sam-cli

# Use copy of python 3.7 from toolcache to install aws sam, setuptools package required for the installation
Python3Dir=$(echo /opt/python-aws-sam-cli/3.7*/x64)
Python3BinDir="${Python3Dir}/bin"
sudo $Python3BinDir/python3 -m pip install setuptools
sudo $Python3BinDir/python3 setup.py install
sudo ln -sf ${Python3BinDir}/sam /usr/local/bin/sam

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! sam --version; then
    echo "AWS SAM CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "AWS $(sam --version)"
#!/bin/bash
################################################################################
##  File:  aws-sam-cli.sh
##  Desc:  Installs AWS SAM CLI
##         Requires Pyton >=3.6, must be run after toolset installation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Download latest aws sam cli sources
TarballUrl=$(curl -s https://api.github.com/repos/awslabs/aws-sam-cli/releases/latest | jq -r '.tarball_url')
TarballPath="/tmp/aws-sam-cli.tar.gz"
wget $TarballUrl -O $TarballPath
tar -xzvf $TarballPath -C /tmp
SourcesDir=$(echo /tmp/awslabs-aws-sam-cli*)

# Use python 3.7 from toolcache to install aws sam, setuptools module required for the installation
Python3Dir=$(echo ${AGENT_TOOLSDIRECTORY}/Python/3.7*/x64)
Python3BinDir=$(echo ${Python3Dir}/bin)
export PATH="$Python3Dir:$Python3BinDir:$PATH"
python3 -m pip install setuptools
cd $SourcesDir
python3 setup.py install
sudo ln -sf ${Python3BinDir}/sam /usr/local/bin/sam

# Cleanup downloaded files
rm -rf $TarballPath
rm -rf $SourcesDir

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! sam --version; then
    echo "AWS SAM CLI was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "AWS $(sam --version)"
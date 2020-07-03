#!/bin/bash
################################################################################
##  File:  aws-sm.sh
##  Desc:  Installs AWS CLI Session Manager
##         Requires Python >=3.6, must be run as non-root user after toolset installation
################################################################################

# Download and install aws cli session manager
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb

sessionPlugin=$(session-manager-plugin)
if [[ $sessionPlugin == *"was installed successfully"* ]]
then
    echo "$sessionPlugin"
    exit 0
else
    echo "$sessionPlugin"
    exit 1
fi
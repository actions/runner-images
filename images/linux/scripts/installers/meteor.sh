#!/bin/bash -e
################################################################################
##  File:  meteor.sh
##  Desc:  Installs Meteor
################################################################################

# Install Meteor
wget -qO- https://install.meteor.com | sh

# If there is a need to change the meteor install to a particular user:
# cd ~
# sudo chown -Rh <username> .meteor/local

invoke_tests "WebServers" "Meteor"

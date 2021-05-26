#!/bin/bash -e
################################################################################
##  File:  meteor.sh
##  Desc:  Installs Meteor
################################################################################

# Install Meteor
wget -qO- https://install.meteor.com | sh

# After installation:
# chown -Rh $meteor_user ~$meteor_user/.meteor/local

invoke_tests "WebServers" "Meteor"

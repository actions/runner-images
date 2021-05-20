#!/bin/bash -e
################################################################################
##  File:  meteor.sh
##  Desc:  Installs Meteor
################################################################################

# Install Meteor
wget -qO- https://install.meteor.com | sh

invoke_tests "WebServers" "Meteor"

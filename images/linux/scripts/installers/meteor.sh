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
# if not, then in the test, --allow-superuser

meteor_user=$(cut -d: -f1 /etc/passwd | tail -1)
chown -Rh $meteor_user ~{$meteor_user}/.meteor/local

invoke_tests "WebServers" "Meteor"

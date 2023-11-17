#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  This script installs Heroku CLI. Based on instructions found here: https://devcenter.heroku.com/articles/heroku-cli
################################################################################

## Install Heroku CLI

# add heroku repository to apt
echo "deb https://cli-assets.heroku.com/channels/stable/apt ./" > /etc/apt/sources.list.d/heroku.list

# install heroku's release key for package verification
curl https://cli-assets.heroku.com/channels/stable/apt/release.key | apt-key add -

# install heroku
apt-get update -y && apt-get install -y heroku

# remove heroku's apt repository
rm /etc/apt/sources.list.d/heroku.list

invoke_tests "Tools" "Heroku"

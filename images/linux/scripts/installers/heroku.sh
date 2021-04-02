#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

REPO_URL="https://cli-assets.heroku.com/apt"

# Install Heroku CLI
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

rm /etc/apt/sources.list.d/heroku.list

echo "heroku $REPO_URL" >> $HELPER_SCRIPTS/apt-sources.txt

invoke_tests "Tools" "Heroku"
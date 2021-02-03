#!/bin/bash -e
################################################################################
##  File:  docker-compose.sh
##  Desc:  Installs Docker Compose
################################################################################

# Install latest docker-compose from releases
URL=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.assets[].browser_download_url | select(endswith("docker-compose-Linux-x86_64"))')
curl -L $URL -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

invoke_tests "Tools" "Docker-compose"

#!/bin/bash -e
################################################################################
##  File:  install-docker-cli.sh
##  Desc:  Install Docker CLI and plugins (Compose, Buildx) but not the engine.
##         The Docker daemon is not included since ubuntu-slim runs as a container.
##         Users can mount the host's Docker socket or use Docker-in-Docker if needed.
################################################################################

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

# Install Docker CLI components (not the daemon)
# docker-ce-cli: Docker command line interface
# docker-buildx-plugin: Build with BuildKit
# docker-compose-plugin: Docker Compose V2
apt-get install --no-install-recommends -y \
    docker-ce-cli \
    docker-buildx-plugin \
    docker-compose-plugin

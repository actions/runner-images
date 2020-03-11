#!/bin/bash
################################################################################
##  File:  docker-compose.sh
##  Desc:  Installs Docker Compose
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

version="1.25.4"

# Install latest docker-compose from releases
curl -L "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v docker-compose; then
    echo "docker-compose was not installed"
    exit 1
fi

## Add version information to the metadata file
echo "Documenting Docker Compose version"
docker_compose_version=$(docker-compose -v)
DocumentInstalledItem "Docker Compose (${docker_compose_version})"

#!/bin/bash
################################################################################
##  File:  docker-ce.sh
##  Desc:  Installs docker onto the image, but does not pre-pull any images
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

docker_package=moby

## Check to see if docker is already installed
echo "Determing if Docker ($docker_package) is installed"
if ! IsInstalled $docker_package; then
    echo "Docker ($docker_package) was not found. Installing..."
    apt-get remove -y moby-engine moby-cli
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/microsoft-prod.list
    apt-get update
    apt-get install -y moby-engine moby-cli
else
    echo "Docker ($docker_package) is already installed"
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v docker; then
    echo "docker was not installed"
    exit 1
else
    # Docker daemon takes time to come up after installing
    sleep 10
    set -e
    docker info
    set +e
fi

## Add version information to the metadata file
echo "Documenting Docker version"
docker_version=$(docker -v)
DocumentInstalledItem "Docker ($docker_version)"

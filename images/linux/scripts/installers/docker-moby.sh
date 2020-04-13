#!/bin/bash
################################################################################
##  File:  docker-moby.sh
##  Desc:  Installs docker onto the image
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

docker pull node:10
docker pull node:12
docker pull buildpack-deps:stretch
docker pull node:10-alpine
docker pull node:12-alpine
docker pull debian:8
docker pull debian:9
docker pull alpine:3.7
docker pull alpine:3.8
docker pull alpine:3.9
docker pull alpine:3.10
docker pull ubuntu:14.04

## Add version information to the metadata file
echo "Documenting Docker version"
docker_version=$(docker -v)
DocumentInstalledItem "Docker-Moby ($docker_version)"

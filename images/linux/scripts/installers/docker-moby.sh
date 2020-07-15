#!/bin/bash
################################################################################
##  File:  docker-moby.sh
##  Desc:  Installs docker onto the image
################################################################################

source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

docker_package=moby

# There is no stable docker-moby for Ubuntu 20 at the moment
if isUbuntu20 ; then
    add-apt-repository "deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/20.04/prod testing main"
fi

## Check to see if docker is already installed
echo "Determing if Docker ($docker_package) is installed"
if ! IsPackageInstalled $docker_package; then
    echo "Docker ($docker_package) was not found. Installing..."
    apt-get remove -y moby-engine moby-cli
    apt-get update
    apt-get install -y moby-engine moby-cli
    apt-get install --no-install-recommends -y moby-buildx
else
    echo "Docker ($docker_package) is already installed"
fi

# Enable docker.service
systemctl is-active --quiet docker.service || systemctl start docker.service
systemctl is-enabled --quiet docker.service || systemctl enable docker.service

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
echo "Checking the docker-moby and moby-buildx"
if ! command -v docker; then
    echo "docker was not installed"
    exit 1
elif ! [[ $(docker buildx) ]]; then
    echo "Docker-Buildx was not installed"
    exit 1
else
    echo "Docker-moby and Docker-buildx checking the successfull"
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

echo "Documenting Docker-buildx version"
DOCKER_BUILDX_VERSION=$(docker buildx version | cut -d ' ' -f2)
DocumentInstalledItem "Docker-Buildx ($DOCKER_BUILDX_VERSION)"

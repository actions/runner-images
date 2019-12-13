#!/bin/bash
################################################################################
##  File:  docker.sh
##  Desc:  Installs the correct version of docker onto the image, and pulls
##         down the default docker image used for building on ubuntu
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

DOCKER_PACKAGE=moby

apt-get remove -y moby-engine mobi-cli
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
apt-get update
apt-get install -y moby-engine mobi-cli

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

## Add version information to the metadata file
echo "Documenting Docker version"
DOCKER_VERSION=`docker -v`
DocumentInstalledItem "Docker ($DOCKER_VERSION)"

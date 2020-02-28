#!/bin/bash
################################################################################
##  File:  docker-images.sh
##  Desc:  Pulls down the default docker images used for building on ubuntu
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

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

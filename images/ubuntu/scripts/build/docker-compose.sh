#!/bin/bash -e
################################################################################
##  File:  docker-compose.sh
##  Desc:  Installs Docker Compose v1
##  Supply chain security: Docker Compose v1 - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install docker-compose v1 from releases
URL="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64"
curl -fsSL "${URL}" -o /tmp/docker-compose-v1

# Supply chain security - Docker Compose v1
external_hash=$(get_hash_from_remote_file "${URL}.sha256" "compose-Linux-x86_64")
use_checksum_comparison "/tmp/docker-compose-v1" "${external_hash}"
install /tmp/docker-compose-v1 /usr/local/bin/docker-compose

invoke_tests "Tools" "Docker-compose v1"

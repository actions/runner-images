#!/bin/bash -e
################################################################################
##  File:  docker-moby.sh
##  Desc:  Installs docker onto the image
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Check to see if docker is already installed
docker_package=moby
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

# Docker daemon takes time to come up after installing
sleep 10
docker info

# If credentials are provided, attempt to log into Docker Hub
# with a paid account to avoid Docker Hub's rate limit.
if [ "${DOCKERHUB_LOGIN}" ] && [ "${DOCKERHUB_PASSWORD}" ]; then
  docker login --username "${DOCKERHUB_LOGIN}" --password "${DOCKERHUB_PASSWORD}"
fi

# Pull images
images=$(get_toolset_value '.docker.images[]')
for image in $images; do
    docker pull "$image"
done

# Always attempt to logout so we do not leave our credentials on the built
# image. Logout _should_ return a zero exit code even if no credentials were
# stored from earlier.
docker logout

invoke_tests "Tools" "Docker"

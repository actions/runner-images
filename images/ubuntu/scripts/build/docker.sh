#!/bin/bash -e
################################################################################
##  File:  docker.sh
##  Desc:  Installs docker onto the image
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

repo_url="https://download.docker.com/linux/ubuntu"
gpg_key="/usr/share/keyrings/docker.gpg"
repo_path="/etc/apt/sources.list.d/docker.list"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o $gpg_key
echo "deb [arch=amd64 signed-by=$gpg_key] $repo_url $(getOSVersionLabel) stable" > $repo_path
apt-get update
apt-get install --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin

# Install docker compose v2 from releases
URL=$(get_github_package_download_url "docker/compose" "contains(\"compose-linux-x86_64\")")
curl -fsSL $URL -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# docker from official repo introduced different GID generation: https://github.com/actions/runner-images/issues/8157
gid=$(cut -d ":" -f 3 /etc/group | grep "^1..$" | sort -n | tail -n 1 | awk '{ print $1+1 }')
groupmod -g $gid docker
chgrp -hR docker /run/docker.sock

# Enable docker.service
systemctl is-active --quiet docker.service || systemctl start docker.service
systemctl is-enabled --quiet docker.service || systemctl enable docker.service

# Docker daemon takes time to come up after installing
sleep 10
docker info

if [ "${DOCKERHUB_PULL_IMAGES:-yes}" == "yes" ]; then
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
else
    echo "Skipping docker images pulling"
fi

# Install amazon-ecr-credential-helper
aws_latest_release_url="https://api.github.com/repos/awslabs/amazon-ecr-credential-helper/releases/latest"
aws_helper_url=$(curl "${authString[@]}" -fsSL $aws_latest_release_url | jq -r '.body' | awk -F'[()]' '/linux-amd64/ {print $2}')
download_with_retries "$aws_helper_url" "/usr/bin" docker-credential-ecr-login
chmod +x /usr/bin/docker-credential-ecr-login

# Cleanup custom repositories
rm $gpg_key
rm $repo_path

invoke_tests "Tools" "Docker"
if [ "${DOCKERHUB_PULL_IMAGES:-yes}" -eq "yes" ]; then
    invoke_tests "Tools" "Docker images"
fi

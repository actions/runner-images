#!/bin/bash -e
################################################################################
##  File:  install-docker.sh
##  Desc:  Install docker onto the image
##  Supply chain security: Docker Compose v2, amazon-ecr-credential-helper - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

REPO_URL="https://download.docker.com/linux/ubuntu"
GPG_KEY="/usr/share/keyrings/docker.gpg"
REPO_PATH="/etc/apt/sources.list.d/docker.list"
os_codename=$(lsb_release -cs)

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o $GPG_KEY
echo "deb [arch=amd64 signed-by=$GPG_KEY] $REPO_URL ${os_codename} stable" > $REPO_PATH
apt-get update

for pkg in containerd.io docker-ce-cli docker-ce docker-buildx-plugin; do
    version=$(get_toolset_value ".docker.components.\"$pkg\"")
    if [[ $version == "latest" ]]; then
        components_to_install+="${pkg} "
    else
        version_string=$(apt-cache madison "${pkg}" | awk '{ print $3 }' | grep "${version}" | grep "${os_codename}" | head -1)
        components_to_install+="${pkg}=${version_string} "
    fi
done
apt-get install -y --no-install-recommends $components_to_install

# Download docker compose v2 from releases
# Temporaty pinned to v2.23.3 due https://github.com/actions/runner-images/issues/9172
compose_version=$(get_toolset_value ".docker.components.compose")
URL=$(resolve_github_release_asset_url "docker/compose" "endswith(\"compose-linux-x86_64\")" "${compose_version}")
compose_binary_path=$(download_with_retry "${URL}" "/tmp/docker-compose-v2")

# Supply chain security - Docker Compose v2
compose_hash_url=$(resolve_github_release_asset_url "docker/compose" "endswith(\"checksums.txt\")" "${compose_version}")
compose_external_hash=$(get_checksum_from_url "${compose_hash_url}" "compose-linux-x86_64" "SHA256")
use_checksum_comparison "${compose_binary_path}" "${compose_external_hash}"

# Install docker compose v2
install "${compose_binary_path}" /usr/libexec/docker/cli-plugins/docker-compose

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

if [[ "${DOCKERHUB_PULL_IMAGES:-yes}" == "yes" ]]; then
    # If credentials are provided, attempt to log into Docker Hub
    # with a paid account to avoid Docker Hub's rate limit.
    if [[ "${DOCKERHUB_LOGIN}" ]] && [[ "${DOCKERHUB_PASSWORD}" ]]; then
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

# Download amazon-ecr-credential-helper
aws_latest_release_url="https://api.github.com/repos/awslabs/amazon-ecr-credential-helper/releases/latest"
aws_helper_url=$(curl -fsSL "${aws_latest_release_url}" | jq -r '.body' | awk -F'[()]' '/linux-amd64/ {print $2}')
aws_helper_binary_path=$(download_with_retry "$aws_helper_url")

# Supply chain security - amazon-ecr-credential-helper
aws_helper_external_hash=$(get_checksum_from_url "${aws_helper_url}.sha256" "docker-credential-ecr-login" "SHA256")
use_checksum_comparison "$aws_helper_binary_path" "$aws_helper_external_hash"

# Install amazon-ecr-credential-helper
install "$aws_helper_binary_path" "/usr/bin/docker-credential-ecr-login"

# Cleanup custom repositories
rm $GPG_KEY
rm $REPO_PATH

invoke_tests "Tools" "Docker"
if [[ "${DOCKERHUB_PULL_IMAGES:-yes}" == "yes" ]]; then
    invoke_tests "Tools" "Docker images"
fi

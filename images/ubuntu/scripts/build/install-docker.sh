#!/bin/bash -e
################################################################################
##  File:  install-docker.sh
##  Desc:  Install docker onto the image
##  Supply chain security: amazon-ecr-credential-helper - dynamic checksum validation
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

# Install docker components which available via apt-get
# Using toolsets keep installation order to install dependencies before the package in order to control versions

components=$(get_toolset_value '.docker.components[] .package')
for package in $components; do
    version=$(get_toolset_value ".docker.components[] | select(.package == \"$package\") | .version")
    if [[ $version == "latest" ]]; then
        apt-get install -y --no-install-recommends "$package"
    else
        version_string=$(apt-cache madison "$package" | awk '{ print $3 }' | grep "$version" | grep "$os_codename" | head -1)
        apt-get install -y --no-install-recommends "${package}=${version_string}"
    fi
done

# Install plugins that are best installed from the GitHub repository
# Be aware that `url` built from github repo name and plugin name because of current repo naming for those plugins

plugins=$(get_toolset_value '.docker.plugins[] .plugin')
for plugin in $plugins; do
    version=$(get_toolset_value ".docker.plugins[] | select(.plugin == \"$plugin\") | .version")
    filter=$(get_toolset_value ".docker.plugins[] | select(.plugin == \"$plugin\") | .asset")
    url=$(resolve_github_release_asset_url "docker/$plugin" "endswith(\"$filter\")" "$version")
    binary_path=$(download_with_retry "$url" "/tmp/docker-$plugin")
    mkdir -pv "/usr/libexec/docker/cli-plugins"
    install "$binary_path" "/usr/libexec/docker/cli-plugins/docker-$plugin"
done

# docker from official repo introduced different GID generation: https://github.com/actions/runner-images/issues/8157
gid=$(cut -d ":" -f 3 /etc/group | grep "^1..$" | sort -n | tail -n 1 | awk '{ print $1+1 }')
groupmod -g "$gid" docker
chgrp -hR docker /run/docker.sock
chgrp -hR docker /var/run/docker.sock

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

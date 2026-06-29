#!/bin/bash -e
################################################################################
##  File:  install-docker.sh
##  Desc:  Install docker onto the image
##  Supply chain security: amazon-ecr-credential-helper - dynamic checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

if is_x64; then
  docker_arch="amd64"
elif is_arm64; then
  docker_arch="arm64"
else
  echo "Unsupported architecture"
  exit 1
fi

REPO_URL="https://download.docker.com/linux/ubuntu"
GPG_KEY="/usr/share/keyrings/docker.gpg"
REPO_PATH="/etc/apt/sources.list.d/docker.list"
os_codename=$(lsb_release -cs)

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o $GPG_KEY
echo "deb [arch=$docker_arch signed-by=$GPG_KEY] $REPO_URL ${os_codename} stable" > $REPO_PATH
apt-get update

# Install docker components which available via apt-get
# Using toolsets keep installation order to install dependencies before the package in order to control versions

components=$(get_toolset_value '.docker.components[] .package')
for package in $components; do
    version=$(get_toolset_value ".docker.components[] | select(.package == \"$package\") | .version")
    if [[ $version == "latest" ]]; then
        apt-get install --no-install-recommends "$package"
    else
        version_string=$(apt-cache madison "$package" | awk '{ print $3 }' | grep "$version" | grep "$os_codename" | head -1)
        apt-get install --no-install-recommends "${package}=${version_string}"
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

# Create systemd-tmpfiles configuration for Docker
cat <<EOF | sudo tee /etc/tmpfiles.d/docker.conf
L /run/docker.sock - - - - root docker 0770
EOF

# Reload systemd-tmpfiles to apply the new configuration
systemd-tmpfiles --create /etc/tmpfiles.d/docker.conf

# Enable docker.service
systemctl is-active --quiet docker.service || systemctl start docker.service
systemctl is-enabled --quiet docker.service || systemctl enable docker.service

# Docker daemon takes time to come up after installing
sleep 10
docker info

if ! is_ubuntu22; then
    docker_images=$(get_toolset_value '.docker.images[]?')
    while IFS= read -r docker_image; do
        [[ -z "$docker_image" ]] && continue

        image_registry=${docker_image%%/*}
        is_dockerhub_image=false
        if [[ "$image_registry" != *.* && "$image_registry" != *:* && "$image_registry" != "localhost" ]]; then
            is_dockerhub_image=true
        fi

        if [[ "$is_dockerhub_image" == "true" && "${DOCKERHUB_PULL_IMAGES:-no}" != "yes" ]]; then
            echo "Skipping Docker Hub image ${docker_image}; set DOCKERHUB_PULL_IMAGES=yes to pull it"
            continue
        fi

        echo "Pulling Docker image ${docker_image}"
        docker pull "$docker_image"
    done <<< "$docker_images"

    # Pull Dependabot docker image
    docker pull ghcr.io/dependabot/dependabot-updater-core:latest

    # Pull AW docker images
    docker pull ghcr.io/github/gh-aw-mcpg:latest
    docker pull ghcr.io/github/gh-aw-firewall/agent:latest
    docker pull ghcr.io/github/gh-aw-firewall/api-proxy:latest
    docker pull ghcr.io/github/gh-aw-firewall/squid:latest
    docker pull ghcr.io/github/github-mcp-server:latest
fi

# Download amazon-ecr-credential-helper
aws_latest_release_url="https://api.github.com/repos/awslabs/amazon-ecr-credential-helper/releases/latest"
aws_helper_url=$(curl -fsSL "${aws_latest_release_url}" | jq -r '.body' | awk -F'[()]' '/linux-'"${docker_arch}"'/ {print $2}')
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

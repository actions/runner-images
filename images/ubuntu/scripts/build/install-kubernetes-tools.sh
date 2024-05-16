#!/bin/bash -e
################################################################################
##  File:  install-kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
##  Supply chain security: KIND, minikube - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download KIND
kind_url=$(resolve_github_release_asset_url "kubernetes-sigs/kind" "endswith(\"kind-linux-amd64\")" "latest")
kind_binary_path=$(download_with_retry "${kind_url}")

# Supply chain security - KIND
kind_external_hash=$(get_checksum_from_url "${kind_url}.sha256sum" "kind-linux-amd64" "SHA256")
use_checksum_comparison "${kind_binary_path}" "${kind_external_hash}"

# Install KIND
install "${kind_binary_path}" /usr/local/bin/kind

## Install kubectl
kubectl_minor_version=$(curl -fsSL "https://dl.k8s.io/release/stable.txt" | cut -d'.' -f1,2 )
curl -fsSL https://pkgs.k8s.io/core:/stable:/$kubectl_minor_version/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/'$kubectl_minor_version'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y && sudo apt-get install -y kubectl
rm -f /etc/apt/sources.list.d/kubernetes.list

# Install Helm
# Temporary pin version v3.14.4 due to strange release of v3.15.0
helm_version="v3.14.4"
download_with_retry "https://get.helm.sh/helm-$helm_version-linux-amd64.tar.gz" /tmp/helm.tar.gz
mkdir -p /tmp/helm
tar xzf /tmp/helm.tar.gz -C /tmp/helm
cp /tmp/helm/linux-amd64/helm /usr/local/bin/helm
chmod +x /usr/local/bin/helm

# Download minikube
curl -fsSL -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Supply chain security - minikube
minikube_hash=$(get_checksum_from_github_release "kubernetes/minikube" "linux-amd64" "latest" "SHA256")
use_checksum_comparison "minikube-linux-amd64" "${minikube_hash}"

# Install minikube
install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -fsSL "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"

#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
##  Supply chain security: KIND, minikube - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Download KIND
kind_url=$(get_github_package_download_url "kubernetes-sigs/kind" "contains(\"kind-linux-amd64\")")
curl -fsSL -o /tmp/kind "${kind_url}"
# Supply chain security - KIND
kind_external_hash=$(get_hash_from_remote_file "${kind_url}.sha256sum" "kind-linux-amd64")
use_checksum_comparison "/tmp/kind" "${kind_external_hash}"
# Install KIND
sudo install /tmp/kind /usr/local/bin/kind

## Install kubectl
KUBECTL_MINOR_VERSION=$(curl -fsSL "https://dl.k8s.io/release/stable.txt" | cut -d'.' -f1,2 )
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBECTL_MINOR_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/'$KUBECTL_MINOR_VERSION'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y && sudo apt-get install -y kubectl
rm -f /etc/apt/sources.list.d/kubernetes.list

# Install Helm
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Download minikube
curl -fsSL -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# Supply chain security - minikube
minikube_hash=$(get_github_package_hash "kubernetes" "minikube" "linux-amd64" "" "latest" "false" ":" 2)
use_checksum_comparison "minikube-linux-amd64" "${minikube_hash}"
# Install minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -fsSL "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"

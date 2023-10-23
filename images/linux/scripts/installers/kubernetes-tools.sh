#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
##  Supply chain security: minikube - checksum validation
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install KIND
URL=$(get_github_package_download_url "kubernetes-sigs/kind" "contains(\"kind-linux-amd64\")")
curl -fsSL -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_MINOR_VERSION=$(curl -fsSL "https://dl.k8s.io/release/stable.txt" | cut -d'.' -f1,2 )
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBECTL_MINOR_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/'$KUBECTL_MINOR_VERSION'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y && sudo apt-get install -y kubectl
rm -f /etc/apt/sources.list.d/kubernetes.list

# Install Helm
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
curl -fsSL -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Supply chain security - minikube
minikube_hash=$(get_github_package_hash "kubernetes" "minikube" "linux-amd64" "" "latest" "false" ":" 2)
use_checksum_comparison "minikube-linux-amd64" "$minikube_hash"

sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
curl -fsSL "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"

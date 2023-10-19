#!/bin/bash -e
################################################################################
##  File:  kubernetes-tools.sh
##  Desc:  Installs kubectl, helm, kustomize
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install KIND
URL=$(get_github_package_download_url "kubernetes-sigs/kind" "contains(\"kind-linux-amd64\")")
echo "Installing kind from $URL"
curl -fsSL -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_VERSION=$(curl -fsSL "https://dl.k8s.io/release/stable.txt")
echo "Installing kubectl version: $KUBECTL_VERSION from https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
curl -fsSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
chmod +x /usr/local/bin/kubectl

# Install Helm
echo "Installing Helm from https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
echo "Installing minikube from https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
curl -fsSL -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
echo "Installing kustomize from $download_url"
curl -fsSL "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"

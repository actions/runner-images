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
curl -fsSL -v -o /usr/local/bin/kind $URL
chmod +x /usr/local/bin/kind

## Install kubectl
KUBECTL_MAJOR_VERSION=$(curl -fsSL "https://dl.k8s.io/release/stable.txt" | cut -d'.' -f1,2 )
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBECTL_MAJOR_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/'$KUBECTL_MAJOR_VERSION'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y && sudo apt-get install -y kubectl
rm -f /etc/apt/sources.list.d/kubernetes.list
kubectl version



# Install Helm
echo "Installing Helm from https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"
curl -fsSL -v https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install minikube
echo "Installing minikube from https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
curl -fsSL -v -O https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kustomize
download_url="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
echo "Installing kustomize from $download_url"
curl -fsSL -v "$download_url" | bash
mv kustomize /usr/local/bin

invoke_tests "Tools" "Kubernetes tools"

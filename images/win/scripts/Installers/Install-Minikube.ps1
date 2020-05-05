################################################################################
##  File:  Install-Minikube.ps1
##  Desc:  Install Minikube
################################################################################

Choco-Install -PackageName minikube
minikube start --driver=docker --download-only

################################################################################
##  File:  Install-KubernetesTools.ps1
##  Desc:  Install tools for K8s.
##  Supply chain security: GitHub Kind - checksum validation, Kubectl, Helm, Minikube - by package manager
################################################################################

Write-Host "Install Kind"
# Choco installation can't be used because it depends on docker-desktop

$targetDir = "C:\ProgramData\kind"
New-Item -Path $targetDir -ItemType Directory -Force | Out-Null

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "kubernetes-sigs/kind" `
    -Version "latest" `
    -UrlMatchPattern "kind-windows-amd64"
$packagePath = Invoke-DownloadWithRetry -Url $downloadUrl -Path "$targetDir\kind.exe"

#region Supply chain security - Kind
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url "$downloadUrl.sha256sum" `
    -FileName (Split-Path $downloadUrl -Leaf)
Test-FileChecksum $packagePath -ExpectedSHA256Sum $externalHash
#endregion

Add-MachinePathItem $targetDir

Write-Host "Install Kubectl"
Install-ChocoPackage kubernetes-cli

Write-Host "Install Helm"
Install-ChocoPackage kubernetes-helm

Write-Host "Install Minikube"
Install-ChocoPackage minikube

Invoke-PesterTests -TestFile "Tools" -TestName "KubernetesTools"

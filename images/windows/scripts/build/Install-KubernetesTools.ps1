################################################################################
##  File:  Install-KubernetesTools.ps1
##  Desc:  Install tools for K8s.
##  Supply chain security: GitHub Kind - checksum validation, Kubectl, Helm, Minikube - by package manager
################################################################################

Write-Host "Install Kind"
# Choco installation can't be used because it depends on docker-desktop
$repoUrl = 'https://api.github.com/repos/kubernetes-sigs/kind/releases/latest'
$assets = (Invoke-RestMethod -Uri $repoUrl).assets
[System.String] $kindDownloadLink = $assets.browser_download_url -match "kind-windows-amd64$"
$destFilePath = "C:\ProgramData\kind"
$null = New-Item -Path $destFilePath -ItemType Directory -Force
$packagePath = Invoke-DownloadWithRetry -Url $kindDownloadLink -Path "$destFilePath\kind.exe"

#region Supply chain security - Kind
$fileHash = (Get-FileHash -Path $packagePath -Algorithm SHA256).Hash
$hashUrl = ($assets.browser_download_url -match "kind-windows-amd64.sha256sum") | Select-Object -First 1
$externalHash = (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*kind-windows-amd64*" }).Split(' ')[0]
Use-ChecksumComparison $fileHash $externalHash
#endregion

Add-MachinePathItem $destFilePath

Write-Host "Install Kubectl"
Install-ChocoPackage kubernetes-cli

Write-Host "Install Helm"
Install-ChocoPackage kubernetes-helm

Write-Host "Install Minikube"
Install-ChocoPackage minikube

Invoke-PesterTests -TestFile "Tools" -TestName "KubernetesTools"

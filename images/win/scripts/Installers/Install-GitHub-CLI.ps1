################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
################################################################################

Write-Host "Get the latest gh version..."
$GhReleasesJson = Invoke-RestMethod "https://api.github.com/repos/cli/cli/releases/latest"
$WindowsMsiAssetNamePattern = "windows_amd64.msi"
$WindowsMsiAsset = $GhReleasesJson.assets | Where-Object { $_.name.EndsWith($WindowsMsiAssetNamePattern) } | Select-Object -First 1
$Name = $WindowsMsiAsset.name
$DownloadUrl = $WindowsMsiAsset.browser_download_url

Install-Binary -Url $DownloadUrl -Name $Name

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"

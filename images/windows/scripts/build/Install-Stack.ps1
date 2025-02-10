################################################################################
##  File:  Install-Stack.ps1
##  Desc:  Install Stack for Windows
##  Supply chain security: Stack - checksum validation
################################################################################

Write-Host "Get the latest Stack version..."

$version = (Get-GithubReleasesByVersion -Repo "commercialhaskell/stack" -Version "latest" -WithAssetsOnly).version

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "commercialhaskell/stack" `
    -Version $version `
    -UrlMatchPattern "stack-*-windows-x86_64.zip"

Write-Host "Download stack archive"
$stackToolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "stack\$version"
$destinationPath = Join-Path $stackToolcachePath "x64"
$stackArchivePath = Invoke-DownloadWithRetry $downloadUrl

#region Supply chain security - Stack
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url "$downloadUrl.sha256" `
    -FileName (Split-Path $downloadUrl -Leaf)
Test-FileChecksum $stackArchivePath -ExpectedSHA256Sum $externalHash
#endregion

Write-Host "Expand stack archive"
Expand-7ZipArchive -Path $stackArchivePath -DestinationPath $destinationPath

New-Item -Name "x64.complete" -Path $stackToolcachePath

Add-MachinePathItem -PathItem $destinationPath

Invoke-PesterTests -TestFile "Tools" -TestName "Stack"

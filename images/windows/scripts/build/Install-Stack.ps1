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
$StackToolcachePath = Join-Path $Env:AGENT_TOOLSDIRECTORY "stack\$version"
$DestinationPath = Join-Path $StackToolcachePath "x64"
$StackArchivePath = Invoke-DownloadWithRetry $downloadUrl

#region Supply chain security - Stack
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url "$downloadUrl.sha256" `
    -FileName (Split-Path $downloadUrl -Leaf)
Test-FileChecksum $StackArchivePath -ExpectedSHA256Sum $externalHash
#endregion

Write-Host "Expand stack archive"
Expand-7ZipArchive -Path $StackArchivePath -DestinationPath $DestinationPath

New-Item -Name "x64.complete" -Path $StackToolcachePath

Add-MachinePathItem -PathItem $DestinationPath

Invoke-PesterTests -TestFile "Tools" -TestName "Stack"

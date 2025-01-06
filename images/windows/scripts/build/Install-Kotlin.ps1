################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

# Install Kotlin
$kotlinVersion = (Get-ToolsetContent).kotlin.version

$kotlinDownloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "JetBrains/kotlin" `
    -Version "$kotlinVersion" `
    -Asset "kotlin-compiler-*.zip"
$kotlinArchivePath = Invoke-DownloadWithRetry $kotlinDownloadUrl

#region Supply chain security
$externalHash = Get-Content $(Invoke-DownloadWithRetry "$kotlinDownloadUrl.sha256")
Test-FileChecksum $kotlinArchivePath -ExpectedSHA256Sum $externalHash
#endregion

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Expand-7ZipArchive -Path $kotlinArchivePath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"

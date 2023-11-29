################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

# Install Kotlin
$kotlinVersion = (Get-ToolsetContent).kotlin.version

$kotlinDownloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "JetBrains/kotlin" `
    -Version $kotlinVersion `
    -Asset "kotlin-compiler-*.zip"
$kotlinArchivePath = Invoke-DownloadWithRetry $kotlinDownloadUrl

#region Supply chain security
$fileHash = (Get-FileHash -Path $kotlinArchivePath -Algorithm SHA256).Hash
$externalHash = Get-HashFromGitHubReleaseBody -RepoOwner "JetBrains" -RepoName "kotlin" -FileName "$kotlinBinaryName-*.zip" -Version $kotlinVersion -WordNumber 2
Use-ChecksumComparison $fileHash $externalHash
#endregion

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Expand-7ZipArchive -Path $kotlinArchivePath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"

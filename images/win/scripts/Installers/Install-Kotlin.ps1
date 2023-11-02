################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
##  Supply chain security: Kotlin - checksum validation
################################################################################

# Install Kotlin
$kotlinVersion = (Get-ToolsetContent).kotlin.version
$kotlinBinaryName = (Get-ToolsetContent).kotlin.binary_name

$kotlinDownloadUrl = Get-GitHubPackageDownloadUrl -RepoOwner "JetBrains" -RepoName "kotlin" -BinaryName $kotlinBinaryName -Version $kotlinVersion -UrlFilter "*{BinaryName}-{Version}.zip"
$kotlinInstallerPath = Start-DownloadWithRetry -Url $kotlinDownloadUrl -Name "$kotlinBinaryName.zip"

#region Supply chain security
$fileHash = (Get-FileHash -Path $kotlinInstallerPath -Algorithm SHA256).Hash
$externalHash = Get-HashFromGitHubReleaseBody -RepoOwner "JetBrains" -RepoName "kotlin" -FileName "$kotlinBinaryName-*.zip" -Version $kotlinVersion -WordNumber 2
Use-ChecksumComparison $fileHash $externalHash
#endregion

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Extract-7Zip -Path $kotlinInstallerPath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"

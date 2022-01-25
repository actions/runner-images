################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
################################################################################

# Install Kotlin
$kotlinVersion = (Get-ToolsetContent).kotlin.version
$kotlinBinaryName = (Get-ToolsetContent).kotlin.binary_name

$kotlinDownloadUrl = Get-GitHubPackageDownloadUrl -RepoOwner "JetBrains" -RepoName "kotlin" -BinaryName $kotlinBinaryName -Version $kotlinVersion -UrlFilter "*{BinaryName}-{Version}.zip"
$kotlinInstallerPath = Start-DownloadWithRetry -Url $kotlinDownloadUrl -Name "$kotlinBinaryName.zip"

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Extract-7Zip -Path $kotlinInstallerPath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"